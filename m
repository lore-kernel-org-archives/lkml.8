Return-Path: <SRS0=EowN=3M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2585DC33CAA
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 22:18:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFAF821D7E
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jan 2020 22:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579817938;
	bh=1QEQIO8BWAIq1V8e658QCqVX3p3sFtysjrQ4cMkD+No=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QYQZMk7s70vMB+RhnvebOIietXPwkQ840NrrYL5eoWvPxCvtbanHDBqI2I//gB+s4
	 0stLY9z/mtY7n8LZgkk41anf7vbmGdlVd3dc3gFFKbsfmynuHnfs0tbXQT1wmYfhyV
	 HuP3YGAiKwSGoR6lfMV3rZCQ4LoGAvDJcR/kxUs4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgAWWS5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jan 2020 17:18:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:57738 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727312AbgAWWS4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jan 2020 17:18:56 -0500
Received: from localhost (unknown [104.132.0.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0552C21734;
        Thu, 23 Jan 2020 22:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579817936;
        bh=1QEQIO8BWAIq1V8e658QCqVX3p3sFtysjrQ4cMkD+No=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mgpDd2lJHJTZW8xM52EL06pd4wP+yn6acWkQWTFTugidxxyxwfqjKHuxvzYw5Jbb3
         woOv9G0EsnPNFw7/tdtd4XYA2EZFAkoQmds+tifpbO26fY2dPu9UzFt3cIGJAMVYav
         3b9rYtyiWBdcw/Z6QIc6j0EW1arOYWgIxl3HtnRg=
Date:   Thu, 23 Jan 2020 14:18:55 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, chao@kernel.org
Subject: Re: [PATCH] f2fs: fix to force keeping write barrier for strict
 fsync mode
Message-ID: <20200123221855.GA7917@jaegeuk-macbookpro.roam.corp.google.com>
References: <20200120100045.70210-1-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200120100045.70210-1-yuchao0@huawei.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/20, Chao Yu wrote:
> If barrier is enabled, for strict fsync mode, we should force to
> use atomic write semantics to avoid data corruption due to no
> barrier support in lower device.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/file.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 86ddbb55d2b1..c9dd45f82fbd 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -241,6 +241,13 @@ static int f2fs_do_sync_file(struct file *file, loff_t start, loff_t end,
>  	};
>  	unsigned int seq_id = 0;
>  
> +	/*
> +	 * for strict fsync mode, force to keep atomic write sematics to avoid
> +	 * data corruption if lower device doesn't support write barrier.
> +	 */
> +	if (!atomic && F2FS_OPTION(sbi).fsync_mode == FSYNC_MODE_STRICT)
> +		atomic = true;

This allows to relax IO ordering and cache flush. I'm not sure that's what you
want to do here for strict mode.

> +
>  	if (unlikely(f2fs_readonly(inode->i_sb) ||
>  				is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
>  		return 0;
> -- 
> 2.18.0.rc1
