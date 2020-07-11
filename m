Return-Path: <SRS0=TDCE=AW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64AF7C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 11:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 294B72076A
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jul 2020 11:58:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727019AbgGKL57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jul 2020 07:57:59 -0400
Received: from smtprelay0122.hostedemail.com ([216.40.44.122]:36238 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726281AbgGKL57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jul 2020 07:57:59 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 20BC2837F24C;
        Sat, 11 Jul 2020 11:57:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: limit75_5f04aa726ed6
X-Filterd-Recvd-Size: 1409
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Sat, 11 Jul 2020 11:57:56 +0000 (UTC)
Message-ID: <dab1ba1aa03a8236933cfb7a28937efb0b808f13.camel@perches.com>
Subject: [PATCH] const_structs.checkpatch: Add regulator_ops
From:   Joe Perches <joe@perches.com>
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     pihsun@chromium.org, lgirdwood@gmail.com, broonie@kernel.org,
        bleung@chromium.org, enric.balletbo@collabora.com,
        groeck@chromium.org, linux-kernel@vger.kernel.org
Date:   Sat, 11 Jul 2020 04:57:54 -0700
In-Reply-To: <20200711114409.9911-1-rikard.falkeborn@gmail.com>
References: <20200711114409.9911-1-rikard.falkeborn@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add regulator_ops to expected to be const list

Signed-off-by: Joe Perches <joe@perches.com>
---
diff --git a/scripts/const_structs.checkpatch b/scripts/const_structs.checkpatch
index ac5f1267151d..e9df9cc28a85 100644
--- a/scripts/const_structs.checkpatch
+++ b/scripts/const_structs.checkpatch
@@ -44,6 +44,7 @@ platform_hibernation_ops
 platform_suspend_ops
 proto_ops
 regmap_access_table
+regulator_ops
 rpc_pipe_ops
 rtc_class_ops
 sd_desc


