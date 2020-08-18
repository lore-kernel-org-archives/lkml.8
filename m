Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E9DC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 05:33:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0862D2063A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 05:33:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="PV6/eopN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgHRFdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 01:33:00 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:54295 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726343AbgHRFc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 01:32:57 -0400
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200818053253epoutp01cf346e2f421d299f065f4be7c067acb5~sRdrTPHCu1966819668epoutp01W
        for <linux-kernel@vger.kernel.org>; Tue, 18 Aug 2020 05:32:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200818053253epoutp01cf346e2f421d299f065f4be7c067acb5~sRdrTPHCu1966819668epoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1597728773;
        bh=jEOVmDYbulTLaXPLZDY41EjVVS5v/5kzsUbXyDk+3EY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PV6/eopNzjO/oPixGLKCHPpLvh9PpTKSA4ooEmq2MFuI9rnenaTQbX2uPrgOMwBxS
         Fz+0TNVfybMKZc17yONV5eUyr51bna0Dx7/Zx1Ak9eYoUB9R168NoCIwJ6/hZRqank
         cjwFksIaRExvoalqsm+pKzFONrqFumeuF6a+ciAQ=
Received: from epsmges5p2new.samsung.com (unknown [182.195.42.74]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20200818053252epcas5p30ea64bd4f545844e9fd9f236720889b1~sRdqN59zZ0717507175epcas5p3b;
        Tue, 18 Aug 2020 05:32:52 +0000 (GMT)
Received: from epcas5p4.samsung.com ( [182.195.41.42]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        72.29.40333.4086B3F5; Tue, 18 Aug 2020 14:32:52 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20200818053252epcas5p4ee61d64bba5f6a131105e40330984f5e~sRdp8vRm71618016180epcas5p4o;
        Tue, 18 Aug 2020 05:32:52 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200818053252epsmtrp28b158913a76d808cb5b6e9f611e2ed1c~sRdp8B3r22801128011epsmtrp2Q;
        Tue, 18 Aug 2020 05:32:52 +0000 (GMT)
X-AuditID: b6c32a4a-9a7ff70000019d8d-47-5f3b68049955
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        73.DA.08382.4086B3F5; Tue, 18 Aug 2020 14:32:52 +0900 (KST)
Received: from test-zns.sa.corp.samsungelectronics.net (unknown
        [107.110.206.5]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200818053250epsmtip2394e526d06a97e4cd6e382dfb8a27fe8~sRdoTURNm1720417204epsmtip2Z;
        Tue, 18 Aug 2020 05:32:50 +0000 (GMT)
From:   Kanchan Joshi <joshi.k@samsung.com>
To:     kbusch@kernel.org, hch@lst.de, Damien.LeMoal@wdc.com,
        axboe@kernel.dk, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        johannes.thumshirn@wdc.com, Kanchan Joshi <joshi.k@samsung.com>
Subject: [PATCH 1/2] nvme: set io-scheduler requirement for ZNS
Date:   Tue, 18 Aug 2020 10:59:35 +0530
Message-Id: <20200818052936.10995-2-joshi.k@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200818052936.10995-1-joshi.k@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsWy7bCmli5LhnW8watzuha/p09htVh9t5/N
        orX9G5PFytVHmSz+dt1jsjj6/y2bxaRD1xgtLu+aw2Yxf9lTdosrUxYxW6x7/Z7Fgdvj/L2N
        LB6Xz5Z6bFrVyeaxeUm9x+6bDWwefVtWMXp83iTn0X6gmymAI4rLJiU1J7MstUjfLoEro+vq
        b9aC96wVl9rnMzcwdrF2MXJySAiYSMy/eoQZxBYS2M0oMXseP4T9iVFi3Ve9LkYuIPsbo8Sa
        G1tZYBoubfnGDpHYyygxp+80lNPKJLF6zjO2LkYODjYBTYkLk0tBGkQEYiVmXOpmAalhFmhm
        lLhzZhnYamEBe4krt3YwgdSzCKhKzHjPBRLmFbCQWLh2BtR18hKrNxwAu45TwFLi68n/YHMk
        BH6ySxxtnMwGUeQicfTJTUYIW1ji1fEt7BC2lMTnd3uhaoolft05ygzR3MEocb1hJtQ79hIX
        9/wFO4IZ6Oj1u/RBwswCfBK9v5+AhSUEeCU62oQgqhUl7k16CnWbuMTDGUugbA+J638/skDC
        oYdR4teVv0wTGGVnIUxdwMi4ilEytaA4Nz212LTAKC+1XK84Mbe4NC9dLzk/dxMjOHFoee1g
        fPjgg94hRiYOxkOMEhzMSiK8SSfM44V4UxIrq1KL8uOLSnNSiw8xSnOwKInzKv04EyckkJ5Y
        kpqdmlqQWgSTZeLglGpgqm9ZWnHhfwXbj42NT82m7dda89E9fcXSGJ3uHJ56hn291Vw5Nscy
        e/guX1Jb+E60q1HXirHqk7+pTM1Fy7eMf3aejmOxPfwr9U/DkhOH0g5OT9/Wt/T5mgvL5TYV
        F5y2v6YZe+7T/uMn/nfLLvDiS9KS/7Pk6W63o+euyd5WfnpgfopNWLma5y+VMLHra29+znv9
        Kbki8bdoO1vUUp1+ycpnB17vWBwlv+TV2eMfFdaejXT6vZ93t3pWxipjiUju1OrP0b6/O5Id
        rflNZOtcrt8O11phF3OG/6m3xa6jEw+op5Q3zDrFOP/VihPyU/jNvnttfeFeUP2P6d+Xlf84
        l1vJ+R8sqXBxVHx7onzGAiWW4oxEQy3mouJEAMlntZmLAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrGLMWRmVeSWpSXmKPExsWy7bCSvC5LhnW8wZQZwha/p09htVh9t5/N
        orX9G5PFytVHmSz+dt1jsjj6/y2bxaRD1xgtLu+aw2Yxf9lTdosrUxYxW6x7/Z7Fgdvj/L2N
        LB6Xz5Z6bFrVyeaxeUm9x+6bDWwefVtWMXp83iTn0X6gmymAI4rLJiU1J7MstUjfLoEro+vq
        b9aC96wVl9rnMzcwdrF2MXJySAiYSFza8o0dxBYS2M0o0fDXBCIuLtF87Qc7hC0ssfLfcyCb
        C6immUmi8/U2IIeDg01AU+LC5FKQGhGBZInWRXtZQGqYBdoZJZ4//MUCkhAWsJe4cmsHE0g9
        i4CqxIz3XCBhXgELiYVrZ0DdIC+xesMBZhCbU8BS4uvJ/ywQ91hI7Ft1kWkCI98CRoZVjJKp
        BcW56bnFhgWGeanlesWJucWleel6yfm5mxjBQauluYNx+6oPeocYmTgYDzFKcDArifAmnTCP
        F+JNSaysSi3Kjy8qzUktPsQozcGiJM57o3BhnJBAemJJanZqakFqEUyWiYNTqoFp0jo254ql
        0grMl2+1/OYrEDJLUa64XKl9r3L29xrOGCFdy6wijnkKqQ/a72Tx9vzf3SC1+Mbynt/7a8QN
        +5MNP7VlyV/mTX1o8E3/8BFnW7UH5/427LN9MmfSk7271LoX/z+We0pzQWNrmOPBQ9sEjm27
        yxVp4BJ14r7zxisO/7fZ7nqfnuy2Y4e13v2/DZKJT681nLvZtvG9hHt1zb7qVXyZzJ4x5lIa
        G2PetZ6pbupdWGC55PEZ4aRkphmzb5d9ebNNMVgsdv6qTGmmxdH+zT4M99yXrOhXmlJWdCXo
        yR/B+rmNjt9e32mvaDy98vUZn0urBXmyBJNio4omzvXVXn467c72j2ZFc5J3bXqjxFKckWio
        xVxUnAgAhRvDSMkCAAA=
X-CMS-MailID: 20200818053252epcas5p4ee61d64bba5f6a131105e40330984f5e
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
X-CMS-RootMailID: 20200818053252epcas5p4ee61d64bba5f6a131105e40330984f5e
References: <20200818052936.10995-1-joshi.k@samsung.com>
        <CGME20200818053252epcas5p4ee61d64bba5f6a131105e40330984f5e@epcas5p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set elevator feature ELEVATOR_F_ZBD_SEQ_WRITE required for ZNS.

Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
---
 drivers/nvme/host/zns.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 57cfd78731fb..cabd870fb64e 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -96,6 +96,7 @@ int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
 
 	q->limits.zoned = BLK_ZONED_HM;
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
+	blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE);
 	blk_queue_max_open_zones(q, le32_to_cpu(id->mor) + 1);
 	blk_queue_max_active_zones(q, le32_to_cpu(id->mar) + 1);
 free_data:
-- 
2.17.1

