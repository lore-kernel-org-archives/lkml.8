Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978D6C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 06:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E51420709
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 06:03:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="tiX2XONw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgHIGD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 02:03:56 -0400
Received: from mail-db8eur05on2065.outbound.protection.outlook.com ([40.107.20.65]:32353
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725988AbgHIGDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 02:03:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XuwwJWpQcfWkM7DrpHmZlVLYaj9FGHcPjD/4NaYWlAHdzGnu+Fl5AfIOYjc/Qc+krdwYS4nwUHfU7cO9OT6lsLXBpHXKCkjPQvRP8C3pGUoRLEMYssM8pP93FqLio32NBfN1lPufulJbR4kGt2retX/Tpd22QUw3SayFJs5cxNMGdWhiXG0f+PlyiA2fMxo7TVHNog4uB/55lKIcCkBQTMk66ASLrneVUHU9usN7vdwDI+tdFHn8wNIen2jdtAdtZtoFJeLMb8PDgUQnZqtpQirdca4leWB8FM83Owyg45UcsxO7uQcJE8nVAUUT0BY/bnGq0LFbTO2Z61R6FCzDVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbyFeOv4XJDOQxp02tYKHwB7XFIsj01MWS0Nn32Zubw=;
 b=GYI1qaiT8DKy3FYSB2GaFUSVkfq271oAmifpskzESpmohClbImm4bbySt/p+yv3nJCc24RyVZxR0updlmIhVwEDubOC4Wuq067dziL7YQj35iwhK9+QoGiM1t718Smmp7MUyA4EPBLiCm1HYkw0jGfTkdhJI4Ycul4MGe9fqD46fta7jdEXcWfHne2o9BzRVNNPS8PdFFfILwDBaJ9pHby3IuS7epuXAWHkzGDUIkeyLXuAaGNTwlJe+cucSagIpgBNw3TjbhQgWTeaMOFp/C0d2N17w+jxF/NgLi/962mNxvCrHLQf2oiPEeBm8QaL0jH2ygjE/5fwBPgApn5kWlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbyFeOv4XJDOQxp02tYKHwB7XFIsj01MWS0Nn32Zubw=;
 b=tiX2XONwa7yfU0rUYResZ0g0e169WPcFB/RDRzaszRsIwUz/jy5l2RxvDHXooP4QaeqZCetgeUQu5/kGhGvyph0xavtkBT7t0fnT1wtBkV4X7Y7eoTV0Le6XmE6dl/pbo0SktjMKcg7QDGEQ5bHeAYDiED9cZrrted7HgM4YfwE=
Authentication-Results: canonical.com; dkim=none (message not signed)
 header.d=none;canonical.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com (2603:10a6:208:b3::15)
 by AM0PR05MB6626.eurprd05.prod.outlook.com (2603:10a6:20b:146::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Sun, 9 Aug
 2020 06:03:51 +0000
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::9186:8b7:3cf7:7813]) by AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::9186:8b7:3cf7:7813%7]) with mapi id 15.20.3261.022; Sun, 9 Aug 2020
 06:03:51 +0000
