Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C653C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07ECE2067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:19:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="CMehT3Zf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgCLJTk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 05:19:40 -0400
Received: from mail-am6eur05on2105.outbound.protection.outlook.com ([40.107.22.105]:46060
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725978AbgCLJTk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 05:19:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHpWDAOcKcGZL1GqNUblW2P80oj23ADMEh0MP7ia1LmFkxrJY4MlWutZx0G4872OTpdmIPTy2OW/Qf7nfLFkoPoOyks3wm70zSo+MqGRaIAa/t9Q8+IkuiNG+rywcF7YIRAXjNj7GHDYH/wDRV2WLEAgiZ00fNIOYaCPRQKaTUO/RCAZcYcFNunhmkaV/YU19EIG4hAR6bmfJ4JkC+C8SCyd9CAhiYVvCOSmfWLtLzgTshmHbZRpdOKbqjMKCOjgkbxaChn/sNOOBw2p5p/ndbCBLFf9flSeR9X7BtdEYbSTKwNwGpisIMo0tkBLGscDslbW0mEsOOVA7Y3pRBr35g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3++/2pTKS8kOwO3uvCIXrygSeiMUxOvcf6PjUd5NHHQ=;
 b=R3kR8eOROjgiB8tdmEcsVk3jANLeLPrt6b3nNQ9u1An1z0y7jU2pRmwfHsVFrc5HgRImFE/hQDSrxnaZRw30o5OgiXgCRWMpiSJZIe83Iv6zyQUTvokntktH9peFxlk4s8F0zDFO1h8IIY40fq6vXHnoyHlCuScynEU8XE47OQIjqEisOUK2Rs4x5R3A5kanHnBJjaTPoQ0a1OE1OskU7Z1tvKq0Z0Qw4dO4OQV7P7zGSaRv7/sm+TnJ3RFOS409PfDrB+CuvWDj3Qh0cmHkw6HI3fRhIxUz5FJWsMoxng9JL45rKdlUTc7YEzKPpwvXP7jWsTurl5rVTXKO0mZJ4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3++/2pTKS8kOwO3uvCIXrygSeiMUxOvcf6PjUd5NHHQ=;
 b=CMehT3Zf/WD1alc4p+BaSbzKFXfGeIYiocpV4n+CO2J94zoAyRaYcjbI8AKT9vgtHW5AMvcq9oMYbjXlabjRQaViUfJxoFQKDA99rK79mhwHrl2U1fJ0ZioRz6kOEmSjP3bhGXX71lVxHOiSB66FfhsZP7PyMIVQriEPNdMQ+1I=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) by
 VI1PR05MB5053.eurprd05.prod.outlook.com (20.177.50.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.14; Thu, 12 Mar 2020 09:19:17 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::7cdd:4feb:a8b6:a6d2]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::7cdd:4feb:a8b6:a6d2%7]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 09:19:16 +0000
X-Gm-Message-State: ANhLgQ1kVyjtbGvTlpiOQB8Rw56I/6WXfqMU7nSm/I66hS6fujBgT9ZF
        vRZnFxdT1MjjiO5dV7y8EHhnYnMwa4/9kh59ee0=
X-Google-Smtp-Source: ADFU+vt+Gknmy2iz1LGVBnmmxJ4cPJO6tlCBI1CnuXhGNwj8Yl1GZu4a4s8YOPSS+ZJd24e6W1nAd5Z7ZRFL5x6acxk=
X-Received: by 2002:ae9:e205:: with SMTP id c5mr6351332qkc.468.1584004742894;
 Thu, 12 Mar 2020 02:19:02 -0700 (PDT)
