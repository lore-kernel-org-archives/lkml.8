Return-Path: <SRS0=2gEN=4S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED293C3F2D1
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 04:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C27CC21556
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Mar 2020 04:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IGoTtOj/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgCAEST (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Feb 2020 23:18:19 -0500
Received: from mail-lf1-f41.google.com ([209.85.167.41]:40117 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgCAESS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Feb 2020 23:18:18 -0500
Received: by mail-lf1-f41.google.com with SMTP id c23so5244171lfi.7;
        Sat, 29 Feb 2020 20:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NmeW9ngS8eifN3sjrGPI1hv1F6A8Nf5uvazYyp+BS9k=;
        b=IGoTtOj/+h+27xsprKEwSB2qcBhb683X9DwROzGYqXm+H59aKnzxoxyZsuIXX6gr9g
         Hqm193MELCrjP4bw/CDODOd4MTJaCCXhKqnG4U+qBviN78AtQRY+9XQgi6VjeKAl+tnB
         Q0NriuGon6BFujvANHfQPnoFpzY6wbonu7bed59nKtd7x6TvS7DCxw2tUIvtpucKTC0l
         H7Q8IvcFoUCwgxT4A7iApdTUZA/CfcLbo9NP7VeHFjy3XDInj+tLwzQFLbjVBnf1BSlW
         xq0KajxErNFSX7q3umxr5NoR+ncHuRO+3DOlQq6w0DcA5PIG7lb1AUCF3XuzZYksHBlB
         ciQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NmeW9ngS8eifN3sjrGPI1hv1F6A8Nf5uvazYyp+BS9k=;
        b=Ps5gZcUoVx92BEnPKzx4KlYGzu0WTvhGkSxyHhNtWnMAZLzQDcvXAP1GeFChqsdgBk
         vmKXT5rIhHTbxUPq54oUMScFVJhKHDsNw8CkljnZaD4fctynDDipbB+fUCC63ozfTEt8
         tjswIYzh3w1EdfF+t2ZbKR+adKb++Uzc84tsvFFvu4DCheFW7RccsPyu7zdJ361CG4W/
         gau+eAAK5YQK0aRCRWoaG7IxqWPRTarFu0chLRbJ7IS0RHylnDMYjJ5r0tpyAab6hgzW
         XtXWVsLMOFx/FrXVugZr4a5d1bgIJkVBsH8KimlJPdppJZB4OuqOwYUwUNMbAwjHfMrV
         Zoqw==
X-Gm-Message-State: ANhLgQ1bJCnDHyh17XWp+nEe/7+zYOT5/TMdKDCELWLFppawMGSR90zI
        d7nY2ciTuJcJ7z3KNKJrTkk=
X-Google-Smtp-Source: ADFU+vvWv2MfdXTIoklhtFwuyU9dmZq6l6Sra2HjKG0MG58egW1bNdSDN0IeN0EFItKplxmO7nXfHg==
X-Received: by 2002:a19:c1cd:: with SMTP id r196mr6771461lff.22.1583036296016;
        Sat, 29 Feb 2020 20:18:16 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id y24sm9568864lfg.63.2020.02.29.20.18.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 29 Feb 2020 20:18:15 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        =?UTF-8?q?Jer=C3=B4me=20Brunet?= <jbrunet@baylibre.com>
Subject: [PATCH v6 1/3] dt-bindings: add vendor prefix for SmartLabs LLC
Date:   Sun,  1 Mar 2020 08:17:19 +0400
Message-Id: <1583036241-88937-2-git-send-email-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583036241-88937-1-git-send-email-christianshewitt@gmail.com>
References: <1583036241-88937-1-git-send-email-christianshewitt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SmartLabs LLC are a professional integrator of Interactive TV solutions
and IPTV/VOD devices [1].

[1] https://www.smartlabs.tv/en/about/

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 9e67944..a34ed82 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -901,6 +901,8 @@ patternProperties:
     description: Sitronix Technology Corporation
   "^skyworks,.*":
     description: Skyworks Solutions, Inc.
+  "^smartlabs,.*":
+    description: SmartLabs LLC
   "^smsc,.*":
     description: Standard Microsystems Corporation
   "^snps,.*":
-- 
2.7.4

