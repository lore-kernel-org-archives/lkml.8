Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B95C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42AC0206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 16:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592584932;
	bh=V7t7/rNV/8i90L5LWGoUJj5anpjm3tjRYXmHt2mdNf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qJ0F/AR/atIaBzia4s6ap9zKnq3YKu3Ij2U0sW9wVR27kEfElwr8eNGZRRGV1Tl2n
	 QBs7EFQBRuOCSR2T0VbSL2FO879kwADAJ6wvTe3TZUPMTJAlGA31w3BODXznVoqBEv
	 qIH2+q10JS0t2ybL6/moWcVQ9SxJu3zObS1zsfIs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388580AbgFSOoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:44:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:35386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388006AbgFSOoJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:44:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3461A21556;
        Fri, 19 Jun 2020 14:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592577847;
        bh=V7t7/rNV/8i90L5LWGoUJj5anpjm3tjRYXmHt2mdNf4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PH/CYJPL7Ykyn+ET0B9yrU8ncif8hzpjOm6qJdYSlG1B2NqIojtN5ptbQM69rtcvy
         1DChr2qLkyvpaWIo6wnqyvjnMUZxk230EscF3DhxeqDDMZ2ugq9kVuvL3CjHcbV14S
         N05k9z8QGC0rPFqpnnlLWtTufac+a6CSY5zhyVOE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Aaron Brown <aaron.f.brown@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Subject: [PATCH 4.9 113/128] igb: Report speed and duplex as unknown when device is runtime suspended
Date:   Fri, 19 Jun 2020 16:33:27 +0200
Message-Id: <20200619141626.112430569@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200619141620.148019466@linuxfoundation.org>
References: <20200619141620.148019466@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>

commit 165ae7a8feb53dc47fb041357e4b253bfc927cf9 upstream.

igb device gets runtime suspended when there's no link partner. We can't
get correct speed under that state:
$ cat /sys/class/net/enp3s0/speed
1000

In addition to that, an error can also be spotted in dmesg:
[  385.991957] igb 0000:03:00.0 enp3s0: PCIe link lost

Since device can only be runtime suspended when there's no link partner,
we can skip reading register and let the following logic set speed and
duplex with correct status.

The more generic approach will be wrap get_link_ksettings() with begin()
and complete() callbacks. However, for this particular issue, begin()
calls igb_runtime_resume() , which tries to rtnl_lock() while the lock
is already hold by upper ethtool layer.

So let's take this approach until the igb_runtime_resume() no longer
needs to hold rtnl_lock.

CC: stable <stable@vger.kernel.org>
Suggested-by: Alexander Duyck <alexander.duyck@gmail.com>
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Tested-by: Aaron Brown <aaron.f.brown@intel.com>
Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/net/ethernet/intel/igb/igb_ethtool.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/intel/igb/igb_ethtool.c
+++ b/drivers/net/ethernet/intel/igb/igb_ethtool.c
@@ -153,7 +153,8 @@ static int igb_get_settings(struct net_d
 	u32 status;
 	u32 speed;
 
-	status = rd32(E1000_STATUS);
+	status = pm_runtime_suspended(&adapter->pdev->dev) ?
+		 0 : rd32(E1000_STATUS);
 	if (hw->phy.media_type == e1000_media_type_copper) {
 
 		ecmd->supported = (SUPPORTED_10baseT_Half |


