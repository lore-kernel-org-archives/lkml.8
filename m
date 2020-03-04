Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E85DC3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 19:13:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D704A21775
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 19:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KrDb4dJR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgCDTNb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 14:13:31 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42384 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgCDTNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 14:13:31 -0500
Received: by mail-pl1-f194.google.com with SMTP id u3so1431709plr.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 11:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=bWWT0U7gHG36go3/z5DgOvjRYUt+7WTsiRbz2Kqd1qY=;
        b=KrDb4dJR9TipAek99R/Qkotco316kjOROJVvfj5QLq2nQMUrLqLQWHPvZ2YmRFk+gL
         Xb457WqeHGsnYiVRwkmmRDvKa0Ml4oO6WGX1TAw3O/GjciLLmoxs89vhtJe24P2pItz7
         3cdXBGHTQ9kIWAKHZdsOk9hBs8MK1zInEOie8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=bWWT0U7gHG36go3/z5DgOvjRYUt+7WTsiRbz2Kqd1qY=;
        b=b0+uy63X2KMDrLbL0h9t9kXIsSV3Zx6QnZzlAd/nASkgILWs95zgAkJr9iQdElm1Ot
         DbLbYBsdbLb0GXFY4Mn4STUqIx2EfQ1L3OfJ1eV9XYH6fG70U9kBooh2Js+ONwWx7XI6
         AQEuxzR/nteyK3PggNiyopDN2MS7RAqF6sJ5H0cI8Vz9EeB4nN4QvzdTVbA3/CK97lql
         Tp1NSZz0cEbs4HQMqQ5BxRfXP1vQ0XkJ/+fn5eR6V1ajzdQjRP3VS/k0X94WxQem/GeR
         KuHSL0ZskXV2hnZs/jPHxs6C6oyN97CbE2PkXcdm/0Sq+b7TcPvwP4nVlSTAn9czIhSj
         chRw==
X-Gm-Message-State: ANhLgQ2M2Xex837XG3Z1/qBC6udZPx+dxZtHSUt6e8UzolTXACiEXHiV
        bRU8ZlDSfNYL2ZOVYhsPm3LgdQ==
X-Google-Smtp-Source: ADFU+vs8lPKj88hbp2zjV9Zwouj4ueT/9QLwk1yoVWR8eEp+HS7tGSSmKS4bSvY+HXXNwHbodHUsdg==
X-Received: by 2002:a17:90a:f0c8:: with SMTP id fa8mr4540508pjb.136.1583349210375;
        Wed, 04 Mar 2020 11:13:30 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id r12sm29051419pgu.93.2020.03.04.11.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 11:13:29 -0800 (PST)
Date:   Wed, 4 Mar 2020 11:13:28 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs: deprecated.rst: Add %p to the list
Message-ID: <202003041103.A5842AD@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once in a while %p usage comes up, and I've needed to have a reference
to point people to. Add %p details to deprecated.rst.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 Documentation/process/deprecated.rst | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
index f9f196d3a69b..a4db119f4e09 100644
--- a/Documentation/process/deprecated.rst
+++ b/Documentation/process/deprecated.rst
@@ -109,6 +109,23 @@ the given limit of bytes to copy. This is inefficient and can lead to
 linear read overflows if a source string is not NUL-terminated. The
 safe replacement is :c:func:`strscpy`.
 
+%p format specifier
+-------------------
+Using %p in format strings leads to a huge number of address exposures.
+Instead of leaving these to be exploitable, "%p" should not be used in
+the kernel. If used currently, it is a hashed value, rendering it
+unusable for addressing. Paraphrasing Linus's current `guideance <https://lore.kernel.org/lkml/CA+55aFwQEd_d40g4mUCSsVRZzrFPUJt74vc6PPpb675hYNXcKw@mail.gmail.com/>`_:
+
+- Just use %p and get the hashed value.
+- If the hashed value is pointless, ask yourself whether the pointer
+  itself is important. Maybe it should be removed entirely?
+- As a last option, if you really think the true pointer value is
+  important, why is some system state or user privilege level considered
+  "special"? If it is well justified (in comments and commit log), maybe
+  you can use %px along with making sure you have sensible permissions.
+
+A system-wide toggle will `not be accepted <https://lore.kernel.org/lkml/CA+55aFwieC1-nAs+NFq9RTwaR8ef9hWa4MjNBWL41F-8wM49eA@mail.gmail.com/>`_.
+
 Variable Length Arrays (VLAs)
 -----------------------------
 Using stack VLAs produces much worse machine code than statically
-- 
2.20.1


-- 
Kees Cook
