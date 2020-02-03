Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBCEC33CAC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 14:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D1742086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 14:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="J2oK00n5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728060AbgBCOQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 09:16:42 -0500
Received: from mail-eopbgr10130.outbound.protection.outlook.com ([40.107.1.130]:15171
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727303AbgBCOQm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 09:16:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crsVhA3j/E6R+QCrcr/xDadxnwu4Ylkr7zJNfrJJXXkIsgGQCElhWW6siFCs8zPMWeO1zksWBQVtSkNWTtJT2y2ns2+DXxSfpJg4AgodE0faGAhFkWaqQLk9C5n34jYC2BysIGgW60XOM7Mx0z+mYgfe9dmQHArK1exhBVOqWXVPu2V9atVRyeweMhFHD5Z1tkW13zS/SnfGLZVdGhag0+3JzucYxEbYFHvh+x4RD8yR1qZwFhcdpZKI6SzBCeueIMjx69ReGaCW3df3EluQwLta30ORRtveuz9XVMFHCB8RtgQ2MJyRl+Uk20weXxO0ufpFjDJ5MGrDgRzL7wCVRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeGf/ODDV/kNGT2JI1kVs8ElXRi8dJB6BskXy9uaPVI=;
 b=Y1SkTR2ZABlluPfXIlzFU2jzUiQ6zXl3JCGaXwfpGqWo1vwFDEg4ptjrfx2qypideuMZF8PGW4xb9+JQ9GD2nMooLmdNIPzm06S8DJR4x5qqIavYNNgEwE4PpE8ndWIvFMGq6yB/zdN6QpLDv0ThBrWLcfFgkxf+/AEJ1C6KrMi4ry6be+hm1oJL/bG8F7dlC0YTZ+cy2NAg4CVqHYR8471gaYSz1QiedHVJH8d0tJXf5JmPtzrXjr5W9NDDPADWx9GXFToPhgtk9mMW4u7/UrqF8ntqNhiDsEiGN9ZsudDGEWpwJtWIVYGCiYXw9piUDpgbrDOPAowGIYbC1yyyVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PeGf/ODDV/kNGT2JI1kVs8ElXRi8dJB6BskXy9uaPVI=;
 b=J2oK00n5pTWMhHo6WCdtkRRjGqI+TUu0EALgT1UyxlohoJJyF2UgvIqndf70zhKklWsLemmIYODnvnb8FqChZaTPMyqwfLgE5nk4TF3CLno93J6NUfIYOmlC23uNaMKQCkEWMiwTewyKRdyApsZuftOrp8/XEdEwrYPdjLMvRDw=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) by
 VI1PR05MB3374.eurprd05.prod.outlook.com (10.170.238.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Mon, 3 Feb 2020 14:16:39 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52%7]) with mapi id 15.20.2686.031; Mon, 3 Feb 2020
 14:16:38 +0000
X-Gm-Message-State: APjAAAUpry2t+LK9DE+Qfxny6Q4rhhJg8LdMxr16dBvlINUACLqQU6az
        IzQ8USovMOQdrLNNzrh97C4JPSZMjFIn+0jBjno=
X-Google-Smtp-Source: APXvYqwfT70Xo+U0ryoeOlAKqNqziMmfSjotp+Z+nlKdoBLASvtFNEM32Jq1/sTAQWhdwgeLGv56+/213gvbXfroqk8=
X-Received: by 2002:ac8:6747:: with SMTP id n7mr23561610qtp.224.1580739071747;
 Mon, 03 Feb 2020 06:11:11 -0800 (PST)
References: <20200202193014.107003-1-stefan@agner.ch>
In-Reply-To: <20200202193014.107003-1-stefan@agner.ch>
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Date:   Mon, 3 Feb 2020 16:11:00 +0200
X-Gmail-Original-Message-ID: <CAGgjyvGOUF0n+9kn1bGZUZr1OjbGRXXAGZ2EXyHEJ-FFG=ivfw@mail.gmail.com>
Message-ID: <CAGgjyvGOUF0n+9kn1bGZUZr1OjbGRXXAGZ2EXyHEJ-FFG=ivfw@mail.gmail.com>
Subject: Re: [PATCH] ARM: imx: limit errata selection to Cortex-A9 based designs
To:     Stefan Agner <stefan@agner.ch>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>, linux@armlinux.org.uk,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Arnd Bergmann <arnd@arndb.de>, Anson.Huang@nxp.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan.agner@toradex.com>
Content-Type: text/plain; charset="UTF-8"
X-ClientProxiedBy: SN4PR0501CA0069.namprd05.prod.outlook.com
 (2603:10b6:803:41::46) To VI1PR05MB3279.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::24)
