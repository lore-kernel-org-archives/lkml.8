Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DEAC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:36:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6372D20721
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:36:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ltNTq8cj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgE2Mgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 08:36:42 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:18612 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbgE2Mgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 08:36:38 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200529123636epoutp0230c8603b339f2e4695943959eca88e07~Tf-gYIqb-0939109391epoutp02V
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 12:36:36 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200529123636epoutp0230c8603b339f2e4695943959eca88e07~Tf-gYIqb-0939109391epoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590755796;
        bh=wUNzcywfsqFiLG1FtR4Yk2Zx32Jp7ZN9xdDjQ3Zctwg=;
        h=From:To:Cc:Subject:Date:References:From;
        b=ltNTq8cjA4Zq46NBi2Jp6kKmCg9nZ8xcUgGLlPzgGH+AV/qap4c4iN6Eea3KT5ula
         3bMAuYX0110JL0NnjdHvhyV9IJz5mIEJSkC66LUwXT4JNss9KGg6ECZBMDSfct72bb
         gMWfkZ8xIcl7gXBx+r/cnZANVUVaRv1F6aIu9X/U=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20200529123636epcas5p2b3c34d6669ee614b317e0c11e92fd185~Tf-gIPYAz3089630896epcas5p2k;
        Fri, 29 May 2020 12:36:36 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        18.B3.09703.4D101DE5; Fri, 29 May 2020 21:36:36 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20200529122614epcas5p38e0acf63c010f8b691caf68916f512bd~Tf2cYLDi10566205662epcas5p3z;
        Fri, 29 May 2020 12:26:14 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200529122614epsmtrp14bc392f630cc06525d0a500d139e0544~Tf2cXlS5c1294412944epsmtrp1B;
        Fri, 29 May 2020 12:26:14 +0000 (GMT)
X-AuditID: b6c32a4a-4b5ff700000025e7-a7-5ed101d44084
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        AD.24.08382.66FF0DE5; Fri, 29 May 2020 21:26:14 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.135]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200529122612epsmtip1b8b8f6b507b3407382d195ee11e7b2d2~Tf2bLLc-m2983829838epsmtip1S;
        Fri, 29 May 2020 12:26:12 +0000 (GMT)
