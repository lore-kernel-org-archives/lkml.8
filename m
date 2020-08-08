Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7147C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 06:50:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B503720866
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 06:50:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ea8Mv7s+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726236AbgHHGuE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 02:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbgHHGuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 02:50:04 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5D36C061A27
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 23:50:03 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id u128so2327730pfb.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 23:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=skKsNjbR2sJekoTD7WKJQrDhL0mkikJinH+fXZp5WE8=;
        b=ea8Mv7s+x7UdwoHVdf5SJ9Cq0u6VfhxmRBbKZte2jB2D1XEyJuycS5MwF/TICAvOG6
         wQNq3cm/44Kuh0MCS/RxFXsDUPtYAGGd/0DxZWkWGAzqzjS3HNuZFkqonQzfI++B6ZBg
         EsG+bFZpc4DozCP/f10ZiP6pH4v9azmL3TKaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=skKsNjbR2sJekoTD7WKJQrDhL0mkikJinH+fXZp5WE8=;
        b=b06PaCR1OyDVeAsG1+DYG+OApsWFSoDJ6BnOaBcEvBTaW3YbanM4L39jwstiAhdE3C
         k+3hRh4VV8SHL+UGi10oRuzHrYuTxrdIj0z6cErZT6CslFw/16zuypWlsaqHA4NRIEST
         2YEFhnuQ1NwllVu8TN2cnY3P6ToT/YXKPhPXrhGThXl2tmd/4tZhCqMFftzqu4lWrWAq
         OHn+q3/T9I1ANcKpjuygxXy+QQRC128gufkhpyK8uIhzNj+CVvTk9Z2tFesJ9SJO3FnX
         AvnJ4dPqT4OGd53sMXfZPDzfK/I7CXaewz8QGFM2GVnfrCyUJT3buVJVtIHB8hO2YiIY
         Jpag==
X-Gm-Message-State: AOAM532XbYjtSbB/Gkvp92uSKm5JZ62cO6zzwsTCokYQNHqq27fximUM
        4+Kej8YqeoCfMVIzswyiJe8jxw==
X-Google-Smtp-Source: ABdhPJxNkNRAvvV1SMnZ96w4Ht5xtafmTpd1uB4vQPCMQMVv4eN9p49igoUEy55OeoNMF0Xxp3RRBQ==
X-Received: by 2002:a63:d1f:: with SMTP id c31mr13975091pgl.27.1596869403032;
        Fri, 07 Aug 2020 23:50:03 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id g5sm7294301pjx.53.2020.08.07.23.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 23:50:01 -0700 (PDT)
Date:   Fri, 7 Aug 2020 23:49:59 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH] docs: Fix function name trailing double-()s
Message-ID: <202008072348.3BA3DD14E@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed a double-() after a function name in deprecated.rst today. Fix
that one and two others in the Documentation/ tree.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/RCU/lockdep.rst                           | 2 +-
 Documentation/process/deprecated.rst                    | 2 +-
 Documentation/translations/it_IT/process/deprecated.rst | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/RCU/lockdep.rst b/Documentation/RCU/lockdep.rst
index f1fc8ae3846a..cc860a0c296b 100644
--- a/Documentation/RCU/lockdep.rst
+++ b/Documentation/RCU/lockdep.rst
@@ -49,7 +49,7 @@ checking of rcu_dereference() primitives:
 		is invoked by both RCU-sched readers and updaters.
 	srcu_dereference_check(p, c):
 		Use explicit check expression "c" along with
-		srcu_read_lock_held()().  This is useful in code that
+		srcu_read_lock_held().  This is useful in code that
 		is invoked by both SRCU readers and updaters.
 	rcu_dereference_raw(p):
 		Don't check.  (Use sparingly, if at all.)
diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
index 4a9aa4f0681e..918e32d76fc4 100644
--- a/Documentation/process/deprecated.rst
+++ b/Documentation/process/deprecated.rst
@@ -142,7 +142,7 @@ only NUL-terminated strings. The safe replacement is strscpy().
 (Users of strscpy() still needing NUL-padding should instead
 use strscpy_pad().)
 
-If a caller is using non-NUL-terminated strings, strncpy()() can
+If a caller is using non-NUL-terminated strings, strncpy() can
 still be used, but destinations should be marked with the `__nonstring
 <https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html>`_
 attribute to avoid future compiler warnings.
diff --git a/Documentation/translations/it_IT/process/deprecated.rst b/Documentation/translations/it_IT/process/deprecated.rst
index e108eaf82cf6..a642ff3fdc8b 100644
--- a/Documentation/translations/it_IT/process/deprecated.rst
+++ b/Documentation/translations/it_IT/process/deprecated.rst
@@ -130,7 +130,7 @@ chi usa solo stringe terminate. La versione sicura da usare è
 strscpy(). (chi usa strscpy() e necessita di estendere la
 terminazione con NUL deve aggiungere una chiamata a memset())
 
-Se il chiamate no usa stringhe terminate con NUL, allore strncpy()()
+Se il chiamate no usa stringhe terminate con NUL, allore strncpy()
 può continuare ad essere usata, ma i buffer di destinazione devono essere
 marchiati con l'attributo `__nonstring <https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html>`_
 per evitare avvisi durante la compilazione.
-- 
2.25.1


-- 
Kees Cook
