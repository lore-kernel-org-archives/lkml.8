Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DATE_IN_PAST_03_06,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32877C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B402467B
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 13:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579699512;
	bh=VY+e001eqKGE4m+ZqZaJPIa6rFwDCRWMN7NXie69oK4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zir/kuhAoIHnptDsE9qySdYL5yqZuKMSYZ2ycdozCMd70dPEvgTTlQc8/zKPIjcEd
	 RtdBuaPYyAdR3AlOTZ6Uk+hb+lePW68uoZYfdVv/p2wz3CR/EntiUWjb5DzwZ+23u+
	 ecBqXTqF7ZXP2Ie9djtq1PDB3C/mRy+mR+1dtsD8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731158AbgAVNZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jan 2020 08:25:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:44524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731131AbgAVNZE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jan 2020 08:25:04 -0500
Received: from localhost (unknown [84.241.205.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0195F2467B;
        Wed, 22 Jan 2020 13:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579699503;
        bh=VY+e001eqKGE4m+ZqZaJPIa6rFwDCRWMN7NXie69oK4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lLAjMS+IIH69F+Jnx+bjwayudiJsMBJhGAgjKiUECbRV/k2CPhWUZLwOBw2Bzg3Ll
         kL/CU/P8Xh+lxHNqUw3qZLVqx4TanxqKGieE2U4K3k7kPDCRUgYzWZ+5+RbKF5v97K
         ++6OStzCmLlFgWqYDfHoX7TGtobzqpQeyyE6oH78=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Petr Machata <petrm@mellanox.com>,
        Amit Cohen <amitc@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 166/222] selftests: mlxsw: qos_mc_aware: Fix mausezahn invocation
Date:   Wed, 22 Jan 2020 10:29:12 +0100
Message-Id: <20200122092845.597727250@linuxfoundation.org>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200122092833.339495161@linuxfoundation.org>
References: <20200122092833.339495161@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Petr Machata <petrm@mellanox.com>

commit fef6d6704944c7be72fd2b77c021f1aed3d5df0d upstream.

Mausezahn does not recognize "own" as a keyword on source IP address. As a
result, the MC stream is not running at all, and therefore no UC
degradation can be observed even in principle.

Fix the invocation, and tighten the test: due to the minimum shaper
configured at the MC TCs, we always expect about 20% degradation. Fail the
test if it is lower.

Fixes: 573363a68f27 ("selftests: mlxsw: Add qos_lib.sh")
Signed-off-by: Petr Machata <petrm@mellanox.com>
Reported-by: Amit Cohen <amitc@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 tools/testing/selftests/drivers/net/mlxsw/qos_mc_aware.sh |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/tools/testing/selftests/drivers/net/mlxsw/qos_mc_aware.sh
+++ b/tools/testing/selftests/drivers/net/mlxsw/qos_mc_aware.sh
@@ -232,7 +232,7 @@ test_mc_aware()
 	stop_traffic
 	local ucth1=${uc_rate[1]}
 
-	start_traffic $h1 own bc bc
+	start_traffic $h1 192.0.2.65 bc bc
 
 	local d0=$(date +%s)
 	local t0=$(ethtool_stats_get $h3 rx_octets_prio_0)
@@ -254,7 +254,11 @@ test_mc_aware()
 			ret = 100 * ($ucth1 - $ucth2) / $ucth1
 			if (ret > 0) { ret } else { 0 }
 		    ")
-	check_err $(bc <<< "$deg > 25")
+
+	# Minimum shaper of 200Mbps on MC TCs should cause about 20% of
+	# degradation on 1Gbps link.
+	check_err $(bc <<< "$deg < 15") "Minimum shaper not in effect"
+	check_err $(bc <<< "$deg > 25") "MC traffic degrades UC performance too much"
 
 	local interval=$((d1 - d0))
 	local mc_ir=$(rate $u0 $u1 $interval)


