Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EEAC433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 11:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02E2C20739
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 11:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="Y6cZJrbF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgGPLyh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 07:54:37 -0400
Received: from mail-am6eur05on2058.outbound.protection.outlook.com ([40.107.22.58]:9377
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727081AbgGPLyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 07:54:37 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NkMNz30aOaNlYp7GJq8CQdY2LMnLv5xrwAS8tcOCw5f2JcYSb4W2Gg9X7Be7DJAcoiz0yO5RzylpRMv5K4IfFAaEDkAigfJaGMaFvPokRyx+b3Nuj9dW8jD743oYo64hvsirgnaBOJoYXJJrYlc7hbZ6KsavW4qdulzDl1UObLRO9pYDAMowOEPOHOlZcFxHOQPKQ1tRGbMtL5GQG0GZ8OIKTwntSfqaM65lOXmKODxB+HYJU7xzOHz2HVtw0yeOpqbZ984QYFONuGilyCHgg2bstoaqliuCZGyU5CHKrI20wpNHi9rMECcjqJ3xn/Unz9K8GSiJ/Ao/QMtvxEpIFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HA5UmcahAmLQhCBBSaCse7gtQb+Lboog6Yi0kZPL+p0=;
 b=OzYNyqROTIAsdUmsEJhgNkY3VxPwwy7mJr557A61kRxVm63kxZ5aBf8jnf/2d1dnzdrYi6JbLlLV4borpMax+eJoB2qE3RlhMw1kYSHuDvWikcw37iIq13ur36aUFBF9eUqLJeUk87gFWClk1Yn4QQZ2TY1Nl+CALBUJlurxVMAdXE7wz6bxr5NlzbjEre1ZasmT1adir6lhnsIGlDQnFiIQ2NM6rWqDJLGphuCzTsIYKaIi4BbA+zkuizTa3AiKIMjrmM7p/g6cFXgj0JkUNKbly8MI9NIAE8oqcLYpN3w4MEmjQeNIHh3ABkMnLZ4b9Zsxcd9XVt/8bY/70gf9yw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HA5UmcahAmLQhCBBSaCse7gtQb+Lboog6Yi0kZPL+p0=;
 b=Y6cZJrbFf4zPOwD6kvVs+P7F/C58H+06Bh/mf99IN+/EpbOHZllKOcFT649bslPumishJWt2f4R5rLZGU71VSRv1RI3rrw/LQ7/mfUhgj5YL/ZCxv1d+lQcJuLuDwfYeqTelSLjCa2g3lo8OKZm1+qKXNaCXnVqfWUjjrs1sBhc=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com (2603:10a6:208:b3::15)
 by AM4PR0501MB2226.eurprd05.prod.outlook.com (2603:10a6:200:52::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Thu, 16 Jul
 2020 11:54:33 +0000
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::e00a:324b:e95c:750f]) by AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::e00a:324b:e95c:750f%7]) with mapi id 15.20.3174.025; Thu, 16 Jul 2020
 11:54:32 +0000
Date:   Thu, 16 Jul 2020 14:54:28 +0300
From:   Eli Cohen <eli@mellanox.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        saeedm@mellanox.com, Parav Pandit <parav@mellanox.com>
Subject: Re: [PATCH vhost next 10/10] vdpa/mlx5: Add VDPA driver for
 supported mlx5 devices
