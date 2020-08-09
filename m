Return-Path: <SRS0=dnKw=BT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D380CC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 05:51:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33208206C0
	for <linux-kernel@archiver.kernel.org>; Sun,  9 Aug 2020 05:51:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Mellanox.com header.i=@Mellanox.com header.b="fvMshppY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgHIFuk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 01:50:40 -0400
Received: from mail-eopbgr60089.outbound.protection.outlook.com ([40.107.6.89]:4683
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725988AbgHIFuk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 01:50:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FvUPONN/Ozszn08prs0/BroebTV4lvEZaOM9iXV93YHEsxFkAuKChC2Ka4gXT4xvvaPIGx7GpYvepZmQAgJ8bvQC+JgDvHgAcvyZXCenpFwr48cnEqhNhP338LN95M5e9HKDX1AMhvasjvCZiCOBkd1c2ju7gyTFoNO2PGas7E0GX7mNOGf0Wvl2PgaIUNzO0BjPHDxm1M2zgt8210HdbtFxArwUsEeS40sQJ4SjmMkdHYwf5PHFIddNLbQjKYucZu3T4aFCVST2PRl2xb5wlrmj1K7wLxKSJf9FNk+8il5SYRW5pwJusbL8RYLrCGPkQqcZFtQMH3jzzOE3NXpOsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tu5UEPP/dfmz9JnTsEdDfx3pUthwfaGjJQ7XuKnwcZg=;
 b=UJuiLZAZGC/KG5XD6tDA8mn5pX0ijTWy2jhuicY1P1lxKfxKG6BCx8SPoFNE7rD1NwIuB7X2DjtjNMQD89IiJ1xHUMPo2nV41NqwnWhJqbmwqf0RuEdOiGuvyxGx6zSb0tLrbM5W/lUspXznojw+Y9Nc7qSfD2pkwbcuah0m8BHKSYvf3Fbgc9j4mA9n2P7c+EsBA8f+3Bak8/Yrt+jO7jRVJfuyp0TWIOIa0RoX/b3vK0PGJRYdUyWI/BLoRQDaJs1SrX3Ip7I4U/Sahk52S4X/EIPW4q2O5X2guwsOqwczm2RCVMKfQRCE5r/hBPHu1geUBUvQBoDuAiGKMDx7cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mellanox.com; dmarc=pass action=none header.from=mellanox.com;
 dkim=pass header.d=mellanox.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Mellanox.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tu5UEPP/dfmz9JnTsEdDfx3pUthwfaGjJQ7XuKnwcZg=;
 b=fvMshppYcYbg8xhvorYAoI0CeCntgwmdfpC2RKACSAr/gh2usq+BPgTwpJ3alYSQe4dSr4+1uY6h3cp0e49qv/fBUhdcEkKbaJcwVhuanz1IdHQ827qHUR8bJiIC4XBgV+gSkB3WZn+2jzWien/qE2OULJEaNQ9chBlIxC9TGVI=
Authentication-Results: gmx.co.uk; dkim=none (message not signed)
 header.d=none;gmx.co.uk; dmarc=none action=none header.from=mellanox.com;
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com (2603:10a6:208:b3::15)
 by AM4PR0501MB2692.eurprd05.prod.outlook.com (2603:10a6:200:66::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.17; Sun, 9 Aug
 2020 05:50:36 +0000
Received: from AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::9186:8b7:3cf7:7813]) by AM0PR05MB4786.eurprd05.prod.outlook.com
 ([fe80::9186:8b7:3cf7:7813%7]) with mapi id 15.20.3261.022; Sun, 9 Aug 2020
 05:50:35 +0000
