Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4EAC54FD0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 10:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65396206E9
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 10:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="R5ykQpLW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726832AbgD0KRb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 06:17:31 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:64682 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbgD0KRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 06:17:25 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200427101722epoutp04fb789cecd6a0177f9e6741d75588f840~Jpcy_z8aV2542025420epoutp04G
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 10:17:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200427101722epoutp04fb789cecd6a0177f9e6741d75588f840~Jpcy_z8aV2542025420epoutp04G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1587982642;
        bh=Oi7IRlJ5A40K+hgVvqOVDwYDzZpVyLe82ksBMj3f7DA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=R5ykQpLW3V9u5mjYZbN/pJdHlxHsKABpO3nneNRkKJrYPov7ghBr/y/LBhVgPRHmT
         4Ahax+PmYW0XF6xfFMCYYRl1bMQ/J7pI+btCZWvAzQynHE35Qw0Qym4a43HYdYk6Lz
         El14Io7ASvYSS6WMUQ9VQcStO0pal+3XWmSlam7E=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTP id
        20200427101721epcas5p107705b37bc160ed98d0cb16152df17ee~JpcyhVjmJ2232522325epcas5p1b;
        Mon, 27 Apr 2020 10:17:21 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        5A.89.10083.131B6AE5; Mon, 27 Apr 2020 19:17:21 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20200427101650epcas5p136af5c6e82d4dd69ea0d34920568bfed~JpcVDUIrK2395323953epcas5p1B;
        Mon, 27 Apr 2020 10:16:50 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200427101650epsmtrp2e1d4071765c9026bc81632aee774aec3~JpcVCEE7T2658926589epsmtrp2j;
        Mon, 27 Apr 2020 10:16:50 +0000 (GMT)
X-AuditID: b6c32a4a-88dff70000002763-3c-5ea6b131726a
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        1B.7C.25866.211B6AE5; Mon, 27 Apr 2020 19:16:50 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.135]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200427101649epsmtip17bbefea0049381be9be35bd698ea8b0f~JpcT71oQk2532925329epsmtip1h;
        Mon, 27 Apr 2020 10:16:48 +0000 (GMT)
From:   Maninder Singh <maninder1.s@samsung.com>
To:     mingo@kernel.org
Cc:     linux-kernel@vger.kernel.org, v.narang@samsung.com,
        a.sahrawat@samsung.com, Maninder Singh <maninder1.s@samsung.com>
Subject: [PATCH 1/1] sched/headers: don't count canary as free space on
 stack.
