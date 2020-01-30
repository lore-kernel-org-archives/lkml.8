Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DF9BC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42BAD214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 18:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580409629;
	bh=005QrlpyeISwVRM5donYC0s406q/R2jnUVfuLChgDP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=vkFx9x2hWCBavfCwaoDH6Oodo+1sfrajaj/ahnJZagB96DcaH6lDZ1M3O988gTNYt
	 NbuSS7F8ZidegjP6T6gmnwj2FhjMfW+vVv91Z/IYh7cKsAfKOnpbqHPlY9rIEfLMs/
	 7XN4hM30oPl2SITdGZKtOfI4XTQ27SFJ26j2Hgbc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729966AbgA3Sk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 13:40:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:47958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729943AbgA3SkZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 13:40:25 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DCA220702;
        Thu, 30 Jan 2020 18:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580409624;
        bh=005QrlpyeISwVRM5donYC0s406q/R2jnUVfuLChgDP4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l2vBa8N/sJN8kJvbuWLi5uYSEvE6/Vc8tILOIDaqSmIQuqqKoDuNba+ZWOQgynXS2
         meWdcFmPuHJOIzl9r5+GZRm9I7YgJHhCoZbygSEBxfsvONo1ti2BC/6DxQED9JvcbC
         2W40ZY6+DSAn8R3neNqdUVmvgU43ULgck0iamr28=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 5.5 24/56] mei: me: add jasper point DID
Date:   Thu, 30 Jan 2020 19:38:41 +0100
Message-Id: <20200130183613.603678518@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200130183608.849023566@linuxfoundation.org>
References: <20200130183608.849023566@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomas Winkler <tomas.winkler@intel.com>

commit 0db4a15d4c2787b1112001790d4f95bd2c5fed6f upstream.

Add Jasper Point (Jasper Lake) device id for MEI

Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Cc: stable <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20200124001455.24176-1-tomas.winkler@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/misc/mei/hw-me-regs.h |    2 ++
 drivers/misc/mei/pci-me.c     |    2 ++
 2 files changed, 4 insertions(+)

--- a/drivers/misc/mei/hw-me-regs.h
+++ b/drivers/misc/mei/hw-me-regs.h
@@ -89,6 +89,8 @@
 
 #define MEI_DEV_ID_ICP_LP     0x34E0  /* Ice Lake Point LP */
 
+#define MEI_DEV_ID_JSP_N      0x4DE0  /* Jasper Lake Point N */
+
 #define MEI_DEV_ID_TGP_LP     0xA0E0  /* Tiger Lake Point LP */
 
 #define MEI_DEV_ID_MCC        0x4B70  /* Mule Creek Canyon (EHL) */
--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -106,6 +106,8 @@ static const struct pci_device_id mei_me
 
 	{MEI_PCI_DEVICE(MEI_DEV_ID_TGP_LP, MEI_ME_PCH15_CFG)},
 
+	{MEI_PCI_DEVICE(MEI_DEV_ID_JSP_N, MEI_ME_PCH15_CFG)},
+
 	{MEI_PCI_DEVICE(MEI_DEV_ID_MCC, MEI_ME_PCH15_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_MCC_4, MEI_ME_PCH8_CFG)},
 


