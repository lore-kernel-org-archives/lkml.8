Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFED5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:03:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEA8421475
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 07:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590649382;
	bh=e2yGY79dxyXpgx2O8P4XGtL4xNiY5C50BQ8WJ1uWirk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=kCE7ZQaapWRxJDV6CoswTwIOisWGuKW9pM99+T8bdZIHnCP/ZNo+YJZpwYGs63Pah
	 iTsAcidm3HJXdHwFt1/oYKA+8FaHUeXqrZk+bWHMXp2kxK31kf8jITRwqN4aKQ/eqZ
	 B+ot2bY/du5UJXzDbTjSqngKgRnOLBCVaRN5eugo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgE1HDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 03:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgE1HDB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 03:03:01 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4500C05BD1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 00:02:59 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id a2so30828616ejb.10
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 00:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1PBhYbqfklz80IAquZA60sDIZLDnTsQBcqqNn/Nkat4=;
        b=uDoq3UV6v6R5+uCaIzdc0mAJQrGfkz2pDE0CgbydrrotI/l5ev9VXmmV4PqD+bbLjo
         0x+ua/p+afyNoZ2ur2aDvU5hKTgy5Ns6RJBCR4984FUS6cu1kZCLrT3R+Aed3BN54CRY
         JjAFUw1SqygnGZKlZrhyhdsWNald3eY16ogrOcIh6HnNoRGYWryNbx+9nPBqljqdFPVw
         eKVz2xbuYB9DIXdTZNV0i9OLdVxyf2Q/giz1GYXT+ORvTwFSEf03YDistwUVnl9OwrMu
         e7IIqp4u+VF44ewSLsZrFEtyle8jLuGdcPTzo+mLfHG82br82OvE8BHm/DvJ+FZJ7Mc2
         fkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=1PBhYbqfklz80IAquZA60sDIZLDnTsQBcqqNn/Nkat4=;
        b=qVtDSg6hu717WsCCLSbWdL5GkwYNckPGJziQc7m4zT3fKef+XPJPvtSvnLuAe/ekmN
         FIl9pLYUc7a4eXLPCqElOWbkWl5FdqoU6+Rm7U0u7yELri86/A0+c213DC/kjKVDFWRY
         F6T4UJWwI6yvIsA66O/n1Z60hqp/uJr56ZiTyyXiECg0Iz98Tm5QEsJr+9pvM+tQdi39
         7crNaazvcrCSFvBfqWMKjTLYiiL6raA7Z4uNK2qB57q5VHb+OgHnDG2BZcpR8jIktsyr
         q6wY7mvn8SUAMuAj3QEgBJek6QERQtjeFTvCFR8GInsTfr0bVyg1vadqCCv5Ct7XpxcF
         NRog==
X-Gm-Message-State: AOAM533tLNT6ZFIDh5GR7fdEc8T2wNiqoI24wTpJXgE7iskm2bT9vlFc
        v83p4nN2v7s9UxulAqCvuJy2spBr
X-Google-Smtp-Source: ABdhPJwINb+novO+dhJfYaiH6uXNIjquRLgjZIQdSPlZ16sa3ERYYJT0Wtvrx2QUwPRouaYfCvrtQw==
X-Received: by 2002:a17:906:cd08:: with SMTP id oz8mr1881621ejb.90.1590649378538;
        Thu, 28 May 2020 00:02:58 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id s19sm4152013edx.92.2020.05.28.00.02.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 00:02:57 -0700 (PDT)
Date:   Thu, 28 May 2020 09:02:55 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [git pull] coredump infoleak fix
Message-ID: <20200528070255.GA790247@gmail.com>
References: <20200527213447.GH23230@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200527213447.GH23230@ZenIV.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Al Viro <viro@zeniv.linux.org.uk> wrote:

> 	xstate note on boxes with xsaves support can leak uninitialized data
> into coredumps
> 
> The following changes since commit 4e89b7210403fa4a8acafe7c602b6212b7af6c3b:
> 
>   fix multiplication overflow in copy_fdtable() (2020-05-19 18:29:36 -0400)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git fixes
> 
> for you to fetch changes up to 9e4636545933131de15e1ecd06733538ae939b2f:
> 
>   copy_xstate_to_kernel(): don't leave parts of destination uninitialized (2020-05-27 17:06:31 -0400)
> 
> ----------------------------------------------------------------
> Al Viro (1):
>       copy_xstate_to_kernel(): don't leave parts of destination uninitialized
> 
>  arch/x86/kernel/fpu/xstate.c | 86 ++++++++++++++++++++++++--------------------
>  1 file changed, 48 insertions(+), 38 deletions(-)

Looks good to me.

I'm wondering, shouldn't we also zero-initialize the dump data to 
begin with? See the patch below (untested).

Thanks,

	Ingo

 fs/binfmt_elf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 13f25e241ac4..25d489bc9453 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1733,7 +1733,7 @@ static int fill_thread_core_info(struct elf_thread_core_info *t,
 		    (!regset->active || regset->active(t->task, regset) > 0)) {
 			int ret;
 			size_t size = regset_size(t->task, regset);
-			void *data = kmalloc(size, GFP_KERNEL);
+			void *data = kzalloc(size, GFP_KERNEL);
 			if (unlikely(!data))
 				return 0;
 			ret = regset->get(t->task, regset,
