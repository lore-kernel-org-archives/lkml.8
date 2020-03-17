Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F068C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:11:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 207A12076B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 13:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584450670;
	bh=QyLkGuPfEBut7lJE9QyErixhuO2mGnV+5sbTxdfHiCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vFQu9D/SgwpmOIclUFovrx/HjzO2LOW/XINmKn562GqiholFemqHh+y99t8R9hq5i
	 tpE728xb9Fr+AW6CPYeIfIWC8Jb2FxjDaKK5GMSjKC59RSn7QGbTFSXqeBELn1j5BS
	 T/5W8p2W0V3SjXuhh3lItVsagAtH9id9JVh8IS9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgCQNK5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 09:10:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:37708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725872AbgCQNK4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 09:10:56 -0400
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5369820752;
        Tue, 17 Mar 2020 13:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584450655;
        bh=QyLkGuPfEBut7lJE9QyErixhuO2mGnV+5sbTxdfHiCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QltzWFyx31h8qGLX0L565lDdBLjuWiGzeDvXbGN/OEFKxRJ7gpzQJeArzAatDag6m
         dbKm6Q4yTnd1XRod03X9LmJRpscuRu6Cs/IEa7Hg9BxYM1KZ/BP4MG4zuiHoRRssp0
         kHQwN1lbbh+fXmpZHLLuHaFO+EMNfZOTJ/VOBGzs=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1jEBzh-0006Rt-GG; Tue, 17 Mar 2020 14:10:53 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@st.com>
Subject: [PATCH 02/12] MAINTAINERS: dt: update etnaviv file reference
Date:   Tue, 17 Mar 2020 14:10:41 +0100
Message-Id: <62bfbba8192469976129adf24783b1534b19d6e4.1584450500.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1584450500.git.mchehab+huawei@kernel.org>
References: <cover.1584450500.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The etnaviv file was converted to json and renamed.

Update its reference accordingly.

Fixes: 90aeca875f8a ("dt-bindings: display: Convert etnaviv to json-schema")
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9f3ce3f8df56..21204be0b4bf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5768,7 +5768,7 @@ L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 F:	drivers/gpu/drm/etnaviv/
 F:	include/uapi/drm/etnaviv_drm.h
-F:	Documentation/devicetree/bindings/display/etnaviv/
+F:	Documentation/devicetree/bindings/gpu/vivante,gc.yaml
 
 DRM DRIVERS FOR ZTE ZX
 M:	Shawn Guo <shawnguo@kernel.org>
-- 
2.24.1

