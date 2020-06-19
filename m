Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E652C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2116A21D80
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 15:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592579040;
	bh=jL57LjiGswb6H7HnMJrD39KF0xhoV9ZcfKG7asJMdfA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Nf2OWzHboH3obxLCB8JGdDGWECdcf2ui7hyyeNFWTXAjMbTUdejSEZIn0GNWecCcv
	 p3G7+18h+6ZmrWy9Wl10gRzpc719Us6nc7LxyNoWbz1s6oTMd0ceLlCNsMTNxWiEPE
	 pX3PQMpP1f+dfYtgPecPdAZEu797I//3TDOYKCn4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391071AbgFSPD5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 11:03:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:60496 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391041AbgFSPDm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 11:03:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97AC42193E;
        Fri, 19 Jun 2020 15:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592579023;
        bh=jL57LjiGswb6H7HnMJrD39KF0xhoV9ZcfKG7asJMdfA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oIkND0hlnMsfjm7kPth2Z8U5reIbREm0hNZC/REDQQ/5KiwGPxwArl71ubCV+72RM
         d5cZHRkYsQVTTwf6CnvZNMRClpklIqBD4fvqhQDqZKYPtfm8kSDBLtkpmVZhT9W+3+
         LctTHdK2dwgY/RC7yFalTBUj862TY5FzTdtjnEpI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        Michael K Johnson <johnsonm@danlj.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 219/267] PCI: Add Genesys Logic, Inc. Vendor ID
Date:   Fri, 19 Jun 2020 16:33:24 +0200
Message-Id: <20200619141659.226560568@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141648.840376470@linuxfoundation.org>
References: <20200619141648.840376470@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Chuang <ben.chuang@genesyslogic.com.tw>

[ Upstream commit 4460d68f0b2f9092273531fbc65613e1855c2e07 ]

Add the Genesys Logic, Inc. vendor ID to pci_ids.h.

Signed-off-by: Ben Chuang <ben.chuang@genesyslogic.com.tw>
Co-developed-by: Michael K Johnson <johnsonm@danlj.org>
Signed-off-by: Michael K Johnson <johnsonm@danlj.org>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/pci_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index bd682fcb9768..3329387261df 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2409,6 +2409,8 @@
 #define PCI_DEVICE_ID_RDC_R6061		0x6061
 #define PCI_DEVICE_ID_RDC_D1010		0x1010
 
+#define PCI_VENDOR_ID_GLI		0x17a0
+
 #define PCI_VENDOR_ID_LENOVO		0x17aa
 
 #define PCI_VENDOR_ID_QCOM		0x17cb
-- 
2.25.1



