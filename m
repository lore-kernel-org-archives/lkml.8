Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B4CC2BB1D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E2FF2074D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 19:39:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ji2pnni8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505013AbgDNTjI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 15:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2504930AbgDNThE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 15:37:04 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AACF0C061A10;
        Tue, 14 Apr 2020 12:37:04 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id t3so10850936qkg.1;
        Tue, 14 Apr 2020 12:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XCcn0Oez3DHMoLsnomZlIHgSagkv3wP7zr1RDul2frQ=;
        b=Ji2pnni81H/QdQEs26s4Z6fXdwADroSrbLcjIJGMVTNTartbwX0XW392IuZrXc7Ifw
         oVFoF81CFjbTDEMGWse+IvV1faRL/tWjexR9bvnoVMGlhRDKFSKAzxi1L/RPKLX4BPzR
         LIxUVeB2M5eShpy2usCUat2ZqVtGUF9SWq6u1oqrdGD+/kvVu05SgP3C8Xg7E9L/xx4P
         yycRmLDE8sbIQj7w35UdiFT/BioiV+iRDHr1DPK9roYbKEwr3ttEL/nNDejoNJHEft6v
         CId+3TA/LhVEw8rM4sY6hCSzrhDuhaS29UhN9piZKncmqlE9rULhx6n6vG/6g4QBC+Vx
         2KZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XCcn0Oez3DHMoLsnomZlIHgSagkv3wP7zr1RDul2frQ=;
        b=BRa9JW/NAIoeGa88tjNqn0Vb/cmMpFEWyNpMpGajp/9MD8Yj2SpsfTrKiQZ3HPY8yi
         lR6VEcvARDKX0jzMimJym0geYcsBZwOGEi8MFDdmRW4TxNbL0ESZrHIHbQhRpfNL24px
         AAx/TztcUs4xEoPRgoioZ7xjUgWTWUS1IScnOqxMzx6vxqDlq95WOCN5QEkxsnWhVXDr
         vVTiDGqrNaLoJsdxhQS1HDO+zhvOj7H5L+gZCBGifz96H55PqBBtaPZJvJQPMACR4NAk
         b2U6nZCQwM2oJ9EiIt71NTV6RbgxMzp7x9gjzrSA+LhOgYEpN2w2ui0c0qUlVis2y9hN
         5MTA==
X-Gm-Message-State: AGi0PuYeRalQ8Fiba6x1hwFO8TJsUOyDUnL1Rdb9riF2LZnV9/psM01R
        42Z/IZ36JAzZuwtNWGoF94GuuZB7r4w=
X-Google-Smtp-Source: APiQypKKOaQjuwK0bBkDSboSxAgdBaOaejp9+0c2qyAgukhvcvo6tpyUJaIA8t7Avkf2ff2IiVKRaQ==
X-Received: by 2002:ae9:e214:: with SMTP id c20mr11125186qkc.107.1586893023363;
        Tue, 14 Apr 2020 12:37:03 -0700 (PDT)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id t15sm11960197qtc.64.2020.04.14.12.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 12:37:02 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     aford@beaconembedded.com, charles.stevens@logicpd.com,
        Adam Ford <aford173@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] dt: Add additional option bindings for IDT VersaClock
Date:   Tue, 14 Apr 2020 14:36:16 -0500
Message-Id: <20200414193616.1368209-3-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200414193616.1368209-1-aford173@gmail.com>
References: <20200414193616.1368209-1-aford173@gmail.com>
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

