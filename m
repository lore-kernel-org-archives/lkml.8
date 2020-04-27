Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA937C54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 04:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 856C6206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 04:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="dThLFE8A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726273AbgD0Eeh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 00:34:37 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:51267 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725890AbgD0Eeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 00:34:36 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200427043433epoutp01be76bba031bd7102b87b3156c4f91c1d~Jkxe_26_C1296412964epoutp01j
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 04:34:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200427043433epoutp01be76bba031bd7102b87b3156c4f91c1d~Jkxe_26_C1296412964epoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1587962073;
        bh=/g3+r/QAPR8JUeIAGeyeaVP/TnwUx6QSY+277vhgibs=;
        h=From:To:Cc:Subject:Date:References:From;
        b=dThLFE8Aaccd7b0vc/ZVZfoPPJoDKDYAviXsCXDv7bdtMK240fh2Ohr9tjpfKsLkX
         bk5CL1ZD3TMNpGLYrWT5EAkgWJIjSu6qIGu3jr3orb1LdrPOcZr/6tu5ymXGQZOBQL
         zPu+GfiXwXaL6jTzkIqyibjKRT4X90S0h3eHHBy8=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20200427043432epcas5p13fd118fa38e6d373c482721ad799c87d~Jkxdvx77-0087200872epcas5p14;
        Mon, 27 Apr 2020 04:34:32 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        80.26.04736.8D066AE5; Mon, 27 Apr 2020 13:34:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20200427043419epcas5p39e2a73db2dcc912df2624ee03bec1f58~JkxRhDPEB2282322823epcas5p3O;
        Mon, 27 Apr 2020 04:34:19 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200427043419epsmtrp11e9dc77b41e1b1893192206ad4a99bb0~JkxRgT3Pc0909709097epsmtrp1H;
        Mon, 27 Apr 2020 04:34:19 +0000 (GMT)