From:   Anupam Aggarwal <anupam.al@samsung.com>
To:     davem@davemloft.net
Cc:     a.sahrawat@samsung.com, t.vivek@samsung.com,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Anupam Aggarwal <anupam.al@samsung.com>
Subject: [PATCH] sparc: remove unused header file nfs_fs.h
Date:   Fri, 29 May 2020 17:56:00 +0530
Message-Id: <1590755160-26009-1-git-send-email-anupam.al@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNIsWRmVeSWpSXmKPExsWy7bCmpu4VxotxBh2/VC0u7k61eN9whd1i
        zvkWFovLu+awWTScXMFq8bJvI5sDm8eWlTeZPPq2rGL0+LxJLoA5issmJTUnsyy1SN8ugStj
        x9EX7AU7WSvWnTjI3MB4m6WLkZNDQsBE4vu+p0A2F4eQwG5GiSs9WxghnE+MEo1rpjBDON8Y
        JXbtus8O0/J8wwxGEFtIYC+jxJ77nBBFXxklOi99YwNJsAnoSsx9MZsVxBYREJdofvOUCaSI
        WWAKo8S+V+fBioQFrCTm/zkANolFQFViwbuTYHFeAVeJx2+mskFsk5O4ea4T7AwJgensElMW
        HIC63EViy6P3UEXCEq+Ob4E6T0riZX8bO0RDP6NE17ILrBDODEaJI3u2QXXbS7xubgC6iQPo
        Jk2J9bv0IcKyElNPrWMCsZkF+CR6fz9hgojzSuyYB2MrS0y99poVwpaUeNzZygxhe0i8OLGR
        FRIusRIbZi1jn8AoOwthwwJGxlWMkqkFxbnpqcWmBUZ5qeV6xYm5xaV56XrJ+bmbGMHxreW1
        g/Hhgw96hxiZOBgPMUpwMCuJ8K45ez5OiDclsbIqtSg/vqg0J7X4EKM0B4uSOK/SjzNxQgLp
        iSWp2ampBalFMFkmDk6pBqaynEu8sSbHq8yWtBpe3Gc769jyq8WSuRP/u07uNH7Y8XFuUtLC
        nO0y0jpzpKa/ymF3PmmwdJVIVZnatS/vzHmrszOKNv2L6GYuvrnXtdb7uUZN7KrXE1MOv//6
        qSeq7f80z9a/OtPcdLd8DSk+FK3OdixQe/3pkKDZjPy3GD96f2xMvrElsIWVr969u0jq4W3V
        U73bDJls7+n7VweufNPRcWknV9qma4YHr2T+XdMlc6J+0V3njVsL1j1ODXEJsOe81Bx1Ytlv
        LZOFl77KbUiQYNnHdCREOyXK1v+LYZvQA8/Jyb/CPuS8mrvT/9F9p1XZr6b2x+Wyr2rTney8
        +gKXhaJkWXrtYdtpG6ZVfVViKc5INNRiLipOBADmdVAIXgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrAJMWRmVeSWpSXmKPExsWy7bCSnG7a/wtxBvPWslhc3J1q8b7hCrvF
        nPMtLBaXd81hs2g4uYLV4mXfRjYHNo8tK28yefRtWcXo8XmTXABzFJdNSmpOZllqkb5dAlfG
        jqMv2At2slasO3GQuYHxNksXIyeHhICJxPMNMxi7GLk4hAR2M0r8ez6DCSIhKdH0egMjhC0s
        sfLfc3aIos+MEpsvtrKBJNgEdCXmvpjNCmKLCIhLNL95ygRSxCwwi1Hi5vqvYAlhASuJ+X8O
        gE1iEVCVWPDuJFgzr4CrxOM3U9kgNshJ3DzXyTyBkWcBI8MqRsnUguLc9NxiwwLDvNRyveLE
        3OLSvHS95PzcTYzgQNHS3MG4fdUHvUOMTByMhxglOJiVRHjXnD0fJ8SbklhZlVqUH19UmpNa
        fIhRmoNFSZz3RuHCOCGB9MSS1OzU1ILUIpgsEwenVANT9ZW8hwkez8tKDyl8Zi/L87zub/eP
        Z94aS/3On3fuXoudv6mP1fRpzVmG7bJp+wJEBXbsrcm2O+DbL3WgOMCOa1HjsvfHGe9qfZxQ
        cHPfv4K8FQb1s6S1emZkfvyY8jr6VoSCmnX+Ok6xtvdnjsxfWdqxJ6QhLzfV8bpZ52bmpa6m
        y7lvNLXFTt/ZpHrbfMUN/1Pdk/uFmO0b1fR9gLEdGH8n+lL1f+sjrs57Lkxqiz+WdGnRW3vm
        z7+Mprnsyj8+I+6ic9ELabWvihcljrw3nK30b5Jy9JPshsZbiUYT9dV4CrZseRh2d9Kay7Mb
        3O6WJB1dHBh6nEOEcx9/p9B2/3a1RRPX9kXW/31WwK7EUpyRaKjFXFScCACIAD+8gwIAAA==
X-CMS-MailID: 20200529122614epcas5p38e0acf63c010f8b691caf68916f512bd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20200529122614epcas5p38e0acf63c010f8b691caf68916f512bd
References: <CGME20200529122614epcas5p38e0acf63c010f8b691caf68916f512bd@epcas5p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused header file linux/nfs_fs.h

Signed-off-by: Anupam Aggarwal <anupam.al@samsung.com>
Signed-off-by: Vivek Trivedi <t.vivek@samsung.com>
Signed-off-by: Amit Sahrawat <a.sahrawat@samsung.com>
---
 arch/sparc/kernel/sys_sparc32.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/sparc/kernel/sys_sparc32.c b/arch/sparc/kernel/sys_sparc32.c
index b5da3bf..f84a02a 100644
--- a/arch/sparc/kernel/sys_sparc32.c
+++ b/arch/sparc/kernel/sys_sparc32.c
@@ -22,7 +22,6 @@
 #include <linux/msg.h>
 #include <linux/shm.h>
 #include <linux/uio.h>
-#include <linux/nfs_fs.h>
 #include <linux/quota.h>
 #include <linux/poll.h>
 #include <linux/personality.h>
-- 
1.9.1

