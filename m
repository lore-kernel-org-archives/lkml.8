Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8D5C55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 05:56:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 499C420700
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 05:56:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="jo4uUlyb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgDXF4p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 01:56:45 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:40894 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgDXF4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 01:56:45 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03O5uhUu038861;
        Fri, 24 Apr 2020 00:56:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587707803;
        bh=gRuOwjKnS19hyev04VgHxxb94U9jBGqXi0jz+Ipyhlg=;
        h=From:To:Subject:Date;
        b=jo4uUlybOhQicPh3E22qTpUqH7zYZe9ttlswScj13yP3U2JpQXAZD3bVOl5B0Thai
         +HjNnz4tqxEMZeUk33FUIvz47F2Ic6oQj9arE2qeUFV5fXNtaQ6w1/obPSA5NqNc4N
         exBoBEvBNYzrHsq77dntJRkQ5cm+dCy3BDqFKK5Q=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03O5uh6H073135
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 24 Apr 2020 00:56:43 -0500
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Fri, 24
 Apr 2020 00:56:42 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Fri, 24 Apr 2020 00:56:42 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03O5ueYI053428;
        Fri, 24 Apr 2020 00:56:41 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] MAINTAINERS: Add Vinod Koul as Generic PHY co-maintainer
Date:   Fri, 24 Apr 2020 11:26:38 +0530
Message-ID: <20200424055638.834-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Vinod Koul as Generic PHY Subsystem co-maintainer.

Cc: Vinod Koul <vkoul@kernel.org>
Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ffcd023d1cba..d61a51b05f17 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7116,6 +7116,7 @@ F:	include/uapi/asm-generic/
 
 GENERIC PHY FRAMEWORK
 M:	Kishon Vijay Abraham I <kishon@ti.com>
+M:	Vinod Koul <vkoul@kernel.org>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git
-- 
2.17.1

