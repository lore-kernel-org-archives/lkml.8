Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFD2C3F2D8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 03:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1A7920838
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 03:02:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="qiI2jCOU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387743AbgCDDCQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 22:02:16 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:30647 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387580AbgCDDCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 22:02:16 -0500
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200304030213epoutp01068d113ea84851b19178d9c12f8139b8~4_rcwxtKI2083320833epoutp01Z
        for <linux-kernel@vger.kernel.org>; Wed,  4 Mar 2020 03:02:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200304030213epoutp01068d113ea84851b19178d9c12f8139b8~4_rcwxtKI2083320833epoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1583290933;
        bh=JDd1T3+YRNjJK3bE+SzL+8P0+FiGsioR6Jes5f4jxJQ=;
        h=From:To:Cc:Subject:Date:References:From;
        b=qiI2jCOUGkCCeSj5pdIcSEAxacA5/qsnhvYsVQyr0b+DVQx8UOAutMXghIfxhmSQg
         I0C/z+LIGUKpfuQ+oWUJrhLnOqPPRq3RqsW5lMKciqvr6JnpDNleEWpr+jw+RTwNam
         g8Ew+HINsav7OrWzgqo+KUTw5uxvxQcXpfXyv+VY=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20200304030213epcas1p3f5c5ed37098a9e9573462f17b65f24be~4_rcUfaw42641626416epcas1p3z;
        Wed,  4 Mar 2020 03:02:13 +0000 (GMT)
