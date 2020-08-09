Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97FCFC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 05:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D558206C0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 05:53:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="aQHvAj30"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgHIFwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 01:52:45 -0400
Received: from mail-eopbgr60055.outbound.protection.outlook.com ([40.107.6.55]:29827
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725988AbgHIFwn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 01:52:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HjaWuCi7GM3VaMaoX3kMplu5MrzKFR8t9qxVR3lYXZ0vGGY4NmUZEaQS9AYhmmIqYxNHYBHglmYD1uIuVFg3ALHKXsrJ3w4kG57T89yydcky4JyGJxivM0W+OjaH0vCN+awXi/Qne1CVThPWkE0F12Ykm0HM+BJo+mlYI/4I0JPk/TZ2gZteKBxOxZ0OPd76HwuYPJqyn94pwcFd9FzisJeQXpDLwfaW0W1zRqHC9E/FXOgSwvyu6bOjPyL0nE3LJp+Tr2ih50UiD/p3HPVWT972HF337mVScBpgIYmF/eiFM6aHHXjOs/R0i9SgrzU3khsv3Sc7H0VdyqaecpY+kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGrNgJ+ZGLAgjm1bx102sQsyp8H/URx+2lAPHJ/1VkU=;
 b=nNsqepNDCEktPa7zzTmj9e4KZ1NLjrgmb7mGtbCd0Zn1SlWzKlUtI4dzDlOXZ8lCBDeodq/DtobCS3waCYeQKXfxuRpTS7DE2JWoNVhAjbS5St1v64VtYZ/lnnukTokDxcyVuC+dJxBAhZ/v2Ca12QnyPDHu9PQiT3i5XW1Lss0tDyAgc4CXYAPOXm8y8Bx9CRXMU4NEzbwGIXMUmWIjsD3Wx4bYSOu4dTrE7YLpQVRKhypdAXsqzFR+WuAbmqN0rbf/rY5X97ZmoBavBxKtv2KlVmsPJqtV1yiriHUEPu/EIuKO1Oh21E5li6o8Eucr/x94WDbjosFCk/OFZ9/DdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGrNgJ+ZGLAgjm1bx102sQsyp8H/URx+2lAPHJ/1VkU=;
 b=aQHvAj306uhPDcjsDY142mXCaQrOoRR8vvNSKyPE0fKSJcnvJ9C+tYwBprqVrX9GljQjuv7U8d0MZeHTNK17gU2+4XPL/u1LipCJmYnhvI5NdFUge/JOozwo+vv6fgnJsMm1ggSsp5ub7ifoY+aeAqxmftlttxcyJ8elW6ukzws=
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com (2603:10a6:208:b3::15)
 by AM4PR0501MB2692.eurprd05.prod.outlook.com (2603:10a6:200:66::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.17; Sun, 9 Aug
 2020 05:52:40 +0000
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::9186:8b7:3cf7:7813]) by AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::9186:8b7:3cf7:7813%7]) with mapi id 15.20.3261.022; Sun, 9 Aug 2020
 05:52:40 +0000
