Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DATE_IN_FUTURE_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF72FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 09:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A151206DC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 09:52:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XR8Gc15Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgFDJwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 05:52:46 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:57201 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728313AbgFDJwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 05:52:45 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20200604095243epoutp0241971949f084ef5253325e2eb241e59a~VToICuXqQ1259012590epoutp02-
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 09:52:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20200604095243epoutp0241971949f084ef5253325e2eb241e59a~VToICuXqQ1259012590epoutp02-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1591264363;
        bh=OaSZFf2qQGBcr7NfAGyghK+7rfdpjrzREc4+KoKyo9c=;
        h=From:To:Cc:Subject:Date:References:From;
        b=XR8Gc15QbSryNH8B7VuWpu5yQnCFUWakWFDvmadMLD2T3eE6cMBjk+XFZOjFrKLWP
         DcsDb/MF7JEtU4wZUrhKbxQCFNFYg+Os9+j2smqIiQjVquIE2f80KH/rZV75HWwtrj
         7MM3sFbZ2la+H3Pse814YSBuLjra/uhwARFjK4RQ=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20200604095243epcas2p2f25665a2a1dc82943d01d64ec0cc6646~VToHtpyas0969709697epcas2p23;
        Thu,  4 Jun 2020 09:52:43 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.40.165]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 49d1Kk2ZMtzMqYkf; Thu,  4 Jun
        2020 09:52:42 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        B6.07.27441.A64C8DE5; Thu,  4 Jun 2020 18:52:42 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20200604095241epcas2p3bef5ec0a913244bcfd8e7a84827bbf77~VToGeX5Qy3171131711epcas2p3B;
        Thu,  4 Jun 2020 09:52:41 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200604095241epsmtrp253442ef020d6204a779f921155dbd375~VToGdwMg_1431714317epsmtrp2o;
        Thu,  4 Jun 2020 09:52:41 +0000 (GMT)
