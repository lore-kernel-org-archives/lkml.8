Return-Path: <SRS0=7DLR=6Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD450C3A5A9
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 12:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD67720787
	for <linux-kernel@archiver.kernel.org>; Sat,  2 May 2020 12:21:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPRso8l2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgEBMVu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 May 2020 08:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727930AbgEBMVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 May 2020 08:21:49 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE3CC061A0C;
        Sat,  2 May 2020 05:21:49 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id ck5so5985009qvb.11;
        Sat, 02 May 2020 05:21:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q4uuPurBluxDeIOpVG3Do+EXvRC/KEYOD2qgBrHFPb4=;
        b=SPRso8l2MPO2G8jziGzAamP+YRuj3CffMPNu4eObvnWBb55iblTKM/Sr7umkRr/RO8
         Yda9sgxu7SAUl2JQRKxHZPkzdJebPg4qL8j+/Dt1O5ORm9waacs88+lMosoETODF+co/
         uA38hJ5uuHtp/6O+C15OA5PdimYEW8RINIbZYgCsnDNLXwJeVZbL+BHCCntK+s8FmWG9
         +jhGBtU25Vl9W7LidSZqw4qGx8ZDUklgwvzolZuOdseYQxIQHEMPXOoE1DG2Uwh8obZ/
         29eHLCVOUdWAzHBqmIYrseYwbFTERHk22RcZAHKqGvDMiKJPY+9pUf+SSRYclF15XaJC
         LAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q4uuPurBluxDeIOpVG3Do+EXvRC/KEYOD2qgBrHFPb4=;
        b=RCkIm//EhVawNUpE4s79nIkju4KQgE6EETZJQCgJjfF7Fnxp8hqKHXHWWmXHuB2Ww3
         UwnCRDZUrUNUe2PLHHNX3Gg3ci3+2EUfW6VR4eq/O0hfjtDZQ2WoYxnV5RSWkC+QzZt7
         yFi25ZVhvEXZnjgYzixHx86Tt+TfI8UfCnKhMjTji57lv7DPM6iN7v0+tlmHOU8xGTPi
         dXHdg+FNIxllPX2ffh5D4qJ0O2z0wA4tG3mnDB2mX9zXVSXSb2KoR29OuUJXjjglRIIZ
         r7jfLVXbUKkrLGSgNcktJvHiH7uE/TIgRzz5MC3eJZ2THemznxlRxaoJaeCEjUtXLw2y
         sD/Q==
X-Gm-Message-State: AGi0PuZUiWRFqiBvhzJFduVbNEtzDt86uHvQHWJMyCLzqspg3fxzZKDR
        Uexm7wipm9Ki5MPHA37MZb02WsEWGNc=
X-Google-Smtp-Source: APiQypJl6yVdpqjUke8MWjTj9v5q2K9ZW62r9/DaDz/j6EmgwyP9up00407cr/kUMaKLnjXyQCiWGg==
X-Received: by 2002:a0c:9002:: with SMTP id o2mr5906140qvo.3.1588422107922;
        Sat, 02 May 2020 05:21:47 -0700 (PDT)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id p47sm5256413qta.44.2020.05.02.05.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 May 2020 05:21:47 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     aford@beaconembedded.com, charles.stevens@logicpd.com,
        Adam Ford <aford173@gmail.com>, Rob Herring <robh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 3/3] dt: Add additional option bindings for IDT VersaClock
Date:   Sat,  2 May 2020 07:21:26 -0500
Message-Id: <20200502122126.188001-3-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200502122126.188001-1-aford173@gmail.com>
References: <20200502122126.188001-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The VersaClock driver now supports some additional bindings to support
child nodes which can configure optional settings like mode, voltage
and slew.

This patch updates the binding document to describe what is available
in the driver.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>

diff --git a/Documentation/devicetree/bindings/clock/idt,versaclock5.txt b/Documentation/devicetree/bindings/clock/idt,versaclock5.txt
index bcff681a4bd0..6165b6ddb1a9 100644
--- a/Documentation/devicetree/bindings/clock/idt,versaclock5.txt
+++ b/Documentation/devicetree/bindings/clock/idt,versaclock5.txt
@@ -31,6 +31,29 @@ Required properties:
 		- 5p49v5933 and
 		- 5p49v5935: (optional) property not present or "clkin".
 
+For all output ports, a corresponding, optional child node named OUT1,
+OUT2, etc. can represent a each output, and the node can be used to
+specify the following:
+
+- itd,mode: can be one of the following:
+                 - VC5_LVPECL
+                 - VC5_CMOS
+                 - VC5_HCSL33
+                 - VC5_LVDS
+                 - VC5_CMOS2
+                 - VC5_CMOSD
+                 - VC5_HCSL25
+
+- idt,voltage-microvolts:  can be one of the following
+                 - 1800000
+                 - 2500000
+                 - 3300000
+-  idt,slew-percent: Percent of normal, can be one of
+                 - 80
+                 - 85
+                 - 90
+                 - 100
+
 ==Mapping between clock specifier and physical pins==
 
 When referencing the provided clock in the DT using phandle and
@@ -81,6 +104,16 @@ i2c-master-node {
 		/* Connect XIN input to 25MHz reference */
 		clocks = <&ref25m>;
 		clock-names = "xin";
+
+		OUT1 {
+			itd,mode = <VC5_CMOS>;
+			idt,voltage-microvolts = <1800000>;
+			idt,slew-percent = <80>;
+		};
+		OUT2 {
+			...
+		};
+		...
 	};
 };
 
-- 
2.25.1