Date:   Sun, 9 Aug 2020 08:52:37 +0300
From:   Eli Cohen <eli@mellanox.com>
To:     Alex Dewar <alex.dewar90@gmail.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdpa/mlx5: Fix erroneous null pointer checks
Message-ID: <20200809055237.GB48080@mtl-vdi-166.wap.labs.mlnx>
References: <20200806191849.82189-1-alex.dewar90@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806191849.82189-1-alex.dewar90@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: AM3PR07CA0103.eurprd07.prod.outlook.com
 (2603:10a6:207:7::13) To AM0PR05MB4786.eurprd05.prod.outlook.com
 (2603:10a6:208:b3::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mtl-vdi-166.wap.labs.mlnx (94.188.199.18) by AM3PR07CA0103.eurprd07.prod.outlook.com (2603:10a6:207:7::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.6 via Frontend Transport; Sun, 9 Aug 2020 05:52:39 +0000
X-Originating-IP: [94.188.199.18]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 38084790-9fd2-47e8-f9de-08d83c286d53
X-MS-TrafficTypeDiagnostic: AM4PR0501MB2692:
X-LD-Processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM4PR0501MB26923663F15A248C3576565DC5470@AM4PR0501MB2692.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: it2hzExECSkfSFkEt+nPqH7QXqK6O4f5xTzbDVCi+njXHw90FCHJ8iuNmB0y3l+I/H4LI4QmWIHbfTOT/J5JumK3WD/1e0EwngZFcvxBGKfudPZxdLytikI7EZn/ipYDHQ8NjsowiRRjZvnItZgKVvG+PffyHiWqpKDcj984FwPjtsErLHnQfPtsV8qwAxYj+y/R8M1GsGTZIO+q3PbxkkrUyorajbbXA5YUrrku3y+8PMRcoM7M1WSUrVzqVMJCGUQ7QCdAf+mkVCXggTJ3KmwE5azogehggWdAefQZiwg1pU1rPexpP440dI2UCSrMfzaMvpPx2DIJXxXIvczjmg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB4786.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(2906002)(956004)(83380400001)(66476007)(66556008)(6506007)(316002)(26005)(4326008)(16526019)(186003)(66946007)(7696005)(52116002)(33656002)(1076003)(54906003)(9686003)(6916009)(8676002)(508600001)(55016002)(86362001)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: I/QPxRpY4i5zU506Z6k7fzjKhQQpWz/9DUITuFl2XU4TwGCxxOwzuds8AK2yEZ/EEqtrdcL4lliey02NmU/gZjWcHDuFqXTQzwOs/r1+1+Av9nKDelN8LOh7PY0NsxNYRavqkFfiE2w9kkNE84gxsGdrdc8fkMVtUvAKxP3nnMY2GyTWM9bJJgHRIwIq5Qur5B+YsL6giBx46pKxCn3OguVFIsdIzQju7wFCuSy8ftItsCMgsllGB2CKcAr/LKmeKvWuSmRsW0odqmTiM6tmKFEpKTQHEFbthrPfBzJSMaX4LjjMcN2QQoE82KYvK8WmAsbhzucZOaErgkZhM1J5h4kDDZsqMhSOxq7SEjgCGJzsrSWoHnikFj/WJIr87JjFa3LI8sQ0ZwzUDIXf5af7eRe2Js9xKSHhvoMThkuZrCDVmEcYjL89TcoPgtDkq+rJ75YWjkDTXIdhHF+dOfOIXotNUP6zHuxEgBFawrlw4AG59ifrOkCQi2bRcEqILTV+vTepsQpYDuSJqy6lQ60m3zPeZh+/VkM0gJ79vBneoq/fT4cDIVjzgbX4pxIougLcEzISq3i8K01o6svAkCgm17GpTAA0Lbc6ShYggEaWg+H2dI+hHDTB/WorQjJA0nM3aBkaTKlIYrsPRzNSK/sOdQ==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38084790-9fd2-47e8-f9de-08d83c286d53
X-MS-Exchange-CrossTenant-AuthSource: AM0PR05MB4786.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2020 05:52:40.4842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aKKCvPCRNJbUPpA6bRRpSAokJZPi4DpRkLCIJOOmvRb7dxbMhR/FgG/s9y3oJJs7OfHHHqzLjNhYcaON5BV1fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0501MB2692
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Eli Cohen <eli@mellanox.com>
On Thu, Aug 06, 2020 at 08:18:39PM +0100, Alex Dewar wrote:
> In alloc_inout() in net/mlx5_vnet.c, there are a few places where memory
> is allocated to *in and *out, but only the values of in and out are
> null-checked (i.e. there is a missing dereference). Fix this.
> 
> Addresses-Coverity: ("CID 1496603: (REVERSE_INULL)")
> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 3ec44a4f0e45..bcb6600c2839 100644
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
> -- 
> 2.28.0
> 