X-AuditID: b6c32a47-fafff70000006b31-20-5ed8c46a7f9f
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        4D.69.08303.964C8DE5; Thu,  4 Jun 2020 18:52:41 +0900 (KST)
Received: from localhost.localdomain (unknown [10.252.15.188]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200604095241epsmtip158f87366c228730fbf8e464f862b1ca1~VToGS3Ufg2316223162epsmtip1f;
        Thu,  4 Jun 2020 09:52:41 +0000 (GMT)
From:   Jeongtae Park <jtp.park@samsung.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jeongtae Park <jtp.park@samsung.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm/vmalloc: fix a typo in comment
Date:   Fri,  5 Jun 2020 03:52:39 +0900
Message-Id: <20200604185239.20765-1-jtp.park@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIKsWRmVeSWpSXmKPExsWy7bCmhW7WkRtxBm86BS3mrF/DZvFl0jt2
        i5WrjzJZHFl7lcni8q45bBb31vxndWDz2PRpErvHiRm/WTx232xg8+jbsorR4/MmOY/X+w8x
        BrBF5dhkpCampBYppOYl56dk5qXbKnkHxzvHm5oZGOoaWlqYKynkJeam2iq5+AToumXmAJ2h
        pFCWmFMKFApILC5W0rezKcovLUlVyMgvLrFVSi1IySkwNCjQK07MLS7NS9dLzs+1MjQwMDIF
        qkzIyXj35iFLwTT2ik1P/7A3ML5i7WLk5JAQMJHY8mAzM4gtJLCDUeLDK9suRi4g+xOjxN97
        WxghnM+MEps3bGaC6Vj48ykbRGIXo8STOT9Y4aruPd8GVsUmoCUxfWYD2A4RAV2JVc93MYMU
        MQusZJTY+e0vI0hCWMBI4uGdX2BFLAKqEjde7Qc7hFfAUmLR3gtsEOvkJVZvOADWLCGwiV1i
        x7GV7F2MHECOi8SKk9oQNcISr45vYYewpSQ+v9vLBlHfzSixqHUFVPMERonv/99AvW0ssfPE
        JBaQQcwCmhLrd+lDhBUldv6eC3YcswCfRMfhv1C7eCU62oQgSpQk5i2dxwxhS0hcmruFGaLE
        Q+LRFXFIOMZKtLWcY53AKDsLYf4CRsZVjGKpBcW56anFRgXGyLG0iRGctrTcdzDOePtB7xAj
        EwfjIUYJDmYlEV4r2WtxQrwpiZVVqUX58UWlOanFhxhNgeE1kVlKNDkfmDjzSuINTY2MjY0t
        zIyMDU2MlcR5i60uxAkJpCeWpGanphakFsH0MXFwSjUwCfeuN33seGFFWA+bkrpenL7IoiB1
        +Xf9v7wezjmauchRb+4OVvEXvHyWZb8XfxVO/sBkkT2tav+H56qOM6IlXuTz/JOtkbHaoLFk
        4/eaqZVy4kYCtp7BUrLcy/9stW6I7tj2+cWlt0+Z//j0WB1+pbpI6/LNLyxPJTk1rk4VPGXR
        Wzpn76ZPSbuPXTD2CBNpmiEqMUHBZEHBl7WfOF4+MjTMNxabpJqeu/n0S6fqOWp7o/yMG61L
        /eZsz3id2FzwIMX6y84St+9uKasiRTacK9flX7lZ9MSCe8KHdkudsU98+PyvbUDcjoOTnins
        EeB+umeKtf0LzeMrkwxnLf/wT+rF1msva1xv/F2S9/i9jBJLcUaioRZzUXEiAKgmWnnkAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPJMWRmVeSWpSXmKPExsWy7bCSnG7mkRtxBu37zCzmrF/DZvFl0jt2
        i5WrjzJZHFl7lcni8q45bBb31vxndWDz2PRpErvHiRm/WTx232xg8+jbsorR4/MmOY/X+w8x
        BrBFcdmkpOZklqUW6dslcGW8e/OQpWAae8Wmp3/YGxhfsXYxcnJICJhILPz5lK2LkYtDSGAH
        o8T1HS+YIRISEss3vGCCsIUl7rccAWsQEvjIKLHtSAiIzSagJTF9ZgNYXERAV2LV813MIIOY
        BdYySnTd/c0GkhAWMJJ4eOcXWBGLgKrEjVf7wRbwClhKLNp7gQ1igbzE6g0HmCcw8ixgZFjF
        KJlaUJybnltsWGCUl1quV5yYW1yal66XnJ+7iREcRlpaOxj3rPqgd4iRiYPxEKMEB7OSCK+V
        7LU4Id6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxfZy2MExJITyxJzU5NLUgtgskycXBKNTDFzt62
        Y+Hvfdv2tvNUJS3nsrMTzLs0f1bB97KL85W28rjKru67e2fZJGk3wzcTvd9IcvJ8X7CEOz7x
        WHLQxcRXc61ms2mdf1pvsvDaXQ2h751WHyat+Wmb8fPkV80Tp3gXLsmceMAvsP3bHM5lsqt9
        FKQKP0+Xb8l4dIvVcquXlz3bOYtmpW61QL8lp2y2FVpphj4+sfGm2ELOa/W5z8/IdR7/6ZqS
        sCMy5P5n0bfffrRLGfHMMl9te0TKom7GPlWHzZ3OjvPqv56ae27zEjvj7ysjuc9eeK/O+WNx
        YzU/c3pwjbHfJLFwe63Fbc/aFlkq1Ym/2Jbz6cjjxrSH0ysiTsoK/axXuuGp5OibxPpKiaU4
        I9FQi7moOBEAVmwMM5ICAAA=
X-CMS-MailID: 20200604095241epcas2p3bef5ec0a913244bcfd8e7a84827bbf77
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: SVC_REQ_APPROVE
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20200604095241epcas2p3bef5ec0a913244bcfd8e7a84827bbf77
References: <CGME20200604095241epcas2p3bef5ec0a913244bcfd8e7a84827bbf77@epcas2p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a typo in comment, fix it.
"nother" -> "another"

Signed-off-by: Jeongtae Park <jtp.park@samsung.com>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Christoph Hellwig <hch@lst.de>
---
 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 1e94497b7388..3091c2ca60df 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2317,7 +2317,7 @@ static inline void __vfree_deferred(const void *addr)
 	 * Use raw_cpu_ptr() because this can be called from preemptible
 	 * context. Preemption is absolutely fine here, because the llist_add()
 	 * implementation is lockless, so it works even if we are adding to
-	 * nother cpu's list.  schedule_work() should be fine with this too.
+	 * another cpu's list. schedule_work() should be fine with this too.
 	 */
 	struct vfree_deferred *p = raw_cpu_ptr(&vfree_deferred);
 
-- 
2.17.1

