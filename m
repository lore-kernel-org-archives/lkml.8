Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CA5C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 05:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4F9F20720
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 05:53:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Topcon.com header.i=@Topcon.com header.b="cn6tL8rV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgBFFxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 00:53:47 -0500
Received: from mail-bn8nam12on2059.outbound.protection.outlook.com ([40.107.237.59]:6105
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725809AbgBFFxq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 00:53:46 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S0BBjdo+cnJhHo+IWE/SMUPms0sEZP7z5i61NsCeJWNeYzY+SEh4HXmv3WraT1sXc8QmqHx6/L7ft8LVZ8H3Ty1KQdJLA+GTh3PIVgLISWDiJk0WcyujMvWb39DI+DjRbZcEQvuyFyAvRBwDdDPBwX9u/pNU8FBvTXSg0bBYtwTKass/NS/RTG9jDgnorUFZzIklF3pZ6FiBFgYUTEGwBztr6vOoHV9wPCo2kUY7ICNe9+1YOBOl+KIO1ns98lvlWmzAYhElFfaY5IUe7R5BE6DDqAzBrJYEj8B+r8z4Q/TdMLKAidkfjJrbtikONZ9qLbSMw2774wc+6hxzFuGzUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+jYRfZj/dIXmloAFTj7QBnotoIT1ICWjxySZYiP+fE=;
 b=nlvqYSyZDDzGG3dsVDHrs2zMjDCIhja0rgX+57jdeqPqBMvqAUUxq3G/8jUjVOSIxNzE5PWf65Tx0X0jV/ZOcaXe8f3l8Ol2pMxIMj12THUjMno4akPgdZYce6ydnS77fogmqiwT5I8Ssmr5gATmDsldhhY87kgRuQIDtTdhy4Yf+LYULMMiQ3+3muzid/fHcdEVLOcGecE4yILJrBW2Y6GISdmPdwI21yJeaQn9K39tfheeKW9WPlIYKlBAjL5APel58LtOkSU+PMun+DaZdk8t8Qj5gcZ2zCn+iImvwW7d8gJHJhSukpglMOjdcJ0Lsvvi9SmTsbr2Z9jAyPBYEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=topcon.com; dmarc=pass action=none header.from=topcon.com;
 dkim=pass header.d=topcon.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Topcon.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+jYRfZj/dIXmloAFTj7QBnotoIT1ICWjxySZYiP+fE=;
 b=cn6tL8rVrVYe5dtz9FffL+Q9bnZ4nATzgBu2KIi3JaxnaoQu9Spk/SyuXZLRjy1m9vLTZr6340Gvpvs8lVlFnEivRU691cy2ZyY/f3RI6muSYhlCANmVw3T3LT39O56FvE0vlhaI1TPJieTsfUGc7OVApP/Vhjmxld6tDAj8EHM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=NShubin@topcon.com; 
Received: from MN2PR06MB5742.namprd06.prod.outlook.com (20.179.148.96) by
 MN2PR06MB6128.namprd06.prod.outlook.com (20.178.245.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Thu, 6 Feb 2020 05:53:40 +0000
Received: from MN2PR06MB5742.namprd06.prod.outlook.com
 ([fe80::9405:d1a5:a151:b165]) by MN2PR06MB5742.namprd06.prod.outlook.com
 ([fe80::9405:d1a5:a151:b165%6]) with mapi id 15.20.2707.020; Thu, 6 Feb 2020
 05:53:40 +0000
From:   Nikita Shubin <NShubin@topcon.com>
Cc:     NShubin@topcon.com, Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] remoteproc: warn on kick missing
Date:   Thu,  6 Feb 2020 08:54:19 +0300
Message-Id: <20200206055419.15897-1-NShubin@topcon.com>
X-Mailer: git-send-email 2.24.1
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0022.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:14::9) To MN2PR06MB5742.namprd06.prod.outlook.com
 (2603:10b6:208:131::32)