Date:   Mon, 27 Apr 2020 15:46:23 +0530
Message-Id: <1587982583-21609-1-git-send-email-maninder1.s@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEIsWRmVeSWpSXmKPExsWy7bCmpq7hxmVxBv9fGltc3J1qcXnXHDaL
        w/PbWCxW/zvFaHHo5FxGB1aPTas62Tz6tqxi9Pi8SS6AOYrLJiU1J7MstUjfLoEr4+vi20wF
        JzgrNi1YzNjA+Iu9i5GTQ0LAROJ/xw/GLkYuDiGB3YwSL+9/ZINwPjFKnJ3VyALhfGaU+Ptx
        PxtMS/vlXawQiV2MEotunIVq+coosepDMzNIFZuAnsSqXXuA2jk4RAREJDa8MQIJMwtUSZy8
        9YQFxBYWCJA4sesH2FAWAVWJq1s6WEFsXgF3ifd/H7NALJOTuHmukxlkvoRAP7tE27F/UIe7
        SPTsaYOyhSVeHd8CZUtJfH63lw2ioZlR4tO+tYwQzhRGiaUXP7JCVNlLvG5uYAK5jllAU2L9
        Ln2IsKzE1FPrmCAu5ZPo/f2ECSLOK7FjHoytKtFycwPUGGmJzx8/Ql3qIbFn2xGwI4QEYiX+
        fXrINoFRdhbChgWMjKsYJVMLinPTU4tNC4zyUsv1ihNzi0vz0vWS83M3MYJjWstrB+Oycz6H
        GAU4GJV4eDm2L40TYk0sK67MPcQowcGsJML7KGNZnBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXHe
        SaxXY4QE0hNLUrNTUwtSi2CyTBycUg2M2w98N/Q7fHB+hdfdlk9MawyOvmTM/5mjpc/w7vGC
        4qPz8zbOPmdlPePanRw7h+xXrzaeNxQsKt0rkLCYb2PzwRXKk+zXzWPaVqc6M2RSNm/fzTNB
        dwyYXNm0tn66w7Jdz+hA0XbJihxFzqgP7/a8mLTvR+yciILs2LfZj5ukpVn3vlLZfejNYiWW
        4oxEQy3mouJEALKTuMzlAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJJMWRmVeSWpSXmKPExsWy7bCSnK7QxmVxBm9+c1hc3J1qcXnXHDaL
        w/PbWCxW/zvFaHHo5FxGB1aPTas62Tz6tqxi9Pi8SS6AOYrLJiU1J7MstUjfLoEr4+vi20wF
        JzgrNi1YzNjA+Iu9i5GTQ0LARKL98i7WLkYuDiGBHYwSz1vvsUAkpCV+/nsPZQtLrPz3nB2i
        6DOjxOTTM5hAEmwCehKrdu0BKuLgEBEQkdjwxggkzCxQJ/HhaRsriC0s4CfRe6MDrJxFQFXi
        6pYOsDivgLvE+7+PoebLSdw818k8gZFnASPDKkbJ1ILi3PTcYsMCo7zUcr3ixNzi0rx0veT8
        3E2M4NDQ0trBuGfVB71DjEwcjIcYJTiYlUR4H2UsixPiTUmsrEotyo8vKs1JLT7EKM3BoiTO
        +3XWwjghgfTEktTs1NSC1CKYLBMHp1QDE9eTl5NMCuetjeZocO12erTOYWLq8TcnH3GkBpwJ
        /G81/6XW+m0n1Pj41qnsKlmXxfQ4/NCn7RUeF7z+iIVnLHudN7uqku/qI8e9l5yfc65YcjDu
        6NZ37z6mNhYUlHooFbzp/rxi+m/x5ZIH9P9euz5r5uNfbBc0mieuVOnT3OP4o+LkW/M2Vuaf
        ZlmuTzyXBtUkMCufOhUb/XKd2B3eJy7ilzwXLLNjE1BcfqX9ls27zK+ym9eyX664ttOCPy+s
        89OffycfCjSulN4QtEz48yTrvS4J1Upr1s3Zu7KM/wFzW/sU6V11LRalFy+IOd58acG3UWvp
        kjP5Z3c8X342SoJ9V4//ucznpQ80goOLhTYqsRRnJBpqMRcVJwIAltvpEXwCAAA=
X-CMS-MailID: 20200427101650epcas5p136af5c6e82d4dd69ea0d34920568bfed
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20200427101650epcas5p136af5c6e82d4dd69ea0d34920568bfed
References: <CGME20200427101650epcas5p136af5c6e82d4dd69ea0d34920568bfed@epcas5p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

currently if all stack is used except canary and thread_info space,
stack usage prints about free space.

[11.7426] X (1260) used greatest stack depth: 4 bytes left

It is because canary is accounted as usable stack, so removing
that from accounting.

[12.8717] X (1270) used greatest stack depth: 0 bytes left

Signed-off-by: vaneet Narang <v.narang@samsung.com>
Signed-off-by: Maninder Singh <maninder1.s@samsung.com>
---
 include/linux/sched/task_stack.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/task_stack.h b/include/linux/sched/task_stack.h
index 2413427..3174938 100644
--- a/include/linux/sched/task_stack.h
+++ b/include/linux/sched/task_stack.h
@@ -100,10 +100,11 @@ static inline unsigned long stack_not_used(struct task_struct *p)
 # endif
 	} while (!*n);
 
+	/* Don't count canary as usable stack */
 # ifdef CONFIG_STACK_GROWSUP
-	return (unsigned long)end_of_stack(p) - (unsigned long)n;
+	return (unsigned long)end_of_stack(p) - (unsigned long)(n + 1);
 # else
-	return (unsigned long)n - (unsigned long)end_of_stack(p);
+	return (unsigned long)(n - 1) - (unsigned long)end_of_stack(p);
 # endif
 }
 #endif
-- 
1.9.1

