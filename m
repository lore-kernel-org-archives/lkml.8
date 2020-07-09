Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FDDC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:24:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D796206A1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 08:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ELrxvSxq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgGIIYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 04:24:19 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:26597 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgGIIYS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 04:24:18 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20200709082415epoutp03a98e6d9e02bba1aa92d68079884be96e~gB-3m8K7D2458524585epoutp03y
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 08:24:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20200709082415epoutp03a98e6d9e02bba1aa92d68079884be96e~gB-3m8K7D2458524585epoutp03y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1594283055;
        bh=jrgreaOxBNKWaQmWizCcB2xRM4knpZFef7IBVXPqW0k=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ELrxvSxqebtaM0tp/Q4yFecthyu/hd8GOgu/WSUsrOn0pShZatQ2KiFxYvNazgxDe
         BOFnXgO2LOZmo2B4L3TccAMOUZkIc3Q4oAtJvwnkWqhlUG7Qeb33X7oIxnatrSCRvo
         2PaIL2hznHObcf6YZk1XxM2viC8SQHl9gIWBoGPU=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20200709082414epcas2p1365b5bbfffd710b831802b91f88f219a~gB-3SnEfk1793717937epcas2p16;
        Thu,  9 Jul 2020 08:24:14 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.40.181]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4B2TjS4qd7zMqYkq; Thu,  9 Jul
        2020 08:24:12 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        DA.F1.18874.924D60F5; Thu,  9 Jul 2020 17:24:09 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20200709082408epcas2p4369fa8f06a57c7358be38282aae0f501~gB-xR0TtA1636816368epcas2p4q;
        Thu,  9 Jul 2020 08:24:08 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200709082408epsmtrp12efabc2c3e00ce3cda19320a7c0b880c~gB-xRMSdd1891618916epsmtrp1m;
        Thu,  9 Jul 2020 08:24:08 +0000 (GMT)
