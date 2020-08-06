Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78DAC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EBE220786
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 17:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="IX+R1haZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729911AbgHFREE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 13:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729780AbgHFRC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 13:02:59 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on062a.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0c::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05738C0D9417
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 08:42:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q68sFDqeicXqZLoJq6AN1fxkspempTr/wAlKN85CyEjPGaqjko4JFHIW7uM47ZHmgryj9QO2DHST74gyZv5ERQFxmvP8SdQtFXzR26Qf1o0ECtXy2a0cpIMD/59eE5XdiBiNzBpQ3+iVRo1wBRHKzfOEA0y1KPjoaTDb62/DqgG4YEmueoxdf9iDuVpHY5lQQICjj0lZ67XuRt8r3QBfE0nK/QltURT3QllbO+z5c8j64PbH0mDe4uc8FM6grGE8aDP4TG/iipvn1Gvm43WnGktVIl3FuiuPutvvhddDq6eOfWo9Kx0ea3+PT2oNYsKemSENpVllkf1IXGs9HeOQ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xATL23JgWRDNPN/Rx4UHfCLuvGa7GjWtqZ7knl9jIBo=;
 b=BBBDtJjkiGBDrMNYN9Jt/O9w7msaMB6Zyf98rv1KiQBdcVVWlTjyteug0TfaDCA3ezBi8ZlSCnE0PlWT3ej+2xrf0T8ipgoCigcrtKkU8HsxmutUFhybxC+VbLgQRqunulWhr8wq2Eqe+Suvgp48fn+gXaePoxKiF4qbOqPKs3Smb6d7XhYvO9rUdN0KAVGEs8hK2JXa0ReKIj+0OuG57BM8jckqe6qc7LdFuQfXWU6YUIbOEJCmr0f9/VOVw0c/Br+gZ2eDTbTxqbbGV9cH6uPDPZ0F0wbOla7yHDKsvdcoojun/D4iDTmPjpANEb8v5bzSZavzfUt6OwGUqLmnMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xATL23JgWRDNPN/Rx4UHfCLuvGa7GjWtqZ7knl9jIBo=;
 b=IX+R1haZpI2tmWQhVr+qfy7QzMrFQ13UN0v3hROGA7s/g14aynwfUK23JjYZs6HTpskyM0NvtB5j/Fb6Suoly/AIfvgYvi3GWVn7eBw9dh1JbUvupFVckdG3HYluQWmC11WznfDr0TcqU812ZEwMqwQWEfI5401I3g/ZwuBb2Aw=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com (2603:10a6:208:b3::15)
 by AM4PR05MB3234.eurprd05.prod.outlook.com (2603:10a6:205:11::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.21; Thu, 6 Aug
 2020 12:03:59 +0000
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::9186:8b7:3cf7:7813]) by AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::9186:8b7:3cf7:7813%7]) with mapi id 15.20.3239.021; Thu, 6 Aug 2020
 12:03:59 +0000
Date:   Thu, 6 Aug 2020 15:03:55 +0300
From:   Eli Cohen <eli@mellanox.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, rob.miller@broadcom.com,
        lingshan.zhu@intel.com, eperezma@redhat.com, lulu@redhat.com,
        shahafs@mellanox.com, hanand@xilinx.com, mhabets@solarflare.com,
        gdawar@xilinx.com, saugatm@xilinx.com, vmireyno@marvell.com,
        zhangweining@ruijie.com.cn
