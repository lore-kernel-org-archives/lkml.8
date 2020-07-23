Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 668CBC433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 23:05:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4037220737
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 23:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oKJuJgi3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728103AbgGWXFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 19:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728027AbgGWXFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 19:05:51 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B918C0619D3;
        Thu, 23 Jul 2020 16:05:51 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id x72so3933038pfc.6;
        Thu, 23 Jul 2020 16:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Zf3sEMsL0DPGCRUnLMz+Lz6K06ydPn+rQ+/2py+7OzE=;
        b=oKJuJgi3jXl0gFItYfYerp5IuxM+KnI/XCd+fqR7+VKJwnwOZTDB3UxG9XC0UQsCey
         aDPdu2Tb4JXmd/J3I3KcbxapdceIy8bznltwlbQ8vZwa9+AmhyO1CmAUB725E4bM+ONW
         N35jTF8ny1KZpsWHE9VhjuTaL8xYOqD89qq8JhTpL7zr0v8iks0nyKknj1CGvux++7KH
         Yidx/P7DfYyVOHv75uZniLyB3n8qhOKGM+QbYGd14sPARZXev81Aor5ml30g/SoWG/Po
         N7VZlNg+8snGhUFW4i1OCn66fvIe7Kg4UGMo7Ox7uCWzukia7dSWj7ifSpIh1GmuPLRc
         Q55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Zf3sEMsL0DPGCRUnLMz+Lz6K06ydPn+rQ+/2py+7OzE=;
        b=XXZt/2YzoyE4slaTWi/d8WEpzqVcnpJ7Vgi4fJlevv+v6z20ht+mz67dt/w9D88xsM
         O1jTjafKFBTpa7eBhBRr0JXhoqzJh1+6LVo1VRFdH66Iq8YAznyE5uU+jD3qRu15+VUv
         UhtXLwyyp1x7277KYagoQ2GZXSA/fh8Xbo6V3wEha9f4PFSAPbm/g15DGahCOcBCjPG0
         YkVbqrXFUhTnwwF8lnSrzHi7OvH6GtcowOucXBCSXDwkwQ7GQjyBanMm2zXQ/DZGGArg
         sdQ5lYBot5h3Ug0Oqzz4XorPifgLlggS+B3Afxv9osOo80/lGY62gt2JhQPP1FNZZxDh
         h+kA==
X-Gm-Message-State: AOAM5329Z6UPbGDrR32x5s8Wy3Sb94y1qOx81mm6LpdvyUA1QJXFMa5C
        mFc9IZb0wTubBWu5SwFG+qc=
X-Google-Smtp-Source: ABdhPJzSr/qRS6pTZToh9J+O+BKWXJaU9VYurAj++Srk/ErDDZN8/HehZ/qFCw5K6+UHcK0Q1jzQfQ==
X-Received: by 2002:a05:6a00:782:: with SMTP id g2mr6316942pfu.126.1595545550863;
        Thu, 23 Jul 2020 16:05:50 -0700 (PDT)
Received: from taoren-ubuntu-R90MNF91.thefacebook.com (c-73-252-146-110.hsd1.ca.comcast.net. [73.252.146.110])
        by smtp.gmail.com with ESMTPSA id gn5sm3644742pjb.23.2020.07.23.16.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2020 16:05:50 -0700 (PDT)
From:   rentao.bupt@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org, taoren@fb.com
Cc:     Tao Ren <rentao.bupt@gmail.com>
Subject: [PATCH v2 2/3] ARM: dts: aspeed: wedge40: enable adc device
Date:   Thu, 23 Jul 2020 16:05:38 -0700
Message-Id: <20200723230539.17860-3-rentao.bupt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200723230539.17860-1-rentao.bupt@gmail.com>
References: <20200723230539.17860-1-rentao.bupt@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tao Ren <rentao.bupt@gmail.com>

Enable adc controller and corresponding voltage sensoring channels for
Wedge40.

Signed-off-by: Tao Ren <rentao.bupt@gmail.com>
---
 Changes in v2:
   - Nothing changed. Resending the patch just in case the previous
     email was not delivered.

 arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
index aea23c313088..1049cfa80ac2 100644
--- a/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
+++ b/arch/arm/boot/dts/aspeed-bmc-facebook-wedge40.dts
@@ -27,6 +27,11 @@
 	memory@40000000 {
 		reg = <0x40000000 0x20000000>;
 	};
+
+	ast-adc-hwmon {
+		compatible = "iio-hwmon";
+		io-channels = <&adc 5>, <&adc 6>, <&adc 7>, <&adc 8>, <&adc 9>;
+	};
 };
 
 &wdt1 {
@@ -126,3 +131,7 @@
 &vhub {
 	status = "okay";
 };
+
+&adc {
+	status = "okay";
+};
-- 
2.17.1