Message-ID: <20200716115428.GC186790@mtl-vdi-166.wap.labs.mlnx>
References: <20200716072327.5359-1-eli@mellanox.com>
 <20200716072327.5359-11-eli@mellanox.com>
 <454850cc-269b-72aa-4511-2bf793a215cc@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454850cc-269b-72aa-4511-2bf793a215cc@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: AM0PR10CA0077.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:15::30) To AM0PR05MB4786.eurprd05.prod.outlook.com
 (2603:10a6:208:b3::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mtl-vdi-166.wap.labs.mlnx (94.188.199.18) by AM0PR10CA0077.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:15::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.19 via Frontend Transport; Thu, 16 Jul 2020 11:54:31 +0000
X-Originating-IP: [94.188.199.18]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6006a8cb-624d-4f8e-f8b4-08d8297f00ee
X-MS-TrafficTypeDiagnostic: AM4PR0501MB2226:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM4PR0501MB22263A95FD263E3AA7462521C57F0@AM4PR0501MB2226.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3Wz+9wRLk1/mVuAJFnXR41Qg747lxrAxbUTc6P8lQw3AwrN/ow+2AW3o6AOAXlpsDJmiKAvwyMMI3+7CgIPXhlcVtK9ASX6wqnraMCPfqlvdw/fKRsT0BHynDOppTdd9QB0TA2u4ZkzhVsiGPzUvTv5PFA01KbYxYIcZZK8ts30qkxdyJjy9kN6NMbmF3WGD8EoMLzNq+kadRT3w4zP1H3EC86Fd1P+oLpWQ811lveJdX46v/PHSTcfvhQZNRof94E5M412GJl+rHSv7VHW8kMCwZjVhx8PN1flMCVRZT6m0a6utEijxBZxcoSl1+Rw1FN5aYvleUh00YFQFXgvkJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB4786.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(396003)(376002)(366004)(136003)(4326008)(9686003)(107886003)(316002)(55016002)(6666004)(26005)(16526019)(33656002)(66476007)(956004)(66556008)(8936002)(8676002)(86362001)(66946007)(5660300002)(186003)(2906002)(83380400001)(478600001)(1076003)(7696005)(52116002)(6506007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: VqzNq3bSXnq5Mq/qDwAYxTSHstntgFuoWJLYRmN9lisZoKRacSnZ3qkHYWXWs38Mk+EgzkQkB/3zXmI2sbanowpOJgr+/CTqxYrwLbrfdvgAorFHf0GZ2Kqbq7GQd7uCsX55O+sWXa5ctC7PVX4tekUKScJO4SNDHxtKYdazPOiNcEFJi9Rr5Fdv+vOWN50LBvvKsuNqXsiAE2ZyrkloAb3nUlOPSYKBhl9qo+8+IhF0bN63omOL8rYw9mLS4cwJ+6BQmCRYy5RZci4s7HoFhSoKjbJwtjlSgXuQRcx7TpOClhHcL94J/YCDaPKtlnEoAAYzAq8To0VtEIrT7LGGP9hX/DCIfBeYkCR+g0xX1pBllmDuM2qv8p7FxjwaiDz/OkIfOXEQgC1y83jCeE7rF92QL6FMUkR921zJgRYRb519g7lxKeSdsdj7o0Vu+OlQ3uBLk9wOvuUevbiDDwYC+LZ/Au99sKYefpXKOPtPF5Y=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6006a8cb-624d-4f8e-f8b4-08d8297f00ee
X-MS-Exchange-CrossTenant-AuthSource: AM0PR05MB4786.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 11:54:32.8770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 28Ls2ABtxN7TjWSoYMOI6t2RcZdzSCSEvhbKJomfx7MeIsSoLQdXw1L7RdIP12sXxa+C3KB1IQX92pAmHUYOJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0501MB2226
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 05:14:32PM +0800, Jason Wang wrote:
> 
> >+static void suspend_vqs(struct mlx5_vdpa_net *ndev)
> >+{
> >+	int i;
> >+
> >+	for (i = 0; i < MLX5_MAX_SUPPORTED_VQS; i++)
> >+		suspend_vq(ndev, &ndev->vqs[i]);
> 
> 
> In teardown_virtqueues() it has a check of mvq->num_ent, any reason
> not doing it here?
> 

Looks like checking intialized is enough. Will fix this.
 
> >+
> >+static void mlx5_vdpa_set_vq_ready(struct vdpa_device *vdev, u16 idx, bool ready)
> >+{
> >+	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> >+	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> >+	struct mlx5_vdpa_virtqueue *mvq = &ndev->vqs[idx];
> >+	int err;
> >+
> >+	if (!mvq->ready && ready && mvq->fw_state != MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY) {
> >+		err = modify_virtqueue(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY);
> >+		if (err) {
> >+			mlx5_vdpa_warn(mvdev, "failed to modify virtqueue(%d)\n", err);
> >+			return;
> >+		}
> >+	}
> 
> 
> I wonder what's the reason of changing vq state on the hardware
> here. I think we can defer it to set_status().
> 

I can defer this to set status.

I just wonder if it is possible that the core vdpa driver may call this
function with ready equals false and after some time call it with ready
equals true.


> (Anyhow we don't sync vq address in set_vq_address()).
> 
> 
> >+static u64 mlx5_vdpa_get_features(struct vdpa_device *vdev)
> >+{
> >+	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> >+	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> >+	u16 dev_features;
> >+
> >+	dev_features = MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, device_features_bits_mask);
> >+	ndev->mvdev.mlx_features = mlx_to_vritio_features(dev_features);
> >+	if (MLX5_CAP_DEV_VDPA_EMULATION(mvdev->mdev, virtio_version_1_0))
> >+		ndev->mvdev.mlx_features |= BIT(VIRTIO_F_VERSION_1);
> 
> 
> This is interesting. This suggests !VIRTIO_F_VERSION_1 &&
> VIRTIO_F_IOMMU_PLATFORM is valid. But virito spec doesn't allow such
> configuration.

Will fix
> 
> So I think you need either:
> 
> 1) Fail vDPA device probe when VERSION_1 is not supported
> 2) clear IOMMU_PLATFORM if VERSION_1 is not negotiated
> 
> For 2) I guess it can't work, according to the spec, without
> IOMMU_PLATFORM, device need to use PA to access the memory
> 
> 
> >+	ndev->mvdev.mlx_features |= BIT(VIRTIO_F_ANY_LAYOUT);
I think this should be removed too

> >+	ndev->mvdev.mlx_features |= BIT(VIRTIO_F_IOMMU_PLATFORM);
> >+	if (mlx5_vdpa_max_qps(ndev->mvdev.max_vqs) > 1)
> >+		ndev->mvdev.mlx_features |= BIT(VIRTIO_NET_F_MQ);
Also this, since multqueue requires configuration vq which is not
supported in this version.

> >+
> >+	print_features(mvdev, ndev->mvdev.mlx_features, false);
> >+	return ndev->mvdev.mlx_features;
> >+}
> >+
> >+static int verify_min_features(struct mlx5_vdpa_dev *mvdev, u64 features)
> >+{
> >+	/* FIXME: qemu currently does not set all the feaures due to a bug.
> >+	 * Add checks when this is fixed.
> >+	 */
> 
> 
> I think we should add the check now then qemu can get notified. (E.g
> IOMMU_PLATFORM)

Will do.
> 
> 
> >+}
> >+
> >+#define MLX5_VDPA_MAX_VQ_ENTRIES 256
> 
> 
> Is this a hardware limitation, qemu can support up to 1K which the
> requirement of some NFV cases.
> 

Theoretically the device is limit is much higher. In the near future we
will have a device capability for this. I wanted to stay on the safe side
with this but I can change this if you think it's necessary.
> 
> >+
> >+static void mlx5_vdpa_get_config(struct vdpa_device *vdev, unsigned int offset, void *buf,
> >+				 unsigned int len)
> >+{
> >+	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> >+	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> >+
> >+	if (offset + len < sizeof(struct virtio_net_config))
> >+		memcpy(buf, &ndev->config + offset, len);
> 
> 
> Note that guest expect LE, what's the endian for ndev->config?
This is struct virtio_net_config from include/uapi/linux/virtio_net.h.
Looking there I see it has mixed endianess. I currently don't touch it
but if I do, I should follow endianess guidance per the struct
definition. So I don't think I should care about endianess when copying.

> 
> 
> >+}
> >+
> >+static void mlx5_vdpa_set_config(struct vdpa_device *vdev, unsigned int offset, const void *buf,
> >+				 unsigned int len)
> >+{
> >+	/* not supported */
> >+}
> >+
> >+static u32 mlx5_vdpa_get_generation(struct vdpa_device *vdev)
> >+{
> >+	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> >+
> >+	return mvdev->generation;
> >+}
> >+
> >+static int mlx5_vdpa_set_map(struct vdpa_device *vdev, struct vhost_iotlb *iotlb)
> >+{
> >+	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> >+	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> >+	bool change_map;
> >+	int err;
> >+
> >+	err = mlx5_vdpa_handle_set_map(mvdev, iotlb, &change_map);
> >+	if (err) {
> >+		mlx5_vdpa_warn(mvdev, "set map failed(%d)\n", err);
> >+		return err;
> >+	}
> >+
> >+	if (change_map)
> >+		return mlx5_vdpa_change_map(ndev, iotlb);
> 
> 
> Any reason for not doing this inside mlx5_handle_set_map()?
> 

All memory registration related operations are done inside mr.c in the
common code directory. But change map involves operations on other
objects managed in this file.

> >+
> >+void mlx5_vdpa_remove_dev(struct mlx5_vdpa_dev *mvdev)
> >+{
> >+	struct mlx5_vdpa_net *ndev;
> >+
> >+	mvdev->status = 0;
> 
> 
> This is probably unnecessary.
> 

Right, will remove.
