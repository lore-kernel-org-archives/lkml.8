Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA24C35247
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 02:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2146820715
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 02:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iwm8IYVb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727877AbgBGCAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 21:00:20 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:39314 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727540AbgBGB7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 20:59:18 -0500
Received: by mail-wr1-f68.google.com with SMTP id y11so775158wrt.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 17:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YJAqrsEVC7Ekr/URFS4yzXVcz6M9nFcDb80ARG3rIgM=;
        b=iwm8IYVbR3yY5kqZcS08S7paz+OmUAVZputW/75j5TFqAmoIih6Xj/qEu4tqxIfFbZ
         g8/C1Wc4kJLUSsu14m64Gn4bvb1P6o3nNyi3NXdSn5xJ3iTOBIOscGVY3VAliKua7Rem
         uRzChQjlzvckoV/Sn1Wv9IUCLS0mmj0ldT0J+2Jz3BSc1aeFsGlRjpmC82G9J2Y9lU4P
         bFa2cNY5Hr7ASgNyF2RfZNJSlYOsgSc4DUMx3N/qqqegrrOjQpEgYJAyuNXz+4G+8B6b
         941ztyTfUlgp+v0LNgao4IwGDngv5asQpbblf0g8zBTu9b/SmY4pXQl3+YPYwqYujDGR
         wxfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YJAqrsEVC7Ekr/URFS4yzXVcz6M9nFcDb80ARG3rIgM=;
        b=dVfmYTfRoUUNtIMtWrMb65jcGShhiKLxy0yH1h4/LiP4/ze7CwF+Q6BnCCe3si2XTJ
         8rZm79zPI/+VecC76dMEYrO/YKkjN1fzRwCPTgV1o54ZWNKM1F/2yg0B1mIdDYy/hPeM
         GkxfZSLNA9Rw65zqxtCSYKbDyctBda2LO9u5oQ419ZoTTXqIouFykM99q67RDRzeHW8+
         QEd+QhdJE9u4am5DIaUtBQ96vgWMf369exQBRTF9F1v4F+ZZ40aJAokns0MPnkUcIo+/
         0GOKtn9LYBb0qiFAQnBFHy3Okgd8Xjnc2Msg6SCX+tSvN/WvzkEGOAMt14774PSJhPX5
         Ru3Q==
X-Gm-Message-State: APjAAAU9PygNSOUzQoMPvT0F3vMMZ/QQG7aRyd3oQkqVKQ8F1fZT6/7v
        RlwE467Xcgxw2E/umoTsg+HDsIv2a2g=
X-Google-Smtp-Source: APXvYqyNNHwwq1ANuJsiYku764bJOteOK5mhChlc5445LjmIh8mwA1V68AM3gSNVqWLquWUGAqQd/w==
X-Received: by 2002:adf:9c8c:: with SMTP id d12mr1190037wre.404.1581040755826;
        Thu, 06 Feb 2020 17:59:15 -0800 (PST)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id a62sm1490095wmh.33.2020.02.06.17.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 17:59:15 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        gregkh@linuxfoundation.org, jackp@codeaurora.org, balbi@kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org
Subject: [PATCH v4 07/18] dt-bindings: usb: dwc3: Add a gpio-usb-connector example
Date:   Fri,  7 Feb 2020 01:58:56 +0000
Message-Id: <20200207015907.242991-8-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200207015907.242991-1-bryan.odonoghue@linaro.org>
References: <20200207015907.242991-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A USB connector should be a child node of the USB controller
connector/usb-connector.txt. This patch adds an example of how to do this
to the dwc3 binding descriptions.

It is necessary to declare a connector as a child-node of a USB controller
for role-switching to work, so this example should be helpful to others
implementing that.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: linux-usb@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Acked-by: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 Documentation/devicetree/bindings/usb/dwc3.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
index 66780a47ad85..4e1e4afccee6 100644
--- a/Documentation/devicetree/bindings/usb/dwc3.txt
+++ b/Documentation/devicetree/bindings/usb/dwc3.txt
@@ -121,4 +121,12 @@ dwc3@4a030000 {
 	interrupts = <0 92 4>
 	usb-phy = <&usb2_phy>, <&usb3,phy>;
 	snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
+
+	usb_con: connector {
+		compatible = "gpio-usb-b-connector";
+		id-gpios = <&tlmm 116 GPIO_ACTIVE_HIGH>;
+		vbus-supply = <&usb3_vbus_reg>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&usb3_id_pin>, <&usb3_vbus_pin>;
+	};
 };
-- 
2.25.0

