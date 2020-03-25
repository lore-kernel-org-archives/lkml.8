Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47506C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 23:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1899B20714
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 23:28:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KhZ47hmH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbgCYX22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 19:28:28 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:41888 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbgCYX21 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 19:28:27 -0400
Received: by mail-pl1-f195.google.com with SMTP id t16so1418071plr.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Mar 2020 16:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SX3uEj2yupJi2G9dIsEwiUFvEAf2VWTLKIwRxsxm8Yk=;
        b=KhZ47hmHyZ3plfSihQcc04GhPmya+BN4Yz36ianPP2/QMX6T5nod8hBzA3+bckshYI
         R8BGgu1kvH5UqrfhV7l5o4PFa2je3PRSR0zU+6aHOtDFb/7Yj29VcJdveO7GJ87Oa3Wc
         73NNQoSOVpU3uOuGS7812aKtDGxq+de3O1+7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SX3uEj2yupJi2G9dIsEwiUFvEAf2VWTLKIwRxsxm8Yk=;
        b=VVEt0NOntqgUoNWUtGPS8gnPGcntSY3AoACDrC7zSF5Tl3R70iXBXYMetZ+FP9zvz3
         ojPJZVn/rNzK85NM8GTPM88CklaQWPyUoGIC/4v2bxBbeuZ9DhwdzwxmNsVq/d9Smdt6
         7AcLV5CUl1jFgE4RKrCibN5TOGyS/1vKMmq+seuC+0HwtQPgQlnadLO5Nfsaz5m3UD+r
         gjnoPCyqeUM88Ld4fT5Y0MbymPa7JxD0tN/RoryjiC3HeN16ng/jH3DoDG7Gqg5Z4ZrW
         miarrXLdZddIn2btaPa+4tot9qbCeRiJg/3JScv8hufDK+ysf273ZsYZxm4zX8eRFaFm
         wEUg==
X-Gm-Message-State: ANhLgQ1d+6OyNMTRPFZ3AqdahGdWtgDSBmsoH3cuUjTuP4ckXCNTIsvM
        /523xyh/R3Ff9VBxwGTcw5Eyrg==
X-Google-Smtp-Source: ADFU+vt0ApjzPBOE0W0mEjIXv58VpXVRZglvlCiDXecmwqCjn6VANpyr6wQRMLJgO8f0u2V7hif+TA==
X-Received: by 2002:a17:90b:4c45:: with SMTP id np5mr6318836pjb.19.1585178906610;
        Wed, 25 Mar 2020 16:28:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d3sm193028pfn.113.2020.03.25.16.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 16:28:25 -0700 (PDT)
Date:   Wed, 25 Mar 2020 16:28:24 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     shuah@kernel.org, mpe@ellerman.id.au,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: enforce local header dependency in lib.mk
Message-ID: <202003251627.91036FC@keescook>
References: <20200325231649.13049-1-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200325231649.13049-1-skhan@linuxfoundation.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 25, 2020 at 05:16:49PM -0600, Shuah Khan wrote:
> Add local header dependency in lib.mk. This enforces the dependency
> blindly even when a test doesn't include the file, with the benefit
> of a simpler common logic without requiring individual tests to have
> special rule for it.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

style nit below...

> ---
>  tools/testing/selftests/lib.mk | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/lib.mk b/tools/testing/selftests/lib.mk
> index 3ed0134a764d..b0556c752443 100644
> --- a/tools/testing/selftests/lib.mk
> +++ b/tools/testing/selftests/lib.mk
> @@ -137,7 +137,8 @@ endif
>  # Selftest makefiles can override those targets by setting
>  # OVERRIDE_TARGETS = 1.
>  ifeq ($(OVERRIDE_TARGETS),)
> -$(OUTPUT)/%:%.c
> +LOCAL_HDRS := $(selfdir)/kselftest_harness.h $(selfdir)/kselftest.h
> +$(OUTPUT)/%:%.c $(LOCAL_HDRS)
>  	$(LINK.c) $^ $(LDLIBS) -o $@

It's already in lib.mk as "target:deps" but the tradition for kernel
make rules has been "target: deps". i.e.:

$(OUTPUT)/%: %.c $(LOCAL_HDRS)

But it doesn't actually matter. :)

-Kees

>  
>  $(OUTPUT)/%.o:%.S
> -- 
> 2.20.1
> 

-- 
Kees Cook
