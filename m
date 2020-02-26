Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF73C4BA0B
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE3A21556
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:29:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="mLbVmw1r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgBZJ3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 04:29:40 -0500
Received: from mail-eopbgr70124.outbound.protection.outlook.com ([40.107.7.124]:6268
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727451AbgBZJ3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 04:29:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z8WnbE76KZ6tOzfMhpObdcF9ZzwnDKHd0akbZirvm162gMQriAOhrqq9PvdsKJhSXt9Y1E2OXQP0Nx2pKV3MKaL9qers6JH+CbuRybzP5uOv2wj4V469MVOzaljcL0NXeDv8NicbiUtB1BWLZwxCld/TzYe9HAXlgNb5hZRmDaretESxVMKymx73Xx3iXva0caf99dgm84GtUvGTtSZfQy/+veV9YAdb2Gw/tvEV4/PGOqzTBbyz+NLk1qhiivL86bChcG66g5qelGk8VldRddmKRt2IELsnwK1Y1Y+b32GVVlfYKIksLpo+jOlPsuok1wkmPDG3llg/DEsODSNI7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mEkvg0neLNYUCLWBkOQ2NRwTyBQYNQuw29smY+KpUQ=;
 b=j6u9W1BkFDOHa0YlPXPSau+A52pPtW2EZPXKsFRd1fl1YX7JL4qP6rB+yLobf9BfygtoCbe3moxcghTN93NTIMdKFbfTJGkPi8DqiHvW6w/UOmDs400LmWwGiX2Bq7UboY+stT2rAuXzbe/U3PAD6XPnz3LhYji9kV+X4bjtJiJ2gSlPUr10omlBTcBKWK2aOs0hYx+dW9G6D8OXJwA1AB+eH1F8bPIzMcFz12eZfntk4K88JFzUqcZ86gVd2ptLPbRL4gLtFq0fsQDfyq7laJLHnDdrrxLTlOOcdf2fJ2eJjsi+jCXVIh20qwRYv+/ne3qMljDsz6T/Ct4OrMrIzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+mEkvg0neLNYUCLWBkOQ2NRwTyBQYNQuw29smY+KpUQ=;
 b=mLbVmw1rR8yTJK6f5MYhJXKeZRoVambbm/J7vPwNLni8SVtSzv6dzuZ51nuD/QkKg7TdX2mhySBrXsat6sXcuTH5v4btWG4wksgG4cVtkM4GRkdxsVzAGXfFwW/QgyC/A/7JuHJ1MYRp5GMdQioTReqULdptA+i2kN07FS9QSrE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) by
 VI1PR05MB6990.eurprd05.prod.outlook.com (20.181.33.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Wed, 26 Feb 2020 09:29:32 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52%7]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 09:29:32 +0000
X-Gm-Message-State: APjAAAWm2WZIbkBVJQcwjL3SJpQdpj0LfiNWsnssGctdT4tloagK+E4l
        IA3zJJarhEcw89oOy8qMUVS5wjsTwlR5yM+YyNo=
X-Google-Smtp-Source: APXvYqwi5shvZmeqxPKwLcbmjjnH+edkvy6nmXG30nLNojOnYDEMaP7va30b9/wSrzYeqiNOORVZ5lQMluIQhwWu6Kk=
X-Received: by 2002:a0c:c389:: with SMTP id o9mr4288045qvi.232.1582709367177;
 Wed, 26 Feb 2020 01:29:27 -0800 (PST)
