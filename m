Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A475DC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 06:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F4ED20709
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 06:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="CVVh0pr4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgHIGDD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 02:03:03 -0400
Received: from mail-db8eur05on2060.outbound.protection.outlook.com ([40.107.20.60]:22560
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725988AbgHIGDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 02:03:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GSqvG15aOEo5I5c3RZ8PB4nCy+oJxfqBHJW3I/NiMCQemmBJYcQ1EokjubzjTZntPxMODwIybYZmKqtMYPG2MdUYTMRmTlwlTJoyL1qHGe5E/EBHEx2JERriexYpswy03R/ItOGdYOlEKV2bxADY5/5QSAphtsrfXoGV3ZeKLyj3o3ejhCSPgqjnmWyxB37kzmXAMGd9o0SkIjIZ2iGVlSJhuUzAQpvL1JgPA35Fv5YM5Zf5+GkjOIKjO0a8jiv1az+JUpP7BpnhzjinwPTD29goZlR+yGShOpAVBz3SV6dXemRgRmLiswwegHwfgNO3G1H9PQHqyqtD0xGgIIha3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgOdh3PCHSIjm4AASM+hH/tYP6MSYCfx7ZCXY/JKzi8=;
 b=l2bKXJnOOUqD9Gj8LYAWPBJTCNjMF8BckLQn39LwLZ8TbFMxVbtbPbcjZOwrCTsglZjj7+yrmhXwDZfP6valqajNABtfzDoqT7XSxrokmZSWpCelBwdz/uJGysE1iGDXEkjotH1ieguUnlku794gPiJeh1yLwW1W98ceMoRSAUnIqEMNflPqMkq9wXYqr3TTiM1XdItIVZ/ofZs/UD1Zujw27eQLjUoayl4FC200zrvNo5PJUyhkMcnoRXM/XQam9mtAU3g9VSxF3dVinhGZHilPMh9D64sZqdFLmPxJHp6YOCi7k/VluLp0ajS7fWlqzf6wpl4zjLvyc3eSKApAjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wgOdh3PCHSIjm4AASM+hH/tYP6MSYCfx7ZCXY/JKzi8=;
 b=CVVh0pr4+mKFQhHaEdJGimj4O2iQrawBol6AxP9VVgiZ14Ds9eeuJqfhCS/yESnwNdSH7xs+4vdWwCU4hxyHhh8EHfaSRdDN+FbD8ujY7mQxft1x92eO/yhupmX9I+/k5KMVc3AYkeekgLojfhORjI1iqdD1G8cRbWMz+SLjBbc=
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com (2603:10a6:208:b3::15)
 by AM0PR05MB6626.eurprd05.prod.outlook.com (2603:10a6:20b:146::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Sun, 9 Aug
 2020 06:03:00 +0000
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::9186:8b7:3cf7:7813]) by AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::9186:8b7:3cf7:7813%7]) with mapi id 15.20.3261.022; Sun, 9 Aug 2020
 06:03:00 +0000
From:   Eli Cohen <eli@mellanox.com>
To:     Eli Cohen <eli@mellanox.com>, Alex Dewar <alex.dewar90@gmail.com>
CC:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] vdpa/mlx5: Fix erroneous null pointer checks
Thread-Topic: [PATCH] vdpa/mlx5: Fix erroneous null pointer checks
Thread-Index: AQHWbCZ0hQUIiLoUFE+0EJhFFNPaH6kvSkSAgAACPhA=
Date:   Sun, 9 Aug 2020 06:03:00 +0000
Message-ID: <AM0PR05MB4786937640988E59BBB453CBC5470@AM0PR05MB4786.eurprd05.prod.outlook.com>
References: <20200806191849.82189-1-alex.dewar90@gmail.com>
 <20200809055237.GB48080@mtl-vdi-166.wap.labs.mlnx>
In-Reply-To: <20200809055237.GB48080@mtl-vdi-166.wap.labs.mlnx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mellanox.com; dkim=none (message not signed)
 header.d=none;mellanox.com; dmarc=none action=none header.from=mellanox.com;