References: <20200312083830.18011-1-igor.opaniuk@gmail.com> <20200312083830.18011-4-igor.opaniuk@gmail.com>
In-Reply-To: <20200312083830.18011-4-igor.opaniuk@gmail.com>
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Date:   Thu, 12 Mar 2020 11:18:51 +0200
X-Gmail-Original-Message-ID: <CAGgjyvHLrtffpEz4X6GN+6Aoje8DVj-6EiGiNEtMs519QO7Gvw@mail.gmail.com>
Message-ID: <CAGgjyvHLrtffpEz4X6GN+6Aoje8DVj-6EiGiNEtMs519QO7Gvw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm: dts: vf: toradex: SPDX tags and copyright cleanup
To:     Igor Opaniuk <igor.opaniuk@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
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
X-ClientProxiedBy: BL0PR02CA0138.namprd02.prod.outlook.com
 (2603:10b6:208:35::43) To VI1PR05MB3279.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mail-qk1-f173.google.com (209.85.222.173) by BL0PR02CA0138.namprd02.prod.outlook.com (2603:10b6:208:35::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16 via Frontend Transport; Thu, 12 Mar 2020 09:19:07 +0000
Received: by mail-qk1-f173.google.com with SMTP id z25so63978qkj.4;        Thu, 12 Mar 2020 02:19:07 -0700 (PDT)
X-Gm-Message-State: ANhLgQ1kVyjtbGvTlpiOQB8Rw56I/6WXfqMU7nSm/I66hS6fujBgT9ZF
        vRZnFxdT1MjjiO5dV7y8EHhnYnMwa4/9kh59ee0=
X-Google-Smtp-Source: ADFU+vt+Gknmy2iz1LGVBnmmxJ4cPJO6tlCBI1CnuXhGNwj8Yl1GZu4a4s8YOPSS+ZJd24e6W1nAd5Z7ZRFL5x6acxk=
X-Received: by 2002:ae9:e205:: with SMTP id c5mr6351332qkc.468.1584004742894;
 Thu, 12 Mar 2020 02:19:02 -0700 (PDT)
X-Gmail-Original-Message-ID: <CAGgjyvHLrtffpEz4X6GN+6Aoje8DVj-6EiGiNEtMs519QO7Gvw@mail.gmail.com>
X-Originating-IP: [209.85.222.173]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18f1addb-95a1-4c48-2037-08d7c6666a8d
X-MS-TrafficTypeDiagnostic: VI1PR05MB5053:
X-Microsoft-Antispam-PRVS: <VI1PR05MB5053A1C7FAED30F9C168054DF9FD0@VI1PR05MB5053.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(376002)(366004)(39850400004)(396003)(199004)(186003)(316002)(86362001)(42186006)(26005)(8676002)(44832011)(9686003)(8936002)(81156014)(53546011)(81166006)(66556008)(66946007)(54906003)(5660300002)(66476007)(2906002)(450100002)(52116002)(478600001)(6666004)(30864003)(55446002)(6862004)(4326008)(2004002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB5053;H:VI1PR05MB3279.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8brVjRqpXzsUzalJyQlAAo9khLXrbtCd0+jNc2VJj9hiej51EayvmLfr0WO/vuRCjeqgcB/OM8mhPcCBuH66XKLeb4LI0V1KmGdpAv7KCFwLiwLkC5DRXSKvQMebjNWt+ZxfauJLvp1fTVdwMigj+7Izahs7kAn3f0nba0XtOcD7jnSNyn6UGg842gBX2uF2ELdppztMVZqYC3qH4MMKFSiwi4Bqzy5m0Zdz770OoTEAftFwEcoKvyJVBHF/BDJ5lb7x7JXra2hdI7puusuP2k077R4e94DUrFu1P97xF8j32Rj0gBi3xG6Wpnk57t4MWT9tiqsRl8Sp6SO87QXRbWWqvVlEy+PitkQAJhVwhoB4U1yNuzAIrrOe6edndub14Cqtvd4fwzXa/jnVSiu4FHaREnd5gG9tDbT7ftsjP5vbi0I9g+3jTcmtIsrxdu5iW+kh3Dt8TyNZw76ZRTM67cY2R5henjKOmhmrf1zV4UU=
X-MS-Exchange-AntiSpam-MessageData: PQUFYHR6cyZw8qSRfApNzUlMbtqPVaH4tAN01MNXRwiEgUv3lKHmr+1QB60VjGbV0T1FqDPEtMziRwTboJDAyH2EUyESryHtS/rl2qa9bzPRt3qwprX5R/TGOSPSgItxlPrBTwpJPCt86Rt3d2JBXA==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 18f1addb-95a1-4c48-2037-08d7c6666a8d
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 09:19:13.3796
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrETp/xrolfAq9QcogIv3e4KNxNMXyatrRH5iVegzYzIxFmBkgxoH7Ob/iEpivyLVP1zFW3eXsmnhzHN2WK6gOWWRm6cMYXZo4Wnwo5tfVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB5053
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 12, 2020 at 10:39 AM Igor Opaniuk <igor.opaniuk@gmail.com> wrote:
>
> From: Igor Opaniuk <igor.opaniuk@toradex.com>
>
> 1. Replace boiler plate licenses texts with the SPDX license
> identifiers in Toradex Vybrid-based SoM device trees.
> 2. As X11 is identical to the MIT License, but with an extra sentence
> that prohibits using the copyright holders' names for advertising or
> promotional purposes without written permission, use MIT license instead
> of X11 ('s/X11/MIT/g').
> 3. Replace "Toradex AG" with "Toradex" in the Copyright notice.
> 4. Use GPL2.0+ instead of GPL2.0, as it's used now by default for all
> new DTS files.
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>

Reviewed-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

> ---
>
>  arch/arm/boot/dts/vf-colibri-eval-v3.dtsi   | 40 ++-------------------
>  arch/arm/boot/dts/vf-colibri.dtsi           | 39 ++------------------
>  arch/arm/boot/dts/vf500-colibri-eval-v3.dts | 40 ++-------------------
>  arch/arm/boot/dts/vf500-colibri.dtsi        | 40 ++-------------------
>  arch/arm/boot/dts/vf610-colibri-eval-v3.dts | 40 ++-------------------
>  arch/arm/boot/dts/vf610-colibri.dtsi        | 40 ++-------------------
>  arch/arm/boot/dts/vf610m4-colibri.dts       | 39 +-------------------
>  7 files changed, 13 insertions(+), 265 deletions(-)
>
> diff --git a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
> index e2da122a63f4..c12a1b8bc086 100644
> --- a/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
> +++ b/arch/arm/boot/dts/vf-colibri-eval-v3.dtsi
> @@ -1,42 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>  /*
> - * Copyright 2014 Toradex AG
> - *
> - * This file is dual-licensed: you can use it either under the terms
> - * of the GPL or the X11 license, at your option. Note that this dual
> - * licensing only applies to this file, and not this project as a
> - * whole.
> - *
> - *  a) This file is free software; you can redistribute it and/or
> - *     modify it under the terms of the GNU General Public License
> - *     version 2 as published by the Free Software Foundation.
> - *
> - *     This file is distributed in the hope that it will be useful,
> - *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *     GNU General Public License for more details.
> - *
> - * Or, alternatively,
> - *
> - *  b) Permission is hereby granted, free of charge, to any person
> - *     obtaining a copy of this software and associated documentation
> - *     files (the "Software"), to deal in the Software without
> - *     restriction, including without limitation the rights to use,
> - *     copy, modify, merge, publish, distribute, sublicense, and/or
> - *     sell copies of the Software, and to permit persons to whom the
> - *     Software is furnished to do so, subject to the following
> - *     conditions:
> - *
> - *     The above copyright notice and this permission notice shall be
> - *     included in all copies or substantial portions of the Software.
> - *
> - *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> - *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> - *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> - *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> - *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - *     OTHER DEALINGS IN THE SOFTWARE.
> + * Copyright 2014-2020 Toradex
>   */
>
>  / {
> diff --git a/arch/arm/boot/dts/vf-colibri.dtsi b/arch/arm/boot/dts/vf-colibri.dtsi
> index fba37b8756f7..cc1e069c44e6 100644
> --- a/arch/arm/boot/dts/vf-colibri.dtsi
> +++ b/arch/arm/boot/dts/vf-colibri.dtsi
> @@ -1,42 +1,7 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>  /*
> - * Copyright 2014 Toradex AG
> + * Copyright 2014-2020 Toradex
>   *
> - * This file is dual-licensed: you can use it either under the terms
> - * of the GPL or the X11 license, at your option. Note that this dual
> - * licensing only applies to this file, and not this project as a
> - * whole.
> - *
> - *  a) This file is free software; you can redistribute it and/or
> - *     modify it under the terms of the GNU General Public License
> - *     version 2 as published by the Free Software Foundation.
> - *
> - *     This file is distributed in the hope that it will be useful,
> - *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *     GNU General Public License for more details.
> - *
> - * Or, alternatively,
> - *
> - *  b) Permission is hereby granted, free of charge, to any person
> - *     obtaining a copy of this software and associated documentation
> - *     files (the "Software"), to deal in the Software without
> - *     restriction, including without limitation the rights to use,
> - *     copy, modify, merge, publish, distribute, sublicense, and/or
> - *     sell copies of the Software, and to permit persons to whom the
> - *     Software is furnished to do so, subject to the following
> - *     conditions:
> - *
> - *     The above copyright notice and this permission notice shall be
> - *     included in all copies or substantial portions of the Software.
> - *
> - *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> - *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> - *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> - *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> - *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - *     OTHER DEALINGS IN THE SOFTWARE.
>   */
>
>  / {
> diff --git a/arch/arm/boot/dts/vf500-colibri-eval-v3.dts b/arch/arm/boot/dts/vf500-colibri-eval-v3.dts
> index 076998968fb5..088964f8dc4b 100644
> --- a/arch/arm/boot/dts/vf500-colibri-eval-v3.dts
> +++ b/arch/arm/boot/dts/vf500-colibri-eval-v3.dts
> @@ -1,42 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>  /*
> - * Copyright 2014 Toradex AG
> - *
> - * This file is dual-licensed: you can use it either under the terms
> - * of the GPL or the X11 license, at your option. Note that this dual
> - * licensing only applies to this file, and not this project as a
> - * whole.
> - *
> - *  a) This file is free software; you can redistribute it and/or
> - *     modify it under the terms of the GNU General Public License
> - *     version 2 as published by the Free Software Foundation.
> - *
> - *     This file is distributed in the hope that it will be useful,
> - *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *     GNU General Public License for more details.
> - *
> - * Or, alternatively,
> - *
> - *  b) Permission is hereby granted, free of charge, to any person
> - *     obtaining a copy of this software and associated documentation
> - *     files (the "Software"), to deal in the Software without
> - *     restriction, including without limitation the rights to use,
> - *     copy, modify, merge, publish, distribute, sublicense, and/or
> - *     sell copies of the Software, and to permit persons to whom the
> - *     Software is furnished to do so, subject to the following
> - *     conditions:
> - *
> - *     The above copyright notice and this permission notice shall be
> - *     included in all copies or substantial portions of the Software.
> - *
> - *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> - *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> - *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> - *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> - *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - *     OTHER DEALINGS IN THE SOFTWARE.
> + * Copyright 2014-2020 Toradex
>   */
>
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/vf500-colibri.dtsi b/arch/arm/boot/dts/vf500-colibri.dtsi
> index 92255f8893ce..8af7ed56e653 100644
> --- a/arch/arm/boot/dts/vf500-colibri.dtsi
> +++ b/arch/arm/boot/dts/vf500-colibri.dtsi
> @@ -1,42 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>  /*
> - * Copyright 2014 Toradex AG
> - *
> - * This file is dual-licensed: you can use it either under the terms
> - * of the GPL or the X11 license, at your option. Note that this dual
> - * licensing only applies to this file, and not this project as a
> - * whole.
> - *
> - *  a) This file is free software; you can redistribute it and/or
> - *     modify it under the terms of the GNU General Public License
> - *     version 2 as published by the Free Software Foundation.
> - *
> - *     This file is distributed in the hope that it will be useful,
> - *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *     GNU General Public License for more details.
> - *
> - * Or, alternatively,
> - *
> - *  b) Permission is hereby granted, free of charge, to any person
> - *     obtaining a copy of this software and associated documentation
> - *     files (the "Software"), to deal in the Software without
> - *     restriction, including without limitation the rights to use,
> - *     copy, modify, merge, publish, distribute, sublicense, and/or
> - *     sell copies of the Software, and to permit persons to whom the
> - *     Software is furnished to do so, subject to the following
> - *     conditions:
> - *
> - *     The above copyright notice and this permission notice shall be
> - *     included in all copies or substantial portions of the Software.
> - *
> - *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> - *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> - *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> - *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> - *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - *     OTHER DEALINGS IN THE SOFTWARE.
> + * Copyright 2014-2020 Toradex
>   */
>
>  #include "vf500.dtsi"
> diff --git a/arch/arm/boot/dts/vf610-colibri-eval-v3.dts b/arch/arm/boot/dts/vf610-colibri-eval-v3.dts
> index ef9b4d6209f6..fb661e8a2dc6 100644
> --- a/arch/arm/boot/dts/vf610-colibri-eval-v3.dts
> +++ b/arch/arm/boot/dts/vf610-colibri-eval-v3.dts
> @@ -1,42 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>  /*
> - * Copyright 2014 Toradex AG
> - *
> - * This file is dual-licensed: you can use it either under the terms
> - * of the GPL or the X11 license, at your option. Note that this dual
> - * licensing only applies to this file, and not this project as a
> - * whole.
> - *
> - *  a) This file is free software; you can redistribute it and/or
> - *     modify it under the terms of the GNU General Public License
> - *     version 2 as published by the Free Software Foundation.
> - *
> - *     This file is distributed in the hope that it will be useful,
> - *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *     GNU General Public License for more details.
> - *
> - * Or, alternatively,
> - *
> - *  b) Permission is hereby granted, free of charge, to any person
> - *     obtaining a copy of this software and associated documentation
> - *     files (the "Software"), to deal in the Software without
> - *     restriction, including without limitation the rights to use,
> - *     copy, modify, merge, publish, distribute, sublicense, and/or
> - *     sell copies of the Software, and to permit persons to whom the
> - *     Software is furnished to do so, subject to the following
> - *     conditions:
> - *
> - *     The above copyright notice and this permission notice shall be
> - *     included in all copies or substantial portions of the Software.
> - *
> - *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> - *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> - *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> - *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> - *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - *     OTHER DEALINGS IN THE SOFTWARE.
> + * Copyright 2014-2020 Toradex
>   */
>
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/vf610-colibri.dtsi b/arch/arm/boot/dts/vf610-colibri.dtsi
> index 05c9a39509b8..607cec2df861 100644
> --- a/arch/arm/boot/dts/vf610-colibri.dtsi
> +++ b/arch/arm/boot/dts/vf610-colibri.dtsi
> @@ -1,42 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>  /*
> - * Copyright 2014 Toradex AG
> - *
> - * This file is dual-licensed: you can use it either under the terms
> - * of the GPL or the X11 license, at your option. Note that this dual
> - * licensing only applies to this file, and not this project as a
> - * whole.
> - *
> - *  a) This file is free software; you can redistribute it and/or
> - *     modify it under the terms of the GNU General Public License
> - *     version 2 as published by the Free Software Foundation.
> - *
> - *     This file is distributed in the hope that it will be useful,
> - *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *     GNU General Public License for more details.
> - *
> - * Or, alternatively,
> - *
> - *  b) Permission is hereby granted, free of charge, to any person
> - *     obtaining a copy of this software and associated documentation
> - *     files (the "Software"), to deal in the Software without
> - *     restriction, including without limitation the rights to use,
> - *     copy, modify, merge, publish, distribute, sublicense, and/or
> - *     sell copies of the Software, and to permit persons to whom the
> - *     Software is furnished to do so, subject to the following
> - *     conditions:
> - *
> - *     The above copyright notice and this permission notice shall be
> - *     included in all copies or substantial portions of the Software.
> - *
> - *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> - *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> - *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> - *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> - *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - *     OTHER DEALINGS IN THE SOFTWARE.
> + * Copyright 2014-2020 Toradex
>   */
>
>  #include "vf610.dtsi"
> diff --git a/arch/arm/boot/dts/vf610m4-colibri.dts b/arch/arm/boot/dts/vf610m4-colibri.dts
> index d4bc0e3f2f11..2c2db47af441 100644
> --- a/arch/arm/boot/dts/vf610m4-colibri.dts
> +++ b/arch/arm/boot/dts/vf610m4-colibri.dts
> @@ -1,45 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>  /*
>   * Device tree for Colibri VF61 Cortex-M4 support
>   *
>   * Copyright (C) 2015 Stefan Agner
> - *
> - * This file is dual-licensed: you can use it either under the terms
> - * of the GPL or the X11 license, at your option. Note that this dual
> - * licensing only applies to this file, and not this project as a
> - * whole.
> - *
> - *  a) This file is free software; you can redistribute it and/or
> - *     modify it under the terms of the GNU General Public License as
> - *     published by the Free Software Foundation; either version 2 of the
> - *     License, or (at your option) any later version.
> - *
> - *     This file is distributed in the hope that it will be useful,
> - *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> - *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - *     GNU General Public License for more details.
> - *
> - * Or, alternatively,
> - *
> - *  b) Permission is hereby granted, free of charge, to any person
> - *     obtaining a copy of this software and associated documentation
> - *     files (the "Software"), to deal in the Software without
> - *     restriction, including without limitation the rights to use,
> - *     copy, modify, merge, publish, distribute, sublicense, and/or
> - *     sell copies of the Software, and to permit persons to whom the
> - *     Software is furnished to do so, subject to the following
> - *     conditions:
> - *
> - *     The above copyright notice and this permission notice shall be
> - *     included in all copies or substantial portions of the Software.
> - *
> - *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> - *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> - *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> - *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> - *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> - *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> - *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> - *     OTHER DEALINGS IN THE SOFTWARE.
>   */
>
>  /dts-v1/;
> --
> 2.17.1
>


-- 
Best regards
Oleksandr Suvorov

Toradex AG
Ebenaustrasse 10 | 6048 Horw | Switzerland | T: +41 41 500 48 00
