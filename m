Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FEDCC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 16:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0DDA820672
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 16:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594831349;
	bh=ED5t9A4zYRl2ppiYuYOQoWbYJVj84a6IYOD4Vjh9qcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=elDFeEPO0McgJ9Yz4JIlOchALfif4qE3qUAU+JbVH1edvtgrwOC/yYKG3MpnTxI+y
	 eImccbMNufncqagO4uVK3OVUC7Y5lQODddbcqgeqfnmm89WddoKGjx7xfFgf5FaBtS
	 XXfotZJ6nH4mUN2MWYHEBCs9wGRbccXFdAjBE46o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbgGOQmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 12:42:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbgGOQmX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 12:42:23 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3798120658;
        Wed, 15 Jul 2020 16:42:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594831342;
        bh=ED5t9A4zYRl2ppiYuYOQoWbYJVj84a6IYOD4Vjh9qcw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dQA5TiCjdpTjdRjyFo64GaYmcJ38VZ98DmESuH3bIc7IwBm+v5kPqFNCfamABR9ad
         juc1949N82lTQqEXq8UtZ8CEbj9YS6CApPxNuKJZjUnXctZlMrROfyWVI3oPc7nkke
         bgJOSl8Vf6rDJvb6pGJKcpTQJ6zKF3hQOrGgCfOk=
Date:   Wed, 15 Jul 2020 09:42:20 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Daeho Jeong <daeho43@gmail.com>
Cc:     Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com,
        Daeho Jeong <daehojeong@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: change the way of handling range.len
 in F2FS_IOC_SEC_TRIM_FILE
Message-ID: <20200715164220.GC1167@sol.localdomain>
References: <20200713031252.3873546-1-daeho43@gmail.com>
 <20200713181152.GC2910046@google.com>
 <3b02263d-a5e1-136c-40ed-514d34e4c895@huawei.com>
 <CACOAw_wBD_ourGJSdRTDM-wzeH97aGE966QDB6bpjiyXRrh47A@mail.gmail.com>
 <f4a594a1-464f-3a74-90cb-fd536bed9962@huawei.com>
 <CACOAw_w3OWDVXSYHuTEEVv1HaBZir1CWcRAmxOt00MB4vXBKVg@mail.gmail.com>
 <1d84bc01-fece-df55-6e33-07a705cfb432@huawei.com>
 <CACOAw_xaS7qB22EPsZvHoC=uPiPtqGMAK5cP4Vk20xO21GQ-Kg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACOAw_xaS7qB22EPsZvHoC=uPiPtqGMAK5cP4Vk20xO21GQ-Kg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 07:25:13PM +0900, Daeho Jeong wrote:
> Chao,
> 
> I can't find fscrypt_zeroout_range_inline_crypt() function. Do you
> mean we need to implement this one for inline encryption?
> 
> 2020년 7월 15일 (수) 오후 4:17, Chao Yu <yuchao0@huawei.com>님이 작성:
> >
> > On 2020/7/15 14:54, Daeho Jeong wrote:
> > > You mean we can support ZEROOUT option only for encrypted files of
> > > non-multidevice f2fs,
> > > and return -EOPNOTSUPP in the multidevice case, right now?
> >
> > Yes, something like:
> >
> > f2fs_sec_trim_file()
> >
> > if ((range.flags & F2FS_TRIM_FILE_ZEROOUT) &&
> >         f2fs_encrypted_file() && f2fs_is_multi_device())
> >         return -EOPNOTSUPP;
> >
> >
> > f2fs_secure_erase()
> >
> > if (!ret && (flags & F2FS_TRIM_FILE_ZEROOUT)) {
> >         if (f2fs_encrypted_file()) {
> >                 if (fscrypt_inode_uses_fs_layer_crypto)
> >                         ret = fscrypt_zeroout_range();
> >                 else
> >                         ret = fscrypt_zeroout_range_inline_crypt();
> >         } else {
> >                 ret = blkdev_issue_zeroout();
> >         }
> > }

fscrypt_zeroout_range_inline_crypt() is being added by
"fscrypt: add inline encryption support", which is queued in the fscrypt tree
(the master branch of https://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git).

But that's not actually relevant here because fscrypt_zeroout_range() calls
fscrypt_zeroout_range_inline_crypt() when needed.

Just use fscrypt_zeroout_range().

- Eric