Subject: Re: [PATCH 1/4] vdpa: introduce config op to get valid iova range
Message-ID: <20200806120354.GA171218@mtl-vdi-166.wap.labs.mlnx>
References: <20200617032947.6371-1-jasowang@redhat.com>
 <20200617032947.6371-2-jasowang@redhat.com>
 <20200805085035-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805085035-mutt-send-email-mst@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: AM0PR02CA0096.eurprd02.prod.outlook.com
 (2603:10a6:208:154::37) To AM0PR05MB4786.eurprd05.prod.outlook.com
 (2603:10a6:208:b3::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mtl-vdi-166.wap.labs.mlnx (94.188.199.18) by AM0PR02CA0096.eurprd02.prod.outlook.com (2603:10a6:208:154::37) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.18 via Frontend Transport; Thu, 6 Aug 2020 12:03:57 +0000
X-Originating-IP: [94.188.199.18]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3fcc5654-b05f-4488-e7f7-08d83a00cd10
X-MS-TrafficTypeDiagnostic: AM4PR05MB3234:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM4PR05MB32344D750858047EE266F118C5480@AM4PR05MB3234.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1091;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FyXBeZ6l4ISI/WhIUFX6Ih5OWagcVWn/oPbDcjw7+m60w95LxUhRBihVGFcl2MKPrulUUKDX3K0dH4WrpynoVvyOd7JD4X9fs4ecWdfL1Mif0Za3wDfLn6cFJ6+yELrblUXrsAyWdkgTAdYBC1C5ac1KBY5P909W0x1eNVB8HF0lJHaD1/168B6aH5ulEJ3e2UuvYENEKhn3psMPKS7VSvQfcpALuaQ8DGFRs/zFdGMkDhvBbQVg61Q6UZ/VI8d0zWxCvMpI8JxfjNDokTLbuFnsaID9z8zNd6z9AyUhEKsv4dh3AzcSDGVsFLMfEmL1k3vtpGXa7Lj6Ohg7nhS5/Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB4786.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(366004)(136003)(396003)(39860400002)(55016002)(83380400001)(956004)(66476007)(2906002)(8936002)(6916009)(66946007)(86362001)(1076003)(316002)(9686003)(7416002)(33656002)(52116002)(6506007)(478600001)(4326008)(5660300002)(8676002)(66556008)(16526019)(7696005)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: G2756I9xJ+PDCn6b/32qMkNvueeFAxpJLlF6etFL3HBdT3RCdxYq1rI4GC0fzgGt5eLtS1tzRJRAD84xpuxBniqQLLPUm2DQaMXVWOd8FN37eeM/2Qbi7rjXraE5OrDkejOobM6Jy8W9a7uxcLPnW9nstBPLI5kYE/jeNNjMqTPDeWGZqko9zms0jpeeO1kFAbCpM7lok3puiT0J3dCtDPzL0425ZACr2WZDVASJXym9H8HfwgSVkR/ejKAHJbqpKAShybBob9+y5qeyzuAwLHDDoqRLO9DhXDVev+2hvF/6uQC6T4CcKVjVKen6EWHcEApMCBvJOpapQIjny97npJmB8ScwIk4BnOlXhtQ7tMwaR5mf2VKU9VEerHh8AdgDonY9VZ4aYjCrYtBuZ3X9QPaqwPkiDo2uccU+MvLfVqLwKgJFyGqUo8rQe41t4x001xK/KPckcX0+T527cN5BX9KzDLNixcqSrQcrv9VZVBHeRZvFgTSVb4mxb3KvjAzWKhqhmA4Szb8Ejwjlrb9bkg80n7yFiCALIUSQV/K7V066OkOSTZjtmSnpH+llVscGqaISaP9IwgcP2Cd2nPMbXWNh49g1Qp1FJPvlepZl75zXVfoMLLVBZb7mHmyCCdBr4nHANWlcJloyBpLRvmOHgg==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fcc5654-b05f-4488-e7f7-08d83a00cd10
X-MS-Exchange-CrossTenant-AuthSource: AM0PR05MB4786.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2020 12:03:59.0182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZRGGHHo6zZqGHn9kG5BgtwL+z2FscKxyw/p/6e6qi1qVBdoeFs51f3LqSY01+wnN/bOw5+Noe+oMM9WnZQvZqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR05MB3234
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 08:51:56AM -0400, Michael S. Tsirkin wrote:
> On Wed, Jun 17, 2020 at 11:29:44AM +0800, Jason Wang wrote:
> > This patch introduce a config op to get valid iova range from the vDPA
> > device.
> > 
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  include/linux/vdpa.h | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> > 
> > diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> > index 239db794357c..b7633ed2500c 100644
> > --- a/include/linux/vdpa.h
> > +++ b/include/linux/vdpa.h
> > @@ -41,6 +41,16 @@ struct vdpa_device {
> >  	unsigned int index;
> >  };
> >  
> > +/**
> > + * vDPA IOVA range - the IOVA range support by the device
> > + * @start: start of the IOVA range
> > + * @end: end of the IOVA range
> > + */
> > +struct vdpa_iova_range {
> > +	u64 start;
> > +	u64 end;
> > +};
> > +
> 
> 
> This is ambiguous. Is end in the range or just behind it?
> How about first/last?

It is customary in the kernel to use start-end where end corresponds to
the byte following the last in the range. See struct vm_area_struct
vm_start and vm_end fields
> 
> 
> 
> >  /**
> >   * vDPA_config_ops - operations for configuring a vDPA device.
> >   * Note: vDPA device drivers are required to implement all of the
> > @@ -134,6 +144,9 @@ struct vdpa_device {
> >   * @get_generation:		Get device config generation (optional)
> >   *				@vdev: vdpa device
> >   *				Returns u32: device generation
> > + * @get_iova_range:		Get supported iova range (on-chip IOMMU)
> > + *				@vdev: vdpa device
> > + *				Returns the iova range supported by the device
> >   * @set_map:			Set device memory mapping (optional)
> >   *				Needed for device that using device
> >   *				specific DMA translation (on-chip IOMMU)
> > @@ -195,6 +208,7 @@ struct vdpa_config_ops {
> >  	void (*set_config)(struct vdpa_device *vdev, unsigned int offset,
> >  			   const void *buf, unsigned int len);
> >  	u32 (*get_generation)(struct vdpa_device *vdev);
> > +	struct vdpa_iova_range (*get_iova_range)(struct vdpa_device *vdev);
> >  
> >  	/* DMA ops */
> >  	int (*set_map)(struct vdpa_device *vdev, struct vhost_iotlb *iotlb);
> > -- 
> > 2.20.1
> 
