Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5759EC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 04:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272C82072C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 04:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Kbx8CKEi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgCSEHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 00:07:54 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:43275 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725601AbgCSEHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 00:07:53 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 2CA815C02B0;
        Thu, 19 Mar 2020 00:07:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 19 Mar 2020 00:07:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:message-id:mime-version:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=JqZGVe
        m4rI66UrgmQlCfN5l+r//ZyO/zrduFLQUqFkQ=; b=Kbx8CKEieLma6upRs2muMG
        15H4EBafz+XjJQCJYzbgTzoFdPa7GoiTeRe0ngQIgIqCP1OR5fojIDYoQQXGMfWJ
        zW9hFwlygiMbyXLHCF8VRPEQi6Ya93W2sonbg0CvGdinOf5gIs/mpqgiefDZ4ngp
        YT4L7NeWlTomatV4tiVG/653NJCUZ0yBBxZ+iHqTlShWKOvTo4q7mG7wMwDs4jfY
        03tlTocXY9F//JkFyOTcVlcig5GnRL655lfJJ2qUJ1Upm8jsgZqMxOrtdKqfT7q1
        tU6WbGsxkE9Qt8eKQRbHFE/X2fFFrSWeVBoLLCHkfe70TSJQoNus97iHXwVZRihQ
        ==
X-ME-Sender: <xms:F_ByXqiQHFbdBhZ9t5M5tuCLPpCYaJkXOd7dYJKvgClZwXb6EEvqDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudefkedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffogggtohfgsehtkeertdertdejnecuhfhrohhmpeforghrvghk
    ucforghrtgiihihkohifshhkihdqifpkrhgvtghkihcuoehmrghrmhgrrhgvkhesihhnvh
    hishhisghlvghthhhinhhgshhlrggsrdgtohhmqeenucfkphepledurdeihedrfeegrdef
    feenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrg
    hrmhgrrhgvkhesihhnvhhishhisghlvghthhhinhhgshhlrggsrdgtohhm
X-ME-Proxy: <xmx:F_ByXjwefj1gpPsuFiKhObTjzLgT6DDx0fKtYczU-RB8I5Boa2awYQ>
    <xmx:F_ByXnjId9SiDnq8kOSIZ-qZYeVOPw8Y1CCLPLgk6RYvXsq5d1V-xg>
    <xmx:F_ByXm-zpA_CzFV5V020hSAuP3Y5XtuHnU15vgsq6rLA42ClYpKgig>
    <xmx:GPByXmHgGU4oG5hvRaaju3aTq_A6lsheNjXe3CbttaMwLhGHBYTFng>
Received: from localhost.localdomain (ip5b412221.dynamic.kabel-deutschland.de [91.65.34.33])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8C7763280063;
        Thu, 19 Mar 2020 00:07:50 -0400 (EDT)
From:   =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>
To:     xen-devel@lists.xenproject.org
Cc:     =?UTF-8?q?Marek=20Marczykowski-G=C3=B3recki?= 
        <marmarek@invisiblethingslab.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Simon Gaiser <simon@invisiblethingslab.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] xen-pciback: fix INTERRUPT_TYPE_* defines
Date:   Thu, 19 Mar 2020 05:06:40 +0100
Message-Id: <20200319040648.10396-1-marmarek@invisiblethingslab.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Invisible Things Lab
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

INTERRUPT_TYPE_NONE should be 0, as it is assumed in
xen_pcibk_get_interrupt_type(). Fix the definition, and also shift other
values to not leave holes.
But also use INTERRUPT_TYPE_NONE in xen_pcibk_get_interrupt_type() to
avoid similar confusions in the future.

Fixes: 476878e4b2be ("xen-pciback: optionally allow interrupt enable flag writes")
Signed-off-by: Marek Marczykowski-Górecki <marmarek@invisiblethingslab.com>
---
 drivers/xen/xen-pciback/conf_space.c | 2 +-
 drivers/xen/xen-pciback/conf_space.h | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/xen/xen-pciback/conf_space.c b/drivers/xen/xen-pciback/conf_space.c
index b20e43e148ce..b4e4ec9cd496 100644
--- a/drivers/xen/xen-pciback/conf_space.c
+++ b/drivers/xen/xen-pciback/conf_space.c
@@ -290,7 +290,7 @@ int xen_pcibk_get_interrupt_type(struct pci_dev *dev)
 {
 	int err;
 	u16 val;
-	int ret = 0;
+	int ret = INTERRUPT_TYPE_NONE;
 
 	err = pci_read_config_word(dev, PCI_COMMAND, &val);
 	if (err)
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
2.21.0

