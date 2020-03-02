Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2DB0C3F2D4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75BD2246B6
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 08:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583136001;
	bh=dbM6ws0/Oqvz1iJityzfK5eRG+lz5REP3+A2a7K9CKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xgr6hF2NOGJYnlLM5JJx3ugQnSZSu1grNloEi/XYbhw4lXDPU3fPRGabhbM1hL1IA
	 BhTZVaOuG76ZYlIIFUS6Q0PlJGGREHJ1H6DpFSztkvpDbh+Cr36ir3Imwb1lSf40LJ
	 3yiJUWCXVj4Uavn7e3hXQ8chnW3E61ES+dKG1cpo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgCBH7n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 02:59:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:51268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbgCBH7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 02:59:42 -0500
Received: from mail.kernel.org (ip5f5ad4e9.dynamic.kabel-deutschland.de [95.90.212.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52110246B9;
        Mon,  2 Mar 2020 07:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583135981;
        bh=dbM6ws0/Oqvz1iJityzfK5eRG+lz5REP3+A2a7K9CKg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QN6Uz+fJY7yr3hx1Oip3Pg77+NTBnKOD+gWFAfkBTMX0PRP0arpu2o/hPQz6q7pnn
         POdV9c95jcaFMZgxRekmKE0CQ0ICGSxDTjTj/JI8SWvO5cK06PVNiOYsXN3aavt3cr
         a7eGlGi2OTYvkKNVLIl2ID5mL0oxOTweDrtSZNWs=
Received: from mchehab by mail.kernel.org with local (Exim 4.92.3)
        (envelope-from <mchehab@kernel.org>)
        id 1j8fzH-0003gV-2S; Mon, 02 Mar 2020 08:59:39 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v2 03/12] docs: dt: usage_model.rst: fix link for DT usage
Date:   Mon,  2 Mar 2020 08:59:28 +0100
Message-Id: <a7e0a5597ace97503c8ff67cdab2351151c7f267.1583135507.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <cover.1583135507.git.mchehab+huawei@kernel.org>
References: <cover.1583135507.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devicetree.org doesn't host the Device_Tree_Usage page
anymore. So, fix the link to point to a new address.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/devicetree/usage-model.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/usage-model.rst b/Documentation/devicetree/usage-model.rst
index 326d7af10c5b..e1b42dc63f01 100644
--- a/Documentation/devicetree/usage-model.rst
+++ b/Documentation/devicetree/usage-model.rst
@@ -12,7 +12,7 @@ This article describes how Linux uses the device tree.  An overview of
 the device tree data format can be found on the device tree usage page
 at devicetree.org\ [1]_.
 
-.. [1] http://devicetree.org/Device_Tree_Usage
+.. [1] https://elinux.org/Device_Tree_Usage
 
 The "Open Firmware Device Tree", or simply Device Tree (DT), is a data
 structure and language for describing hardware.  More specifically, it
-- 
2.21.1

