Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0ADCC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 06:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE3BD20714
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 06:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592115909;
	bh=+G4mFwwUxmvulUqVt+U7sEFgiDncSSdch8RRO+Rxg8c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=tGF/hAIQ0gqqatt8NyeO5xEGvoGwkoGhF98RXHK8nFPEbvCwOgoPOLLqJLmQaLlxk
	 XJZA09vDOgXcvmEmURZDiiCEmHiCVIhsZNQie9dAw2Tl1Trvn4poGtxIMlMfdokzQu
	 yjW6NyOIXq2IZpgujqzyWoo6rxhpDr8fURiEYWvQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbgFNGZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 02:25:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725265AbgFNGZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 02:25:05 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0E6D720714;
        Sun, 14 Jun 2020 06:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592115904;
        bh=+G4mFwwUxmvulUqVt+U7sEFgiDncSSdch8RRO+Rxg8c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pQ3hdpvVEsVSGxTpRYyfTvoyFlSPo7daG/GvIK6LqYPP9oF5AYCNIJ133AzcrnEPj
         zVLqWD4ebXqK/2jYxNngAIG7d75cLYlA7c+Sv68AQAst5+nlMBOxCUgWnYvjncdM+s
         l0f4HoE5v9nDdYbgobdDaiRCnyprotyZ6XlNb4eQ=
Date:   Sun, 14 Jun 2020 08:25:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dio Putra <dioput12@gmail.com>
Cc:     devel@driverdev.osuosl.org, tkjos@android.com,
        linux-kernel@vger.kernel.org, arve@android.com,
        joel@joelfernandes.org, maco@android.com, christian@brauner.io
Subject: Re: [PATCH] staging: android: ashmem.c: Cleanup
Message-ID: <20200614062501.GA2610536@kroah.com>
References: <4ba43a70-c29f-6c41-9c81-66a25b0432af@gmail.com>
 <77288a97-c87a-8ef2-60ab-e7f89cde07ff@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77288a97-c87a-8ef2-60ab-e7f89cde07ff@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 14, 2020 at 11:40:42AM +0700, Dio Putra wrote:
> Okay, my fault here. Changing the function a little bit didn't help unfortunately.
> 
> $ cd ~/git/linux/
> $ make CC=clang W=1 M=drivers/staging/android
>   CC      drivers/staging/android/ashmem.o
> drivers/staging/android/ashmem.c:418:16: error: cannot assign to variable 'vmfile_fops' with const-qualified type 'const struct file_operations'
>                         vmfile_fops = *vmfile->f_op;
>                         ~~~~~~~~~~~ ^
> drivers/staging/android/ashmem.c:370:31: note: variable 'vmfile_fops' declared const here
>         const struct file_operations vmfile_fops;
>         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
> drivers/staging/android/ashmem.c:419:21: error: cannot assign to variable 'vmfile_fops' with const-qualified type 'const struct file_operations'
>                         vmfile_fops.mmap = ashmem_vmfile_mmap;
>                         ~~~~~~~~~~~~~~~~ ^
> drivers/staging/android/ashmem.c:370:31: note: variable 'vmfile_fops' declared const here
>         const struct file_operations vmfile_fops;
>         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
> drivers/staging/android/ashmem.c:420:34: error: cannot assign to variable 'vmfile_fops' with const-qualified type 'const struct file_operations'
>                         vmfile_fops.get_unmapped_area =
>                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^
> drivers/staging/android/ashmem.c:370:31: note: variable 'vmfile_fops' declared const here
>         const struct file_operations vmfile_fops;
>         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
> 3 errors generated.
> make[1]: *** [scripts/Makefile.build:267: drivers/staging/android/ashmem.o] Error 1
> make: *** [Makefile:1735: drivers/staging/android] Error 2
> $ 
> 
> On 6/14/20 12:37 AM, Dio Putra wrote:
> > Minor cleanup to make file_operations const once again.
> > 
> > Signed-off-by: Dio Putra <dioput12@gmail.com>
> > ---
> >  drivers/staging/android/ashmem.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > base-commit: aa5af974127d317071d6225a0f3678c5f520e7ce
> > diff --git a/drivers/staging/android/ashmem.c b/drivers/staging/android/ashmem.c
> > index 8044510d8ec6..fbb6ac9ba1ab 100644
> > --- a/drivers/staging/android/ashmem.c
> > +++ b/drivers/staging/android/ashmem.c
> > @@ -367,7 +367,7 @@ ashmem_vmfile_get_unmapped_area(struct file *file, unsigned long addr,
> >  
> >  static int ashmem_mmap(struct file *file, struct vm_area_struct *vma)
> >  {
> > -	static struct file_operations vmfile_fops;
> > +	static const struct file_operations vmfile_fops;
> >  	struct ashmem_area *asma = file->private_data;
> >  	int ret = 0;
> >  

Always test-build your patches before you send them out please...

thanks,

greg k-h