X-AuditID: b6c32a4b-acbff70000001280-28-5ea660d8efb5
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        82.CF.18461.BC066AE5; Mon, 27 Apr 2020 13:34:19 +0900 (KST)
Received: from localhost.localdomain (unknown [107.108.92.210]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200427043418epsmtip1b5b0893b75cbe020dc4b6865b1c9b268~JkxQlk-gw3266832668epsmtip19;
        Mon, 27 Apr 2020 04:34:18 +0000 (GMT)
From:   Vishal Goel <vishal.goel@samsung.com>
To:     casey@schaufler-ca.com,
        linux-security-modulemodule@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vishal Goel <vishal.goel@samsung.com>
Subject: [PATCH 1/1] Smack:- Remove redundant inode_smack cache since now
 new cache is being used for inode_smack structure allocations
Date:   Mon, 27 Apr 2020 09:42:33 +0530
Message-Id: <1587960753-6006-1-git-send-email-vishal.goel@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsWy7bCmuu6NhGVxBqe3SVrc2/aLzeLyrjls
        FstnXGKzWHf7NKMDi0ffllWMHkf3L2Lz+LxJLoA5issmJTUnsyy1SN8ugSujZW4Xe8E/9orH
        0z8wNTBeZOti5OSQEDCR2NF3grmLkYtDSGA3o8TTk91MEM4nRokTL+6wQTjfGCX2XZrI2MXI
        AdZyd70ARHwvo8TWNbOhir4wSizrvMQMMpdNQFuid95dJpAGEYF0icdTK0FMZgFNiQNNUSDl
        wgKdjBJ/138AO4NFQFXi88IWMJtXwE1i5pt1jBDnyUmcPDaZFaRBQqCbXeLtjuesEAkXiUlX
        vrFD2MISr45vgbKlJF72t7FDNLQzShydtRHKmcIo8W/fDagqe4nXzQ1MMCet36UPEZaVmHpq
        HROIzSzAJ9H7+wkTRJxXYsc8GFtVYuqkbqgx0hKHb5xhgbA9JDpOnQWzhQRiJY4vOcg2gVF2
        FsKGBYyMqxglUwuKc9NTi00LjPNSy/WKE3OLS/PS9ZLzczcxgiNZy3sH46ZzPocYBTgYlXh4
        ObYvjRNiTSwrrsw9xCjBwawkwhtTsihOiDclsbIqtSg/vqg0J7X4EKM0B4uSOO8k1qsxQgLp
        iSWp2ampBalFMFkmDk6pBsbG5J49FQ3bm4Myd77RZKnNUVHmSq8MZvc/sjaZv39yzOZ8s52+
        J2I/CKdM3S6hNGnHy73bzt9YsuZL4gOZGbH9f9uNzsS/mcokpDpnQpwDX3Eme2xrQ1VX1bkf
        5ZMC/nFet3B7bTO3suNBmvUK0YS0QzyXyz58Pvx0UQ2PxMql4i8qnCOnH1ViKc5INNRiLipO
        BAArgceL4AIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKJMWRmVeSWpSXmKPExsWy7bCSnO7phGVxBk9nCljc2/aLzeLyrjls
        FstnXGKzWHf7NKMDi0ffllWMHkf3L2Lz+LxJLoA5issmJTUnsyy1SN8ugSujZW4Xe8E/9orH
        0z8wNTBeZOti5OCQEDCRuLteoIuRi0NIYDejxMXDXcxdjJxAcWmJJZ1v2CFsYYmV/56zQxR9
        YpS4snsLK0iCTUBbonfeXSYQW0QgU2LCxDVgQ5kFNCUONEWB1AsLtDNKPJs3F2woi4CqxOeF
        LWwgNq+Am8TMN+sYIRbISZw8Npl1AiPPAkaGVYySqQXFuem5xYYFhnmp5XrFibnFpXnpesn5
        uZsYwSGhpbmDcfuqD3qHGJk4GA8xSnAwK4nwxpQsihPiTUmsrEotyo8vKs1JLT7EKM3BoiTO
        e6NwYZyQQHpiSWp2ampBahFMlomDU6qB6SBP0eWUXzdyjp5p+ZrIFR4551n3juCQ/eHO6esE
        9i/bnPcm5AjHXLbDP7JyXdV0drxJXtqZ4izbKNRgu0rD+vmJ//3Wq03to6altCz6zsGUaCj8
        eP30f5E2D3ZwVL1Umtqr+mqywo3r29tjWD8d+679xu3NmYUz+mTEnqa/ZYrYWPNQvWHxzWdp
        TgznCtwCRaXMs3NL9pfe39Mfu2rvdqVqNqUUJlWBw0Grspq7WMW6us2WfnBdfeJNvs+kd+cu
        qEte+BOk2d4UJLEowTjQ5PZrp1nq+oZLJX42/Wb2KZ/2Wc2x9bRw2laVVVftvU5VtGydbxKa
        GHHj72cnwwndWWcOhXNtz2Oq31zAkvxbiaU4I9FQi7moOBEAFZtYWXgCAAA=
X-CMS-MailID: 20200427043419epcas5p39e2a73db2dcc912df2624ee03bec1f58
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20200427043419epcas5p39e2a73db2dcc912df2624ee03bec1f58
References: <CGME20200427043419epcas5p39e2a73db2dcc912df2624ee03bec1f58@epcas5p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Vishal Goel <vishal.goel@samsung.com>
---
 security/smack/smack_lsm.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 2862fc3..d0f87d4 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -55,7 +55,6 @@
 DEFINE_MUTEX(smack_ipv6_lock);
 static LIST_HEAD(smk_ipv6_port_list);
 #endif
-static struct kmem_cache *smack_inode_cache;
 struct kmem_cache *smack_rule_cache;
 int smack_enabled;
 
@@ -4841,15 +4840,9 @@ static __init int smack_init(void)
 	struct cred *cred = (struct cred *) current->cred;
 	struct task_smack *tsp;
 
-	smack_inode_cache = KMEM_CACHE(inode_smack, 0);
-	if (!smack_inode_cache)
-		return -ENOMEM;
-
 	smack_rule_cache = KMEM_CACHE(smack_rule, 0);
-	if (!smack_rule_cache) {
-		kmem_cache_destroy(smack_inode_cache);
+	if (!smack_rule_cache)
 		return -ENOMEM;
-	}
 
 	/*
 	 * Set the security state for the initial task.
-- 
1.9.1

