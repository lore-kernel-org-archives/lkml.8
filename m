Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91185C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 12:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A31D2087D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 12:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597408764;
	bh=EegKnqHRZMQsA/pGucdJ5ay2rhbxOu1GzsIX8DvXDXc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ACnUsHbicrZqCKyrvqUTzcS+YT1/fcLogRqwxYOSaT/JW3OSa39hrH4gU0AmY9nOb
	 Vd+bUJH8sPTiuQhD1zpWBc2fpXa/kfwP1nQR9+Zfy04L8oopX5HOtq8NAVkZVLtZZU
	 H8Xrzby2CC4w/eq00L7acIUZVz6845vc96Ro89rY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbgHNMjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Aug 2020 08:39:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:52376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728323AbgHNMjQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Aug 2020 08:39:16 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E7B120866;
        Fri, 14 Aug 2020 12:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597408756;
        bh=EegKnqHRZMQsA/pGucdJ5ay2rhbxOu1GzsIX8DvXDXc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ECovbeo3YzEdHHFQby9dOpfrt3TtOdR4UCCK+HKYcMfeP8aNX3AH3IRBlCICJVu53
         E3gQ5Md3Mb8l07clI/dOgEbYlIEmn6k6NLXOOPFy8GvDDYQa6t8B0bN0QOpJt+6e3H
         qupz6y/jE409fwQG8/WDAtrEqfPuobn2D9914f+k=
From:   Sasha Levin <sashal@kernel.org>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org
Cc:     gregkh@linuxfoundation.org, iourit@microsoft.com,
        linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4/4] drivers: hv: dxgkrnl: create a MAINTAINERS entry
Date:   Fri, 14 Aug 2020 08:38:56 -0400
Message-Id: <20200814123856.3880009-5-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200814123856.3880009-1-sashal@kernel.org>
References: <20200814123856.3880009-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4e2698cc7e23..1e725a9e6335 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8003,6 +8003,13 @@ F:	Documentation/devicetree/bindings/mtd/ti,am654-hbmc.txt
 F:	drivers/mtd/hyperbus/
 F:	include/linux/mtd/hyperbus.h
 
+Hyper-V vGPU DRIVER
+M:	Sasha Levin <sashal@kernel.org>
+M:	Iouri Tarassov <iourit@microsoft.com>
+L:	linux-hyperv@vger.kernel.org
+S:	Supported
+F:	drivers/hv/dxgkrnl/
+
 HYPERVISOR VIRTUAL CONSOLE DRIVER
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Odd Fixes
-- 
2.25.1