x-originating-ip: [37.142.159.249]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 4253c2f7-6427-4999-7e9e-08d83c29debf
x-ms-traffictypediagnostic: AM0PR05MB6626:
x-ld-processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr,ExtFwd
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM0PR05MB6626394679E31F7D3258E1BAC5470@AM0PR05MB6626.eurprd05.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hyd0igPnp19F58ox5D0+vxWUpouyxr48Gp0Bcpr2PqdSTBwFickiNiHWRaaOgNd9ys7mJi3vT46bJSDyDYEde24V85IFnVL+5GTwQD44AJ9MiNx33w516ZyqIEuVaKw0H5S5y7f0wueG9Hvftce/QHnWhefzPw/5aC+Aw9vjm/Sxuuivp2Hf7HMXajP8FaD5rKBLdKo1FxnM/FDgeJ1y+xTZW7OUQRerKm2hYbePfTK0CqIZv0vAPNnTmf/snmfF7v/sQxvMIcIet62r9QgWon51b1p0tBMrhEnwTKZZV0rVXb3q66kAFuBnvf68AAbg+u6iPtHsbOKp+nz2f2DXUA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB4786.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(136003)(346002)(366004)(376002)(396003)(71200400001)(76116006)(66476007)(66446008)(66946007)(64756008)(66556008)(5660300002)(52536014)(7696005)(186003)(26005)(54906003)(316002)(6506007)(83380400001)(53546011)(110136005)(86362001)(2906002)(33656002)(4326008)(8676002)(8936002)(9686003)(508600001)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: got7sbRFu9id/6pRn6scCne9j15T/wTgYljoq93YjA1ES2eMyMwwXcAB1L/8udyWtiRqL4tjsOVnXbD0bj1e6zpkOpJ23LeF6zczTPOUyavPTMyCv9m09ExqIkqjZRKtbCmZku82vq6mhLI7/qhRxVPGUxk6GOu3v8CSPau/nn8PaDYVlRJB5ZQjTbL23mmOupBTwGHQPuVSgI2uXq4ZP/dL6ZPBXAeGNO+08unsO3gTyoDGtD4qpImy+xXn+CVW4yAZ9rEtOLzTKRy42BWnx0XtFO9/dn+uKUaVsCi0uRMGrN5bOw4P3b5O55EocC+MF/qnqquXVodkQ1g91+jwt6FGeMazAq1iJIiKyAVN2WhDMd+nBwxe3n2WCFUduxti0axrAbukEiiBTN09erfQ5RSrYjh6EdFn6h+k6OhZw80Vt4O27RqtgVZMZwvPfLGa4uu7hW8Qz/VBAhwazMBHjenNVUzyM+EcwygjQSh/5eZwObVFziPQpPjHO6sL5kS+1EVlZzhEqbLT4VrAPn61SGci1vrqJD5fGtTZud/jBPx6/fA/zKADCoDoyxyqDCaExHFHNS3yil7ReKx8b/ox3J2cYqsjdNzGMpTVF42GaIG2x5yJdOqDGJBRVA5nD8SLvjQtDvAiSn7fTxLD32eR1w==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM0PR05MB4786.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4253c2f7-6427-4999-7e9e-08d83c29debf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2020 06:03:00.0563
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lu1Y9neWK4RC7c/1ONhiE0duFzI8dDDGORIirRRbl1KA+zF5Yj89dBJhRlioyd7NpBZ/zhZ319muj4GnaHNPSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR05MB6626
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After all this patch is not fixing it all. If we get to default of the swit=
ch statement we will free invalid pointer so removing ack-ed by me.

The previous patch by Colin King fixes it.


-----Original Message-----
From: Eli Cohen <eli@mellanox.com>=20
Sent: Sunday, August 9, 2020 8:53 AM
To: Alex Dewar <alex.dewar90@gmail.com>
Cc: Michael S. Tsirkin <mst@redhat.com>; Jason Wang <jasowang@redhat.com>; =
Parav Pandit <parav@mellanox.com>; virtualization@lists.linux-foundation.or=
g; linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdpa/mlx5: Fix erroneous null pointer checks

Acked-by: Eli Cohen <eli@mellanox.com>
On Thu, Aug 06, 2020 at 08:18:39PM +0100, Alex Dewar wrote:
> In alloc_inout() in net/mlx5_vnet.c, there are a few places where=20
> memory is allocated to *in and *out, but only the values of in and out=20
> are null-checked (i.e. there is a missing dereference). Fix this.
>=20
> Addresses-Coverity: ("CID 1496603: (REVERSE_INULL)")
> Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5=20
> devices")
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> ---
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c=20
> b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> index 3ec44a4f0e45..bcb6600c2839 100644
> --- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
> +++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
> @@ -867,7 +867,7 @@ static void alloc_inout(struct mlx5_vdpa_net *ndev, i=
nt cmd, void **in, int *inl
>  		*outlen =3D MLX5_ST_SZ_BYTES(qp_2rst_out);
>  		*in =3D kzalloc(*inlen, GFP_KERNEL);
>  		*out =3D kzalloc(*outlen, GFP_KERNEL);
> -		if (!in || !out)
> +		if (!*in || !*out)
>  			goto outerr;
> =20
>  		MLX5_SET(qp_2rst_in, *in, opcode, cmd); @@ -879,7 +879,7 @@ static=20
> void alloc_inout(struct mlx5_vdpa_net *ndev, int cmd, void **in, int *inl
>  		*outlen =3D MLX5_ST_SZ_BYTES(rst2init_qp_out);
>  		*in =3D kzalloc(*inlen, GFP_KERNEL);
>  		*out =3D kzalloc(MLX5_ST_SZ_BYTES(rst2init_qp_out), GFP_KERNEL);
> -		if (!in || !out)
> +		if (!*in || !*out)
>  			goto outerr;
> =20
>  		MLX5_SET(rst2init_qp_in, *in, opcode, cmd); @@ -896,7 +896,7 @@=20
> static void alloc_inout(struct mlx5_vdpa_net *ndev, int cmd, void **in, i=
nt *inl
>  		*outlen =3D MLX5_ST_SZ_BYTES(init2rtr_qp_out);
>  		*in =3D kzalloc(*inlen, GFP_KERNEL);
>  		*out =3D kzalloc(MLX5_ST_SZ_BYTES(init2rtr_qp_out), GFP_KERNEL);
> -		if (!in || !out)
> +		if (!*in || !*out)
>  			goto outerr;
> =20
>  		MLX5_SET(init2rtr_qp_in, *in, opcode, cmd); @@ -914,7 +914,7 @@=20
> static void alloc_inout(struct mlx5_vdpa_net *ndev, int cmd, void **in, i=
nt *inl
>  		*outlen =3D MLX5_ST_SZ_BYTES(rtr2rts_qp_out);
>  		*in =3D kzalloc(*inlen, GFP_KERNEL);
>  		*out =3D kzalloc(MLX5_ST_SZ_BYTES(rtr2rts_qp_out), GFP_KERNEL);
> -		if (!in || !out)
> +		if (!*in || !*out)
>  			goto outerr;
> =20
>  		MLX5_SET(rtr2rts_qp_in, *in, opcode, cmd);
> --
> 2.28.0
>=20
