Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76C0EC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 04:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 414A320747
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 04:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bxCvFM9b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbgFNEkw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 00:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725265AbgFNEkv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 00:40:51 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68393C03E96F
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 21:40:50 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id d66so6316063pfd.6
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 21:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=X0jHmyTeV0liIsm64hbjioRiMTjKGIsGf1zJtDDDraA=;
        b=bxCvFM9b61L0pKFDnjXvxZ39M+doP2fx0OwF6xPJJqWW3Rbc13bCUyg0HBgCgUsLKm
         +D91gmU50kNXJkYkShzMH7MXG9WADaQFjdxb4LnYFc0CqGb76ZefvM15CrEyKWWAqLAj
         6Smm/j0Gy9dLYYCw6j3TbubSnYCbg84EYbJzmox2Z0adLVLPHCb8yDBYSpwWPChvoD8Q
         aMzqGl7gYG8dyVqMv+n4Fc9GYsKqiltn+DxOgaGqaLTn1bY1jOb7TEAgnQwH5iAwzf/x
         grXv8UQTC2uIJ8syF3Et85ChUlR7Yuj4LEsYArK/K+kX+KqoAiBXecWWTONivB2mQOaf
         brdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=X0jHmyTeV0liIsm64hbjioRiMTjKGIsGf1zJtDDDraA=;
        b=XAVWWy2Z5/fsPqSKMXvRwHaN1V128rcjuBiywI6kISOFZTLG8/joOH1cuOvcckaK8v
         uMJHlUtPUYODuUW+0QVBMZUykv665fpneWfdK/mdhPsnZDpOcFW5zrF7HeId7x/DNJck
         Nw4DYsS7DkifzDIrZnpN1oyF4GPzDEqhGJfxqBQ8ERa243GrBy/vQDtQ142oFNpTFV5R
         m/r7Ju8bt5daAmsCJqstGVXZPVmErgk5k/saR0twesXDPFejU0oCmIEdyLTUq91a2BOa
         iKrQbjHSKE5ra5JxgA4B4yIn/Sp8ygZkh+FGmXm41+1p0jlC59e/njHq6UbWi1J3CqQ8
         tU+Q==
X-Gm-Message-State: AOAM531kriWUrzcKCcWW440BdHdatPpaEAgYJ/vT8PRuefmJpJ+n//DH
        VY6pTb/wLWWAVijFm6HgR5ejq1eL
X-Google-Smtp-Source: ABdhPJzb2adrqnTPbnPaGL4A3WTJNegJCfYtKHsH9IYilutj906HsCC6K8L5onSe63iESCAeEtNNUQ==
X-Received: by 2002:a63:7d58:: with SMTP id m24mr16323995pgn.81.1592109649234;
        Sat, 13 Jun 2020 21:40:49 -0700 (PDT)
Received: from ASMDT.1 ([182.1.234.31])
        by smtp.gmail.com with ESMTPSA id 192sm4228432pgg.39.2020.06.13.21.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2020 21:40:48 -0700 (PDT)
Subject: Re: [PATCH] staging: android: ashmem.c: Cleanup
From:   Dio Putra <dioput12@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     arve@android.com, tkjos@android.com, maco@android.com,
        joel@joelfernandes.org, christian@brauner.io,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <4ba43a70-c29f-6c41-9c81-66a25b0432af@gmail.com>
Message-ID: <77288a97-c87a-8ef2-60ab-e7f89cde07ff@gmail.com>
Date:   Sun, 14 Jun 2020 11:40:42 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <4ba43a70-c29f-6c41-9c81-66a25b0432af@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, my fault here. Changing the function a little bit didn't help unfortunately.

$ cd ~/git/linux/
$ make CC=clang W=1 M=drivers/staging/android
  CC      drivers/staging/android/ashmem.o
drivers/staging/android/ashmem.c:418:16: error: cannot assign to variable 'vmfile_fops' with const-qualified type 'const struct file_operations'
                        vmfile_fops = *vmfile->f_op;
                        ~~~~~~~~~~~ ^
drivers/staging/android/ashmem.c:370:31: note: variable 'vmfile_fops' declared const here
        const struct file_operations vmfile_fops;
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
drivers/staging/android/ashmem.c:419:21: error: cannot assign to variable 'vmfile_fops' with const-qualified type 'const struct file_operations'
                        vmfile_fops.mmap = ashmem_vmfile_mmap;
                        ~~~~~~~~~~~~~~~~ ^
drivers/staging/android/ashmem.c:370:31: note: variable 'vmfile_fops' declared const here
        const struct file_operations vmfile_fops;
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
drivers/staging/android/ashmem.c:420:34: error: cannot assign to variable 'vmfile_fops' with const-qualified type 'const struct file_operations'
                        vmfile_fops.get_unmapped_area =
                        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^
drivers/staging/android/ashmem.c:370:31: note: variable 'vmfile_fops' declared const here
        const struct file_operations vmfile_fops;
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
3 errors generated.
make[1]: *** [scripts/Makefile.build:267: drivers/staging/android/ashmem.o] Error 1
make: *** [Makefile:1735: drivers/staging/android] Error 2
$ 

On 6/14/20 12:37 AM, Dio Putra wrote:
> Minor cleanup to make file_operations const once again.
> 
> Signed-off-by: Dio Putra <dioput12@gmail.com>
> ---
>  drivers/staging/android/ashmem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> base-commit: aa5af974127d317071d6225a0f3678c5f520e7ce
> diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
> index 8044510d8ec6..fbb6ac9ba1ab 100644
> --- a/drivers/staging/android/ashmem.c
> +++ b/drivers/staging/android/ashmem.c
> @@ -367,7 +367,7 @@ ashmem_vmfile_get_unmapped_area(struct file *file, unsigned long addr,
>  
>  static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
>  {
> -	static struct file_operations vmfile_fops;
> +	static const struct file_operations vmfile_fops;
>  	struct ashmem_area *asma = file->private_data;
>  	int ret = 0;
>  
> 

