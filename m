Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D635C2BAEE
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:00:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 558A220775
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 15:00:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="ePgOG452"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgCXPA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 11:00:27 -0400
Received: from esa4.hc3370-68.iphmx.com ([216.71.155.144]:31012 "EHLO
        esa4.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727567AbgCXPA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 11:00:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1585062026;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ssXAEeDvel0Jf7gmmpPeu8hMRNYSVWL/a7oAMPsVjt4=;
  b=ePgOG452eLS5MuC9X1m8/otaN1CdNfmiwcuslOnuvSDrQ0FgkIaUHTwm
   YIkx4FckauvGI+7j58Tih90J6LexM0S50zAeuXReog7ePpQSrvmWJj+0p
   LatItf4Q5TS77sjowZ9+5UgYM4OT+L55l2cij3zONNevHcaEKmiNcLWG5
   U=;
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
IronPort-SDR: 229YkSUPjTs2vF4LrHxAgXY+0/Cxpb0vjzrzH+SAqyCmieLe/OXnOTr2iYuhQQYLYQGzbEhzZ2
 LVaJsD+YCTD7R5RnydHpvwGjcWkpBXoBE2bYSPnPELLfD66DWK7DKj71KdmYeJEKXWxPA3FmTk
 lO7BeEP9kxCvTYODa9N22iDd5RWV+Is0Stno94+OksnMGfdPoqSmqX3Ie7W7tDpQQDvU0q6ixo
 H4UR9U5rhZ8+5qOxxNeAa1Rb7ooSq5lKz1fJ8zNdGSi+vDaldHSaGfgFhtlSX5QXFf1TG77Izk
 s+s=
X-SBRS: 2.7
X-MesageID: 15193081
X-Ironport-Server: esa4.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.72,300,1580792400"; 
   d="scan'208";a="15193081"
From:   Roger Pau Monne <roger.pau@citrix.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Roger Pau Monne <roger.pau@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        "Stefano Stabellini" <sstabellini@kernel.org>,
        <xen-devel@lists.xenproject.org>
Subject: [PATCH 1/2] xen: expand BALLOON_MEMORY_HOTPLUG description
Date:   Tue, 24 Mar 2020 16:00:14 +0100
Message-ID: <20200324150015.50496-1-roger.pau@citrix.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To mention it's also useful for PVH or HVM domains that require
mapping foreign memory or grants.

Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
---
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: xen-devel@lists.xenproject.org
---
 drivers/xen/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index 61212fc7f0c7..57ddd6f4b729 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -19,6 +19,10 @@ config XEN_BALLOON_MEMORY_HOTPLUG
 	  It is very useful on critical systems which require long
 	  run without rebooting.
 
+	  It's also very useful for translated domains (PVH or HVM) to obtain
+	  unpopulated physical memory ranges to use in order to map foreign
+	  memory or grants.
+
 	  Memory could be hotplugged in following steps:
 
 	    1) target domain: ensure that memory auto online policy is in
-- 
2.25.0

