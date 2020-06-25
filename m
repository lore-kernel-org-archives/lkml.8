Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C58CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 06:06:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0125E206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 06:06:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eaXqrVjG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389917AbgFYGGW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 02:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726493AbgFYGGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 02:06:21 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A582EC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 23:06:21 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ev7so2036595pjb.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 23:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bmHKXnQ4Boi1eFNXwwpe1A6f+AH0+2ONWt2wcc9MKB4=;
        b=eaXqrVjGvqMbRGvwa0gOwAwGm+xvdYLnWL086+E3GRyZYwYMETONorNvcngNumR8Zh
         E9NqO2qEQHI4dLFhIlZzgazQMSiFJEftyIoyWUuvn+Pkl8/hU/+0PEZTV7GxVo1HxPeP
         eQOMGmpgP1euTXqO4xce92nCWtXYOI3uPeYr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bmHKXnQ4Boi1eFNXwwpe1A6f+AH0+2ONWt2wcc9MKB4=;
        b=OAA5G9h+p4pkxfMafSW8ZlyszveK3uHqABR2cOLobudJWjUm/N3zJ8Kxt7VKSkJscJ
         dy8ysNuVEmV9JiQ1kco+0zcjXesgJZWAcozKMY1j9bqrPzqjFqGlMWypUUB1MUVGweSp
         +7K9Tk60475m8oV/snnAv/pwDD8EUdHsd08qs4UhDs8XDYpTrMGrLtWcJfnwbTRUdTxI
         YomDaXyabi2diuDh+V0D3R0FZ9Oi0vb7rrQsrEWotTcmTHzxGwQ8qFyeloT8YuyDXtf2
         girI5JjnFMi2RILN9cPBpAnHwpLMK/vEiQJw+3C5qC1O6W/6R98OmOm8iORrhgySTI/z
         ASug==
X-Gm-Message-State: AOAM5321bxEylhdGJWb07EEfF7WrRGHk/sURq5CDwiTMq2MGfFS1VCLe
        JOBSpXr70RTYzDmr4WLtaUD8qQ8ZBic=
X-Google-Smtp-Source: ABdhPJxgLn1OrSz77PkNWmC2KIlmqjt/PSB0iT+FDiN9y5fw1zLTEuhwg7bZeyQizf/TOK7pdWhF8w==
X-Received: by 2002:a17:90b:190b:: with SMTP id mp11mr1647255pjb.82.1593065180560;
        Wed, 24 Jun 2020 23:06:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u4sm21959927pfl.102.2020.06.24.23.06.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 23:06:19 -0700 (PDT)
Date:   Wed, 24 Jun 2020 23:06:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Richard Weinberger <richard.weinberger@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Prasad Sodagudi <psodagud@codeaurora.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        clang-built-linux@googlegroups.com,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH drivers/misc 0/4] lkdtm: Various clean ups
Message-ID: <202006242300.145D555@keescook>
References: <20200529200347.2464284-1-keescook@chromium.org>
 <202006231610.4993DC5@keescook>
 <2356a78c-750b-538f-3d64-b9c78aff89cb@infradead.org>
 <903628180.54697.1592983405305.JavaMail.zimbra@nod.at>
 <202006241335.2C0FB5DF90@keescook>
 <b97853f0-c4be-7039-1d4c-96b3ab802472@infradead.org>
 <CAFLxGvxiyyX9s=y4phGxvWh-vonS1WPOUbRZr9mgq-B+wY+2nQ@mail.gmail.com>
 <10f7c20a-0a32-f5cf-7fdf-761db22afcd9@infradead.org>
 <03486f13-b138-2fc6-4d90-2737d86add2f@infradead.org>
 <80f501f4-d4fb-1f22-5603-57b5490a695d@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80f501f4-d4fb-1f22-5603-57b5490a695d@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 06:45:47PM -0700, Randy Dunlap wrote:
> Looks like lkdtm/bugs.c needs to get/use arch/x86/include/asm/processor.h
> but it actually uses arch/x86/um/asm/processor*.h, which does not have the
> needed structs etc.

Should I just test for !UML in bugs.c? (This is all for the
lkdtm_DOUBLE_FAULT() test.) I already do those kinds of checks for the
lkdtm_UNSET_SMEP() test. e.g.:


diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 736675f0a246..f3e7040a7739 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -13,7 +13,7 @@
 #include <linux/uaccess.h>
 #include <linux/slab.h>
 
-#ifdef CONFIG_X86_32
+#if IS_ENABLED(CONFIG_X86_32) && !IS_ENABLED(CONFIG_UML)
 #include <asm/desc.h>
 #endif
 
@@ -419,7 +419,7 @@ void lkdtm_UNSET_SMEP(void)
 
 void lkdtm_DOUBLE_FAULT(void)
 {
-#ifdef CONFIG_X86_32
+#if IS_ENABLED(CONFIG_X86_32) && !IS_ENABLED(CONFIG_UML)
 	/*
 	 * Trigger #DF by setting the stack limit to zero.  This clobbers
 	 * a GDT TLS slot, which is okay because the current task will die

-- 
Kees Cook
