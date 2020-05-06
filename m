Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AEDFC47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59F81208E4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="g7/147YY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbgEFQfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 12:35:44 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:52540 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729747AbgEFQfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:35:42 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 046GZdhQ088891;
        Wed, 6 May 2020 11:35:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1588782939;
        bh=OGc5X3j3zEIjA4+QYcZqsAYDx3XrS7LxDxXz9jsd81g=;
        h=From:To:Subject:Date:In-Reply-To:References;
        b=g7/147YYBK6ii+xi4lmSI+xcUikFShbOtdqQp+KPi8Rd0snHnqGqPlCL0nT4kG8FD
         9Jf6Dj/F6PGLvYt6oDz62Y/l2llz+rBVTo7h6DDSieTT8MP24jQAzqW/OTR7ilhmpn
         PFTT6oSxguhfJPSHsmqi+J9cghveYWG+Y3LFC+vw=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 046GZd6A069280
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 May 2020 11:35:39 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 6 May
 2020 11:35:39 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 6 May 2020 11:35:39 -0500
Received: from uda0868495.fios-router.home (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 046GZbQI128992;
        Wed, 6 May 2020 11:35:38 -0500
From:   Murali Karicheri <m-karicheri2@ti.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <nsekhar@ti.com>,
        <grygorii.strashko@ti.com>
Subject: [net-next RFC PATCH 2/2] prp: update man page for PRP
Date:   Wed, 6 May 2020 12:35:37 -0400
Message-ID: <20200506163537.3958-3-m-karicheri2@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200506163537.3958-1-m-karicheri2@ti.com>
References: <20200506163537.3958-1-m-karicheri2@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This update man page for PRP support

Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
---
 man/man8/ip-link.8.in | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/man/man8/ip-link.8.in b/man/man8/ip-link.8.in
index 939e2ad49f4e..56d95a79eac5 100644
--- a/man/man8/ip-link.8.in
+++ b/man/man8/ip-link.8.in
@@ -1383,6 +1383,35 @@ corresponds to the 2010 version of the HSR standard. Option "1" activates the
 2012 version.
 .in -8
 
+.TP
+Parallel Redundancy Protocol (PRP) Support
+For a link of type
+.I PRP
+the following additional arguments are supported:
+
+.BI "ip link add link " DEVICE " name " NAME " type prp"
+.BI slave1 " SLAVE1-IF " slave2 " SLAVE2-IF "
+.RB [ " supervision"
+.IR ADDR-BYTE " ] ["
+.BR version " { " 0 " | " 1 " } ]"
+
+.in +8
+.sp
+.BR type " prp "
+- specifies the link type to use, here PRP.
+
+.BI slave1 " SLAVE1-IF "
+- Specifies the physical device used for the first of the two redundant ports.
+
+.BI slave2 " SLAVE2-IF "
+- Specifies the physical device used for the second of the two redundant ports.
+
+.BI supervision " ADDR-BYTE"
+- The last byte of the multicast address used for PRP supervision frames.
+Default option is "0", possible values 0-255.
+
+.in -8
+
 .TP
 BRIDGE Type Support
 For a link of type
-- 
2.17.1

