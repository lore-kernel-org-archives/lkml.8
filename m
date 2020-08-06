Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90869C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:36:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB76D204FD
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 16:36:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="reVsNquZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbgHFQgF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 12:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728852AbgHFQfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 12:35:16 -0400
Received: from EUR03-DB5-obe.outbound.protection.outlook.com (mail-db5eur03on0606.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe0a::606])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AC3C00215D
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 09:02:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RD8xgo43a6T2SGFjAcWDjV+r4fjzoY8b6B8Mxy98sWXkZNyIEDqP9gqLZuLaF94uXmsKvOzHM5wBYDt33M2G0wqjQNf5bER2SYJwoE7ygSgeoicrhHYwXuzJiMSbeYMx+ZetpH1S0iX63tcZ7Z4f6ds4h/b5HyVAXt7oOv5SrmxTTjzG1u3EBToIkN+zo4VGFWAD/nu85CCf7eIe8BzAlWTn+GS8bwtIk6S2Zt2yLS15/BBqY3rvNumTBX9g4GkRhy/bn3PxxiuQzCytJDrRtDeQ394w1fDQ2Ib/tzf03RrSB0Ctfo1Q6AtYEP+j5AZtmhBK8B7/cVC07oI8bKLWFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLqJ0miimQRl3JojoWiGKToPRHUPoM8wNVkepgL6SQg=;
 b=lnXMYx7V9iSBw3xE6NsSk5cxP553ydfP74bwFG4yUE8btt0npzVlBv8HVnzi3kjeNGuSqW4tBp00M90djfVe0yJPtVG2IrcapN+DQIrIW9oD+AjB+SJZAdyARoAOoO14cdK2+2fpWHs2f/ZBKJ0Eua0JhXUu+Zs9shF8aSVAzOrFVOE5GiGWqj/YSZmaJ1xc4ZOIlhGGaqrvxptekaqiGbXDLWgfLzNuf1DtCdMMB16rhOV2jWBc914FsmRnz4RKDSTOL801VbbRsoX3hDnr9RKPsqqUuk6pDyLT8bXzypiJHRkxtUAUM1hDUIZd/fcNTMTShe3Y0fAzXtVz6Lnitg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DLqJ0miimQRl3JojoWiGKToPRHUPoM8wNVkepgL6SQg=;
 b=reVsNquZ1rhlqHKc/+DtjcfpPD4xs4VfGbUVvXNfDDnKDdu3Yc1uXV2e7vzh95DrHSUNjVfvCJ71vL4WQvpBwzNaziCSTkMTlvAVQ1uWzkvDA5XMOl6HB3+5evvJWbCYYUJY/XuMRVllSBgpgmGGu0PvKiZuk0btZyMY1Zci4Rw=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com (2603:10a6:208:b3::15)
 by AM0PR05MB4900.eurprd05.prod.outlook.com (2603:10a6:208:cb::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.21; Thu, 6 Aug
 2020 12:10:10 +0000
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::9186:8b7:3cf7:7813]) by AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::9186:8b7:3cf7:7813%7]) with mapi id 15.20.3239.021; Thu, 6 Aug 2020
 12:10:10 +0000
Date:   Thu, 6 Aug 2020 15:10:02 +0300
From:   Eli Cohen <eli@mellanox.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     "mst@redhat.com" <mst@redhat.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rob.miller@broadcom.com" <rob.miller@broadcom.com>,
        "lingshan.zhu@intel.com" <lingshan.zhu@intel.com>,
        "eperezma@redhat.com" <eperezma@redhat.com>,
        "lulu@redhat.com" <lulu@redhat.com>,
        Shahaf Shuler <shahafs@mellanox.com>,
        "hanand@xilinx.com" <hanand@xilinx.com>,
        "mhabets@solarflare.com" <mhabets@solarflare.com>,
        "gdawar@xilinx.com" <gdawar@xilinx.com>,
        "saugatm@xilinx.com" <saugatm@xilinx.com>,
        "vmireyno@marvell.com" <vmireyno@marvell.com>,
        "zhangweining@ruijie.com.cn" <zhangweining@ruijie.com.cn>
