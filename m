Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40361C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 03:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 195872064B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 03:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTUOyk1X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbgGJDsN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 23:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgGJDsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 23:48:12 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBCFC08C5CE;
        Thu,  9 Jul 2020 20:48:12 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id gc9so2033306pjb.2;
        Thu, 09 Jul 2020 20:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Gu/0uC+QDtxWdvOlcoY9Tz/6p4MtbAdmS5ljsFnkPqg=;
        b=WTUOyk1XhsR2CrACw12GvrBtOHIoBJXRPZ7puT8Ig377hIwjohKnCApbXtCZur5Kpc
         vboCygIXbWS8N/4oVDjoCI83vqq+eMcBwIeHEcA5nX3YRU18oDnR4ZgRAV9Rh4ud+MUC
         NGRhXMvM5Mv6jS9XHqbsfLBrVuCp7fCrXNb4vV9rs5B2IsmKk6z+Pf0yteZh5Fv0a4eK
         vmSJ7mmJB/vXr/uLvXh/QK4gg8iYjpCUX7mETKqyCOgz7WigiKLqnlZyoVcHLzD6jJFa
         ibMyla+iCR7k2hMqRmD+82C1lvTv0BF2mL4O51edRMneVduz4WUxQi34Va+NfH0I70HZ
         L2Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Gu/0uC+QDtxWdvOlcoY9Tz/6p4MtbAdmS5ljsFnkPqg=;
        b=UMkO/HvbYqPv1Tgaaw79+Mf2t497nCnGgzdFBl64xzynNJ9cRA9IAfQUMomNZaiPao
         PDOYKb5hD31yVr4IY4obHzGn/k1k1ToCFkPvmZ/FfQsktaPjhoH+Pzow5TNNpr3OSGtZ
         A5u92YYq/Ke/aWidgaWSwpdV81RKDtNds0mfV0fVY+EPDzfu5aes4FqdLpqsCqdsbRfU
         VEEvEyBLfepjtNCaVYqlajHwDxdETTeK8kQmrKJT0PWXb653RIMQvpCjYeyBdbvzTswp
         vfBYJmPz7VujNjDA6Z4aqjqMhMHVzdncC1gSH19XP7Ai3BOWQMsdFXigOgb1ZIdlM8LH
         iIeg==
X-Gm-Message-State: AOAM5314Z1kPc3GdL/geo96fPhVw1MAqDe5CdIKJ0SLP8z/1uJzyP0hx
        dHRAqClx7syi3QWPq0z2tkJck236
X-Google-Smtp-Source: ABdhPJy3j9HGfuqDOkOdpeR3fyETA37d659Nw8UvgOxUOHp5zF4w0idcLpnXqbnfPaPMvPAI7fuy9Q==
X-Received: by 2002:a17:902:d211:: with SMTP id t17mr21262388ply.106.1594352891825;
        Thu, 09 Jul 2020 20:48:11 -0700 (PDT)
Received: from localhost.localdomain ([2001:470:67:5b9:5dec:e971:4cde:a128])
        by smtp.gmail.com with ESMTPSA id p10sm4386285pgn.6.2020.07.09.20.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 20:48:10 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, balbi@kernel.org,
        gregkh@linuxfoundation.org, matthias.bgg@gmail.com,
        swboyd@chromium.org, chunfeng.yun@mediatek.com,
        linux-arm-kernel@lists.infradead.org, alcooperx@gmail.com,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH] MAINTAINERS: Add entry for Broadcom BDC driver
Date:   Thu,  9 Jul 2020 20:48:06 -0700
Message-Id: <20200710034806.15650-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Broadcom BDC driver did not have a MAINTAINERS entry which made it
escape review from Al and myself, add an entry so the relevant mailing
lists and people are copied.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1d4aa7f942de..360d001b81b8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3434,6 +3434,14 @@ F:	drivers/bus/brcmstb_gisb.c
 F:	drivers/pci/controller/pcie-brcmstb.c
 N:	brcmstb
 
+BROADCOM BDC DRIVER
+M:	Al Cooper <alcooperx@gmail.com>
+L:	linux-usb@vger.kernel.org
+L:	bcm-kernel-feedback-list@broadcom.com
+S:	Maintained
+F:	Documentation/devicetree/bindings/usb/brcm,bdc.txt
+F:	drivers/usb/gadget/udc/bdc/
+
 BROADCOM BMIPS CPUFREQ DRIVER
 M:	Markus Mayer <mmayer@broadcom.com>
 M:	bcm-kernel-feedback-list@broadcom.com
-- 
2.17.1

