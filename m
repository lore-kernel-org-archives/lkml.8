Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C706EC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 19:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 865E92073E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 19:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="mUJus+x1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgGRTtK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 15:49:10 -0400
Received: from mail-eopbgr40080.outbound.protection.outlook.com ([40.107.4.80]:12769
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726346AbgGRTtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 15:49:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lGehW7tyolUBJYHeo3mf+kzBeRoTXt7bcKTfdmQOoG0t4NEMzHseeLi3OoPPlJ63wazXe0ciarkMIce8mb1bBYpmf3sSY3VUDmcjoAjGUO+RZCGctCmEQLpUKcJkxcjiZOnQCXoAAASUH6Bhac1fj4iL+ml51rizSIfD6ZAJc9LHgZ7/8PDhqhdsYhz6hpOcpilLUcPmwHCRSVMpt1AK1q8cLLYVMi6iUX0SAplCcaoek2ec31YUbRXqAUtwcIXXzSo8wX/APgrBNZzBTJvMoHOAkLu25+bLqLBY5Mb0TCNS/6glZ8S7JLzfw0Vs6OuAT/BUIjqGdwN4iP1LXAA8Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kf730q/ljStrk3mrtns+jHCvBJrGvrpLVbNsUphd71Y=;
 b=KRO5+pAz1Og8xl4716lqFi0bgvQLDY0alHfmuedr4PubvIR+XINBhJJq9GmQvwrBSKW6iAva+3OkkKT7vpcC/L9s+0jktZRwfuth59/5rNWO7p/UuIag4EGZcdry/jyZhWiIlaw1fbdOlA88c6KJUKezKts12WHuUdyQv9Cup3gy6zww2xRixVM9Zrs5BtyqGMVFwfSyEiV7T/4qsRLMA9p+ZvDfRP6b1nnxHGIekOy8QdcEgvuuagbOc/Kk6rSnacCiLBVz6Ac3IrhYlZEGk9YFMXDCgpHG4zG7i81Tm23u5h6yG5vpFSCykxWn+m0EG4s7rK8dhvSgREByRjgBGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kf730q/ljStrk3mrtns+jHCvBJrGvrpLVbNsUphd71Y=;
 b=mUJus+x1QFZq1nI1Dp/ZhKHMqczlthYXM9R8OgzGKrTl53L+9TKp3lMIH0RhM/T6a5wP7cGVa1x84L10N4c8P3L4/q8JdNgEKBht0AkzoVywhwCZaBSfwVYzFuW2AJ4yw/rluO/xFB7N+3rvcfRlNNYFYyGVwHPJvjkwD2+QqgM=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com (2603:10a6:208:b3::15)
 by AM0PR05MB5137.eurprd05.prod.outlook.com (2603:10a6:208:e9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Sat, 18 Jul
 2020 19:49:06 +0000
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::e00a:324b:e95c:750f]) by AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::e00a:324b:e95c:750f%7]) with mapi id 15.20.3174.029; Sat, 18 Jul 2020
 19:49:06 +0000
Date:   Sat, 18 Jul 2020 22:49:02 +0300
From:   Eli Cohen <eli@mellanox.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        saeedm@mellanox.com, Parav Pandit <parav@mellanox.com>
Subject: Re: [PATCH vhost next 10/10] vdpa/mlx5: Add VDPA driver for
 supported mlx5 devices
