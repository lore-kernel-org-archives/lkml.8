Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F10EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 23:15:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D08F2068E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 23:15:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nlDElXol"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgFOXPi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 19:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725960AbgFOXPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 19:15:37 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C5CC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 16:15:37 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l17so1161128wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 16:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dWQlCnE7maS8wm7a3DA3gd5Zr0pgvg11Rme0nYpS72w=;
        b=nlDElXolMQF8tXJOD0uxKuE1mPso8DMpdpV2oym5fGxBkk35MkYCldHcamozMR75pb
         u2xkyoEgjrJGs9hYA89AN0b5jKs1G0womn8MEpHwByAlLUTjn0u/NVJWj9B/AlcHSiEx
         LzTQTFdIkPZkeDBXKWUksYUcnmASn54pw3nDQkudpMsvUy3+KZaLuNtu1cjvmE01vzw9
         Mx7ozS8t8sUDNPETsDZMfsfBtW3Gld+zUif5PNoHNgxNG/ZI8h6cE4gFqEkZ5qusR4vy
         +aN/sfXEEue7d9GyiCWKKiyrNvVoCuKaZM57CxJFLHEbEP2K4yL0+xJqQLSOPkREU10O
         2+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dWQlCnE7maS8wm7a3DA3gd5Zr0pgvg11Rme0nYpS72w=;
        b=l/brbN/Awiz/gPhHkSnaQ70EAPnr7Do+/UHTb3v1udM9qBywl6YlCydOoy6Z91hbTi
         gTu2OalNK8ORu6Djy7TLQ7Oe15ThdJaljOzMuklEkqr6RttZdsu5zCgNifuuFUv57MH9
         jgyCAeYULlA5iM8y3zAYDltQkFEFJnh8kVNpX1+RqnmgDnHun+ZVGCWX4qFbdoCl6ra7
         VCyVCmrmLUJRHkIf9DhhlrdZxsbH8qIXNCAy9hcTIEO18rfhYc3puG8t0i7mUb6aF0bt
         OGTqV80uVHXsTRDHV4ssJYUV5Vj2G1q8EhB0Y8s88fcTsr4NyOUcQtHwmfhvg5Gweaxw
         T0QQ==
X-Gm-Message-State: AOAM5302WMjn/8JpjylWOXpe0rU0Dao13yVZZ7JVoxBWt+m+BoAou2+p
        PIHetClCBMiNOHOgQFUAnPVYsg==
X-Google-Smtp-Source: ABdhPJxa2HdiOKvNpxpmH/vjOg0PanAxBXKq9qTbpxpPhWU5yOqitFvSxoq0K3iIsQw03ndoXM7L0g==
X-Received: by 2002:a1c:b443:: with SMTP id d64mr150530wmf.157.1592262935863;
        Mon, 15 Jun 2020 16:15:35 -0700 (PDT)
Received: from google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id r12sm27826004wrc.22.2020.06.15.16.15.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 16:15:35 -0700 (PDT)
Date:   Tue, 16 Jun 2020 01:15:29 +0200
From:   Marco Elver <elver@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] compiler_attributes.h: Support no_sanitize_undefined check
 with GCC 4
Message-ID: <20200615231529.GA119644@google.com>
References: <202006160328.6MfJNuqX%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006160328.6MfJNuqX%lkp@intel.com>
User-Agent: Mutt/1.13.2 (2019-12-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UBSAN is supported since GCC 4.9, which unfortunately did not yet have
__has_attribute(). To work around, the __GCC4_has_attribute workaround
requires defining which compiler version supports the given attribute.

In the case of no_sanitize_undefined, it is the first version that
supports UBSAN, which is GCC 4.9.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Marco Elver <elver@google.com>
---

Doing a 'make W=1' with GCC 4.9 and the provided config fixes the build
robot's report.

Peter: Feel free to either squash this patch into the one adding
__no_sanitize_undefined or apply on top.

Although at this point we don't have any users of
__no_sanitize_undefined anymore since objtool resolved the noinstr
problem for UBSAN differently. We should probably keep the attribute
around because eventually somebody will need it.

Thanks,
-- Marco

---
 include/linux/compiler_attributes.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index cdf016596659..c8f03d2969df 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -40,6 +40,7 @@
 # define __GCC4_has_attribute___noclone__             1
 # define __GCC4_has_attribute___nonstring__           0
 # define __GCC4_has_attribute___no_sanitize_address__ (__GNUC_MINOR__ >= 8)
+# define __GCC4_has_attribute___no_sanitize_undefined__ (__GNUC_MINOR__ >= 9)
 # define __GCC4_has_attribute___fallthrough__         0
 #endif
 
-- 
2.27.0.290.gba653c62da-goog