MIME-Version: 1.0
Received: from mail-qt1-f181.google.com (209.85.160.181) by SN4PR0501CA0069.namprd05.prod.outlook.com (2603:10b6:803:41::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2707.12 via Frontend Transport; Mon, 3 Feb 2020 14:16:38 +0000
Received: by mail-qt1-f181.google.com with SMTP id w8so11468639qts.11        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 06:16:38 -0800 (PST)
X-Gm-Message-State: APjAAAUpry2t+LK9DE+Qfxny6Q4rhhJg8LdMxr16dBvlINUACLqQU6az
        IzQ8USovMOQdrLNNzrh97C4JPSZMjFIn+0jBjno=
X-Google-Smtp-Source: APXvYqwfT70Xo+U0ryoeOlAKqNqziMmfSjotp+Z+nlKdoBLASvtFNEM32Jq1/sTAQWhdwgeLGv56+/213gvbXfroqk8=
X-Received: by 2002:ac8:6747:: with SMTP id n7mr23561610qtp.224.1580739071747;
 Mon, 03 Feb 2020 06:11:11 -0800 (PST)
X-Gmail-Original-Message-ID: <CAGgjyvGOUF0n+9kn1bGZUZr1OjbGRXXAGZ2EXyHEJ-FFG=ivfw@mail.gmail.com>
X-Originating-IP: [209.85.160.181]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f06451ae-3f56-4800-fcd6-08d7a8b3af39
X-MS-TrafficTypeDiagnostic: VI1PR05MB3374:
X-Microsoft-Antispam-PRVS: <VI1PR05MB3374D32C32A1892D73CECDFAF9000@VI1PR05MB3374.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2803;
X-Forefront-PRVS: 0302D4F392
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(199004)(189003)(53546011)(55236004)(107886003)(498600001)(6862004)(4326008)(2906002)(186003)(55446002)(8936002)(54906003)(81166006)(42186006)(81156014)(5660300002)(86362001)(26005)(44832011)(66946007)(9686003)(52116002)(6666004)(66556008)(8676002)(66476007);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB3374;H:VI1PR05MB3279.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Mg6AkpC6EqbGo3ESQ26V2I1Hy8V67PwUUZWS7i3iRy2DDXRRzGcTXwyO5EBfk3izoHoK6jDmhg04eIEndpUeWgZ3sDsaEPwI/LYTvNixdXaY1bb57LdXJ9YVNymRCzzjXxXeTnrWumOjPx8xkhTNC4aR7XB+1nsgqsOP6jCV8uw8S8++5kmerxuBMS4KcpPXk91zkM6VSB8EO9+kStsAUo6Z9ya2q+4ow6aneeRBPthQWFNRCTCS87BP/fa9Z+yPcjWeAL4kF/TvxxS1KVwjgu3kqhnMWolvy3+MQoWGSZo3B61NdIiCvlYE92O8EZzdphz4mypf+rXlQ4lFzwMh5/iYKsM0nYmG3/dG1Qh2TFUqpW8al2a0EF+a/qgtCcR6RUTsvAUv1zn77RmjejWpEqHdrlGIkSihHrL249G8QQkO1reOxfs912BTtkFmiGly
X-MS-Exchange-AntiSpam-MessageData: oDkt53dLTp1YGUsTgAjCF67BHHsJ50opGmJSVue7EPPbl/GUuHVQpVdQ7JuEKhvNyyTc5i1CUGPx3DWLdKdGXt+ORzqSDX1NTuV/seLeIUq9bdEZiRySMjec6qU7V0Nxpwl7Ud4jEAcOGz+2TA6aJg==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f06451ae-3f56-4800-fcd6-08d7a8b3af39
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2020 14:16:38.9699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E1bFSxTCAwQrN+jQLhX96Di2h9QbqHqaLqGY1NteNdZPRT2u8wf6cMAhXXPcoZjRtcn/zKqGTe/hJxVoxzqhYrWlDWwWoKP3JY7265IH+Ic=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB3374
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 2, 2020 at 9:31 PM Stefan Agner <stefan@agner.ch> wrote:
>
> From: Stefan Agner <stefan.agner@toradex.com>
>
> The two erratas 754322 and 775420 are Cortex-A9 specific. Only
> select the erratas for SoC which use a Cortex-A9.
>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

Reviewed-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

> ---
>  arch/arm/mach-imx/Kconfig | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/mach-imx/Kconfig b/arch/arm/mach-imx/Kconfig
> index 95584ee02b55..e7d7b90e2cf8 100644
> --- a/arch/arm/mach-imx/Kconfig
> +++ b/arch/arm/mach-imx/Kconfig
> @@ -471,8 +471,6 @@ config      SOC_IMX53
>  config SOC_IMX6
>         bool
>         select ARM_CPU_SUSPEND if (PM || CPU_IDLE)
> -       select ARM_ERRATA_754322
> -       select ARM_ERRATA_775420
>         select ARM_GIC
>         select HAVE_IMX_ANATOP
>         select HAVE_IMX_GPC
> @@ -484,6 +482,8 @@ config SOC_IMX6
>  config SOC_IMX6Q
>         bool "i.MX6 Quad/DualLite support"
>         select ARM_ERRATA_764369 if SMP
> +       select ARM_ERRATA_754322
> +       select ARM_ERRATA_775420
>         select HAVE_ARM_SCU if SMP
>         select HAVE_ARM_TWD
>         select PINCTRL_IMX6Q
> @@ -494,6 +494,8 @@ config SOC_IMX6Q
>
>  config SOC_IMX6SL
>         bool "i.MX6 SoloLite support"
> +       select ARM_ERRATA_754322
> +       select ARM_ERRATA_775420
>         select PINCTRL_IMX6SL
>         select SOC_IMX6
>
> @@ -502,6 +504,8 @@ config SOC_IMX6SL
>
>  config SOC_IMX6SLL
>         bool "i.MX6 SoloLiteLite support"
> +       select ARM_ERRATA_754322
> +       select ARM_ERRATA_775420
>         select PINCTRL_IMX6SLL
>         select SOC_IMX6
>
> @@ -510,6 +514,8 @@ config SOC_IMX6SLL
>
>  config SOC_IMX6SX
>         bool "i.MX6 SoloX support"
> +       select ARM_ERRATA_754322
> +       select ARM_ERRATA_775420
>         select PINCTRL_IMX6SX
>         select SOC_IMX6
>
> --
> 2.25.0
>

-- 
Best regards
Oleksandr Suvorov

Toradex AG
Altsagenstrasse 5 | 6048 Horw/Luzern | Switzerland | T: +41 41 500
4800 (main line)
