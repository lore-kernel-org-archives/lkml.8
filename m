Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A60EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 16:27:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50ED0207ED
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 16:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591892845;
	bh=7Vh2eMKAqsqarBEFvSteTBIrjnkfpF7p21JR7SHTWnU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R3pCd7qEkQRqhNW7wUT/EIzVlAw6Nz8Rx14aiNjRHIz/xyDpqo+s20HHej5M/dEKG
	 qHKAyxYfFeQTQT1WnLzWe/AvoAgSkvtKeY+95qfRzjbub3DRa4l1mj9NrW+BNpl42/
	 qojzj3A8opqrJvOdFM0xiwRoRlk+HRn5yDXsMKek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbgFKQ1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 12:27:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:35354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725782AbgFKQ1X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 12:27:23 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9BA5D20792;
        Thu, 11 Jun 2020 16:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591892842;
        bh=7Vh2eMKAqsqarBEFvSteTBIrjnkfpF7p21JR7SHTWnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=loimR59ESifvGt9gJ/k3lNBbw2wz/KxaR8VRsFjmkzEE2gwVAEKMbUxbZxwC0zh8G
         IHOznBOCpQyR83dvEhg/xor9v5dDFIEziXXV9DM7mHWM//FUw1Y351w+jlomXLLxYm
         1IB2eJK6fZTtEHbyFEQ79PmS6+uggD2KfvnuDJnA=
Date:   Thu, 11 Jun 2020 09:27:21 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add F2FS_IOC_SEC_TRIM_FILE ioctl
Message-ID: <20200611162721.GB1152@sol.localdomain>
References: <20200611031652.200401-1-daeho43@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611031652.200401-1-daeho43@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 12:16:52PM +0900, Daeho Jeong wrote:
> +	for (index = pg_start; index < pg_end;) {
> +		struct dnode_of_data dn;
> +		unsigned int end_offset;
> +
> +		set_new_dnode(&dn, inode, NULL, NULL, 0);
> +		ret = f2fs_get_dnode_of_data(&dn, index, LOOKUP_NODE);
> +		if (ret)
> +			goto out;
> +
> +		end_offset = ADDRS_PER_PAGE(dn.node_page, inode);
> +		if (pg_end < end_offset + index)
> +			end_offset = pg_end - index;
> +
> +		for (; dn.ofs_in_node < end_offset;
> +				dn.ofs_in_node++, index++) {
> +			struct block_device *cur_bdev;
> +			block_t blkaddr = f2fs_data_blkaddr(&dn);
> +
> +			if (__is_valid_data_blkaddr(blkaddr)) {
> +				if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode),
> +					blkaddr, DATA_GENERIC_ENHANCE)) {
> +					ret = -EFSCORRUPTED;
> +					goto out;
> +				}
> +			} else
> +				continue;
> +
> +			cur_bdev = f2fs_target_device(sbi, blkaddr, NULL);
> +			if (f2fs_is_multi_device(sbi)) {
> +				int i = f2fs_target_device_index(sbi, blkaddr);
> +
> +				blkaddr -= FDEV(i).start_blk;
> +			}
> +
> +			if (len) {
> +				if (prev_bdev == cur_bdev &&
> +					blkaddr == prev_block + len) {
> +					len++;
> +				} else {
> +					ret = f2fs_secure_erase(prev_bdev,
> +							prev_block, len, flags);
> +					if (ret)
> +						goto out;
> +
> +					len = 0;
> +				}
> +			}
> +
> +			if (!len) {
> +				prev_bdev = cur_bdev;
> +				prev_block = blkaddr;
> +				len = 1;
> +			}
> +		}
> +
> +		f2fs_put_dnode(&dn);
> +	}

This loop processes the entire file, which may be very large.  So it could take
a very long time to execute.

It should at least use the following to make the task killable and preemptible:

		if (fatal_signal_pending(current)) {
			err = -EINTR;
			goto out;
		}
		cond_resched();

Also, perhaps this ioctl should be made incremental, i.e. take in an
(offset, length) like pwrite()?

- Eric
