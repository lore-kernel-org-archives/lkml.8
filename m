Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E8FC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 01:45:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75DC8206F7
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 01:45:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="O0cT0OuP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbgFJBpR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 21:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725954AbgFJBpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 21:45:16 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE9AC05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 18:45:16 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id w3so616657qkb.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 18:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SyG3PDT/1k7qwtsgQqq5FDrFZ5PwQThhefYVb1X2LUg=;
        b=O0cT0OuPOQIon8tdE+8vsepQXDEPeFw84UM/G5iXWznws6X1+5ppCbJhjI7m/Ib4l+
         neph/zHqc75eNZUcpcxLi+6jJeWzWlduBs6KWVN6WEC7zHHMNYK+sWiag2SqDa70lub1
         8lRncKp7maiGoo4VoSr6W6HaTz4eOapitwKtP+F1xwL/OQIRUwNHAsfYzn0h6YICSKz2
         SskErKyPjkKrz3RJV8yJeIFWXdqT88GKSLr2BIx3P/JqvYD0r8ezI4ZkDiXcpdlrMpAp
         G606p/0Nyvc8Y6z1hlQH7aKJeV3flxzOzu/gS5xs7gpuiCsvMW2yYDEkoeHHnzVJErS9
         5rhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SyG3PDT/1k7qwtsgQqq5FDrFZ5PwQThhefYVb1X2LUg=;
        b=n86NtILnQdUMW01U10yXn6Zc/HIU2i1wEwSN4OahT2pWXLIlpvuaE1SD3NgojltkDx
         D4Xa69K0MjkBKkQi1sRSEPDoP4zziD7uF2rtEDcRywQ/yS5ppufBbvRSkHVqWkSt8nNF
         7c7seFCtCfvoPbxEG1ybTc+o8/hID+fcc06XPd1qYN5zzoI2yvhS1OLVY8vHg9lwZDja
         G80ZpseOuf3kljlgdwh2ITQhXk5AKXw4m/lrVhtnkGXKa/LSiRfXdbZKP1dkxA8jHocp
         qbbFgcnqSLgeEH+ALgeDIrmxY1NNeTiculEHi+YrTD6YUkmwqI0gFTOaSKc2GH/aeyQw
         a1fw==
X-Gm-Message-State: AOAM533us/N4d++DHyxX02xr7vhgaeTOh3J1K0Io6uPCWlmZ1+3ljnAA
        U/aQjgJ1QgCMYswq8UzuRfk1kA==
X-Google-Smtp-Source: ABdhPJwmZ8+aSeZTUD4JHv3p3mVlsPu+AZd2ArmXbgxF2cry2dw1lWhW/nN0xlaPURjvFEdS8HQS3g==
X-Received: by 2002:a37:9bd7:: with SMTP id d206mr882395qke.113.1591753515098;
        Tue, 09 Jun 2020 18:45:15 -0700 (PDT)
Received: from ovpn-113-201.phx2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id d14sm11601210qtr.17.2020.06.09.18.45.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2020 18:45:14 -0700 (PDT)
From:   Qian Cai <cai@lca.pw>
To:     heiko.carstens@de.ibm.com, gor@linux.ibm.com,
        borntraeger@de.ibm.com
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Qian Cai <cai@lca.pw>
Subject: [PATCH] s390: set NODES_SHIFT=0 when NUMA=n
Date:   Tue,  9 Jun 2020 21:45:01 -0400
Message-Id: <20200610014501.4268-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When NUMA=n and nr_node_ids=2, in apply_wqattrs_prepare(), it has,

for_each_node(node) {
	if (wq_calc_node_cpumask(...

where it will trigger a booting warning,

WARNING: workqueue cpumask: online intersect > possible intersect

because it found 2 nodes and wq_numa_possible_cpumask[1] is an empty
cpumask. NUMA=y has no such problem because node_possible_map will be
initialized properly containing only node 0. Fix it by setting
NODES_SHIFT=0 when NUMA=n.

Fixes: 701dc81e7412 ("s390/mm: remove fake numa support")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 arch/s390/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index f854faff38c3..59625356d18a 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -462,7 +462,8 @@ config NUMA
 
 config NODES_SHIFT
 	int
-	default "1"
+	default "1" if NUMA
+	default "0"
 
 config SCHED_SMT
 	def_bool n
-- 
2.21.0 (Apple Git-122.2)