Date:   Sun, 9 Aug 2020 09:03:47 +0300
From:   Eli Cohen <eli@mellanox.com>
To:     Colin King <colin.king@canonical.com>
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        virtualization@lists.linux-foundation.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] vdpa/mlx5: fix memory allocation failure checks
Message-ID: <20200809060347.GA48369@mtl-vdi-166.wap.labs.mlnx>
References: <20200806160828.90463-1-colin.king@canonical.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806160828.90463-1-colin.king@canonical.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: AM0PR04CA0020.eurprd04.prod.outlook.com
 (2603:10a6:208:122::33) To AM0PR05MB4786.eurprd05.prod.outlook.com
 (2603:10a6:208:b3::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mtl-vdi-166.wap.labs.mlnx (94.188.199.18) by AM0PR04CA0020.eurprd04.prod.outlook.com (2603:10a6:208:122::33) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.18 via Frontend Transport; Sun, 9 Aug 2020 06:03:51 +0000
X-Originating-IP: [94.188.199.18]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7ec00f12-38da-4b89-d036-08d83c29fd74
X-MS-TrafficTypeDiagnostic: AM0PR05MB6626:
X-LD-Processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR05MB6626C19213B54B150576F2DEC5470@AM0PR05MB6626.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vbfnW3AT1UP0GXbODSTqmeriYKF6yBQta70tejl2ba6IsFtU5x2uB3U8j097w6kySOcO3yzPSqqMTbeSH0Ske/yv+03+o0vcUir/F9rhwl7CNIHlpWjw/jHPWpj5RQZ0df9ZpiJMlpfZyu8Ver5av7ugNziY0Kiv/A51YZ43ZpIeqPqm6w0ITyoL7Rjtc6CRd4VzZHab0iXIMcXRdpw5l8oNggiMrhCk36g0tL+QB7//j3gd3/bFUpZnmO0+i+FvvxBRTuowRAQLKk/LpUDqmaQR0aCPqY99J9Vq5pG0gxpK6QFMJiJbpTsn6kUpLrDe8S7d/jsoZmdi9P7jlsXwyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB4786.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(66476007)(66946007)(66556008)(5660300002)(6666004)(956004)(52116002)(1076003)(7696005)(186003)(26005)(54906003)(316002)(6506007)(83380400001)(16526019)(86362001)(2906002)(33656002)(4326008)(8676002)(8936002)(9686003)(508600001)(6916009)(55016002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: c/7fNNenNhaTGP/h7m6PFxW0QTbIRUjwetd39b31yu88cvafynoEqpY/zyC7CDT4PVoPtXT5KWVK+bRSzYjyqIzGasWMxCPdFeSjblfdu1zeycl7CyF1GUMIbpQtKj+ToaDb9vq+CAbBdVVIrDQAwCGTycboUP9zoJEbO8C3m81UDFrvSqxQUFDV8iLkyplq9ewfWuVvNUHJhshr5GXWM3U73rn40/rs9rCe7hx596WPRQP0ijC0ilmAnhrYpgENujotaPIfCvK1/WVxMaV/Q7kUdfqA2rtDvC+mhYdOMmNz66wXQ56D0RCt7trWNziJMBaIu7GH7Hyjp0xVhXSQCQjm83q9NLmbPa+zDbxssPG/9fv1mN1Z8UYFBcteXcAcLEnNlL4abERlPMT3SI2Xvh7rBSdnSd+JZ7u52NkMcLh8DU6/9ctWYpCDG91wz8B2EOK3w7XEVfwezac3cH/Nfvj/TRtxBZl8kfiRsNEw/yWJ//+uOHTWTj6L10b3EzSS78I5UFeHvD/Kq1ojaMtg5RfS4dXej3fny+XcdZaL4rxpjoyUEhAc8t/xMbuPmYCRK9Imhiv0Y/Kd8Cu9z9TVHEL+J/Bl10HAmZNuihWdJGwnvrG5v+W4WsnPgCrsVwqHA8B4bqyuUMHCQo/dZ2Kqtg==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ec00f12-38da-4b89-d036-08d83c29fd74
X-MS-Exchange-CrossTenant-AuthSource: AM0PR05MB4786.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2020 06:03:51.8171
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uf0u8fHYmZPWx1CA1UUv7EOBpWEXoaSHn06evCjoRIcOZ5rZ77Q6ly2D0bHuCYNpahw3Gv7ijZwFnN6406QeMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6626
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 05:08:28PM +0100, Colin King wrote:
Acked by: Eli Cohen <eli@mellanox.com>

> From: Colin Ian King <colin.king@canonical.com>
> 
> The memory allocation failure checking for in and out is currently
> checking if the pointers are valid rather than the contents of what
> they point to. Hence the null check on failed memory allocations is
> incorrect.  Fix this by adding the missing indirection in the check.
> Also for the default case, just set the *in and *out to null as
> these don't have any thing allocated to kfree. Finally remove the
> redundant *in and *out check as these have been already done on each
> allocation in the case statement.
> 
> Addresses-Coverity: ("Null pointer dereference")
> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 3ec44a4f0e45..55bc58e1dae9 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -867,7 +867,7 @@ static void alloc_inout(struct mlx5_vdpa_net *ndev, int cmd, void **in, int *inl
>  		*outlen = MLX5_ST_SZ_BYTES(qp_2rst_out);
>  		*in = kzalloc(*inlen, GFP_KERNEL);
>  		*out = kzalloc(*outlen, GFP_KERNEL);
> -		if (!in || !out)
> +		if (!*in || !*out)
>  			goto outerr;
>  
>  		MLX5_SET(qp_2rst_in, *in, opcode, cmd);
> @@ -879,7 +879,7 @@ static void alloc_inout(struct mlx5_vdpa_net *ndev, int cmd, void **in, int *inl
>  		*outlen = MLX5_ST_SZ_BYTES(rst2init_qp_out);
>  		*in = kzalloc(*inlen, GFP_KERNEL);
>  		*out = kzalloc(MLX5_ST_SZ_BYTES(rst2init_qp_out), GFP_KERNEL);
> -		if (!in || !out)
> +		if (!*in || !*out)
>  			goto outerr;
>  
>  		MLX5_SET(rst2init_qp_in, *in, opcode, cmd);
> @@ -896,7 +896,7 @@ static void alloc_inout(struct mlx5_vdpa_net *ndev, int cmd, void **in, int *inl
>  		*outlen = MLX5_ST_SZ_BYTES(init2rtr_qp_out);
>  		*in = kzalloc(*inlen, GFP_KERNEL);
>  		*out = kzalloc(MLX5_ST_SZ_BYTES(init2rtr_qp_out), GFP_KERNEL);
> -		if (!in || !out)
> +		if (!*in || !*out)
>  			goto outerr;
>  
>  		MLX5_SET(init2rtr_qp_in, *in, opcode, cmd);
> @@ -914,7 +914,7 @@ static void alloc_inout(struct mlx5_vdpa_net *ndev, int cmd, void **in, int *inl
>  		*outlen = MLX5_ST_SZ_BYTES(rtr2rts_qp_out);
>  		*in = kzalloc(*inlen, GFP_KERNEL);
>  		*out = kzalloc(MLX5_ST_SZ_BYTES(rtr2rts_qp_out), GFP_KERNEL);
> -		if (!in || !out)
> +		if (!*in || !*out)
>  			goto outerr;
>  
>  		MLX5_SET(rtr2rts_qp_in, *in, opcode, cmd);
> @@ -927,16 +927,15 @@ static void alloc_inout(struct mlx5_vdpa_net *ndev, int cmd, void **in, int *inl
>  		MLX5_SET(qpc, qpc, rnr_retry, 7);
>  		break;
>  	default:
> -		goto outerr;
> +		goto outerr_nullify;
>  	}
> -	if (!*in || !*out)
> -		goto outerr;
>  
>  	return;
>  
>  outerr:
>  	kfree(*in);
>  	kfree(*out);
> +outerr_nullify:
>  	*in = NULL;
>  	*out = NULL;
>  }
> -- 
> 2.27.0
> 
