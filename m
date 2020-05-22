Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56ED7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 10:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2188B2065C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 10:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="NOGVi4rT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728802AbgEVKN4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 06:13:56 -0400
Received: from mail-dm6nam12on2059.outbound.protection.outlook.com ([40.107.243.59]:55008
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728396AbgEVKNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 06:13:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OgK5/HfNibtMQzBGs1ukSDOWwPGds9RFNKkU0YHUaHG+JYeUCKtPHGTH/EMmIJAfGm3a08MJksn6lVx2fbxRe/iy4FMkyUZbKS/Nvh8gby55O/n1ov2bwxOe2ZNG61zgi6H7/y+t54e/66A2JT7NT4wpgqC3EmpURAWQRdkL5h0G/9saepMD+mGaeoaLBuBG0zDUO/ok3hBKrUV0dub1hOyytOsK4NOsF/IIfQerj0EgRT85KTUccoX5lpyQ7aQCPpEL8AM4ujQhtLcuXfrWbdqy/i4xfcnZj2ZQCJy1MDOPQ5m80aMx0ofn3H4exXOpjL3RQ9emS8jIrmDACf18KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTKtN9Ug6mmfRFpD6K6zDwDVkPakQr9Of6JoGRC6fO8=;
 b=jJuIcSetadZ1P2tDo+Hy6FspuaqUna5Y6BALaWglttu71838O0dX0v2lC/saOt1La8zvQ5vybb/k4pUyJkGpBAC8KVeMT4NwEjWWnymhD/SI8U2KA0+Hq0ryLGcfrDF+J944UrGweC4vjnA0P8En/X7WVej1WGCG7uNK8dr2/7UC9v4UlLUEqVH4N2uzazFPfLto4nKzCuAiMBHhcBKVNIVRKhXT5fZ6ZA9kaxTFj2zEfZMDFMn1fuR60FvnrvqRTdLovpFExrN6jyeMDWv+aHeSAgdxu/fNNiyq2Qiy5iWg8Gz9aLvuY2AdEUPUqITG3jzOO+IlphqY4ibSaNK2gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mTKtN9Ug6mmfRFpD6K6zDwDVkPakQr9Of6JoGRC6fO8=;
 b=NOGVi4rTKieF8MK8vorTuBpF5o0HTDf8h+5FjRBwijdnLuREBPLHCCCs1o1jG/ltxkvTMKPog0kbD1YK46Sip6VfHGr3rJUdwA5kTz1opjxGkhlEhOjGGMxMXiKDFwuKOm2JXyF3yH8ZswfNNyp6jq/YpkWenmAH5Ipn5GYADCg=
Authentication-Results: glider.be; dkim=none (message not signed)
 header.d=none;glider.be; dmarc=none action=none header.from=synaptics.com;
Received: from BYAPR03MB3573.namprd03.prod.outlook.com (2603:10b6:a02:ae::15)
 by BYAPR03MB3750.namprd03.prod.outlook.com (2603:10b6:a03:6f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.20; Fri, 22 May
 2020 10:13:51 +0000
Received: from BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::d1ae:8ea7:ea:8998]) by BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::d1ae:8ea7:ea:8998%7]) with mapi id 15.20.3021.026; Fri, 22 May 2020
 10:13:50 +0000
