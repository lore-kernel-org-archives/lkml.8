Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 927B8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67F5D20B80
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="YJifHKh/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgE2Mgr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 08:36:47 -0400
Received: from mailout4.samsung.com ([203.254.224.34]:17711 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbgE2Mgp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 08:36:45 -0400
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20200529123642epoutp041508ebd34429d9659ac56c351d19d065~Tf-lK9Il_3148131481epoutp04B
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 12:36:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20200529123642epoutp041508ebd34429d9659ac56c351d19d065~Tf-lK9Il_3148131481epoutp04B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590755802;
        bh=J49SSn9UF1qlBD1LQ3PUEtbn/nUXaru2NxUEX14GL+M=;
        h=From:To:Cc:Subject:Date:References:From;
        b=YJifHKh/ZlOkmmpku+3p0VqbeI2I9I5vlcalPMGUtatTr+vtOqtSv6d2VjRMjM5dD
         /mlw/dna79y0A6qn5gguVQMOwjhklyMJRtbpWE9Yfjwj10lFM+/z8NZGUoRbqzzWud
         Vx02iiNM0JnfJ4b0UzjweXZvgJ1zp6/D0H/ztbu4=
Received: from epsmges5p3new.samsung.com (unknown [182.195.42.75]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20200529123640epcas5p25cadb932855c3328753282da6ec26894~Tf-j27gZz1526315263epcas5p2b;
        Fri, 29 May 2020 12:36:40 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        82.D2.09475.8D101DE5; Fri, 29 May 2020 21:36:40 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
        20200529121821epcas5p24b23172c6a1956ed4a2ef06d5c44619b~TfvkHHUk_1550815508epcas5p2b;
        Fri, 29 May 2020 12:18:21 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200529121821epsmtrp1e52afc3e5c4add6bc332af26a8d5a934~TfvkGcoBL0701107011epsmtrp1D;
        Fri, 29 May 2020 12:18:21 +0000 (GMT)
X-AuditID: b6c32a4b-39fff70000002503-04-5ed101d86fab
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        14.B3.08303.D8DF0DE5; Fri, 29 May 2020 21:18:21 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.135]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200529121819epsmtip178c5205fbbd84f3079fee798c877a2e7~TfviS0QTP3038930389epsmtip1-;
        Fri, 29 May 2020 12:18:19 +0000 (GMT)
From:   Anupam Aggarwal <anupam.al@samsung.com>
To:     mchehab+samsung@kernel.org, corbet@lwn.net,
        darrick.wong@oracle.com, viro@zeniv.linux.org.uk,
        ira.weiny@intel.com, dhowells@redhat.com
Cc:     a.sahrawat@samsung.com, t.vivek@samsung.com,
        linux-kernel@vger.kernel.org,
        Anupam Aggarwal <anupam.al@samsung.com>
Subject: [PATCH] dcache: use of d_time under required configs
Date:   Fri, 29 May 2020 17:47:36 +0530
Message-Id: <1590754656-25878-1-git-send-email-anupam.al@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsWy7bCmlu4NxotxBjfPKFtc3J1q8b7hCrvF
        kwPtjBZ3329ntXjX9JvFYv/T5ywWl3fNYbN4/6mTyeJl30Y2i/N/j7M6cHks3vOSyWPTqk42
        j8V9k1k9Pj69xeLxft9VNo++LasYPT5vkvPY9OQtUwBHFJdNSmpOZllqkb5dAlfGlgs3WAtm
        clZMnLGeuYHxAnsXIyeHhICJxMfbS1m7GLk4hAR2M0r0bVwM5XxilLi6+xAzhPOZUeLWqkY2
        mJbJ+1uYQWwhgV2MEueauSGKvjJKrN/ZwQqSYBPQlZj7YjbYKBGBHkaJS1PvMIIkmAUqJLoe
        rQeaxMEhLGAr8fy1D0iYRUBVouvybxYQm1fAVeLBtIVMEMvkJG6e6wS7QkLgFrvEy8MnoK5w
        kZh18QozhC0s8er4FqiHpCRe9rexQzT0M0p0LbvACuHMYJQ4smcbC0SVvcTr5gYmkCuYBTQl
        1u/ShwjLSkw9tY4J4lA+id7fT6Cu4JXYMQ/GVpaYeu01K4QtKfG4sxXqCA+JplUL2SDBEitx
        8fR5pgmMsrMQNixgZFzFKJlaUJybnlpsWmCcl1quV5yYW1yal66XnJ+7iRGcNrS8dzA+evBB
        7xAjEwfjIUYJDmYlEd41Z8/HCfGmJFZWpRblxxeV5qQWH2KU5mBREudV+nEmTkggPbEkNTs1
        tSC1CCbLxMEp1cC0/3VNiPYZW4PnNv9Ys+ouWW9ma+MxMZPbcauybOl0pi86YlY/J516HKxe
        VrV4UXZ4fe0B7Xz1/zbl57x1T/UbV7K69lw90XEkyVRDqtLZLsyvIpAnV3GHxLqDf/Ws7kjn
        F9o8lpOaqLtMQ+awl4LS1+Wus2TNIgSmXQjh6NNjNVqxov1V5xTjxlNemtIvnCp9TDu/9254
        EJh55tO8mKe1By5dbP/sP3dJKv/rshOlFyJ6en9OCt185pipgfFWW6aZl+c/z1v5j8siWP02
        x4RTDY11b3/+8782a7X6m4Sfi+Nq2gUtv6drm58UOTVjc7v5PkVmUcndn+K6ppytjcmZ6BsU
        q7Ve1P1j1rU5PUosxRmJhlrMRcWJAHq/+Y2KAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNLMWRmVeSWpSXmKPExsWy7bCSnG7v3wtxBjMOiFhc3J1q8b7hCrvF
        kwPtjBZ3329ntXjX9JvFYv/T5ywWl3fNYbN4/6mTyeJl30Y2i/N/j7M6cHks3vOSyWPTqk42
        j8V9k1k9Pj69xeLxft9VNo++LasYPT5vkvPY9OQtUwBHFJdNSmpOZllqkb5dAlfGlgs3WAtm
        clZMnLGeuYHxAnsXIyeHhICJxOT9LcxdjFwcQgI7GCVaD8xmg0hISjS93sAIYQtLrPz3HKxB
        SOAzo8S9CQkgNpuArsTcF7NZQZpFBKYwSvSuvQLWzCxQI3Hm/C6gBAeHsICtxPPXPiBhFgFV
        ia7Lv1lAbF4BV4kH0xYyQcyXk7h5rpN5AiPPAkaGVYySqQXFuem5xYYFRnmp5XrFibnFpXnp
        esn5uZsYweGnpbWDcc+qD3qHGJk4GA8xSnAwK4nwrjl7Pk6INyWxsiq1KD++qDQntfgQozQH
        i5I479dZC+OEBNITS1KzU1MLUotgskwcnFINTJXftBLEzrBx6pYGLjPkqNSSuHT8lUC3wc8J
        i978/JAbLCu613F9jO7Cmyd2rl20MPY4f1dFwYqtHMVMr9uenmu+VxNx15MlSuHWhTap70v6
        fQqPvwvj4NJPlF6yMoOdc/9zlnNv3757Pt3+eZsqb0rSsW6xbgZlLt9mxcYdBx+qruqU/9FV
        Nffziwd1dwRi9j88/aUn6HKt9Zc1E/maPEvVvii1/2V8fzX75pbu69WPt0k/fLhvnYBukY/q
        pyBVpX+zjWMOJUjptrJv2yVj593L8veiGTvT0cYJt2fslbsoN/GJAZ+PzCfhg1p/Sn1iWeWE
        FhWcOcmz0sFvGvfpMypmR9XmHZ/woNZUcePnxUosxRmJhlrMRcWJAJzhUMuuAgAA
X-CMS-MailID: 20200529121821epcas5p24b23172c6a1956ed4a2ef06d5c44619b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20200529121821epcas5p24b23172c6a1956ed4a2ef06d5c44619b
References: <CGME20200529121821epcas5p24b23172c6a1956ed4a2ef06d5c44619b@epcas5p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct dentry{}->d_time is used when CONFIG_NFS_FS or
CONFIG_VBOXSF_FS is on.
Limit the d_time only when either of configs CONFIG_NFS_FS or
CONFIG_VBOXSF_FS is enabled
With this change size of "struct dentry" is reduced by 8-bytes
on 64-bit system, while of 32-bit system size remains unchanged
dentry object is vastly used, so this change should be useful
for memory saving

Signed-off-by: Anupam Aggarwal <anupam.al@samsung.com>
Signed-off-by: Vivek Trivedi <t.vivek@samsung.com>
Signed-off-by: Amit Sahrawat <a.sahrawat@samsung.com>
---
 include/linux/dcache.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index a94c551..d90da5e 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -101,7 +101,9 @@ struct dentry {
 	struct lockref d_lockref;	/* per-dentry lock and refcount */
 	const struct dentry_operations *d_op;
 	struct super_block *d_sb;	/* The root of the dentry tree */
+#if IS_ENABLED(CONFIG_NFS_FS) || IS_ENABLED(CONFIG_VBOXSF_FS)
 	unsigned long d_time;		/* used by d_revalidate */
+#endif
 	void *d_fsdata;			/* fs-specific data */
 
 	union {
-- 
1.9.1

