Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E32EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F0BF20759
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 08:12:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DO5aHBa3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730755AbgF3IMx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 04:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728073AbgF3IMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 04:12:51 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE4CC061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 01:12:51 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z15so7877998wrl.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 01:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rLJNg6SZ5HWWuZJdX48spsQBewv6zMsf37jjJ1GBFiQ=;
        b=DO5aHBa3pNUaSGETSWQbzofDqahUYhogpdVMSaV5TJlJRqs3OGdlyZtLoInmnpn22p
         em373dlDejE5fuud8z1S1bUSgxOzS7iLzlW83StXkc7Ga5xL3v4jBHwQelDaajWtC2dp
         ullhzxtosXK96KE1TcOpDCTk1l+zG0s1TfKx+8ZCadweQAoTXlb0KaAXVfdhQebo3kMd
         dsSqaxyReuGgZWoekjOGguN93HVjM9tlZKISxbRSYMPfdkRtMndednWm7oqxlyGNhYH1
         au1+FTOV3GzZJaAVjcz62PjOPBPQ8jxsU5cRAYNPI0GL45FdNc3Gg9jE9PbiKgLUvvoH
         jmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rLJNg6SZ5HWWuZJdX48spsQBewv6zMsf37jjJ1GBFiQ=;
        b=rCijSUNvG6DqDp/740kATmqyzBy72HAiCEApYLOjFVqukSPxOKnUjfwuVYG63fvVYX
         i/UzA+S1EfWmPmaZ2qPO46ovOmu68Ts9NF9jruW4W5VCpxJY67lMVE1mec+MXnvlufvI
         sOa+ZBDZGFUO0Myf+Ieu9EgR6AFKmumEeJmuJGBsUBbIqE4Rznq7hKz9vfbRf2T91Col
         AVogC2f/acIXvIXF35imlXqVXYsegEXWiFACDuHnj89Yyiak1aQrFo4KYTLisHKBmkYi
         8npKdGwlaqS/HVkdOarC93M5dbG5eBoB00o50IlASKy/2LUDhIRcHfkU7uSNMSqo48wR
         r8Xg==
X-Gm-Message-State: AOAM531VADdhQlmgxj3CqqJ3+8XliwW7j4qSeu8EXHJXRQDrZKmBp+pF
        RZ7srrWXrlFAxQLnf7tyW9DjYQ==
X-Google-Smtp-Source: ABdhPJwzVH84vx569ch3pQWZoaa/tB1s2+xBvZx8nv2vs4jTY0G7z5RQJESw82aZLv7bw+tzTqJuoA==
X-Received: by 2002:a05:6000:1283:: with SMTP id f3mr20939240wrx.106.1593504770162;
        Tue, 30 Jun 2020 01:12:50 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id i17sm2767303wrc.34.2020.06.30.01.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 01:12:49 -0700 (PDT)
Date:   Tue, 30 Jun 2020 09:12:47 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     haver <haver@linux.vnet.ibm.com>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Jung <mijung@gmx.net>,
        Michael Ruettger <michael@ibmra.de>,
        Frank Haverkamp <haver@linux.ibm.com>,
        Joerg-Stephan Vogt <jsvogt@de.ibm.com>
Subject: Re: [PATCH 16/20] misc: genwqe: card_base: Remove set but unused
 variable 'rc'
Message-ID: <20200630081247.GI1179328@dell>
References: <20200629140442.1043957-1-lee.jones@linaro.org>
 <20200629140442.1043957-17-lee.jones@linaro.org>
 <fff00e6667c442cac13147ee5095430a@linux.vnet.ibm.com>
 <20200630074224.GH1179328@dell>
 <770e66e5f2d7efcea61fc9d57e1053f0@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <770e66e5f2d7efcea61fc9d57e1053f0@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Jun 2020, haver wrote:

