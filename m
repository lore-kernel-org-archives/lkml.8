Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6464EC8300C
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 11:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C1E8206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 11:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura-hr.20150623.gappssmtp.com header.i=@sartura-hr.20150623.gappssmtp.com header.b="a8bAvr4t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgD2LH4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 07:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726808AbgD2LHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 07:07:53 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36269C03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 04:07:53 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id f13so1954858wrm.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 04:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KJmebWLDjLh8vCDBka3zVT6nvvCa+5XmuntIjuQhiRE=;
        b=a8bAvr4tStYxSiUIDr6CBH1RpXcjAMY6BYfytKrGJMS3014kO0oblUdosbqFinyAsn
         /y7zsjtKhwO/CCEzsfFbCbo9oamzSyyaSqYgbX9Y8pM7M6wTXDaSR7LIPlhWDD3NBQCe
         Yx81Yuh5JvZAMajTarm3aG00aEUr3wES/l62cTslRFXyitByx+FCrtFh3mU/orHyrIis
         N80oRdH4FhllSfLWsF3mLu5eSEiJ4QsuwCpZpM/CF6Y70ixk7UE73F7/GKxKE1nsfwYp
         +gS+wxjIHW08Rkpppp7y4Ht3pHTK7ParjBdVZf77zGNqIi/A1VxpVpmru3bLauvJyHzy
         2UPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KJmebWLDjLh8vCDBka3zVT6nvvCa+5XmuntIjuQhiRE=;
        b=hIBZJ0kBDAtgJ//wG7X1bvSy46sdIUKe0ZPS4U2VhK3uqXnUJwK3E86bIchV0H3QWV
         t9ehLN8EHuMndcecLu8yNhHj3U9SEe8TgDkPDNn//fdbvO0lc18KBcL44NHLdGINW4Ks
         SUr+9bEH09YmhXg1UOyPCPDOspFk3zIkjjyQWwt70Szcv1Bhy2ViJsjM4uYqDYAxLWou
         1KGh3lFsKRujJxn9wHXthUEgWXPTg6kJVffOBGFARtfzvApJcBL53S3uJc9mJELay12E
         X+IufeEJwRN6EXlYhQi7HXTVRStE8bK7LVk7uiKJDNFUm5X95UaJLqE8DBTaSUij9PId
         jSVw==
X-Gm-Message-State: AGi0PubNACuoSvanNWZsebzredkv5EuXJqHv388PtPAOt9mUv9R6yriQ
        7PCPqHENH7NqnZCecu6Djwy7cg==
X-Google-Smtp-Source: APiQypIz3/hA+7TRshIH/ZVdn0UyHlwF6q8tWlAm9hqsVhDplySuS0IVFw3daGFhG17P0Yof3jG+0g==
X-Received: by 2002:a5d:4443:: with SMTP id x3mr37857274wrr.162.1588158471948;
        Wed, 29 Apr 2020 04:07:51 -0700 (PDT)
Received: from localhost.localdomain ([2a0e:b107:830:0:47e5:c676:4796:5818])
        by smtp.googlemail.com with ESMTPSA id u7sm7679963wmg.41.2020.04.29.04.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 04:07:51 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Christian Lamparter <chunkeey@gmail.com>,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: [PATCH net-next v4 3/3] ARM: dts: qcom: ipq4019: add MDIO node
Date:   Wed, 29 Apr 2020 13:07:27 +0200
Message-Id: <20200429110726.448625-4-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200429110726.448625-1-robert.marko@sartura.hr>
References: <20200429110726.448625-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the necessary MDIO interface node
to the Qualcomm IPQ4019 DTSI.

Built-in QCA8337N switch is managed using it,
and since we have a driver for it lets add it.

Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
Cc: Luka Perkov <luka.perkov@sartura.hr>
---
Changes from v3 to v4:
* Change compatible to IPQ4019

Changes from v2 to v3:
* Correct commit title

 arch/arm/boot/dts/qcom-ipq4019.dtsi | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index b4803a428340..8b72a149bc33 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -578,6 +578,34 @@ wifi1: wifi@a800000 {
 			status = "disabled";
 		};
 
+		mdio: mdio@90000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "qcom,ipq4019-mdio";
+			reg = <0x90000 0x64>;
+			status = "disabled";
+
+			ethphy0: ethernet-phy@0 {
+				reg = <0>;
+			};
+
+			ethphy1: ethernet-phy@1 {
+				reg = <1>;
+			};
+
+			ethphy2: ethernet-phy@2 {
+				reg = <2>;
+			};
+
+			ethphy3: ethernet-phy@3 {
+				reg = <3>;
+			};
+
+			ethphy4: ethernet-phy@4 {
+				reg = <4>;
+			};
+		};
+
 		usb3_ss_phy: ssphy@9a000 {
 			compatible = "qcom,usb-ss-ipq4019-phy";
 			#phy-cells = <0>;
-- 
2.26.2