MIME-Version: 1.0
Received: from NShubin.TOPCON.COM (193.232.110.5) by FR2P281CA0022.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:14::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.21 via Frontend Transport; Thu, 6 Feb 2020 05:53:38 +0000
X-Mailer: git-send-email 2.24.1
X-Originating-IP: [193.232.110.5]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20085c89-d4f6-4aa9-fd4e-08d7aac8ea5b
X-MS-TrafficTypeDiagnostic: MN2PR06MB6128:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MN2PR06MB61289BC810E8205C048A6AD5D91D0@MN2PR06MB6128.namprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-Forefront-PRVS: 0305463112
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(346002)(136003)(366004)(396003)(39860400002)(376002)(199004)(189003)(6486002)(36756003)(2616005)(52116002)(956004)(7696005)(66556008)(4326008)(66946007)(66476007)(86362001)(5660300002)(478600001)(316002)(26005)(8936002)(81156014)(81166006)(8676002)(2906002)(6666004)(1076003)(186003)(16526019)(54906003)(109986005)(266003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR06MB6128;H:MN2PR06MB5742.namprd06.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: topcon.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Hd+Bg4GSbx/65fNvt9vXIY0bWOPrB/1qpSSQC+/Mcl7oJLMAZLBn5A9B25ufVsI/mBSQND2pBCbvKHmqvSEa52Ixa7YkMkB182wYjVzgGcWxxo34ceDd2SEu6wApPezlhME8drKLLilUgQQrAa2uLwMwFHdRPIAc/gRLPXFld3hzcmTayfqCE69u7+REdMld+gP/MieBkzcBzzfzyzJfLQAZ3uX34OCME8xeE7OFKGl0wlNs4dUySgvNvwLvNwe9i0Y0vLaBctICPZC8bAqVPOo0lJzaTqDkKo5miyCKN6GayOdCO/vAgty8Y+fwG0ddRw2gxqTPGN603GuCNkUulvRdt6kAEwtreiRPibyEMi3oycCp3nSWncVm8fgSARb9n1CbnNHuws9aPAZpTWBM4yWWnnGEkP9mDHQy20EyL4/+UH2EdC383sU8GdFBJ39yGwY1y4pQE2+mPXjWTJWFNmkx9bcRZqJGf1Y0bmn6yJk=
X-MS-Exchange-AntiSpam-MessageData: 13hzBTKZdpWPsIVjivBB+wUZUPITF0V2UVi37JX9/MEUIkOrNvFy8DYkWfQrqB8eSX0i4c7QQjpotVwkjgSnMdECExbcl2vESlPmZtEzO3v+wifVnPfzMaboWHCUTblwd7swlEyGTxy+rGGOsZzJmQ==
X-OriginatorOrg: Topcon.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20085c89-d4f6-4aa9-fd4e-08d7aac8ea5b
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2020 05:53:40.1341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 96c2c3ba-19d3-47b6-ba0b-8f7471bd1f14
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/6DcAlTv+7x6iTfv5zbXJwgFemfWDFE4m10oo8h7I2Mb+hHG6nrwpst1vvhqRrrHQ5Te0HoLUcbcaDfRwQoGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR06MB6128
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.kick method not set in rproc_ops will result in:

8<--- cut here ---
Unable to handle kernel NULL pointer dereference

in rproc_virtio_notify, after firmware loading.

At least a warning needed on attempt to call missing method.

Signed-off-by: Nikita Shubin <NShubin@topcon.com>
---
 drivers/remoteproc/remoteproc_virtio.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/re=
moteproc_virtio.c
index 8c07cb2ca8ba..77a81f331e3f 100644
--- a/drivers/remoteproc/remoteproc_virtio.c
+++ b/drivers/remoteproc/remoteproc_virtio.c
@@ -32,6 +32,12 @@ static bool rproc_virtio_notify(struct virtqueue *vq)

        dev_dbg(&rproc->dev, "kicking vq index: %d\n", notifyid);

+       if (unlikely(rproc->ops->kick =3D=3D NULL)) {
+               WARN_ONCE(rproc->ops->kick =3D=3D NULL, ".kick method not d=
efined for %s",
+                       rproc->name);
+               return false;
+       }
+
        rproc->ops->kick(rproc, notifyid);
        return true;
 }
--
2.24.1

Confidentiality Notice: This message (including attachments) is a private c=
ommunication solely for use of the intended recipient(s). If you are not th=
e intended recipient(s) or believe you received this message in error, noti=
fy the sender immediately and then delete this message. Any other use, rete=
ntion, dissemination or copying is prohibited and may be a violation of law=
, including the Electronic Communication Privacy Act of 1986.   =AD=AD
