Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7ECC433E5
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 14:10:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8948A22B4E
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 14:10:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dp1f9xNn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgGSOKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 10:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgGSOKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 10:10:45 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5B28C0619D2;
        Sun, 19 Jul 2020 07:10:44 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id w3so22682275wmi.4;
        Sun, 19 Jul 2020 07:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6+i6RY9LWPM0oMc6IkXi+EqQQ0KYWnUH3ATLz37JIGc=;
        b=dp1f9xNnBRiEwNcHBq0meBXNOsWJkgt3Uoi0BWGbQ6VsOIq7LmcH3kzOo2MJn9tUfa
         Bv+4UhVMJkwHxzHg4zfV5e3Mlita+S766uE5+2hdW25VhrNfVPXw6IIQIHCjsbK/P+P+
         pkL59RXE7DiJ/d8qXcO9tEjnYIymZ0lKAnqv7Yu0/7FTLM2v6EgVarGMLMK0uNT4Qw8X
         pqWntsnWCzFsk2yBiJfD0tIE3rGRb3wVAvfNjh2gQlWqRgDBV4tWgu9zXdCoE6VTc7mO
         6QsBhyNRmSLhCOGleBw36/s9cHigai5vbUqdRgGohvxwv4eNbz+3J+z8UEHoAJBiSP5J
         QmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6+i6RY9LWPM0oMc6IkXi+EqQQ0KYWnUH3ATLz37JIGc=;
        b=jPOmOFETEKEVXFMtgHiVsYo3SMZGt4LBBGkEp/8X4YJohM4u85lJQu1LF9BYzxJvyx
         d+KkI6QF2dkxpZ7ci89hc8UZBGACEOVoYlLqekUah6x61uwXlNrmHV+a0Itxte3dekjP
         iH7yUuj9o50gg0bFeIpwhFsvdteCYxEzTX+dRcdK7EKrMUiQqCvobTILKz9UtL9MP2mw
         VNl2XtXKKIAh4D+zXLt1DjqyiQ5+8f4geEz9uZIYPhfeDBnRncUFBNgiOEY2tJKcu7Na
         T4NlhDa4ZvFd2s9D6eswK0BLG/Mh3bgmD7H+JUOR8R/r5hBJUOQp6jUCI6Kgs0rcFDtq
         k9hw==
X-Gm-Message-State: AOAM530gZuLY3WdOKkhN0c8MAsAmH8uxS5nCi8uzaMW4gtQ2T6eHpmOu
        iQNipQb/mhk8Txt69Mj7UkM=
X-Google-Smtp-Source: ABdhPJzq4GQqvr8i9zhthgq+iMBYiRgjINWCxSMC2J6MWU6I+sNtickMI/hOp9jSKWuJ5bcybWdaYg==
X-Received: by 2002:a1c:2e57:: with SMTP id u84mr18708737wmu.52.1595167843592;
        Sun, 19 Jul 2020 07:10:43 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id y11sm9215554wrs.80.2020.07.19.07.10.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 07:10:43 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Dongjin Kim <tobetter@hardkernel.com>
Subject: [PATCH 2/3] dt-bindings: arm: amlogic: add support for the ODROID-N2+
Date:   Sun, 19 Jul 2020 14:10:33 +0000
Message-Id: <20200719141034.8403-3-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200719141034.8403-1-christianshewitt@gmail.com>
References: <20200719141034.8403-1-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HardKernel ODROID-N2+ uses a revised Amlogic S922X v2 chip that supports
higher cpu clock speeds than the original ODROID-N2.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index 378229fa8310..595bb1d089f7 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -152,6 +152,7 @@ properties:
               - azw,gtking
               - azw,gtking-pro
               - hardkernel,odroid-n2
+              - hardkernel,odroid-n2-plus
               - khadas,vim3
               - ugoos,am6
           - const: amlogic,s922x
-- 
2.17.1

