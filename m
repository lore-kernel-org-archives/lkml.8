Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E27DBC433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 07:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2536207F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 07:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=students-iitmandi-ac-in.20150623.gappssmtp.com header.i=@students-iitmandi-ac-in.20150623.gappssmtp.com header.b="MhQLprU+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgG2HjP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 03:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726290AbgG2HjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 03:39:14 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08AAC061794
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 00:39:14 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id f193so2100023pfa.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 00:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=students-iitmandi-ac-in.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zMRvTgAMRZWNdLWhRQAFPO8+G0B9J9srTu2Fp7kXf3M=;
        b=MhQLprU+zfumI0Msb8Sixe8JB0MV/W4eiDpEHKivnFRbY8aL9QeXqyRmnViWb7gOp5
         nkoIGdOUWLWHQKitYjmabDUeW04u+WgogyNIuSCi9jH/FmVFpM6KcfmaUNUfEXshZbhv
         ilraWxNFBfNIa0z732o6XMA/TIYB/UR0wAz1ildcGyYKrw+Fru+qIZsROWbs3VMX3o0t
         B1yJPZR9xzo0YAW18KINNWlB7xLihcIw+1UG9Fd3ejO1wYMlcXIyZ1FKpZcEtGmy0bj2
         yJqq11CpEebpfFOmExwZrNXO7EY7HNbx7Y1tveWOWlGjR4v7x1QlIqUgGYu6N1jZC9Hv
         r12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zMRvTgAMRZWNdLWhRQAFPO8+G0B9J9srTu2Fp7kXf3M=;
        b=PCR+L2VJ1bFLeRn5OSrYOxzzX3MFMHqv9sOYg2sTcWSbBBVahhhLroPR57QvtmCuOx
         SfVYynKTEmLSssGMwumojjJOaobMarzYOT2lLxIMxk0obV6TI4nStMrlvq7G38zPjzfp
         z05LeKNlahgJHFJU5+4/QfKgA7qJrURYTFOSpH92Ac2pY4tOZ+2yIEQirHoikXSWZrNC
         xj2SM6P1bDVtIOs++WinLjMlAk4ouVzTTz8LQ5IGe4DcFs3Nu516DL5/exAD6FwEPoeo
         WP7viqSjw7BnbhI9NUEw/VHZxmguBJ0Ool49ZpscAFkZdTSIi/5sFqGf3K+Qy1nTHNop
         sbTw==
X-Gm-Message-State: AOAM532gmjROpycV0ti89eSR9i2p/jiMQHYNTyxk1/AGqar+l4MUTDbC
        Gaq1KLkr80Q8aDaHbE7/hopT+Q==
X-Google-Smtp-Source: ABdhPJz2y+b3KMCeMF9l2PfAURxiLwo90lBqvKvvMpApyd7bhUoIzx4c9gUaLiu08ofQdhu9c2ootg==
X-Received: by 2002:a63:5d1:: with SMTP id 200mr28603061pgf.59.1596008354163;
        Wed, 29 Jul 2020 00:39:14 -0700 (PDT)
Received: from devil-VirtualBox.www.tendawifi.com ([103.198.174.215])
        by smtp.gmail.com with ESMTPSA id f24sm1214206pjq.48.2020.07.29.00.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 00:39:13 -0700 (PDT)
From:   Ankit Baluni <b18007@students.iitmandi.ac.in>
To:     mchehab@kernel.org, gregkh@linuxfoundation.org,
        sakari.ailus@linux.intel.com, andriy.shevchenko@linux.intel.com
Cc:     linux-media@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, b18007@students.iitmandi.ac.in
Subject: [PATCH v3] Staging : media : atomisp : fixed a brace coding sytle issue
Date:   Wed, 29 Jul 2020 13:09:02 +0530
Message-Id: <20200729073902.1704-1-b18007@students.iitmandi.ac.in>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200728225935.28880-1-b18007@students.iitmandi.ac.in>
References: <20200728225935.28880-1-b18007@students.iitmandi.ac.in>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Removed braces for a 'if' condition as it contain only single line & 
there is no need for braces for such case according to coding style
rules.

Signed-off-by: Ankit Baluni <b18007@students.iitmandi.ac.in>

---
Changes in v2:
	-Added more description about the patch.
	-Added space before the symobol '<' in 'From'
	 and 'Signed-off-by' line.
Changes in v3:
	-Removed space before ':' in subject line.

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

