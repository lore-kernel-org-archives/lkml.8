Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F29C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 05:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98842207DD
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 05:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="tSgdldUE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgGTFTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 01:19:49 -0400
Received: from mail-am6eur05on2083.outbound.protection.outlook.com ([40.107.22.83]:51809
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725287AbgGTFTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 01:19:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bILze/TnnIO+ZkhzvJjg19QZbWnBYKtPJf2SFaTThXQwa0WRD4sgJagXcT6hhnnlgST4YQRcmlrcyflzePYM016C5fWh/2L7RgCYsWqx8yTD5mHXNXls30KVAJvjkfPwAnQQlmozIYii3iitax4YOOmxXY/YfXUy3o/p9t4SXj/GLiCne0ojwcmfTUNLb1LxOKRy95c4JwhfwdfZ5yy/LhOhknRHDSvPiblCBK/3FB4/VSxuzPuDZbsJLPh2xWI1IM1S18codEerSr9n+Egx9NAa9nTg+W4BbhHpg9rFcJ8nfjYbSUu4zVZIjHVY5tsROC+pALnGvqd3XfXmc/7XSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkGS3oBnWPmH7USF1p1dYNJ6wG+q8/gO873T7sBMXTw=;
 b=O52yZb723JDyrnP9rIXHIp5K4gQKEnE/DG7g+ckH6kzAZdtNJiRjXLdQZAvyYKHOFCgZJGLndkHZWHas+zWFvT1YjaHG36PbQK6NBufZ8LjlRsZ3y97kLJ8cUZ0RC6LKqHJgUa7vo2UNq5ux3moH8L1gjj8O5wE5iepRw2x0A5H3IB3/j76hx/Sth5ZiOKgAglWFilV8ejPT5mI6vaRvf2l/SCX4DdtDTmhsxAc1WvbI/btifD9k01K0BvpTc6EGhpVQtgZeMhXmuG2aC9VTiE6idHN8ijP9NW0QzsXYmqvrl4nEhzZF1Wvr9cGYstlQdkrdKzZ1gmoQXsTvxTKTjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hkGS3oBnWPmH7USF1p1dYNJ6wG+q8/gO873T7sBMXTw=;
 b=tSgdldUEMXM9zpqqti+bbwXDvvvvtel6/fn6/Mm5YoBmm1iXe4Os0IL8j98Oicq7pvL3cU2Y/0MPfBKG/v/Dw421E4VjP3zohQV3DjeS1ljfrNHvPt40L+lnR2quAiRUIOnCqfKrw7MS68HmmmgviCbYH9loZzK+e6bOaSp3rqM=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com (2603:10a6:208:b3::15)
 by AM4PR0501MB2228.eurprd05.prod.outlook.com (2603:10a6:200:45::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Mon, 20 Jul
 2020 05:19:44 +0000
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::e00a:324b:e95c:750f]) by AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::e00a:324b:e95c:750f%7]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 05:19:44 +0000
Date:   Mon, 20 Jul 2020 08:19:40 +0300
From:   Eli Cohen <eli@mellanox.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     mst@redhat.com, virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, shahafs@mellanox.com,
        saeedm@mellanox.com, Parav Pandit <parav@mellanox.com>,
        Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [PATCH vhost next 10/10] vdpa/mlx5: Add VDPA driver for
 supported mlx5 devices