Message-ID: <20200718194902.GA52765@mtl-vdi-166.wap.labs.mlnx>
References: <20200716072327.5359-1-eli@mellanox.com>
 <20200716072327.5359-11-eli@mellanox.com>
 <454850cc-269b-72aa-4511-2bf793a215cc@redhat.com>
 <20200716115428.GC186790@mtl-vdi-166.wap.labs.mlnx>
 <b85ecb97-2120-f63f-f5f4-01d90f88d666@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b85ecb97-2120-f63f-f5f4-01d90f88d666@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: AM0PR02CA0015.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::28) To AM0PR05MB4786.eurprd05.prod.outlook.com
 (2603:10a6:208:b3::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mtl-vdi-166.wap.labs.mlnx (94.188.199.18) by AM0PR02CA0015.eurprd02.prod.outlook.com (2603:10a6:208:3e::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend Transport; Sat, 18 Jul 2020 19:49:05 +0000
X-Originating-IP: [94.188.199.18]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 08d1acc5-f562-4337-9cbb-08d82b53a101
X-MS-TrafficTypeDiagnostic: AM0PR05MB5137:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB5137431AAAB5D0D872054826C57D0@AM0PR05MB5137.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9xNsSM99avMSEjDvDf1J8t0tdrLLrDQt4KDl9jxPsvaMld12a+lvdRSrA3gDNszSB3rIPneMAZ/GjQ/P3O2OoOku1co/qUaNCjZxcZGzBFMJ434OLFXslxhrc9rz4G7MPSaPapo9plRLzqqlc4LNQeZNh/S7PyNkOu+oM6oxbKOFcujdOMMPE/HvHdU3Ssn2gMSPT9qlHU+NFnQgRVG0AJ4+hcVVJK5+bXz4jhB7+Ocl2+MxSGRNXRKaqolZsyQlMiqZYtXKaM1wpFXSM98I+xTTn5kZqce0mvZy6+9tcszNhDsxcletZvhmemO7sPp4235io27dDieG7JybpJKepg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB4786.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(346002)(376002)(366004)(39850400004)(107886003)(956004)(66556008)(6666004)(66946007)(66476007)(8936002)(478600001)(4326008)(316002)(8676002)(52116002)(7696005)(6506007)(26005)(6916009)(186003)(16526019)(2906002)(9686003)(86362001)(5660300002)(33656002)(1076003)(55016002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: K1x2qkqIlKY5c3vsRyQO6DoQrcK4KhPK5E1TUobKzvmZNrEXnWjbQyJSA1oc4kTX0AOYqBKSPViUq4SURorSfVl/X9rrRUzsBIV2KVLVwdi1h7tO9S2PP6caAj1hTLsFndwYYWQg1HRNGrF10qwfKK53+UBr3so90xIe/0ieEOshO1vnv/k9ZwVDcu4KfBRvGoGhyu64TEGwFPgkJWKIepTmJ3+P9c6HBdkf1iXcOQ981ZlCbNXB9XhxEYI/8Yrh4on3RX37P4ZiiGl2+OgZBer/ZZPJXtzDg+NKFHkvx81WHMMqzCRiygDlUEQTcRlM4ZiQ0Y8VKp2S8Be0gHMI6vYK+vox4Xf/DBUzpD/KXuWXm0YIHSMzoXlPyxuvTUXEFVDL+1xxt2jIGD2gkbPwZseZ+MY1bvWpkjnZYeF8JCOU/6tUq7AVzYQA8kj2pGgWZWfrUnU43E8VP/1oNxc2a4d/+ewi8wPkRPO1UVuQ2fY=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08d1acc5-f562-4337-9cbb-08d82b53a101
X-MS-Exchange-CrossTenant-AuthSource: AM0PR05MB4786.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2020 19:49:05.8811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVegIihsS/UwTIk53gaQRLoCr2Nf/w2dabM2TndzRE2hgHvj57UEuvOy9W/1qlNJrGgKv32Rlu4RtCiwEBdxWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB5137
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 04:57:29PM +0800, Jason Wang wrote:
> >Looks like checking intialized is enough. Will fix this.
> >>>+
> >>>+static void mlx5_vdpa_set_vq_ready(struct vdpa_device *vdev, u16 idx, bool ready)
> >>>+{
> >>>+	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> >>>+	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> >>>+	struct mlx5_vdpa_virtqueue *mvq = &ndev->vqs[idx];
> >>>+	int err;
> >>>+
> >>>+	if (!mvq->ready && ready && mvq->fw_state != MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY) {
> >>>+		err = modify_virtqueue(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY);
> >>>+		if (err) {
> >>>+			mlx5_vdpa_warn(mvdev, "failed to modify virtqueue(%d)\n", err);
> >>>+			return;
> >>>+		}
> >>>+	}
> >>
> >>I wonder what's the reason of changing vq state on the hardware
> >>here. I think we can defer it to set_status().
> >>
> >I can defer this to set status.
> >
> >I just wonder if it is possible that the core vdpa driver may call this
> >function with ready equals false and after some time call it with ready
> >equals true.
> 
> 
> Good point, so I think we can keep the logic. But looks like the
> code can not work if ready equals false since it only tries to
> modify vq state to RDY.
>

The point is that you cannot modify the virtqueue to "not ready". The
only option is to destroy it and create a new one. This means that if I
get ready equals false after the virtqueue has been created I need to
teardown the driver and set it up again.

Given that, I think your original suggestion to defer this logic is
reasonable.