X-AuditID: b6c32a46-519ff700000049ba-5a-5f06d429a5e0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D9.84.08382.824D60F5; Thu,  9 Jul 2020 17:24:08 +0900 (KST)
Received: from pika.dsn.sec.samsung.com (unknown [12.36.155.212]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200709082408epsmtip11258ec8f93d94a418f00bc7f9beb23bb~gB-xFD2Ai0298102981epsmtip1k;
        Thu,  9 Jul 2020 08:24:08 +0000 (GMT)
From:   sanggil2.kim@samsung.com
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Sanggil Kim <sanggil2.kim@samsung.com>
Subject: [PATCH] arm64: kernel: Add module symbols _text, _etext.
Date:   Thu,  9 Jul 2020 17:23:45 +0900
Message-Id: <1594283025-4166-1-git-send-email-sanggil2.kim@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsWy7bCmma7mFbZ4g6nvBS02Pb7GanF51xw2
        ixdzPzI6MHtsXlLv0bdlFaPH501yAcxROTYZqYkpqUUKqXnJ+SmZeem2St7B8c7xpmYGhrqG
        lhbmSgp5ibmptkouPgG6bpk5QHuUFMoSc0qBQgGJxcVK+nY2RfmlJakKGfnFJbZKqQUpOQWG
        hgV6xYm5xaV56XrJ+blWhgYGRqZAlQk5GWv/72AuOM1acWD6RpYGxhssXYycHBICJhKvn91k
        7GLk4hAS2MEocbrtOhuE84lR4vjlVVDON0aJDVMfs8K0tHQcgWrZyyhxZNplVriqp99uMYFU
        sQnISbT8PccIYosIaEhM6XrMDmIzC3hIPF70E6xGWMBRYtmDR2BxFgFViV3/3wGt4+DgFXCX
        2LlcFGKZnMTNc53MIPMlBP6zSXyc1wt1hYvE1fnH2CBsYYlXx7ewQ9hSEi/726DscomVDetZ
        IJpbGCXuLn0H1WAsMetZOyPIMmYBTYn1u/RBTAkBZYkjt1ggzuST6Dj8lx0izCvR0SYE0agm
        8W/lNKgLZCSWrljDBGF7SPzduwzsWyGBWImt1w6yTGCUnYUwfwEj4ypGsdSC4tz01GKjAiPk
        SNrECE47Wm47GKe8/aB3iJGJg/EQowQHs5IIr4Eia7wQb0piZVVqUX58UWlOavEhRlNgcE1k
        lhJNzgcmvrySeENTIzMzA0tTC1MzIwslcd56xQtxQgLpiSWp2ampBalFMH1MHJxSDUwN7YeE
        Yy+H/fE0FPsvYs63uir0bQj/dv0vV7bekf57qudnyI7eU6teF6yyf/K2MGR3vu7c1w8Z36eU
        Xr+oavv7Zc2uYmOvrQKS4gLrNlUHdk0P7+G9N6mkIerl4hqt5DOL56s5mAafWrJ1VQvP9ry6
        vb0Gx84yys0zZThit7b3v5XZvtXFy24/4LnuK30gYqk0e/KkP9NKulNmBG26XegzkbFjh/ef
        VRN97kQGG3V/WvpGatPzbxYb5jDotnQx23TfTN/OtTJ+QafVAi/1STNb0hpZgsvvrN2ixPR/
        0201/d6FWzgZz8zNVH5iFuZ9a4G8L0+Pl9iOe3zRWv9P3Ffo6ppz649H1cLFt7svqgQqsRRn
        JBpqMRcVJwIAy3eJCsQDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHJMWRmVeSWpSXmKPExsWy7bCSnK7GFbZ4g0v/BSw2Pb7GanF51xw2
        ixdzPzI6MHtsXlLv0bdlFaPH501yAcxRXDYpqTmZZalF+nYJXBlr/+9gLjjNWnFg+kaWBsYb
        LF2MnBwSAiYSLR1HGLsYuTiEBHYzSrzdNoUVIiEj8envCiYIW1jifssRVoiiL4wSHS3XwbrZ
        BOQkWv6eYwSxRQQ0JKZ0PWbvYuTgYBbwkji4zBkkLCzgKLHswSN2EJtFQFVi1/93bCAlvALu
        EjuXi0KMl5O4ea6TeQIjzwJGhlWMkqkFxbnpucWGBYZ5qeV6xYm5xaV56XrJ+bmbGMFBoKW5
        g3H7qg96hxiZOBgPMUpwMCuJ8BoossYL8aYkVlalFuXHF5XmpBYfYpTmYFES571RuDBOSCA9
        sSQ1OzW1ILUIJsvEwSnVwMTrWp59plvgqsJx3eev3qyQMz+ysJmh2ScmY+1Eqz9tT4QOXnKd
        +3v2/88Wv5h7H8dGhPTuKFxjay4i2OVj7eaUeK3sF6PTsfiat14f4qoyrx7eU/0y17l+fpHi
        3qic1Gy3v1y89Zo3PnT82rmT0+zZ/RmaxsfETB3YXSMCw9dsaRPSD71yaY5Wb4aS1bPK6S95
        I3at0egr2eD2rmxe4I6VvHWF6nn+V4Tuz44xf6RWz7lc6Z/0uVcCqX6eQU8strfPe3PW94vy
        k4rIeYIfDnhzGNwO+ljk3Gx/LVxoo86/Sz/2Mnc28hxjSl/H+HzS8qRlG5kYc/YosIb8eGl8
        96uT2Ff32Ut/3lX4u6ZZR4mlOCPRUIu5qDgRAB16vdhxAgAA
X-CMS-MailID: 20200709082408epcas2p4369fa8f06a57c7358be38282aae0f501
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200709082408epcas2p4369fa8f06a57c7358be38282aae0f501
References: <CGME20200709082408epcas2p4369fa8f06a57c7358be38282aae0f501@epcas2p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sanggil Kim <sanggil2.kim@samsung.com>

We have a solution to protect kernel code section(autually from _text to
_etext) by not MMU. In order to do this, we have to know the addresses
of _text and _etext at runtime.

Signed-off-by: Sanggil Kim <sanggil2.kim@samsung.com>
---
 arch/arm64/kernel/head.S | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 037421c..09b405e 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -1003,3 +1003,6 @@ SYM_FUNC_START_LOCAL(__primary_switch)
 	adrp	x0, __PHYS_OFFSET
 	br	x8
 SYM_FUNC_END(__primary_switch)
+
+EXPORT_SYMBOL(_text)
+EXPORT_SYMBOL(_etext)
-- 
2.7.4

