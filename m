Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECE9C4332D
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 03:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 213EC2070A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 03:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YVr08bjp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgCTDJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 23:09:42 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:47661 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726614AbgCTDJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 23:09:41 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E25955C00D8;
        Thu, 19 Mar 2020 23:09:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 19 Mar 2020 23:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=jBBs34
        ifVHQ0aVecQlyYvVN7oUaD2V0VfvCaG76C/2c=; b=YVr08bjp5poGxs01hCJ8iZ
        Mg8A978WUliOLV6tKVX/QW+nuVYoedFY8bSWcgaOrocmUdIAk7toA7j1IMY26ZMz
        w5dwqL6RVIo6WVs8J88GGHKZ1BwK7PLqOimQqYYeCAvkSzlM4G09ZxouwQcyt6JY
        UksDfti7CbwUHpiqopap6bcrDaWVdQhKNdH/AEUM/ST97c1F0+W6rj2WnOX+cwuA
        cxtoLOrZkkoCGMDr+2VY0U2aW69Fd136cUpdtBeR9UvPqCsoCzgemebsTWXTLuAX
        oYfxkqkv7SXVe98Yh+nmYIdu5OVBP7QOf4wHiNyurJ20iCoWYSl78ocrX2Sj+zCg
        ==
X-ME-Sender: <xms:9DN0XgTb57k-FI1iRGuhtqwsI7bVWb6E_d6Q3Q4d4JyEsVoCWzJc-A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudegtddgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffogggtohfgsehtkeertdertdejnecuhfhrohhmpeforghrvghk
    ucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesihhnvh
    hishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucfkphepledurdeihedrfeegrdef
    feenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    hrmhgrrhgvkhesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhm
X-ME-Proxy: <xmx:9DN0XpL3bPRpU4iAoFhcTi8QWn-V6J-GIPuHJdAXN2EA53JLSbwnOg>
    <xmx:9DN0XnObG_zP_4pClfj_ABVOIQkzcFh7lUFh0MAXDb70Cq8b0PfU1Q>
    <xmx:9DN0XrzJ2aBuC-BbGGGfSd8ylxR9tSS9UR5TOVEjWVejta6BGZnjbQ>
    <xmx:9DN0XjWAP_SLFfYETPh6ujhwj2HXbfo2FaKHboWP2_Cx35VpeHCboQ>
Received: from localhost.localdomain (ip5b412221.dynamic.kabel-deutschland.de [91.65.34.33])
        by mail.messagingengine.com (Postfix) with ESMTPA id 76E073280059;
        Thu, 19 Mar 2020 23:09:39 -0400 (EDT)
From:   =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     xen-devel@lists.xenproject.org
Cc:     =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Simon Gaiser <simon@invisiblethingslab.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] xen-pciback: fix INTERRUPT_TYPE_* defines
Date:   Fri, 20 Mar 2020 04:09:18 +0100
Message-Id: <20200320030929.24735-1-marmarek@invisiblethingslab.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Invisible Things Lab
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xen_pcibk_get_interrupt_type() assumes INTERRUPT_TYPE_NONE being 0
(initialize ret to 0 and return as INTERRUPT_TYPE_NONE).
Fix the definition to make INTERRUPT_TYPE_NONE really 0, and also shift
other values to not leave holes.
But also, do not assume INTERRUPT_TYPE_NONE being 0 anymore to avoid
similar confusions in the future.

Fixes: 476878e4b2be ("xen-pciback: optionally allow interrupt enable flag writes")
Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
---
Changes in v2:
 - don't depend on INTERRUPT_TYPE_NONE being 0
---
 drivers/xen/xen-pciback/conf_space.c | 2 +-
 drivers/xen/xen-pciback/conf_space.h | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/xen/xen-pciback/conf_space.c b/drivers/xen/xen-pciback/conf_space.c
index b20e43e148ce..da51a5d34e6e 100644
--- a/drivers/xen/xen-pciback/conf_space.c
+++ b/drivers/xen/xen-pciback/conf_space.c
@@ -320,7 +320,7 @@ int xen_pcibk_get_interrupt_type(struct pci_dev *dev)
 		if (val & PCI_MSIX_FLAGS_ENABLE)
 			ret |= INTERRUPT_TYPE_MSIX;
 	}
-	return ret;
+	return ret ?: INTERRUPT_TYPE_NONE;
 }
 
 void xen_pcibk_config_free_dyn_fields(struct pci_dev *dev)
diff --git a/drivers/xen/xen-pciback/conf_space.h b/drivers/xen/xen-pciback/conf_space.h
index 28c45180a12e..5fe431c79f25 100644
--- a/drivers/xen/xen-pciback/conf_space.h
+++ b/drivers/xen/xen-pciback/conf_space.h
@@ -65,10 +65,10 @@ struct config_field_entry {
 	void *data;
 };
 
-#define INTERRUPT_TYPE_NONE (1<<0)
-#define INTERRUPT_TYPE_INTX (1<<1)
-#define INTERRUPT_TYPE_MSI  (1<<2)
-#define INTERRUPT_TYPE_MSIX (1<<3)
+#define INTERRUPT_TYPE_NONE (0)
+#define INTERRUPT_TYPE_INTX (1<<0)
+#define INTERRUPT_TYPE_MSI  (1<<1)
+#define INTERRUPT_TYPE_MSIX (1<<2)
 
 extern bool xen_pcibk_permissive;
 
-- 
2.21.1

