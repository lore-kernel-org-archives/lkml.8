Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4B2C433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 06:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6E3F206C0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 06:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="J26KKMJK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgHIGeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 02:34:07 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:7466 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgHIGeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 02:34:06 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f2f98d10000>; Sat, 08 Aug 2020 23:33:53 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 08 Aug 2020 23:34:06 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 08 Aug 2020 23:34:06 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 9 Aug
 2020 06:34:06 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by HQMAIL109.nvidia.com (172.20.187.15) with Microsoft SMTP Server (TLS) id
 15.0.1473.3 via Frontend Transport; Sun, 9 Aug 2020 06:34:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mMNQYsc177GKXUdhE4zyEkKrt0+W36JqWWeFnNYTJwOHU19+iJRDr2iGsbUr4GRlEUhjTuRtTodbKyJ3HRFdTt85xhy9Iy+MGntJen0cRvfFZt1P+El/z2p95zvWMj26TxkhO9ZM4TwW4TJ87zds87Ecfe9kiHqqMZ1JBqo2C7T2gUnfmbKZFeL0sHsQxOg1OOz5/0YhcqYHeVm7H/M0jcyNBcXS7X8IHpw/SAIalXkxFVAErwvFABoLOSuh1hZmDH7IO6QhZhPRC37n7IkzrUUYcKCFoRqYUwhqmwYvvin6ZctoogEHsLV9Nf6FVPa5bcWOaEQY8DH18f8eyyqm1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JjBF71yuXPGgTlGLNv2OC/udHBQVF+GJ8wR4qNmXefY=;
 b=ZFRavNyxO5g4TGxxpig7XticcQ2tMVG80/vn4dQtL4EOSvHOWBXc7oYW2ZbeUAhxMunVKABaCSELKl1pzthPCc+Nz6Z1dOQyLqN5Yc1k/prss+q7hRO9oeKgnsBboAnxJYDPLk2hAOg19ar3Casa6l++aS1z6RLZDlqwYC6+a/SJxCzP++tRyKdhgnBCnohHtG7wIuu7fiIstU0rmmNnVy7OU3Jpkb0idfnN0qyUGviRAvrhKuMfMoIcp4bxEXwBEpcPdAZey8vDzTwC74BCbrNIoj1zAKRRm7Hlvw5gdjuTqg9VG/qAw68R9LiuE9XPl2X13zIWS74dqHZiGQjMpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from BN8PR12MB3425.namprd12.prod.outlook.com (2603:10b6:408:61::28)
 by BN8PR12MB3396.namprd12.prod.outlook.com (2603:10b6:408:45::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.20; Sun, 9 Aug
 2020 06:34:05 +0000
Received: from BN8PR12MB3425.namprd12.prod.outlook.com
 ([fe80::8941:c1aa:1ab4:2e39]) by BN8PR12MB3425.namprd12.prod.outlook.com
 ([fe80::8941:c1aa:1ab4:2e39%6]) with mapi id 15.20.3261.022; Sun, 9 Aug 2020
 06:34:04 +0000
From:   Eli Cohen <elic@nvidia.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        "Michael S. Tsirkin" <mst@redhat.com>, Eli Cohen <eli@mellanox.com>
CC:     Jason Wang <jasowang@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] vdpa/mlx5: Fix pointer math in mlx5_vdpa_get_config()
Thread-Topic: [PATCH] vdpa/mlx5: Fix pointer math in mlx5_vdpa_get_config()
Thread-Index: AQHWbWcyWw0bb6Lnek2A2pEcJ9pvpakvUneg
Date:   Sun, 9 Aug 2020 06:34:04 +0000
Message-ID: <BN8PR12MB3425E1FCC3E20A04182640D2AB470@BN8PR12MB3425.namprd12.prod.outlook.com>
References: <20200808093241.GB115053@mwanda>
In-Reply-To: <20200808093241.GB115053@mwanda>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=nvidia.com;
x-originating-ip: [37.142.159.249]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e9b411e5-a3d3-4eb5-1dc9-08d83c2e363c
x-ms-traffictypediagnostic: BN8PR12MB3396:
x-microsoft-antispam-prvs: <BN8PR12MB3396B5E6DE29CB1A62CBDCBCAB470@BN8PR12MB3396.namprd12.prod.outlook.com>
x-ms-exchange-transport-forked: True
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y6F93z70qKgoA6CUCLziOlIxf6T7/bgDnDIM4G9Ro7SGJGUAs4fcdCGdRwg3a7qhtX15ydXKIGyQUTc0ZIkuy97KzMBm0XRIrKHIdz9IRkExUihpbdTV0lu7xyqmFjoH6DzLuDJF2X/nDjz6t5idyggJxXyyx17Q+71NaXvnL4+0DR0PIRLxZVebzq7ByQtS2iGJd5MlO/BZFUDTzytWtaz0a6KojyUU1K4tLGbUq20kBB2+rz+Hr/v4tTaCutRXTppfnzL/sDbhiRPrGI+7mJEtxlNQpuuRnOLMRgfP3R7PAUEfzNq4sbaQlKr+aaHc1eIfW+xdCUB9Oup5wWlaCg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3425.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(396003)(366004)(346002)(39850400004)(136003)(186003)(76116006)(66476007)(64756008)(26005)(7696005)(71200400001)(66556008)(53546011)(6506007)(66446008)(316002)(33656002)(52536014)(66946007)(54906003)(110136005)(83380400001)(8936002)(55016002)(5660300002)(9686003)(86362001)(4326008)(8676002)(2906002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Cq2lQoxvcS+hSrK7orxk5uezDNXEwwLnvPa3wq3PSqFNAl/mI09Uv2ZxIpghlmAVgeVkaM2uQaun8b2GXa/XObyFjG81LuisT+H+Rrz4SDM0RJjAT/8/2bYDKaoStrlzMzCYFpfI4TrS710D+zLnuJ5FonbztBkcc2o/YDs7TYC6nOYaRvUEKXTM4umtYsvFZwUS7V0zMle+1J2lvRj5z3CYBbP008iwbr2Bd6xssb8YNwIINT1mLTDCoT0oB56XTu9s/Vw0WZ5792zOfGR9gb4UgtZ5md6D35H5FRLhCq8abtU6sO/q+HaQgX2biXRTJIsyMH5f3FVsUo3/GgyJJbnNpVV7WiZlbZ1b0YFgdUCs6URgIlML3KmTVhN8L864mPIA4K1sUWuNEdJBHjAw+UFLV0hTfCPd6AoitvaBOd0DBFVbi+uV0qpBFnoldd0JqSAPgdkOFz/kyi6rijtR73oaOLeikr8+INkIcPfr1MoPf0qUW1ODZpVKzaImkKtBaTCQHF197YnplQoZPTMTkTmSQM52JDyocJyELP201ZdOX6NhJDSo8Vu7W0HYccm43c6iRStNrXAJQofC6a8uqz7uPvKQP+u+UaoioSCEEZ0Cz/r1BSw2BbT5ytzG3LSOUNimG41Aj3rnUZJ4423Bjg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3425.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b411e5-a3d3-4eb5-1dc9-08d83c2e363c
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2020 06:34:04.7347
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xKtrZLQUyCRpvh4/onRH/KLIqia6rW8EXhlyIB1w7mPbMWrCqWgGiV7on11Ap/Ck
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3396
X-OriginatorOrg: Nvidia.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596954833; bh=JjBF71yuXPGgTlGLNv2OC/udHBQVF+GJ8wR4qNmXefY=;
        h=X-PGP-Universal:ARC-Seal:ARC-Message-Signature:
         ARC-Authentication-Results:From:To:CC:Subject:Thread-Topic:
         Thread-Index:Date:Message-ID:References:In-Reply-To:
         Accept-Language:Content-Language:X-MS-Has-Attach:
         X-MS-TNEF-Correlator:authentication-results:x-originating-ip:
         x-ms-publictraffictype:x-ms-office365-filtering-correlation-id:
         x-ms-traffictypediagnostic:x-microsoft-antispam-prvs:
         x-ms-exchange-transport-forked:x-ms-oob-tlc-oobclassifiers:
         x-ms-exchange-senderadcheck:x-microsoft-antispam:
         x-microsoft-antispam-message-info:x-forefront-antispam-report:
         x-ms-exchange-antispam-messagedata:Content-Type:
         Content-Transfer-Encoding:MIME-Version:
         X-MS-Exchange-CrossTenant-AuthAs:
         X-MS-Exchange-CrossTenant-AuthSource:
         X-MS-Exchange-CrossTenant-Network-Message-Id:
         X-MS-Exchange-CrossTenant-originalarrivaltime:
         X-MS-Exchange-CrossTenant-fromentityheader:
         X-MS-Exchange-CrossTenant-id:X-MS-Exchange-CrossTenant-mailboxtype:
         X-MS-Exchange-CrossTenant-userprincipalname:
         X-MS-Exchange-Transport-CrossTenantHeadersStamped:X-OriginatorOrg;
        b=J26KKMJKFcDx6r29xLENW2XLcWSK6WzgYiM0svxj/J1SJAMfXXGVTEb6I/j1VDs25
         lXRQOiQ6+6lycWvKogGOcpiBZedCA10sXv2rwc0lLH9gGIgIRC6EHqUe9wuSih+Agi
         NgA/OYtpFXK+kwqidSc9MDpN8JDvmsczFLBG7VUDyaZlQF462IjXwqPkJS9v05TXuR
         3rDqrj0DSKbkqr9o/eqQCp5/wJXvh+s2yNClXpsbumywLh8JOh9v+rfuJ4hGWO4Szr
         nKgpGUAS4C6T9qpHJEDoYvjtaWH6HNrcbVWVpahGhmEiwrWZ5zXfkz5gU15Qyw4iG3
         o/6jgnTC0Aamg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Eli Cohen <elic@nvidia.com>

BTW, vdpa_sim has the same bug.

-----Original Message-----
From: Dan Carpenter <dan.carpenter@oracle.com>=20
Sent: Saturday, August 8, 2020 12:33 PM
To: Michael S. Tsirkin <mst@redhat.com>; Eli Cohen <eli@mellanox.com>
Cc: Jason Wang <jasowang@redhat.com>; Parav Pandit <parav@mellanox.com>; vi=
rtualization@lists.linux-foundation.org; linux-kernel@vger.kernel.org; kern=
el-janitors@vger.kernel.org
Subject: [PATCH] vdpa/mlx5: Fix pointer math in mlx5_vdpa_get_config()

There is a pointer math bug here so if "offset" is non-zero then this will =
copy memory from beyond the end of the array.

Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices=
")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5=
_vnet.c
index 3ec44a4f0e45..9d1637cf772e 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1758,7 +1758,7 @@ static void mlx5_vdpa_get_config(struct vdpa_device *=
vdev, unsigned int offset,
 	struct mlx5_vdpa_net *ndev =3D to_mlx5_vdpa_ndev(mvdev);
=20
 	if (offset + len < sizeof(struct virtio_net_config))
-		memcpy(buf, &ndev->config + offset, len);
+		memcpy(buf, (u8 *)&ndev->config + offset, len);
 }
=20
 static void mlx5_vdpa_set_config(struct vdpa_device *vdev, unsigned int of=
fset, const void *buf,
--
2.27.0

