Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68CD5C2D0E5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4032074D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 21:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxH+GGmF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727548AbgCZVdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 17:33:17 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40788 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgCZVdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 17:33:16 -0400
Received: by mail-qk1-f194.google.com with SMTP id l25so8688823qki.7;
        Thu, 26 Mar 2020 14:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Ng6NKbIQ7UH3Fnc48aHdWJ3D471uKUieydIRfZ614w=;
        b=lxH+GGmFX0wL7NEqN1O4gbB6ll8ceOy96u0EDOjFkzyYSPNSMooflVnL0LYq2eDdve
         pIyAuRztz0hDq0jS+Dm5y+G4qqs+2YItdKIeGyeKDRQlKkkXLWqjmY2FN30LxaGExg2K
         9HC/SRWABTzD3dwtho1G8lRmsgb0yucRK71Y+ud5Lw06G9rhInWiZxT5faln4HUYVaRJ
         FfAAQ4RJb0NhamOtZ82R5NOpEseJP2QV5AA9QABLfdRmyN1aUCndkrCQbxbtqFTJqnm/
         OIQtnlDR7vQ2WLCBtkhcMfSfmNKebDARjuVZ9h5n27fP+NIiiU7hNuadKjqGxdxRmVEV
         Vk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+Ng6NKbIQ7UH3Fnc48aHdWJ3D471uKUieydIRfZ614w=;
        b=iH9YMMAxn7G7ZIhNcExjvwzWg404CGkI21NpNsz/pyvVUQAD0uxjFV5mKpMFaQjeOV
         qoPbE2VvJqWCn98NE7SGxC+frwYEJ7NkO2K3J6r3119bSqOJSlpdsF21VvflS4YJMTSy
         l7SESeB2U4BO01sn+HiZaUg4rrR4sJ+cwT1ppktdu/fy6EFPJYaOde+PpVggkNq+B3iD
         CIV59aaDlvHT7DV8aekfHoo07JmbtD4pp2TPh3bKnKhvhY2u7TpXLAoKlYo4dTB8LxOI
         eS6NBMWlRnDAR16pJiyp4apwXvz/5LxD7zXGi1wh5kCNt/IxlhmoRTjSW6Vsp/cfGYyv
         iP1g==
X-Gm-Message-State: ANhLgQ22akVcn7NtSC3NpsTfSEoid2GVRU/Cy1KQ1WV0YUtB8p0hYaxn
        /Tg6Kt3uKbapVWhPHAMwSai9DHL1pps=
X-Google-Smtp-Source: ADFU+vvdIQ9lpvc4Gl+88YADLGqhvIcb51g8/gKUmpNuNw8n4MhXlTE/jl0iFENafg08bPhVeBD6Zg==
X-Received: by 2002:a37:4902:: with SMTP id w2mr9908921qka.13.1585258393619;
        Thu, 26 Mar 2020 14:33:13 -0700 (PDT)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id a11sm2271488qto.57.2020.03.26.14.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 14:33:12 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     devicetree@vger.kernel.org
Cc:     aford@beaconembedded.com, charles.stevens@logicpd.com,
        Adam Ford <aford173@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC] clk: vc5: Add bindings for output configurations
Date:   Thu, 26 Mar 2020 16:32:51 -0500
Message-Id: <20200326213251.54457-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Versaclock can be purchased in a non-programmed configuration.
If that is the case, the driver needs to configure the chip to
output the correct signal type, voltage and slew.

This RFC is proposing an additional binding to allow non-programmed
chips to be configured beyond their default configuration.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/Documentation/devicetree/bindings/clock/idt,versaclock5.txt b/Documentation/devicetree/bindings/clock/idt,versaclock5.txt
index 05a245c9df08..4bc46ed9ba4a 100644
--- a/Documentation/devicetree/bindings/clock/idt,versaclock5.txt
+++ b/Documentation/devicetree/bindings/clock/idt,versaclock5.txt
@@ -30,6 +30,25 @@ Required properties:
 		- 5p49v5933 and
 		- 5p49v5935: (optional) property not present or "clkin".
 
+For all output ports, an option child node can be used to specify:
+
+- mode: can be one of
+		  - LVPECL: Low-voltage positive/psuedo emitter-coupled logic
+		  - CMOS
+		  - HCSL 
+		  - LVDS: Low voltage differential signal
+
+- voltage-level:  can be one of the following microvolts
+		  - 1800000
+		  - 2500000
+		  - 3300000
+-  slew: Percent of normal, can be one of 
+		  - P80 
+		  - P85
+		  - P90
+		  - P100 
+
+
 ==Mapping between clock specifier and physical pins==
 
 When referencing the provided clock in the DT using phandle and
@@ -62,6 +81,8 @@ clock specifier, the following mapping applies:
 
 ==Example==
 
+#include <dt-bindings/versaclock.h>
+
 /* 25MHz reference crystal */
 ref25: ref25m {
 	compatible = "fixed-clock";
@@ -80,6 +101,13 @@ i2c-master-node {
 		/* Connect XIN input to 25MHz reference */
 		clocks = <&ref25m>;
 		clock-names = "xin";
+
+		ports@1 {
+			reg = <1>;
+			mode = <CMOS>;
+			pwr_sel = <1800000>;
+			slew = <P80>;
+		};
 	};
 };
 
-- 
2.25.1

