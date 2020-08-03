Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9E3BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 18:29:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A2F022B4E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 18:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DjzvW0b8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728605AbgHCS3l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 14:29:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHCS3l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 14:29:41 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9A8C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 11:29:41 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id w17so21264521ply.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 11:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=Jp+RUdqxn2bqBAJrnl3/EtyTRS168jjNSIe2CptEcmg=;
        b=DjzvW0b8CiSYl0WsHAxDm6vYeLjke22BrUVzGogsnNj1LZjAWNzxHJFpLFhoulfDgl
         Ni25KCT3eSrzC04fZ61g1Ay9PNx3FccY2qTnpZuQL5hc32pGb4N09mVekuDj9MnPA96w
         dYFvfR/u1sUYaqOjbobYBDeStPIf+ee3utRyM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Jp+RUdqxn2bqBAJrnl3/EtyTRS168jjNSIe2CptEcmg=;
        b=fEAnqbqbZCD1CbySotyFK5DmjyhvhAWTXujaRtJsDYJonhTKPZ5C9X9794maeCyIXP
         0SU09pEBb8H8wnYvXFkiPKa4RvHDvNgmMblzhUey7cfiMDg0b7MyoY8S0DRrw4HjaDUK
         jxn5fzwlGFI8SqMsyxhnz+h1/VkgHHVfRvVuxwAOSuE/AfWoPgdwoYutm7mosFQoVsin
         +XT87Wfc8e+9WY7w+NkFxGpK0ZRp6kDXPWyN1j4tv0Kum/NfeFP/tVjxYPH2v4yAlNhp
         8vl37CeT03MrKCx+9fNg9flIKYkrExEFfWQvjKNQC37uz5ORckfdKtLlSGZE+DwbP/qi
         fMgA==
X-Gm-Message-State: AOAM530X/0aD73oKxyigDvUCWtDCYcPfVHVjcy/SlXJFofl2qP5t5yLY
        mDutIJESnoRMO/kWS1u9HAIkog==
X-Google-Smtp-Source: ABdhPJw6+KwHqP+X6kkB/Nh+5MoJPmoZuMVKaA4zdRO65/hv0t1RhuJZhxmS17f5eIeBraxJKlocrQ==
X-Received: by 2002:a17:902:a9c8:: with SMTP id b8mr16117240plr.2.1596479380570;
        Mon, 03 Aug 2020 11:29:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a184sm19938041pfa.83.2020.08.03.11.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 11:29:39 -0700 (PDT)
Date:   Mon, 3 Aug 2020 11:29:38 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: [RFC] saturate check_*_overflow() output?
Message-ID: <202008031118.36756FAD04@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I wonder if we should explicitly saturate the output of the overflow
helpers as a side-effect of overflow detection? (That way the output
is never available with a "bad" value, if the caller fails to check the
result or forgets that *d was written...) since right now, *d will hold
the wrapped value.

Also, if we enable arithmetic overflow detection sanitizers, we're going
to trip over the fallback implementation (since it'll wrap and then do
the overflow test in the macro).

e.g. I'm think of something like this (showing only "mul" here, and
untested):

diff --git a/include/linux/overflow.h b/include/linux/overflow.h
index 93fcef105061..00baf3a75dc7 100644
--- a/include/linux/overflow.h
+++ b/include/linux/overflow.h
@@ -71,12 +71,16 @@
 })
 
 #define check_mul_overflow(a, b, d) ({		\
+	bool __result;				\
 	typeof(a) __a = (a);			\
 	typeof(b) __b = (b);			\
 	typeof(d) __d = (d);			\
 	(void) (&__a == &__b);			\
 	(void) (&__a == __d);			\
-	__builtin_mul_overflow(__a, __b, __d);	\
+	__result = __builtin_mul_overflow(__a, __b, __d);\
+	if (unlikely(__result))			\
+		*__d = type_max(__a);		\
+	__result;				\
 })
 
 #else
@@ -105,15 +109,20 @@
  * If one of a or b is a compile-time constant, this avoids a division.
  */
 #define __unsigned_mul_overflow(a, b, d) ({		\
+	bool __result;					\
 	typeof(a) __a = (a);				\
 	typeof(b) __b = (b);				\
 	typeof(d) __d = (d);				\
 	(void) (&__a == &__b);				\
 	(void) (&__a == __d);				\
-	*__d = __a * __b;				\
-	__builtin_constant_p(__b) ?			\
+	__result = __builtin_constant_p(__b) ?		\
 	  __b > 0 && __a > type_max(typeof(__a)) / __b : \
 	  __a > 0 && __b > type_max(typeof(__b)) / __a;	 \
+	if (unlikely(__result))				\
+		*__d = type_max(typeof(__a));		\
+	else						\
+		*__d = __a * __b;			\
+	__result;
 })
 
 /*
@@ -176,6 +185,7 @@
  */
 
 #define __signed_mul_overflow(a, b, d) ({				\
+	bool __result;							\
 	typeof(a) __a = (a);						\
 	typeof(b) __b = (b);						\
 	typeof(d) __d = (d);						\
@@ -183,10 +193,14 @@
 	typeof(a) __tmin = type_min(typeof(a));				\
 	(void) (&__a == &__b);						\
 	(void) (&__a == __d);						\
-	*__d = (u64)__a * (u64)__b;					\
-	(__b > 0   && (__a > __tmax/__b || __a < __tmin/__b)) ||	\
-	(__b < (typeof(__b))-1  && (__a > __tmin/__b || __a < __tmax/__b)) || \
-	(__b == (typeof(__b))-1 && __a == __tmin);			\
+	__result = (__b > 0   && (__a > __tmax/__b || __a < __tmin/__b)) || \
+		   (__b < (typeof(__b))-1  && (__a > __tmin/__b || __a < __tmax/__b)) || \
+		   (__b == (typeof(__b))-1 && __a == __tmin);		\
+	if (unlikely(__result))						\
+		*__d = type_max(__a);					\
+	else								\
+		*__d = (u64)__a * (u64)__b;				\
+	__result;							\
 })
 
 

Thoughts?

-- 
Kees Cook
