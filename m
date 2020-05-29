Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A754C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FC7820776
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 12:36:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="FulXStSj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgE2Mgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 08:36:38 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:46751 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgE2Mgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 08:36:37 -0400
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20200529123633epoutp0137e23ca8f84804394d08cb09e4d5882c~Tf-dJB04i0460404604epoutp01E
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 12:36:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20200529123633epoutp0137e23ca8f84804394d08cb09e4d5882c~Tf-dJB04i0460404604epoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1590755793;
        bh=qVRse0t/lKrDbVySbUMpwja/fCaCoeHHAoOhemPtOeA=;
        h=From:To:Cc:Subject:Date:References:From;
        b=FulXStSjuuoNrWUlEz9BJ9ZiBBMDJsuhZ4AqwGSNRKAdTvfBQjRxxkdXwywUpJmzU
         S6iKUzA2iEtyAwodKAP9w/0gyqeeTYBd4DsZ1QUvunOZdbqjs1qxpUh+Btjnsohanp
         QCGjqnvnHHkzlg/33qx6+kSL1EHZzcbAEICLOYN4=
Received: from epsmges5p1new.samsung.com (unknown [182.195.42.73]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20200529123633epcas5p26729ea8c5a671a64e4eff849ca7753fe~Tf-cxAZIv1526315263epcas5p2W;
        Fri, 29 May 2020 12:36:33 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        DD.D2.09467.0D101DE5; Fri, 29 May 2020 21:36:32 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20200529122842epcas5p319a1fd6d29aa4b645f0d64c38f550971~Tf4mygg8k2103021030epcas5p3t;
        Fri, 29 May 2020 12:28:42 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200529122842epsmtrp158d86b55ab154dd98270950d2f98b071~Tf4mxz9zl1294412944epsmtrp1s;
        Fri, 29 May 2020 12:28:42 +0000 (GMT)
X-AuditID: b6c32a49-a3fff700000024fb-6f-5ed101d0fed6
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        00.44.08382.AFFF0DE5; Fri, 29 May 2020 21:28:42 +0900 (KST)
Received: from localhost.localdomain (unknown [107.109.224.135]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200529122841epsmtip182ddff703e1a9b6bb08fca16dc119f29~Tf4lPoZy93038630386epsmtip1g;
        Fri, 29 May 2020 12:28:40 +0000 (GMT)
From:   Anupam Aggarwal <anupam.al@samsung.com>
To:     viro@zeniv.linux.org.uk, linux@dominikbrodowski.net, pc@cjr.nz,
        dhowells@redhat.com
Cc:     a.sahrawat@samsung.com, t.vivek@samsung.com,
        linux-kernel@vger.kernel.org,
        Anupam Aggarwal <anupam.al@samsung.com>
Subject: [PATCH] init: include nfs header files when CONFIG_ROOT_NFS is
 enabled
Date:   Fri, 29 May 2020 17:58:21 +0530
Message-Id: <1590755301-26094-1-git-send-email-anupam.al@samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsWy7bCmpu4FxotxBk2PLC0u7k61eN9whd3i
        XdNvFovLu+awWSxo+cBqceNyE7PFy76NbBbn/x5ndeDw2NZ3itXjwk5uj/f7rrJ59G1Zxejx
        eZOcx6Ynb5kC2KK4bFJSczLLUov07RK4Mu79WMBe8Jm14vu+SWwNjI2sXYycHBICJhI3f55g
        6mLk4hAS2M0ocWvVBkYI5xOjxLGuTmYI5xujxMEDy5hhWv4cXwVVtZdR4tyR56wQzldGiSc7
        LoFVsQnoSsx9MRtsiYhApMSjsxeZQGxmgQqJrkfr2UBsYYFAiV9dW8HqWQRUJbY1nAGzeQVc
        JZqPbIY6UE7i5jmIMyQEtrFLTH35iQUi4SJx6OhpRghbWOLV8S3sELaUxMv+NnaIhn5Gia5l
        F1ghnBmMEkf2bIPqtpd43dwAdBIH0EmaEut36UOEZSWmnloHdSmfRO/vJ0wQcV6JHfNgbGWJ
        qddeQ10nKfG4sxUaLh4SW6edBTtCSCBW4uaV72wTGGVnIWxYwMi4ilEytaA4Nz212LTAMC+1
        XK84Mbe4NC9dLzk/dxMjOB1oee5gvPvgg94hRiYOxkOMEhzMSiK8a86ejxPiTUmsrEotyo8v
        Ks1JLT7EKM3BoiTOq/TjTJyQQHpiSWp2ampBahFMlomDU6qBSSXQfPHly/9zNwZLJ5ezyUVY
        Oh25tvb65S2OT1bZuWpWX/CZUX5Ue84Nprit37dNn7Ety2/69z+vP7gGirW6yj+0dV+ZovXq
        6fuPXmLzzs/uP8HUlr85z0kxMnf25K+vi18vWJRctWS6palXu8LV+5pxamda+4y+T/UqDFf5
        nKDu13U0Qmn1yfIPN0wUNZnfsIX1bTolxCGy/t+8c0vKflU77Fs4IWzVXLeYyJZy1j+vrmls
        cn3fmvR6c8gEW4FF23kNjEVf6uZ+dQ+7wZOUU7dx1SKtpdmu+w5Nmje9f/vh5j23Mk4dLDj4
        aZOVdE9Qg9TLeX52zFvPXRTd98zpTmj5xTNzNde7elksPc/+5LoSS3FGoqEWc1FxIgA1jwgf
        dgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnluLIzCtJLcpLzFFi42LZdlhJTvfX/wtxBvM+qVtc3J1q8b7hCrvF
        u6bfLBaXd81hs1jQ8oHV4sblJmaLl30b2SzO/z3O6sDhsa3vFKvHhZ3cHu/3XWXz6NuyitHj
        8yY5j01P3jIFsEVx2aSk5mSWpRbp2yVwZdz7sYC94DNrxfd9k9gaGBtZuxg5OSQETCT+HF/F
        2MXIxSEksJtR4s6t04wQCUmJptcboGxhiZX/nrNDFH1mlPh/ZiILSIJNQFdi7ovZYJNEBGIl
        jv37DRZnFqiROHN+F1hcWMBf4uiMXnYQm0VAVWJbwxlmEJtXwFWi+chmqCvkJG6e62SewMiz
        gJFhFaNkakFxbnpusWGBYV5quV5xYm5xaV66XnJ+7iZGcFhpae5g3L7qg94hRiYOxkOMEhzM
        SiK8a86ejxPiTUmsrEotyo8vKs1JLT7EKM3BoiTOe6NwYZyQQHpiSWp2ampBahFMlomDU6qB
        af76vy4aDVM5lqQyqj8MWsQqUbKh86zcCdWOjQ9bA3q+GJvtknNJ/Sy7b2afIZNKvLv5hFfa
        ga0fRD+eVptR3Tqtplyzr+tnZLdw/PvLbOo9Kgujz4jvZ5crNAl4H1sS5l7uEHb0CN/Kt/Nm
        eX2cG+mxNdzM+vaz119vLe38wX/mYKxk07oN1h3brrJdnNQzZ95s3+SXGbM3L7mdn6pgI5v6
        V1vPeXFJp7y6Q9w2iXOqkgr9gSbVPtx5jo8LJm0xVTs24bxRq9Xe01enavbzzj+4Pbb35ZQF
        x+O7v156POvA8+aHHqYeLS+N2o3OeU1iWrVHdkqIgs7SNR/lWrfrP8q4v9Rudeq8xoLW09sM
        lFiKMxINtZiLihMBcIdzyJoCAAA=
X-CMS-MailID: 20200529122842epcas5p319a1fd6d29aa4b645f0d64c38f550971
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: REQ_APPROVE
CMS-TYPE: 105P
X-CMS-RootMailID: 20200529122842epcas5p319a1fd6d29aa4b645f0d64c38f550971
References: <CGME20200529122842epcas5p319a1fd6d29aa4b645f0d64c38f550971@epcas5p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move inclusion of header files linux/nfs_fs.h, linux/nfs_fs_sb.h &
linux/nfs_mount.h under config CONFIG_ROOT_NFS

Signed-off-by: Anupam Aggarwal <anupam.al@samsung.com>
Signed-off-by: Vivek Trivedi <t.vivek@samsung.com>
Signed-off-by: Amit Sahrawat <a.sahrawat@samsung.com>
---
 init/do_mounts.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 29d326b..02baec4 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -20,9 +20,11 @@
 #include <linux/ramfs.h>
 #include <linux/shmem_fs.h>
 
+#ifdef CONFIG_ROOT_NFS
 #include <linux/nfs_fs.h>
 #include <linux/nfs_fs_sb.h>
 #include <linux/nfs_mount.h>
+#endif
 #include <uapi/linux/mount.h>
 
 #include "do_mounts.h"
-- 
1.9.1

