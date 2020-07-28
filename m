Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D136C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E13062075D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 08:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=students-iitmandi-ac-in.20150623.gappssmtp.com header.i=@students-iitmandi-ac-in.20150623.gappssmtp.com header.b="nhCjMNdG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728155AbgG1IXr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 04:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728068AbgG1IXq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 04:23:46 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32282C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 01:23:46 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l63so11441885pge.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 01:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=students-iitmandi-ac-in.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Krf3mHPaRhONZrJUP4kLL+SpT/1O8y5l8m6Ya1wdpkE=;
        b=nhCjMNdGpcIOWYXchr2X67Jx0xqPObEdVXUjSjcpgdiYIruWbcrLrjOSjJzGqAIjd7
         vrlt8Jb75Qf+wTP9BNzXwrM0QEtfMyFaj3F8eAHdCZnvakhHkGu3s0VoUuJWRBv8oe9a
         lyzFkTycR02L1IJfPhmBwvu6/GhoRYxO07BNT8B1jJ8komhzqC80ueEL+jHk8n89+1CU
         qqil3Ip7r/q+8uL6iFxdTsrIk46pLcuaXVt5C/6ibrhdHcTItJI5CRZOtXL1apqR5xdz
         J7MSYQgRLxz8hrXMiABWD1IOkuc7T62hWlfuzqn0GiBerGiq4FJOBDuwZ5cGU5J5L38h
         C0dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Krf3mHPaRhONZrJUP4kLL+SpT/1O8y5l8m6Ya1wdpkE=;
        b=MTuGqmnv7625V97DAps/Vd2XGxm3ZGg/EVYMYq/6xHmgBUIX7sFeVG/Tsz148+ZqYN
         KfiBM5mS/fI1bFgloCvbHloZ0j+eLZxgNsey/qIiSB1JK0YTwrnzJGx1LoijqEM92ua4
         rA2czno2Woo7Q++gTmNiwbioXJAvD4OcmmcF6LRG49c8Nku8RrIvUg3ywkmSqGKTnxtO
         wbei2nfnKWF/F0ZnoedJu2ZTTdfmW5xHTF6wxurqJeW6rfuNnqwlsdkN2tno7pKwZBu7
         bCOS3hJ9XJtvOIkj3m7H6oR1kNJveknoT27AxshRX7TG37/3HZWNmF7iT1HiWb2a+EPo
         cutA==
X-Gm-Message-State: AOAM5334RFjRjdsyiRS2a43ZbtCQXICWp1ybpfjSN85RRE8sZHGHQo3F
        4mYHfBbtxlW6CkZDb2n+wkUiiA==
X-Google-Smtp-Source: ABdhPJwxUnxFK756k0a5/cKYYYuNHSDaVSvQ6w8JriFYCnKNk602Aut098WOzwQLFtdyZlJjBPowUQ==
X-Received: by 2002:a63:4e51:: with SMTP id o17mr24411320pgl.315.1595924625553;
        Tue, 28 Jul 2020 01:23:45 -0700 (PDT)
Received: from devil-VirtualBox.www.tendawifi.com ([103.198.174.215])
        by smtp.gmail.com with ESMTPSA id o10sm2033014pjo.55.2020.07.28.01.23.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 01:23:44 -0700 (PDT)
From:   Ankit <b18007@students.iitmandi.ac.in>
To:     mchehab@kernel.org, gregkh@linuxfoundation.org,
        sakari.ailus@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, b18007@students.iitmandi.ac.in
Subject: [PATCH v2] Staging : media : atomisp : fixed a brace coding sytle issue
Date:   Tue, 28 Jul 2020 13:53:30 +0530
Message-Id: <20200728082330.24948-1-b18007@students.iitmandi.ac.in>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200728073715.GA351768@kroah.com>
References: <20200728073715.GA351768@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ankit Baluni <b18007@students.iitmandi.ac.in>

Removed braces for a 'if' condition as it contain only single line & 
there is no need for braces for such case according to coding style
rules.

Signed-off-by: Ankit Baluni <b18007@students.iitmandi.ac.in>

---
 drivers/staging/media/atomisp/pci/atomisp_cmd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/atomisp_cmd.c b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
index 8ea65bef35d2..28b96b66f4f3 100644
--- a/drivers/staging/media/atomisp/pci/atomisp_cmd.c
+++ b/drivers/staging/media/atomisp/pci/atomisp_cmd.c
@@ -4981,9 +4981,8 @@ enum mipi_port_id __get_mipi_port(struct atomisp_device *isp,
 	case ATOMISP_CAMERA_PORT_SECONDARY:
 		return MIPI_PORT1_ID;
 	case ATOMISP_CAMERA_PORT_TERTIARY:
-		if (MIPI_PORT1_ID + 1 != N_MIPI_PORT_ID) {
+		if (MIPI_PORT1_ID + 1 != N_MIPI_PORT_ID)
 			return MIPI_PORT1_ID + 1;
-		}
 	/* fall through */
 	default:
 		dev_err(isp->dev, "unsupported port: %d\n", port);
-- 
2.25.1

