Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3447C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 08:10:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAD56206CD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 08:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="a34yKohv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbgGFIKA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 04:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbgGFIKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 04:10:00 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12B71C061794
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 01:09:58 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id k71so12969188pje.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 01:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VCmd/Q/RwcSA/pj5yu0ht37WucGeahbXzUSgEgDD5Y0=;
        b=a34yKohv39fS7hwrbdQee6Nfq3+QRzZPB1ztLKSK3f4vghVVFNXv5QVnuHL0KbggUE
         3jYMrfhUwXpMMtUnqBLakgoHsDAnmHd9vhmaFRt+IlVHmI7Q6bH4hAV9FjxEgTe9px4X
         Rj8tS87gAKYVEViQR8IhIbaadlQ8vK9MPH8TU8Dg2fv9p8AbZOL4/mZbw94uoHt+fgVQ
         Z6sJ/rVzNv127Cb9ZWOZHXfsnpLU5RTnWweExr12B60ixxiLTLeZTvnGVcwELpXtpU23
         WFOhSK8MHAbZx5AjQHxf1m9BNehDrLBy1oFWfFOkPD4R5eWoL2EZxoJhzqknVKtYjc4h
         6goA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VCmd/Q/RwcSA/pj5yu0ht37WucGeahbXzUSgEgDD5Y0=;
        b=o53ADa1IVuPC8siilhE3J2meuHl8dVlUYLhGq+67PbTTCzjopKoAwvq0FQKLYS0gR/
         Cou/VrnNl3W2ng12JGwe/q+VRejUj7yMG1Sfnos2mJWFyEatgmDOIRl4spCOb8EmgaRh
         6pfC7BbktvpWOBuulZ5fEbzgvKvoOkfQUlB08CpeaS9UTAOhCT+UhnkwoWywXJbj+e43
         7FxGdBJPlJ/VNlyx3mKpLXuRZwSK5EbStyjDS9jLOZFppOqo/5B6ghqfwVzumXQeRomh
         fuqytRgprr/r33kko1pZ5iAdBWHytDdxcLL9YhUJgOCP9tyfgPehOe1JYmlZbUrrfUxe
         a3FQ==
X-Gm-Message-State: AOAM532BvJ203yma0t3lUQD7wqtLXDwTJVSSkewbiMwFjP6XRDhYBRSj
        HicySL/xqPFpo9dOoITeQGeouQ==
X-Google-Smtp-Source: ABdhPJz3CrSi8F6hur0DrDIDsFCWPfB1Zrw4V5AWBS5sVzmAVdDrf2onExh8OWA//eXbcNXZ0fT5RA==
X-Received: by 2002:a17:902:b287:: with SMTP id u7mr30536796plr.107.1594022997394;
        Mon, 06 Jul 2020 01:09:57 -0700 (PDT)
Received: from localhost.localdomain (36-239-207-44.dynamic-ip.hinet.net. [36.239.207.44])
        by smtp.gmail.com with ESMTPSA id m22sm20003229pfk.216.2020.07.06.01.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 01:09:56 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Christoph Fritz <chf.fritz@googlemail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: fan53880: Add missing .owner field in regulator_desc
Date:   Mon,  6 Jul 2020 16:09:44 +0800
Message-Id: <20200706080944.663750-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing .owner field in regulator_desc, which is used for refcounting.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/fan53880.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/regulator/fan53880.c b/drivers/regulator/fan53880.c
index 285acc705a55..575d289b8e04 100644
--- a/drivers/regulator/fan53880.c
+++ b/drivers/regulator/fan53880.c
@@ -45,6 +45,7 @@ static const struct regulator_ops fan53880_ops = {
 		.of_match =	   of_match_ptr("LDO"#_num),		\
 		.regulators_node = of_match_ptr("regulators"),		\
 		.type =		   REGULATOR_VOLTAGE,			\
+		.owner =	   THIS_MODULE,				\
 		.linear_ranges =   (struct linear_range[]) {		\
 		      REGULATOR_LINEAR_RANGE(_default, 0x0, 0x0, 0),	\
 		      REGULATOR_LINEAR_RANGE(800000, 0xf, 0x73, 25000),	\
@@ -69,6 +70,7 @@ static const struct regulator_desc fan53880_regulators[] = {
 		.of_match =	   of_match_ptr("BUCK"),
 		.regulators_node = of_match_ptr("regulators"),
 		.type =		   REGULATOR_VOLTAGE,
+		.owner =	   THIS_MODULE,
 		.linear_ranges =   (struct linear_range[]) {
 		      REGULATOR_LINEAR_RANGE(1100000, 0x0, 0x0, 0),
 		      REGULATOR_LINEAR_RANGE(600000, 0x1f, 0xf7, 12500),
@@ -87,6 +89,7 @@ static const struct regulator_desc fan53880_regulators[] = {
 		.of_match =	   of_match_ptr("BOOST"),
 		.regulators_node = of_match_ptr("regulators"),
 		.type =		   REGULATOR_VOLTAGE,
+		.owner =	   THIS_MODULE,
 		.linear_ranges =   (struct linear_range[]) {
 		      REGULATOR_LINEAR_RANGE(5000000, 0x0, 0x0, 0),
 		      REGULATOR_LINEAR_RANGE(3000000, 0x4, 0x70, 25000),
-- 
2.25.1

