Return-Path: <SRS0=bQGS=5U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FCFC2BA15
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 16:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAD092076C
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Apr 2020 16:15:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PITs6j2o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgDDQPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 12:15:55 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34508 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726197AbgDDQPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 12:15:54 -0400
Received: by mail-qt1-f194.google.com with SMTP id 14so8943018qtp.1;
        Sat, 04 Apr 2020 09:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GET/abLarLGWrJ/MA6cxRPWMhupz6y/cS44XtSN8P1Q=;
        b=PITs6j2oMJ94bhpMMf1H3BqUuhd7dJBQ7tNZLaOPASETEFGlBsTBTvv/VjpX1wljdc
         TI4OpRHn3OdDW+HvlYeEV8MahPpuRgBpGyHi/nQHlxWvZIGN+IPpEPC9rtkfA283KBcs
         6Kc5IK4H5qLdfrQDvViuKJg/KnUjEKnXewzzh3Xq8MgLA5iV8GgJzHORhBAdrGibo6VU
         EXVBlEoxnXSykLuS/AH/rAqCeE2Q+clyju7NH2zRT/CpkNtJ5l7IicQL1/x3qQAtFABM
         FLhA4MBj7ClvkGg6UDeNq3+seAh4kFvnmPlVg5Q1RCb4P1brviqg+bhnzWJe19o7ZWKD
         IrmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GET/abLarLGWrJ/MA6cxRPWMhupz6y/cS44XtSN8P1Q=;
        b=Ks12LQ8I8zkRUtB2wy20rrPEKk8fo/HNojNyHlaHh+ZBVgSGE4jz21ueBvFxwVMa73
         hybR+1aSr4BxFSZ0M9S4R777TDANonjwnUGwg5Hk9268+Hnz467lUam+CuPttSYnN9Az
         wKRRBkrO3pcAIPF/VmDjrgePzRc+gCcuZknMlbIUdNjQq3OltCMWRXLW91LJK/mjUCz3
         OftJILaP768cIZdtLEA8N7R7Xm2LhNy/oVNP0tMczVFlEK+111qsZ/exqP5CEXyf0LcH
         6zGhFbPhU+DdQJpRdevTeYzcXMb5OGqSt+69kbGLSzVGQBRn1wWJX5tQMS+Zg/LSYsNR
         ETAA==
X-Gm-Message-State: AGi0PuYEWiHlLfVKC2hqa4TSEibWiIBCuMFxqFEg6TwehWZiObJYw1SJ
        Tpi/QyERJ8xp8Om2h2qgf3VJ7RQm1eQ=
X-Google-Smtp-Source: APiQypIqmrIQsN+B5vp2y+ZGCzobEJI6V/qWweRvWnzLs0lYY//84LnNyNJvfLEqHbKDxIZNGFwMOQ==
X-Received: by 2002:aed:208e:: with SMTP id 14mr13326211qtb.335.1586016950961;
        Sat, 04 Apr 2020 09:15:50 -0700 (PDT)
Received: from localhost.localdomain (c-73-37-219-234.hsd1.mn.comcast.net. [73.37.219.234])
        by smtp.gmail.com with ESMTPSA id n67sm9213534qte.79.2020.04.04.09.15.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2020 09:15:50 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-clk@vger.kernel.org
Cc:     aford@beaconembedded.com, charles.stevens@logicpd.com,
        Adam Ford <aford173@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] clk: vc5: Add support for IDT VersaClock 5P49V6965
Date:   Sat,  4 Apr 2020 11:15:35 -0500
Message-Id: <20200404161537.2312297-1-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update IDT VersaClock 5 driver to support 5P49V6965.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/clk/clk-versaclock5.c b/drivers/clk/clk-versaclock5.c

index 24fef51fbcb5..fa96659f8023
--- a/drivers/clk/clk-versaclock5.c
+++ b/drivers/clk/clk-versaclock5.c
@@ -124,6 +124,7 @@ enum vc5_model {
 	IDT_VC5_5P49V5933,
 	IDT_VC5_5P49V5935,
 	IDT_VC6_5P49V6901,
+	IDT_VC6_5P49V6965,
 };
 
 /* Structure to describe features of a particular VC5 model */
@@ -683,6 +684,7 @@ static int vc5_map_index_to_output(const enum vc5_model model,
 	case IDT_VC5_5P49V5925:
 	case IDT_VC5_5P49V5935:
 	case IDT_VC6_5P49V6901:
+	case IDT_VC6_5P49V6965:
 	default:
 		return n;
 	}
@@ -956,12 +958,20 @@ static const struct vc5_chip_info idt_5p49v6901_info = {
 	.flags = VC5_HAS_PFD_FREQ_DBL,
 };
 
+static const struct vc5_chip_info idt_5p49v6965_info = {
+	.model = IDT_VC6_5P49V6965,
+	.clk_fod_cnt = 4,
+	.clk_out_cnt = 5,
+	.flags = 0,
+};
+
 static const struct i2c_device_id vc5_id[] = {
 	{ "5p49v5923", .driver_data = IDT_VC5_5P49V5923 },
 	{ "5p49v5925", .driver_data = IDT_VC5_5P49V5925 },
 	{ "5p49v5933", .driver_data = IDT_VC5_5P49V5933 },
 	{ "5p49v5935", .driver_data = IDT_VC5_5P49V5935 },
 	{ "5p49v6901", .driver_data = IDT_VC6_5P49V6901 },
+	{ "5p49v6965", .driver_data = IDT_VC6_5P49V6965 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, vc5_id);
@@ -972,6 +982,7 @@ static const struct of_device_id clk_vc5_of_match[] = {
 	{ .compatible = "idt,5p49v5933", .data = &idt_5p49v5933_info },
 	{ .compatible = "idt,5p49v5935", .data = &idt_5p49v5935_info },
 	{ .compatible = "idt,5p49v6901", .data = &idt_5p49v6901_info },
+	{ .compatible = "idt,5p49v6965", .data = &idt_5p49v6965_info },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, clk_vc5_of_match);
-- 
2.25.1

