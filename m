Return-Path: <SRS0=iO2y=4R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 984CCC3F2C6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 14:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B1BE24699
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Feb 2020 14:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5/pObSF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbgB2OKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 09:10:09 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:34752 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgB2OKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 09:10:08 -0500
Received: by mail-lj1-f195.google.com with SMTP id x7so6602046ljc.1;
        Sat, 29 Feb 2020 06:10:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=r/iCABg4UBjB++Fm7IMDHmXpxhSnsF+XLYegHsRByUs=;
        b=h5/pObSF/xkpM2FbDhJrj7JLttJODK8r4OoPMORIZnz/ls4WhVKbLzg9TByoKc36eA
         smr8i+k1W1Ap5S2q4FmE5Xn6GW91Y+Is5GcK8IKAbvVdqBgsyWkaBeXzsWi6lhOgxNoS
         8DmO2/MkQqrm930PT9+eeUNV4y86vb0HArssRz0RU4MV5ZfZp1fFNxVGqMA4CEuE9Rd/
         WjBaGagO7Mns+CO+PctTbrqTNrzJPXLnz6SQVh7A6yvo9Fm1Z9P9nowAyeYxy+eObcS/
         ycfjlL4MtwfRrIEq5WWNC0xLYa2GBsJXlLXailljNq9TRHDSb1bJpJ2vgM6jDZvlf8n+
         PDBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=r/iCABg4UBjB++Fm7IMDHmXpxhSnsF+XLYegHsRByUs=;
        b=cb9GjtKukreOzlajaFzq2PWB2m0SEjuuNnkXoQkIBUNc6rRRaNfynZk0nqGDXPJJJu
         sLVEI7yw87iUA3SSsceHjjzVLbyb2ACI5EvBmCc4GpVpOifC9b+VOL8CNoRsP+Ao5WXO
         L5vDFet+nJdFtu2EwcwHxNcBLArl676Wd1AnveKI5BZhEFGdKnbFJgKWgZLPk7a1NJI/
         OdU/Cyze4ck3j69dOamwvlQjetK7oGUBtgv3IMI6sjyCeuAtWoHLZ5j97xv1XZ3PaHxa
         UsufFcvsphISfmK0nPFBZ2diirr6nOm2MF9RpC9OJG27Eq2kyn3/GtI64laJzBgJe3JM
         C/Yg==
X-Gm-Message-State: ANhLgQ08uY/jm81zazSoVhUhtcn1DDXP1MgO/2g+hN5cLYSPe7iVDXk7
        TYt9444GQ/UOXWNSnwB10UApf+gV+NJxmw==
X-Google-Smtp-Source: ADFU+vtZyjptE2moe72CDf/tXaeElIWg7AMBJ4+wkWWAYrOyrnBfvQrLP784TZMKurcmn6gCvOxYhw==
X-Received: by 2002:a2e:7005:: with SMTP id l5mr5781465ljc.230.1582985406655;
        Sat, 29 Feb 2020 06:10:06 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id j11sm7104124lfb.58.2020.02.29.06.10.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Feb 2020 06:10:06 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 1/2] dt-bindings: arm: amlogic: add support for the Beelink GT-King
Date:   Sat, 29 Feb 2020 18:09:12 +0400
Message-Id: <1582985353-83371-2-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582985353-83371-1-git-send-email-christianshewitt@gmail.com>
References: <1582985353-83371-1-git-send-email-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Shenzen AZW (Beelink) GT-King is based on the Amlogic W400 reference
board with an S922X chip.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/arm/amlogic.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/amlogic.yaml b/Documentation/devicetree/bindings/arm/amlogic.yaml
index f74aba4..6bf9bbc 100644
--- a/Documentation/devicetree/bindings/arm/amlogic.yaml
+++ b/Documentation/devicetree/bindings/arm/amlogic.yaml
@@ -148,6 +148,7 @@ properties:
       - description: Boards with the Amlogic Meson G12B S922X SoC
         items:
           - enum:
+              - azw,gtking
               - hardkernel,odroid-n2
               - khadas,vim3
               - ugoos,am6
-- 
2.7.4