References: <1582565548-20627-1-git-send-email-igor.opaniuk@gmail.com> <1582565548-20627-5-git-send-email-igor.opaniuk@gmail.com>
In-Reply-To: <1582565548-20627-5-git-send-email-igor.opaniuk@gmail.com>
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Date:   Wed, 26 Feb 2020 11:29:15 +0200
X-Gmail-Original-Message-ID: <CAGgjyvHE+B-VCSfmR9MeO2-u6=dVCUCmCorEa1J+NG5vwQoRfA@mail.gmail.com>
Message-ID: <CAGgjyvHE+B-VCSfmR9MeO2-u6=dVCUCmCorEa1J+NG5vwQoRfA@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] arm: dts: vf: toradex: re-license GPL-2.0+ to GPL-2.0
To:     Igor Opaniuk <igor.opaniuk@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-ClientProxiedBy: BL0PR05CA0004.namprd05.prod.outlook.com
 (2603:10b6:208:91::14) To VI1PR05MB3279.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mail-qv1-f52.google.com (209.85.219.52) by BL0PR05CA0004.namprd05.prod.outlook.com (2603:10b6:208:91::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.11 via Frontend Transport; Wed, 26 Feb 2020 09:29:31 +0000
Received: by mail-qv1-f52.google.com with SMTP id y8so994300qvk.6;        Wed, 26 Feb 2020 01:29:31 -0800 (PST)
X-Gm-Message-State: APjAAAWm2WZIbkBVJQcwjL3SJpQdpj0LfiNWsnssGctdT4tloagK+E4l
        IA3zJJarhEcw89oOy8qMUVS5wjsTwlR5yM+YyNo=
X-Google-Smtp-Source: APXvYqwi5shvZmeqxPKwLcbmjjnH+edkvy6nmXG30nLNojOnYDEMaP7va30b9/wSrzYeqiNOORVZ5lQMluIQhwWu6Kk=
X-Received: by 2002:a0c:c389:: with SMTP id o9mr4288045qvi.232.1582709367177;
 Wed, 26 Feb 2020 01:29:27 -0800 (PST)
X-Gmail-Original-Message-ID: <CAGgjyvHE+B-VCSfmR9MeO2-u6=dVCUCmCorEa1J+NG5vwQoRfA@mail.gmail.com>
X-Originating-IP: [209.85.219.52]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d12beb38-d496-4303-72f2-08d7ba9e623c
X-MS-TrafficTypeDiagnostic: VI1PR05MB6990:
X-Microsoft-Antispam-PRVS: <VI1PR05MB699070E53C2C69E65AB5B6B1F9EA0@VI1PR05MB6990.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-Forefront-PRVS: 0325F6C77B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(39850400004)(396003)(366004)(376002)(199004)(189003)(66476007)(44832011)(5660300002)(66946007)(9686003)(450100002)(54906003)(6862004)(55446002)(52116002)(478600001)(4326008)(6666004)(2906002)(55236004)(81166006)(186003)(26005)(86362001)(81156014)(66556008)(8676002)(316002)(8936002)(42186006)(53546011);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB6990;H:VI1PR05MB3279.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 65GyI4JhZVlhq/OTQX9vkclgp+bfeqNkmiNhIIk8mra1DC9BPJedRiEYwS2e4ETKTNydLVxpfqwSr+r0HKk8zWdCHZ0VUhnPtHj0iK7eFrCrweD1WPhCcZECmCFk6N7/2ZMxarCZBsy91anIVhUIYPHA94fx7xdNLMj8rKTr9jaWIhfuOpBYg/GJoIzQYuoS1os3DH2i5L+4/g7h1kAvrrCAjTkQKp5mT8wbbv18w+ZqCgNuEgrbCCT2LOQa6ZTEtvTVsO8CErb6mpV4Ge6yE1xRwsmjeioXBaxvKPAzeoHqhywebTzee2moG/mIFL+R0m+ulOzvpLd2ElA/YeOqhO+mSxdsM9NmEMu0CWTvLjZamIx2BCAJ4u1/0VZUcQ4eCxFJq6tpHFZ4Xv0KGZEn0mCeUlnjarmP0H0MQ4pTWc3pAE7GO6QG+nMDULpcOUzG
X-MS-Exchange-AntiSpam-MessageData: VfZ+vgqCM3BaX3/tPgRxZ4+teQIzlfqZBs2e8LUPIaIWs4/fFcXiECNeaxU/Pju3S5qlTQcXriQTVVj3SKEHJF4tdKW28dqvpk44iZ9DFcMV8PW/DV982VdvpgyJGj/0pIt8P5tWHC24ZkVZN9FEDg==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d12beb38-d496-4303-72f2-08d7ba9e623c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2020 09:29:31.3841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Ikg9m9XVwHXKvXQ+AYj9NKU3IpkHnTC1D4b08kdfhEGttqDX4AHjTfRNrjYmcbqqsdl+jZPicT+DtGFbRioQ2cE13f20ps0DE+C/QB/g54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB6990
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 7:33 PM Igor Opaniuk <igor.opaniuk@gmail.com> wrote:
>
> From: Igor Opaniuk <igor.opaniuk@toradex.com>
>
> Specify explicitly that GPL-2.0 license can be used and not
> GPL-2.0+ (which also includes next less permissive versions of GPL)
> in Toradex Vybrid-based SoM device trees.
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>

Reviewed-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

And please ignore my note about copyright for the previous change of this file.

> ---
>
>  arch/arm/boot/dts/vf610m4-colibri.dts | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/vf610m4-colibri.dts b/arch/arm/boot/dts/vf610m4-colibri.dts
> index 2c2db47..75c6d82 100644
> --- a/arch/arm/boot/dts/vf610m4-colibri.dts
> +++ b/arch/arm/boot/dts/vf610m4-colibri.dts
> @@ -1,7 +1,8 @@
> -// SPDX-License-Identifier: GPL-2.0+ OR MIT
> +// SPDX-License-Identifier: GPL-2.0 OR MIT
>  /*
>   * Device tree for Colibri VF61 Cortex-M4 support
>   *
> + * Copyright (C) 2020 Toradex AG
>   * Copyright (C) 2015 Stefan Agner
>   */
>
> --
> 2.7.4
>

-- 
Best regards
Oleksandr Suvorov

Toradex AG
Ebenaustrasse 10 | 6048 Horw | Switzerland | T: +41 41 500 48 00