Received: from epsmges1p5.samsung.com (unknown [182.195.40.166]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 48XJZX1wrjzMqYlm; Wed,  4 Mar
        2020 03:02:12 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p5.samsung.com (Symantec Messaging Gateway) with SMTP id
        28.44.51241.43A1F5E5; Wed,  4 Mar 2020 12:02:12 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTPA id
        20200304030211epcas1p4da8cb569947aefb3aad1da039aaabce4~4_ra-2t-42787927879epcas1p4Q;
        Wed,  4 Mar 2020 03:02:11 +0000 (GMT)
Received: from epsmgms1p2new.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200304030211epsmtrp1253ac05cdbf978b91bbac385255f5416~4_ra-IcEq1810618106epsmtrp1N;
        Wed,  4 Mar 2020 03:02:11 +0000 (GMT)
X-AuditID: b6c32a39-14bff7000001c829-1f-5e5f1a3470d0
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        71.6D.06569.33A1F5E5; Wed,  4 Mar 2020 12:02:11 +0900 (KST)
Received: from jaewon-linux.10.32.193.11 (unknown [10.253.104.82]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200304030211epsmtip1a9bd437bc0c024e1aa416e475bd3fa93~4_ra0Rda12234322343epsmtip1C;
        Wed,  4 Mar 2020 03:02:11 +0000 (GMT)
From:   Jaewon Kim <jaewon31.kim@samsung.com>
To:     walken@google.com, bp@suse.de, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, Jaewon Kim <jaewon31.kim@samsung.com>
Subject: [PATCH] mm: mmap: show vm_unmapped_area error log
Date:   Wed,  4 Mar 2020 12:02:06 +0900
Message-Id: <20200304030206.1706-1-jaewon31.kim@samsung.com>
X-Mailer: git-send-email 2.13.7
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTURjHObvb3dW6dZlWp1FmlwpmqZtzdo3NoixWmRgWkZDrsh028e6F
        3S0yCQTFajkroTDJMI0Ks4ytZBp9aFKaVkRSX3yhJghpKqx3JO1u16hvv+c5//95/jznEJgi
        IlMSZQ4PcjtYjsYTpV29KnV6ttJUqn7QuJS51tmBM5cuqJjzwauA8c9OSpihnms4M9axIGPm
        G07vkBu7m0blxpaA1xiINsiN/Y1zUmP9w3ZgDA5WGr8EUorkJZzehlgLcqcih9lpKXNYDfT+
        YtMuky5HrUnX5DJb6VQHa0cGOr+gKH1PGSeEoVNPsJxXaBWxPE9n5undTq8HpdqcvMdAI5eF
        c2nUrgyetfNehzXD7LRv06jVWTpBeZyztQ6+lbjukCfHXoQkVcC3xAcSCEhlwyt326QxVlAh
        AEcGeB9IFDgK4KOFxzKx+A7g9egr2V/H98gMLjqeAFj9Zaco+gHg6/F38tgBTm2Gsy0NcUMy
        pYfDjffijFFeOP25H4txErUNno1E46Ol1Eb4pjos9AmCFPRnhvEYQmodvLGAxa6HVB0Oxya/
        YmKGfNg368dFToKTfQ/lIivhpwu1ctFQDeD01SAQixoARwN+IKq00F/3Jj4Mo1SwsydTbK+H
        3XPNQMy5DM58q5OJIUh4tlYhSjbBmolvi3tYA3/PTyyyEYaCA4s7OQYfLITwi2Bt078BLQC0
        g5XIxdutiNe4dP+/UQDE/1dabgg8f10QBhQB6KUk3FtaqpCxJ/gKexhAAqOTyZ8vhRZpYStO
        IbfT5PZyiA8DnbC8S5hyhdkp/FaHx6TRZWm1WiY7Z2uOTkuvIj8eVZUqKCvrQeUIuZD7r09C
        JCirwPEPzeh8zfjgkbTlm/OeJZ5J6M3SZBWgQJfDat5QMnW5tVx5+/2a4oPhW+XHDjdd7FrN
        j1RyPwasQ1PNZjIjt/ZX/b7dZlVE70vR9lcs49INJB1VmqJtefTMoc591kKd/EVZR6T7ZNCX
        lN9wa7u2//6Wm88K7W3gwLnckadWLS3lbawmDXPz7B89XMmjdQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjluLIzCtJLcpLzFFi42LZdlhJTtdYKj7OYNlBbYs569ewWUzs17To
        3jyT0aL3/Ssmi8u75rBZ3Fvzn9Xi36RaB3aPnbPusnss2FTqsenTJHaPEzN+s3j0bVnF6LH5
        dLXH501yAexRXDYpqTmZZalF+nYJXBmLTl9iKljBW3Hv5A6mBsYu7i5GTg4JAROJb4/esYHY
        QgK7GSV6PjBCxGUk3px/ytLFyAFkC0scPlzcxcgFVPKVUeLQnZksIDVsAtoS7xdMYgWxRQQc
        JHbc6WEGsZkFKiX+3b4FFhcWsJLoePQJrJ5FQFXiQvMhZpCZvAI2Eu232SDGy0ss/M88gZFn
        ASPDKkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT83E2M4FDS0trBeOJE/CFGAQ5GJR5eCc+4
        OCHWxLLiytxDjBIczEoivD/OAIV4UxIrq1KL8uOLSnNSiw8xSnOwKInzyucfixQSSE8sSc1O
        TS1ILYLJMnFwSjUwWrInx759POV4bJ3Fvptb5IpTY+5uSJvQPKm4+/rJ+uO+19z2zJ5cIVVh
        90DlkZnBDzeTQvc/Xud3cMlezMo+6fK1zr6Pt3FuvlHiPoOaGvvIRVd9jU+63pp+LTKZZUvO
        H3m9iSpnVIInixTfzIv7ofmUh51Jx6v566IphTOWuDmxrWW/9f6bEktxRqKhFnNRcSIAJx3Z
        aiECAAA=
X-CMS-MailID: 20200304030211epcas1p4da8cb569947aefb3aad1da039aaabce4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 101P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200304030211epcas1p4da8cb569947aefb3aad1da039aaabce4
References: <CGME20200304030211epcas1p4da8cb569947aefb3aad1da039aaabce4@epcas1p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even on 64 bit kernel, the mmap failure can happen for a 32 bit task.
Virtual memory space shortage of a task on mmap is reported to userspace
as -ENOMEM. It can be confused as physical memory shortage of overall
system.

The vm_unmapped_area can be called to by some drivers or other kernel
core system like filesystem. It can be hard to know which code layer
returns the -ENOMEM.

Print error log of vm_unmapped_area with rate limited. Without rate
limited, soft lockup ocurrs on infinite mmap sytem call.

i.e.)
<3>[  576.024088]  [6:  mmap_infinite:14251] mmap: vm_unmapped_area err:-12 total_vm:0xfee08 flags:0x1 len:0xa00000 low:0x8000 high:0xf3f63000

Signed-off-by: Jaewon Kim <jaewon31.kim@samsung.com>
---
 include/linux/mm.h | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 52269e56c514..ee822d65ebb7 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2379,10 +2379,19 @@ extern unsigned long unmapped_area_topdown(struct vm_unmapped_area_info *info);
 static inline unsigned long
 vm_unmapped_area(struct vm_unmapped_area_info *info)
 {
+	unsigned long addr;
+
 	if (info->flags & VM_UNMAPPED_AREA_TOPDOWN)
-		return unmapped_area_topdown(info);
+		addr = unmapped_area_topdown(info);
 	else
-		return unmapped_area(info);
+		addr = unmapped_area(info);
+
+	if (IS_ERR_VALUE(addr) && printk_ratelimit()) {
+		pr_err("%s err:%d total_vm:0x%lx flags:0x%lx len:0x%lx low:0x%lx high:0x%lx\n",
+			__func__, addr, current->mm->total_vm, info->flags,
+			info->length, info->low_limit, info->high_limit);
+	}
+	return addr;
 }
 
 /* truncate.c */
-- 
2.13.7

