Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4CEFC33C9E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1E7A2084D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 10:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578737996;
	bh=lmYdt9hnY53BoyiuaTK2YcklylDm7s19zNZgwKX/ylU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EFgEh5ULHuGxg3lLiR6Gv0TBkjc/MSlID/+ksflD5td4PcKIEThWaU4zjZWeW4WEI
	 2LN7jNPghIcM2dRTMLgozuxqfHPLxA6PA+wIYWlkyk2RZqZnsdygHFM5TajiEwRuye
	 Gl0dr3xV2/J93niAWbse+dIixaeo94//pTSqIRes=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730584AbgAKKTz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 05:19:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:40168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730558AbgAKKTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 05:19:51 -0500
Received: from localhost (unknown [62.119.166.9])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87FFC2082E;
        Sat, 11 Jan 2020 10:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578737991;
        bh=lmYdt9hnY53BoyiuaTK2YcklylDm7s19zNZgwKX/ylU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ztm4XKHqe04UOn4eu2ibU4DcqVHy+fqTTekBV0PdXjpSZCcJYE7dxAROIbXsLGv0u
         vsFpo3aJklbU3o5f8oMu+33XZLfUSFZLKK0kJbecoFIQ9WoPFsS93f92mrmvQIToMz
         x0yR3YDU8I6VJvgrmDmewkEBbinlLDU7egsPw8u4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Chris Healy <cphealy@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 68/84] net: dsa: mv88e6xxx: Preserve priority when setting CPU port.
Date:   Sat, 11 Jan 2020 10:50:45 +0100
Message-Id: <20200111094910.964618335@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200111094845.328046411@linuxfoundation.org>
References: <20200111094845.328046411@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>

[ Upstream commit d8dc2c9676e614ef62f54a155b50076888c8a29a ]

The 6390 family uses an extended register to set the port connected to
the CPU. The lower 5 bits indicate the port, the upper three bits are
the priority of the frames as they pass through the switch, what
egress queue they should use, etc. Since frames being set to the CPU
are typically management frames, BPDU, IGMP, ARP, etc set the priority
to 7, the reset default, and the highest.

Fixes: 33641994a676 ("net: dsa: mv88e6xxx: Monitor and Management tables")
Signed-off-by: Andrew Lunn <andrew@lunn.ch>
Tested-by: Chris Healy <cphealy@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/dsa/mv88e6xxx/global1.c |    5 +++++
 drivers/net/dsa/mv88e6xxx/global1.h |    1 +
 2 files changed, 6 insertions(+)

--- a/drivers/net/dsa/mv88e6xxx/global1.c
+++ b/drivers/net/dsa/mv88e6xxx/global1.c
@@ -371,6 +371,11 @@ int mv88e6390_g1_set_cpu_port(struct mv8
 {
 	u16 ptr = MV88E6390_G1_MONITOR_MGMT_CTL_PTR_CPU_DEST;
 
+	/* Use the default high priority for management frames sent to
+	 * the CPU.
+	 */
+	port |= MV88E6390_G1_MONITOR_MGMT_CTL_PTR_CPU_DEST_MGMTPRI;
+
 	return mv88e6390_g1_monitor_write(chip, ptr, port);
 }
 
--- a/drivers/net/dsa/mv88e6xxx/global1.h
+++ b/drivers/net/dsa/mv88e6xxx/global1.h
@@ -197,6 +197,7 @@
 #define MV88E6390_G1_MONITOR_MGMT_CTL_PTR_INGRESS_DEST		0x2000
 #define MV88E6390_G1_MONITOR_MGMT_CTL_PTR_EGRESS_DEST		0x2100
 #define MV88E6390_G1_MONITOR_MGMT_CTL_PTR_CPU_DEST		0x3000
+#define MV88E6390_G1_MONITOR_MGMT_CTL_PTR_CPU_DEST_MGMTPRI	0x00e0
 #define MV88E6390_G1_MONITOR_MGMT_CTL_DATA_MASK			0x00ff
 
 /* Offset 0x1C: Global Control 2 */