Message-ID: <20200720051940.GA116013@mtl-vdi-166.wap.labs.mlnx>
References: <20200716072327.5359-1-eli@mellanox.com>
 <20200716072327.5359-11-eli@mellanox.com>
 <454850cc-269b-72aa-4511-2bf793a215cc@redhat.com>
 <20200716115428.GC186790@mtl-vdi-166.wap.labs.mlnx>
 <b85ecb97-2120-f63f-f5f4-01d90f88d666@redhat.com>
 <20200718194902.GA52765@mtl-vdi-166.wap.labs.mlnx>
 <ed10cb66-174f-ec5c-8043-4e18de65fb99@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed10cb66-174f-ec5c-8043-4e18de65fb99@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: AM3PR07CA0075.eurprd07.prod.outlook.com
 (2603:10a6:207:4::33) To AM0PR05MB4786.eurprd05.prod.outlook.com
 (2603:10a6:208:b3::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mtl-vdi-166.wap.labs.mlnx (94.188.199.18) by AM3PR07CA0075.eurprd07.prod.outlook.com (2603:10a6:207:4::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.17 via Frontend Transport; Mon, 20 Jul 2020 05:19:43 +0000
X-Originating-IP: [94.188.199.18]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 95094744-bbe6-4d2d-0ba1-08d82c6c8340
X-MS-TrafficTypeDiagnostic: AM4PR0501MB2228:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM4PR0501MB22288E2767EE01AA762B0BE7C57B0@AM4PR0501MB2228.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DGQ5gbndmgYXrpQxZItLu5Mvqm57+CcAVi7uwPMo79WgW7qIFh4yMbRSfm3up+Upavgne6ziXvhDdL7T8WjRQXWdEsHrZN3a8RSortO/ZDsJDD3RmF8gkso8rsmLNM6/cd3+fg1oe09DHzJI7P8MILDhjGA8GpnI+neRK7p25K7YYcR+z1kOXrUbRddhFZ4iu2cDL4OFMNPh7uoC3WlEewejLict6SlWRKXfx5kV4T5amfbgsFyxmU8hFsNLp13MqwkekgKkt8gEfHt3Rtm1n4LPCGjeJj6qsLZCtVl3egX+9HicDXNMImElu5B6dFjKNbuNhdccJPwg8qDTZGUcbQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB4786.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(366004)(26005)(5660300002)(8676002)(8936002)(316002)(55016002)(66556008)(66946007)(54906003)(9686003)(478600001)(186003)(16526019)(66476007)(52116002)(7696005)(4326008)(2906002)(86362001)(1076003)(956004)(6916009)(6506007)(83380400001)(33656002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: fGNzDJXk7fJvomHs6MjDrugU0VZGjxRdzQHU+QMNtBS1gZXMtCWLAU2WkhCfQ9IkS8J98+R2RHg7gdQ8sSozqamXsZC55CrB4wTxhg4rVDuIUIloNuO0Y5AhbDiKtAfQ/oeTL4QXLqad3Fv0mfWzqjkNQGIuxK3t2Gz/r5ZR+kSjtWwcXvqkMFigZA7Sy3+M7aclghW1TGwaJZDwC3NHwMHiqvPfM0SOvGJYfzwR35IzFwXY0PgHE0/Ng/MT/DucTuyPRB+Cu03cN632rIf/7Ab+zF7V+nnYFOrGh4IpY4UviW1GVTP2icJcalETFahNFmnEP8v0qw+UQ9IGS+lRzEtBMy9vLuy5L4PCITAClp//DA7ULFyIwnsuI5Og3L3qwjGrQhkJtQI/lG/uxTJTaN6i6HxesVk/Bj3RCFap3zBA5U+GuOKq0GuUx7ayGoovfMLsHD47iLSBYAW9rVkSLko8iXaxUTx/Wrjdzq82qCw=
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95094744-bbe6-4d2d-0ba1-08d82c6c8340
X-MS-Exchange-CrossTenant-AuthSource: AM0PR05MB4786.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 05:19:44.5076
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJGHsou9TtS7Jtnpx3378LLsZkOJTeQINvImhLl1RLqafeKDCyzl6OhUk4EY9Ed9E9Yg2S8GvLquzLi7q5usPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0501MB2228
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 12:12:30PM +0800, Jason Wang wrote:
> 
> On 2020/7/19 上午3:49, Eli Cohen wrote:
> >On Fri, Jul 17, 2020 at 04:57:29PM +0800, Jason Wang wrote:
> >>>Looks like checking intialized is enough. Will fix this.
> >>>>>+
> >>>>>+static void mlx5_vdpa_set_vq_ready(struct vdpa_device *vdev, u16 idx, bool ready)
> >>>>>+{
> >>>>>+	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
> >>>>>+	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
> >>>>>+	struct mlx5_vdpa_virtqueue *mvq = &ndev->vqs[idx];
> >>>>>+	int err;
> >>>>>+
> >>>>>+	if (!mvq->ready && ready && mvq->fw_state != MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY) {
> >>>>>+		err = modify_virtqueue(ndev, mvq, MLX5_VIRTIO_NET_Q_OBJECT_STATE_RDY);
> >>>>>+		if (err) {
> >>>>>+			mlx5_vdpa_warn(mvdev, "failed to modify virtqueue(%d)\n", err);
> >>>>>+			return;
> >>>>>+		}
> >>>>>+	}
> >>>>I wonder what's the reason of changing vq state on the hardware
> >>>>here. I think we can defer it to set_status().
> >>>>
> >>>I can defer this to set status.
> >>>
> >>>I just wonder if it is possible that the core vdpa driver may call this
> >>>function with ready equals false and after some time call it with ready
> >>>equals true.
> >>
> >>Good point, so I think we can keep the logic. But looks like the
> >>code can not work if ready equals false since it only tries to
> >>modify vq state to RDY.
> >>
> >The point is that you cannot modify the virtqueue to "not ready".
> 
> 
> Is this a hardware limitation of software one?

Sorry, but I was not accruate in my statement above. You can suspend the
hardware VQ but you cannot mover out of suspend back to ready.
> 
> I'm asking since we need support live migration. But a questions is
> how to stop the device but not reset, since we need get e.g
> last_avail_idx from the device.
> 
> It could be either:
> 
> 1) set_status(0)
> 2) get_vq_state()
> 
> or
> 
> 1) set_queue_ready(0)
> 2) get_vq_state()
> 

This can work.

> Set_status(0) means reset the virtio device but last_avail_idx is
> something out of virtio spec. I guess using set_queue_ready() is
> better.
> 
> What's you opinion?

So if the intention to set ready(0) as a preliminary state for live
migration then we're ok. We just need to keep in mind that there's no
way of suspend but destroy the hardware vq.

> 
> Thanks
> 
> 
> >  The
> >only option is to destroy it and create a new one. This means that if I
> >get ready equals false after the virtqueue has been created I need to
> >teardown the driver and set it up again.
> >
> >Given that, I think your original suggestion to defer this logic is
> >reasonable.
> >
> 
