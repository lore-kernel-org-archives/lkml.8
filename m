Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF6EC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6587B20775
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:00:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="RO5hUxKx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbgCXPA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:00:26 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:31012 "EHLO
        esa4.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbgCXPA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:00:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1585062025;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uz4Sy1jYWR9Vj5L6zBEJzx886dGphqoV9Swq2hMNCsc=;
  b=RO5hUxKxI2tACwq5lST8VKqqpVvklL25YxYCdaQDPKHJ/aydlmiBdkHb
   EC8A46QNtbRDi+SvoaRNBkhr2rQGACg/yD69k5k0rJw1r+rUxhTTwEpsx
   cW0IUrUHK34H4GCBpdf4daXxXYP9/twkDXwGZSGNLNtT2VICvqbOSF5y9
   4=;
Authentication-Results: esa4.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=roger.pau@citrix.com; spf=Pass smtp.mailfrom=roger.pau@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
  receiver=esa4.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa4.hc3370-68.iphmx.com: domain of
  roger.pau@citrix.com designates 162.221.158.21 as permitted
  sender) identity=mailfrom; client-ip=162.221.158.21;
  receiver=esa4.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa4.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa4.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: YCwg7q0KwdVY96iyKyprGhvcUpIMhF5ZtrnBAK+bwM9Pfso8az5/0cXLxWjW0rbNRCmPQce0YJ
 xunPaMFS2oSKdxY5wn1t7mHyGBgWaX59MPoIp0Qzfkdlz5+B3yOzrxelV39hxfGRiZ8/1DuWUB
 DAR2gmxTdHlMbVOhR2+A2IZSwRt67js3hq2xZTgY9bZG1Bdi93cvBm/7jVXTvJ5G8Ju1JeclXk
 RYR1FKQkS3y4JvmUfE0PvGnnHY6DbuXqgxw++MAiud9kpB/aqGn0yd/or4ZEjxIbTD1EQlz4hQ
 J28=
X-SBRS: 2.7
X-MesageID: 15193080
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.72,300,1580792400"; 
   d="scan'208";a="15193080"
From:   Roger Pau Monne <roger.pau@citrix.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Roger Pau Monne <roger.pau@citrix.com>,
        Ian Jackson <ian.jackson@eu.citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        <xen-devel@lists.xenproject.org>
Subject: [PATCH 2/2] xen: enable BALLOON_MEMORY_HOTPLUG by default
Date:   Tue, 24 Mar 2020 16:00:15 +0100
Message-ID: <20200324150015.50496-2-roger.pau@citrix.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200324150015.50496-1-roger.pau@citrix.com>
References: <20200324150015.50496-1-roger.pau@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without it a PVH dom0 is mostly useless, as it would balloon down huge
amounts of RAM in order get physical address space to map foreign
memory and grants, ultimately leading to an out of memory situation.

Such option is also needed for HVM or PVH driver domains, since they
also require mapping grants into physical memory regions.

Suggested-by: Ian Jackson <ian.jackson@eu.citrix.com>
Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
---
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: xen-devel@lists.xenproject.org
---
 drivers/xen/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index 57ddd6f4b729..c344bcffd89d 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -13,6 +13,7 @@ config XEN_BALLOON
 config XEN_BALLOON_MEMORY_HOTPLUG
 	bool "Memory hotplug support for Xen balloon driver"
 	depends on XEN_BALLOON && MEMORY_HOTPLUG
+	default y
 	help
 	  Memory hotplug support for Xen balloon driver allows expanding memory
 	  available for the system above limit declared at system startup.
-- 
2.25.0