Subject: Re: [PATCH 1/4] vdpa: introduce config op to get valid iova range
Message-ID: <20200806121002.GA171574@mtl-vdi-166.wap.labs.mlnx>
References: <20200617032947.6371-1-jasowang@redhat.com>
 <20200617032947.6371-2-jasowang@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200617032947.6371-2-jasowang@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: AM0PR05CA0075.eurprd05.prod.outlook.com
 (2603:10a6:208:136::15) To AM0PR05MB4786.eurprd05.prod.outlook.com
 (2603:10a6:208:b3::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mtl-vdi-166.wap.labs.mlnx (94.188.199.18) by AM0PR05CA0075.eurprd05.prod.outlook.com (2603:10a6:208:136::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15 via Frontend Transport; Thu, 6 Aug 2020 12:10:08 +0000
X-Originating-IP: [94.188.199.18]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ef9a659e-936a-47a2-4194-08d83a01aa33
X-MS-TrafficTypeDiagnostic: AM0PR05MB4900:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB4900A014E6839CE2227D2131C5480@AM0PR05MB4900.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kHanc3JHLU/I1xq/QrHA4qMmqSDF+tBPez6FGK0a3a+17tc0NZ/AVuT49eQZwoMpPtXysyM3NnRgmzYKkrbhRO+xNIiWunKiY8ZvUsfMpTwaKjiz2LQB+4Eazgpm/9QknQhCOhJANnj3TfQIvZ5anpztVTjPwxTr/iq7T5nv7AHY6eOUzTZnBjzOzYqis6dN3EQW2avtlLnBAQu63GEQ95fMgbM8GFiZyOU4GfQ+sd4YaLt6fItkE7PjxWRnrvkQP6AcgeGYqY7GAYye6r7EZ0c0ka+SAr25okNSd0x7+3hW6lZL996S2Dinnap9NljJy8ni5O4IDqzDu3mv2ctGJw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB4786.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(136003)(366004)(376002)(346002)(26005)(186003)(6506007)(66556008)(52116002)(66946007)(7696005)(83380400001)(956004)(1076003)(54906003)(16526019)(33656002)(66476007)(5660300002)(86362001)(6666004)(316002)(4326008)(2906002)(7416002)(478600001)(8676002)(9686003)(55016002)(6916009)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: X0pl5mAtk+FTVMqFnpy41em+Qof4ftxxZZGaOnV7i/dFbs1/+WUh8Ajd1yArPlwpI8ZHnyf7wU5Ae++C/iqPYlP5FheDodcXH1aUTERK9cAsm9kSCtBgz7OCQew+ydVYPC1FDAo1pEh5JlWlvNlx2SQg9bmQ8FZqUj6DWSi0iYJpvcgYJF6MU4YLjomWaFssnNJa9aaf2y+bmrvf0NK+NRk5pEN8JckXDW0OdmweFJuyykDA15z4Su+yT49jrKzuxormlS1SOG4j6HBBOhE5Bpq96rWsBAmPfUjKgME7Zz3f9jhRgKJy36wV7FmYxn3Ii1FGsMc9q9WGR/kKYQPUgRrUdASVjly/5DEYVoe1GZ2MSZsRYq1f8nQuZ3gMVqwXz9JVKA8CGn/DMCh8+VpnTFWRG6ghC+swolXaEJ7TGNPXifLntNV3xh02RmdCrsiIZHTIDYTT6EywfJd5nIcb3dxOqXaSgbbd4pnISwQLu/6aaumg+DzR8roXoZGLthlBgCRU7To7dz3ul4H7+2ODknQgcW8j8u/+Gm6GYgjonqnGxH5tu9u4NXZZGBpoYwLQ25/5P6irNCNI3plFMYxrpinmG6MiF+M19f9KhzkBgboqqg5g7mI+pwHUDSztvjWeZsRt89OviZr9bGokB3Xl7w==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef9a659e-936a-47a2-4194-08d83a01aa33
X-MS-Exchange-CrossTenant-AuthSource: AM0PR05MB4786.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2020 12:10:10.0457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mFAkiKODoRNjNaUipZ6P4IeGOI5Jv5+VdwNd0n/l8WRtC2iOws8feC0YKuSKGuuDFHFXtOlteG9piqUsF5Fnig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB4900
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 06:29:44AM +0300, Jason Wang wrote:
> This patch introduce a config op to get valid iova range from the vDPA
> device.
> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  include/linux/vdpa.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
> index 239db794357c..b7633ed2500c 100644
> --- a/include/linux/vdpa.h
> +++ b/include/linux/vdpa.h
> @@ -41,6 +41,16 @@ struct vdpa_device {
>  	unsigned int index;
>  };
>  
> +/**
> + * vDPA IOVA range - the IOVA range support by the device
> + * @start: start of the IOVA range
> + * @end: end of the IOVA range
> + */
> +struct vdpa_iova_range {
> +	u64 start;
> +	u64 end;
> +};
> +

What do you do with this information? Suppose some device tells you it
supports some limited range, say, from 0x40000000 to 0x80000000. What
does qemu do with this information?

>  /**
>   * vDPA_config_ops - operations for configuring a vDPA device.
>   * Note: vDPA device drivers are required to implement all of the
> @@ -134,6 +144,9 @@ struct vdpa_device {
>   * @get_generation:		Get device config generation (optional)
>   *				@vdev: vdpa device
>   *				Returns u32: device generation
> + * @get_iova_range:		Get supported iova range (on-chip IOMMU)
> + *				@vdev: vdpa device
> + *				Returns the iova range supported by the device
>   * @set_map:			Set device memory mapping (optional)
>   *				Needed for device that using device
>   *				specific DMA translation (on-chip IOMMU)
> @@ -195,6 +208,7 @@ struct vdpa_config_ops {
>  	void (*set_config)(struct vdpa_device *vdev, unsigned int offset,
>  			   const void *buf, unsigned int len);
>  	u32 (*get_generation)(struct vdpa_device *vdev);
> +	struct vdpa_iova_range (*get_iova_range)(struct vdpa_device *vdev);
>  
>  	/* DMA ops */
>  	int (*set_map)(struct vdpa_device *vdev, struct vhost_iotlb *iotlb);
> -- 
> 2.20.1
> 