Date:   Sun, 9 Aug 2020 08:50:32 +0300
From:   Eli Cohen <eli@mellanox.com>
To:     Alex Dewar <alex.dewar@gmx.co.uk>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Parav Pandit <parav@mellanox.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdpa/mlx5: Fix uninitialised variable in core/mr.c
Message-ID: <20200809055032.GA48080@mtl-vdi-166.wap.labs.mlnx>
References: <20200806185625.67344-1-alex.dewar@gmx.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806185625.67344-1-alex.dewar@gmx.co.uk>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ClientProxiedBy: AM0PR10CA0037.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::17) To AM0PR05MB4786.eurprd05.prod.outlook.com
 (2603:10a6:208:b3::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mtl-vdi-166.wap.labs.mlnx (94.188.199.18) by AM0PR10CA0037.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15 via Frontend Transport; Sun, 9 Aug 2020 05:50:35 +0000
X-Originating-IP: [94.188.199.18]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 2f94133a-db39-4825-4a81-08d83c282305
X-MS-TrafficTypeDiagnostic: AM4PR0501MB2692:
X-LD-Processed: a652971c-7d2e-4d9b-a6a4-d149256f461b,ExtAddr,ExtFwd
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM4PR0501MB26920CE608076BAE94CF1680C5470@AM4PR0501MB2692.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 46LfO37tNNKV4jlgYJJVOv91tfQsLGYQnpviHdkU7Ut5hNT/md639Lb1mgRpRyXKYyWepC/H4HiskgERyE9u6QnEEqlfvQZzOwa5M4P8N8HKA4ZKjUVV1LfSVZMaeGKLJ5clzAuE9pORp2O86CS6EuFq2rtG7pzqCW6MDXdLW8QwSLpEUV5bRu0gm+28ipmOK+Jn20BDEEFFFjszfkrsX0qOxN7gLO95w9hIX8JWXsP+gUX78aTZ+ScZQUPeGEHvcLU5ss9ZunF0uhqiTs1+dyZ0/tKRS0+ylwxw7jYawCh8ek38DdaNP409eUCLP0IsI9ZmLSTz90/lb1AI0ZSGPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB4786.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(346002)(366004)(376002)(136003)(396003)(2906002)(956004)(83380400001)(66476007)(66556008)(6506007)(316002)(26005)(4326008)(16526019)(186003)(6666004)(66946007)(7696005)(52116002)(33656002)(1076003)(54906003)(9686003)(6916009)(8676002)(508600001)(55016002)(86362001)(5660300002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: jsS4HsC5EOkLHK5PvlSj+NDeWOErdDdboLM12nonA4mHcmzVfPLuEfOePfc3dF/YkG44CLoAX4bGiDRYqFr0uRYL/HqR9Tf9YUmH3t5Tl12lpyT2c/AwNJwPEEKjkV9DzhaaYHnFOiEA9YeB3W9xHmEqQV8ao2/gDmaBCQtebESXkkEfsGBckL26oAqOTR7HsxiXcbcpYZ6++a23JWVHgAfmb+SF9d906zu8rqYY/mXsIGUZ8+FM0QBcWHfqBDpItZ71AbXOOTVEO6fyjby5GB7Nlh0o8JvQMG0DDXL5wu2mB1oohYHo/JxO9mkAcBJCm54agqtepcpvCiD1L7HAZFzbyXvNa2LHIRm9MA6GdU+jdoYWX674JM2sV/5AwG/Kyfb2rUtOEwvpgdzC2ajvnjvOCzFbgav07JgdPp11VsLeIHSvfDkCR8sXA7pxvTK8O8hkaGfTeNkvJ28iY3Z82YQq67n3jjo7U0fHLC9Aeu1glipcUC04owxquF7uGgGK8UErl/Vs7XIcIK3insJYe+spugbazO3YgaEavXMkQR8OvLHLPKl3qW9mivgToa4t512IeMzY7/1BazpzDx97GI1s1rfqqJNtgmgXRGro2+xemaML/95siCRx0Z8UM8nOCRIjJ3J7bWlPWEbHGk/Eyg==
X-OriginatorOrg: Mellanox.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f94133a-db39-4825-4a81-08d83c282305
X-MS-Exchange-CrossTenant-AuthSource: AM0PR05MB4786.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2020 05:50:35.9051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a652971c-7d2e-4d9b-a6a4-d149256f461b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wZq4MLlqbksZlyfJNI0SeOTJtYHJMZmT7tNqa0kJ+AVaT4YxMyhd85GqzVJk9/2lkbydYksoEnUhdWB1/+/70w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0501MB2692
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 07:56:15PM +0100, Alex Dewar wrote:

Acked-by: Eli Cohen <eli@mellanox.com>
> If the kernel is unable to allocate memory for the variable dmr then
> err will be returned without being set. Set err to -ENOMEM in this
> case.
> 
> Fixes: 94abbccdf291 ("vdpa/mlx5: Add shared memory registration code")
> Addresses-Coverity: ("Uninitialized variables")
> Signed-off-by: Alex Dewar <alex.dewar@gmx.co.uk>
> ---
>  drivers/vdpa/mlx5/core/mr.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vdpa/mlx5/core/mr.c b/drivers/vdpa/mlx5/core/mr.c
> index f5dec0274133..ef1c550f8266 100644
> --- a/drivers/vdpa/mlx5/core/mr.c
> +++ b/drivers/vdpa/mlx5/core/mr.c
> @@ -319,8 +319,10 @@ static int add_direct_chain(struct mlx5_vdpa_dev *mvdev, u64 start, u64 size, u8
>  	while (size) {
>  		sz = (u32)min_t(u64, MAX_KLM_SIZE, size);
>  		dmr = kzalloc(sizeof(*dmr), GFP_KERNEL);
> -		if (!dmr)
> +		if (!dmr) {
> +			err = -ENOMEM;
>  			goto err_alloc;
> +		}
> 
>  		dmr->start = st;
>  		dmr->end = st + sz;
> --
> 2.28.0
> 
