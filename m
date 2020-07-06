Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAABC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 10:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92E3720715
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 10:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DZNreafT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbgGFK5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 06:57:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728529AbgGFK5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 06:57:48 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FE0C061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 03:57:47 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id j18so38746678wmi.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 03:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VRAGgZFnNGbZfF3FXbHx1jVMVdZOphG/3DoDAkcd1es=;
        b=DZNreafT6odk0ibgNYJ5XXIzXGAoeTjEMrN27W+E7DH8Zv45kpK6gOWMv/t3NYJ2Gq
         IvxUTlKKtZDsgTPp8P777asJ2FJyjhBj8DcEMTXqGt8aelfK6wWQQ0t2Iltoe5DHi0CC
         oEbN84P9H2jyIPsDK1501XCqD3Qsvd3xkvs13lCcgoB+9t9NtTuqPMkv+P5izo5nNjOE
         yclT1dUz7G5kXgDwO8mXHKI//L93gxzZCkWcXTLVsUT6ffn5dx+tpV8IWahTnXALd2py
         aG8s1aDC11mGpZG/Emi4J35UjUyycZ0nX7YQGwEE5fpM2nMxpGMAgmi/Tsqzu4hSfclL
         kBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VRAGgZFnNGbZfF3FXbHx1jVMVdZOphG/3DoDAkcd1es=;
        b=fyfarTfPwoAVzWAOs+RtAoMgB7ngj28uWj91Nsu3PPqKqW3UAiH5dE7BWaiRlTcVGe
         qG00WZwnTm6zRkl2ryHpPYSaaem8gD4lUK7S9MSalAV6rfQqsN0qTn9dpz++8em/u7b/
         1pgYtre7b4b+MIs7+u/2lBcY1R/N0gTCWP0bHw9LJwei2m27PfPYMqwzsty3NDyvj0J7
         uHPsvG4t09tOeR7nWM29A+QH+1uZsHfhT7PC+K42b3dJMzizk4f8RHNimMvw1IqyVrRg
         7LW5B9Uqw1tD8PbbdhNSSPI2ZX5wZ2lynLpgZKUWZXVj9bJOugvbGAIEkyQEvCGV3wWT
         ex7g==
X-Gm-Message-State: AOAM531C4l8s2WSVYtgTILwhzyO4m9PqVhYnMVY1AB2yiG/D+grwbNNM
        VF2jdQjofoHj+RAkv+edRJyKC0NZphY=
X-Google-Smtp-Source: ABdhPJxgvtStstbbFLcI6l5L4oGamr70uiSQenQFm53C4+40ZqQaNclW0DbHoDM+pYImyWC0BBR2Eg==
X-Received: by 2002:a1c:1fc2:: with SMTP id f185mr48701370wmf.0.1594033066450;
        Mon, 06 Jul 2020 03:57:46 -0700 (PDT)
Received: from maphy.uni-hannover.de ([130.75.75.70])
        by smtp.gmail.com with ESMTPSA id h2sm23585127wrw.62.2020.07.06.03.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 03:57:46 -0700 (PDT)
Date:   Mon, 6 Jul 2020 12:57:44 +0200
From:   Tammo Block <tammo.block@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: [PATCH v3 1/6] tiocl.h: Change/Add defines for mouse report
Message-ID: <c634f34e11fad08d0d4b049507314e59bff8e130.1594032517.git.tammo.block@gmail.com>
References: <cover.1594032517.git.tammo.block@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1594032517.git.tammo.block@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add additional defines for mouse event types. The change of the value
of TIOCL_SELBUTTONMASK deserves a bit more explanation :

The old value of 15 uses the first 4 bits and sends them unchanged back
to userspace if requested by an application. But in fact only the first
two bits have ever been used by any daemon or useful at all, as the
kernel already knows the status of the shift and alt keys encoded in
bits 3 and 4. On the other hand we *do* want to know the status of bits
6-8, encoding button values >3 and mouse move and drag operations.

This change is up- and downwards compatible by masking all spourious
bits and leaving only the undisputed parts (bits 1 and 2) untouched.

Signed-off-by: Tammo Block <tammo.block@gmail.com>
---
 include/uapi/linux/tiocl.h | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/tiocl.h b/include/uapi/linux/tiocl.h
index b32acc229024..3717e865571d 100644
--- a/include/uapi/linux/tiocl.h
+++ b/include/uapi/linux/tiocl.h
@@ -9,7 +9,7 @@
 #define 	TIOCL_SELPOINTER	3	/* show the pointer */
 #define 	TIOCL_SELCLEAR	4	/* clear visibility of selection */
 #define 	TIOCL_SELMOUSEREPORT	16	/* report beginning of selection */
-#define 	TIOCL_SELBUTTONMASK	15	/* button mask for report */
+#define 	TIOCL_SELBUTTONMASK	0xe3	/* button mask for report */
 /* selection extent */
 struct tiocl_selection {
 	unsigned short xs;	/* X start */
@@ -28,7 +28,11 @@ struct tiocl_selection {
 
 /* these two don't return a value: they write it back in the type */
 #define TIOCL_GETSHIFTSTATE	6	/* write shift state */
-#define TIOCL_GETMOUSEREPORTING	7	/* write whether mouse event are reported */
+#define TIOCL_GETMOUSEREPORTING	7	/* write which mouse events are reported */
+#define		TIOCL_REPORTBTNPRESS	1	/* report button press only    "9" */
+#define		TIOCL_REPORTRELEASE	2	/* report press and release "1000" */
+#define		TIOCL_REPORTDRAG	3	/* report drag events       "1002" */
+#define		TIOCL_REPORTANYMOVE	4	/* report any movement      "1003" */
 #define TIOCL_SETVESABLANK	10	/* set vesa blanking mode */
 #define TIOCL_SETKMSGREDIRECT	11	/* restrict kernel messages to a vt */
 #define TIOCL_GETFGCONSOLE	12	/* get foreground vt */
-- 
2.27.0