Date:   Fri, 22 May 2020 18:12:30 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: <soc.lore.kernel.org>
Cc:     soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH v2 06/15] ARM: berlin: Drop unneeded select of HAVE_SMP
Message-ID: <20200522181118.36de5dd9@xhacker.debian>
In-Reply-To: <20200505150722.1575-7-geert+renesas@glider.be>
References: <20200505150722.1575-1-geert+renesas@glider.be>
        <20200505150722.1575-7-geert+renesas@glider.be>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TY2PR04CA0012.apcprd04.prod.outlook.com
 (2603:1096:404:f6::24) To BYAPR03MB3573.namprd03.prod.outlook.com
 (2603:10b6:a02:ae::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TY2PR04CA0012.apcprd04.prod.outlook.com (2603:1096:404:f6::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23 via Frontend Transport; Fri, 22 May 2020 10:13:48 +0000
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 31eda608-cc58-4b15-336b-08d7fe38d2b2
X-MS-TrafficTypeDiagnostic: BYAPR03MB3750:
X-Microsoft-Antispam-PRVS: <BYAPR03MB3750577EEDA0E9CB8B07C537EDB40@BYAPR03MB3750.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 04111BAC64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5LviJ8V6PWnVhZAnMiDAB83WgUzIrxhu5UZV5bnjX9UYtEygsWMPYUEoV5jkT21v+SCYKEV4CLdiBFkID0l4Id/Zd7FnpCDDEp/UO+n2bQboWyNeDth+F2jiV6/DMETKA/JmGrTRvXrGMlJCJ3NVA9G7VTIbuLa+dMBNgwOiY47KiPOi/GSU3zWv02k7cPeeC4p2hOqgJS/qjh8PsNYcsv2Cbc/X/v3ilxHNXWTmUGYvZX73ZgFjGDyOE8zpV/vszZfec+QggUm8R+2qLaWBl7VxxgdKB1dKojPanGpJlrwtstbHDvauBYhHUAvW8zzkHD7LbzDGCIv21Z+A66pnQxYjryl2NOK7DgNUWorcW1oYeGhDFlNkO4aaR7QZjSvszSyXuLTglF54zZq6eC051F/g3tu06Vc8gVKjUjuQ414NTdhs6zYw2YdHITR31I76
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3573.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(396003)(366004)(136003)(376002)(346002)(316002)(7696005)(55016002)(956004)(52116002)(54906003)(6666004)(6506007)(9686003)(5660300002)(2906002)(8676002)(86362001)(8936002)(478600001)(66476007)(66946007)(186003)(66556008)(26005)(1076003)(4326008)(16526019);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: LvspS/C47dCAFz9y1RYWt4dT1m7xN4O+SAJSojAW2GSEazrDsdVhLtVDTr5yopoCEfxze7GBWI6YfKVlXFHOOSQm2z5SYNEVT2iDXWmvkJK3QXxcKUtyHr5BtC5zEBW4KaFFpk52GXyHhyKu9fiYmq6kWg482BrxgXwdaK4bMO+FBDttGPD0rk6NF4LAXO9gNAi6ZKNAwNzSn3I/Grqji0vtT8eQ8qWaamB4JqTkYhYqe6EBxJe4VdIqUnbIIDD/UYVniINiiB4oGicQJWpSQZ568f2crjnqBIMPaXGoGSBkoJpcyhVKYGFwTWm8yY65cewB5OozjQjg8hnU42DEASp7lkypEQn9IhcIMNTBKlyx1ZFS7YtIYPar4Q4hPcRzeF9oEyEB+JgVwNnYjzS8aXBkD7sbNG5W6s5weO7tcvjMbV0pqE0TTWtvcMfKLL7kLiSv4oGdaMH4YZ3mzCRK/hmhZcmznQz/FXGN2Eeqruk=
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31eda608-cc58-4b15-336b-08d7fe38d2b2
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2020 10:13:50.5190
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m1XsDOkAFXXwU9VvEnLOqyTMTJT6G/dC3G83N2gKAzmNqZY93db2l5MN+4ckBqoGWj6jCzaUlWBv4UMoRIfO0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB3750
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd, Kevin, Olof,

On Tue,  5 May 2020 17:07:13 +0200 Geert Uytterhoeven wrote:

> 
> 
> Support for Marvell Berlin SoCs depends on ARCH_MULTI_V7.
> As the latter selects HAVE_SMP, there is no need for MACH_BERLIN_BG2 to
> select HAVE_SMP.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Cc: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Acked-by: Arnd Bergmann <arnd@arndb.de>

The patch looks good to me. I want to know what will be the mainline
path of this series. SoC maintainers take it then send A PR to arm-soc?
Or each SoC maintainers ack it, arm-soc will take the whole series?
If later, then

Acked-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>


This is the first time I see a series touch different SoC platforms.

Thanks in advance,
Jisheng

> ---
> v2:
>   - Add Acked-by.
> ---
>  arch/arm/mach-berlin/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/arm/mach-berlin/Kconfig b/arch/arm/mach-berlin/Kconfig
> index 5b1f61fd78780300..01861fa72c9714b7 100644
> --- a/arch/arm/mach-berlin/Kconfig
> +++ b/arch/arm/mach-berlin/Kconfig
> @@ -19,7 +19,6 @@ config MACH_BERLIN_BG2
>         select CPU_PJ4B
>         select HAVE_ARM_SCU if SMP
>         select HAVE_ARM_TWD if SMP
> -       select HAVE_SMP
>         select PINCTRL_BERLIN_BG2
> 
>  config MACH_BERLIN_BG2CD
> --
> 2.17.1
> 