> On 2020-06-30 09:42, Lee Jones wrote:
> > On Tue, 30 Jun 2020, haver wrote:
> > 
> > > On 2020-06-29 16:04, Lee Jones wrote:
> > > > Variable 'rc' hasn't been checked since the driver's inception
> > > > in 2013.  If it hasn't caused any issues since then, it's unlikely
> > > > to in the future.  Let's take it out for now.
> > > >
> > > > Fixes the following W=1 kernel build warning(s):
> > > >
> > > >  drivers/misc/genwqe/card_base.c: In function
> > > > ‘genwqe_health_check_stop’:
> > > >
> > > > /home/lee/projects/linux/kernel/drivers/misc/genwqe/card_base.c:1046:6:
> > > > warning: variable ‘rc’ set but not used
> > > > [-Wunused-but-set-variable]
> > > >  1046 | int rc;
> > > >  | ^~
> > > >
> > > > Cc: Michael Jung <mijung@gmx.net>
> > > > Cc: Michael Ruettger <michael@ibmra.de>
> > > > Cc: Frank Haverkamp <haver@linux.ibm.com>
> > > > Cc: Joerg-Stephan Vogt <jsvogt@de.ibm.com>
> > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > ---
> > > >  drivers/misc/genwqe/card_base.c | 4 +---
> > > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/misc/genwqe/card_base.c
> > > > b/drivers/misc/genwqe/card_base.c
> > > > index 1dc6c7c5cbce9..bceebf49de2d5 100644
> > > > --- a/drivers/misc/genwqe/card_base.c
> > > > +++ b/drivers/misc/genwqe/card_base.c
> > > > @@ -1043,12 +1043,10 @@ static int genwqe_health_thread_running(struct
> > > > genwqe_dev *cd)
> > > >
> > > >  static int genwqe_health_check_stop(struct genwqe_dev *cd)
> > > >  {
> > > > -	int rc;
> > > > -
> > > >  	if (!genwqe_health_thread_running(cd))
> > > >  		return -EIO;
> > > >
> > > > -	rc = kthread_stop(cd->health_thread);
> > > > +	kthread_stop(cd->health_thread);
> > > >  	cd->health_thread = NULL;
> > > >  	return 0;
> > > >  }
> > > 
> > > Good idea. Let's remove it Thanks for the contribution.
> > 
> > No problem, and you are welcome.
> > 
> > > Signed-off-by: Frank Haverkamp <haver@linux.ibm.com>
> > 
> > Just as an aside, this should be Acked-by, unless you either
> > contributed to the patch directly or are in the delivery path i.e. you
> > plan to pick the patch and send it to, say Linus, via a pull-request.
> 
> Right. Thanks for reminding me. Feel free to send it yourself.
> When was the documentation checking introduced? At the time we
> contributed the code there was no such checking.

The checking scripts have been in place for many years, but it looks
like doc checking became part of EXTRA_GCC_CHECKS builds in 2017:

> commit 3a025e1d1c2ea42fa497c9c6b21c284e0f69e28b
Author: Matthew Wilcox <willy@infradead.org>
Date:   Mon Nov 20 10:40:40 2017 -0800

    Add optional check for bad kernel-doc comments
    
    Implement a '-none' output mode for kernel-doc which will only output
    warning messages, and suppresses the warning message about there being
    no kernel-doc in the file.
    
    If the build has requested additional warnings, automatically check all
    .c files.  This patch does not check .h files.  Enabling the warning
    by default would add about 1300 warnings, so it's default off for now.
    People who care can use this to check they didn't break the docs and
    maybe we'll get all the warnings fixed and be able to enable this check
    by default in the future.
    
    Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
    Signed-off-by: Jonathan Corbet <corbet@lwn.net>

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 2e3a10e79ca9e..aceac0ba07451 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -108,6 +108,10 @@ ifneq ($(KBUILD_CHECKSRC),0)
   endif
 endif
 
+ifneq ($(KBUILD_ENABLE_EXTRA_GCC_CHECKS),)
+  cmd_checkdoc = $(srctree)/scripts/kernel-doc -none $< ;
+endif
+
 # Do section mismatch analysis for each module/built-in.o
 ifdef CONFIG_DEBUG_SECTION_MISMATCH
   cmd_secanalysis = ; scripts/mod/modpost $@
@@ -289,6 +293,7 @@ define rule_cc_o_c
        $(call echo-cmd,checksrc) $(cmd_checksrc)                         \
        $(call cmd_and_fixdep,cc_o_c)                                     \
        $(cmd_modversions_c)                                              \
+       $(cmd_checkdoc)                                                   \
        $(call echo-cmd,objtool) $(cmd_objtool)                           \
        $(call echo-cmd,record_mcount) $(cmd_record_mcount)
 endef

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
