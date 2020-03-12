Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75E9EC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F362067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="LXGSD02q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgCLJRg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 05:17:36 -0400
Received: from mail-eopbgr150121.outbound.protection.outlook.com ([40.107.15.121]:33347
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725978AbgCLJRf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 05:17:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NAB+AUNjUu6mBfL+5iSvc/6HQSvZHX5EzbhMNAd+R+UaSweMipvLNWpO509HBPV6VFRHjA/pqGQFhCMq/QDnuYTjHSs0WIsCPKStCXb7jj5BNPljQEw4VmxFiUk8WJsDDRY1WsGQb+nmBR3jZB7P+0VSxEeLXVsLyohSPyxQWO+7h3FpjhTsmvBdh9/tue1UmUckggGVIuKrY0/DfjG8NHfNVibjfvHh6A3COqRYmqoaTLU8sF4IifavYx4qFrl2va4u6pcWmidDSLPZ7AytfOLG0r0zhtezFHjHOCkv78iKT1APeH9+fmctRYFb+EfsazDICzlXUxZniZpKZJg/kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSQhWa2maDf/6BiU3/ljOc69UGGSpW3YuT4SDr7TKFs=;
 b=VQfSbKZrWuJbOq3R7US8b6PQh7+s5izlpehAwKT5Gmvzhck49xx4YgYUI7OWZgw99/GDiITndYwyL1PYbgI0au/r+iJiczNXjhhHnXYFbqWqxupMBKTLsYIPQOVuNTfCXC2unzU+9wchAUW7yHNKkJwcIRuldf97OBIAiwPWYr6aLPoBYLLetq4nSI3j4nbRRlKIYn/wMDsRIsGp6dCRsGdapB642YPxLD9IXzQiXR6rtMYIj2cR0VfwBVfJ+BxVNYMftO/YhBMzWnLSvbLLRTAf66TM44M+5DctryH9a9eGozz94mcVA86dau/aoejo8WYF1In645NvfYyBNcZdAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LSQhWa2maDf/6BiU3/ljOc69UGGSpW3YuT4SDr7TKFs=;
 b=LXGSD02qPXSTGbZ1yPRCZccvjda/ZNMN9BWIdXTo+FDTQ6pI2W3gZebl6ncdIpzBKUH1Z+lMGo77Pa12rtmHuWp6wu8eCdZBSrVi+cKRq2LySLvf8iO59xQOoJj0kdiJlTaC+l0Nt750nXocVaxGbbxmGgvhKwpZ2tzI5dvfU1E=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) by
 VI1PR05MB5053.eurprd05.prod.outlook.com (20.177.50.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.14; Thu, 12 Mar 2020 09:16:56 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::7cdd:4feb:a8b6:a6d2]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::7cdd:4feb:a8b6:a6d2%7]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 09:16:56 +0000
X-Gm-Message-State: ANhLgQ39G0w4N72+0elwIwMujK+o/P/rfFMeYoD/naQP2EEnemcoEeSa
        Rtnc6iuU6MA/ziRikAObYvAZD27VoDZqHg/SzQw=
X-Google-Smtp-Source: ADFU+vsqo9XUdaoXnUYhxkjwkxNUPlHE43zwv1gUy1LagsySjQuXNeodn2FewPnV8aIzhfThqMgY+yn7VUASEZ2Imp4=
X-Received: by 2002:ac8:32fc:: with SMTP id a57mr5855509qtb.331.1584004598741;
 Thu, 12 Mar 2020 02:16:38 -0700 (PDT)
References: <20200312083830.18011-1-igor.opaniuk@gmail.com> <20200312083830.18011-3-igor.opaniuk@gmail.com>
In-Reply-To: <20200312083830.18011-3-igor.opaniuk@gmail.com>
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Date:   Thu, 12 Mar 2020 11:16:27 +0200
X-Gmail-Original-Message-ID: <CAGgjyvEQm2qqqiQo4NaPAGt0aCTSx8nS+xr7mnLgDH_SQPu9Lw@mail.gmail.com>
Message-ID: <CAGgjyvEQm2qqqiQo4NaPAGt0aCTSx8nS+xr7mnLgDH_SQPu9Lw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] arm: dts: imx7: toradex: use SPDX-License-Identifier
To:     Igor Opaniuk <igor.opaniuk@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-ClientProxiedBy: MN2PR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:208:236::7) To VI1PR05MB3279.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mail-qt1-f176.google.com (209.85.160.176) by MN2PR05CA0038.namprd05.prod.outlook.com (2603:10b6:208:236::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2814.6 via Frontend Transport; Thu, 12 Mar 2020 09:16:44 +0000
Received: by mail-qt1-f176.google.com with SMTP id l21so3720080qtr.8;        Thu, 12 Mar 2020 02:16:44 -0700 (PDT)
X-Gm-Message-State: ANhLgQ39G0w4N72+0elwIwMujK+o/P/rfFMeYoD/naQP2EEnemcoEeSa
        Rtnc6iuU6MA/ziRikAObYvAZD27VoDZqHg/SzQw=
X-Google-Smtp-Source: ADFU+vsqo9XUdaoXnUYhxkjwkxNUPlHE43zwv1gUy1LagsySjQuXNeodn2FewPnV8aIzhfThqMgY+yn7VUASEZ2Imp4=
X-Received: by 2002:ac8:32fc:: with SMTP id a57mr5855509qtb.331.1584004598741;
 Thu, 12 Mar 2020 02:16:38 -0700 (PDT)
X-Gmail-Original-Message-ID: <CAGgjyvEQm2qqqiQo4NaPAGt0aCTSx8nS+xr7mnLgDH_SQPu9Lw@mail.gmail.com>
X-Originating-IP: [209.85.160.176]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03b6d29d-e1ae-40d0-572c-08d7c666153f
X-MS-TrafficTypeDiagnostic: VI1PR05MB5053:
X-Microsoft-Antispam-PRVS: <VI1PR05MB5053934486BDD6CAE576AED8F9FD0@VI1PR05MB5053.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(376002)(366004)(39850400004)(396003)(199004)(186003)(316002)(86362001)(42186006)(26005)(8676002)(44832011)(9686003)(8936002)(81156014)(53546011)(81166006)(66556008)(66946007)(54906003)(5660300002)(66476007)(2906002)(450100002)(55236004)(52116002)(478600001)(6666004)(30864003)(55446002)(6862004)(4326008)(2004002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB5053;H:VI1PR05MB3279.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dlEav+P3Y1t91IsHwFwFx7s8la/qht0y3HUC4Y9PDzOEnoSia8WrEA2xnD0N1m9xmBRZgbl4wo93Oa95/Oig99AHdkpwbXOvR8Z/lTTNV0dQamT/hfxiRcKBrFaQaOSs4wl5klzhALnnryeafelOZxZ7AwDxdmndTB7VkT0QXCyOa0a76RJh/q74uiK5gPmDSy4qzePdGfaZqlUe61rSHp10XdPrQOL5amvxYadu+3a/JaY9ayzqV8KnmAUJRPyTEidDdmGsyvIqz/oqndU+A3+UbR6K52b8yMgVQr6y0/IgnhcOylu37zraoz8COefDqIcNXv6jM6lgO36T16ckVDXwVS0VLiriX6QSL0WeeSm0/GZD1fVZa3FcU3BU6XOo91GLLjHIjNk09NlxFMvx8Esjg/Vk+2kSs0h6RSlvhiB51/IzKtZIUvaxLqOTnPB2Kgnqj4HeNed5B0SlnwkxlFdfWCdGhK5RgQz/6iQLERY=
X-MS-Exchange-AntiSpam-MessageData: aV6wFJDa1pw2sNm1RAY/NrCMoNXBL3am58xiDBG3kUWTRUAxLhBaU4SFZ3wBf81HBYNIXFZGUyUd/fBK0QZdQQOpJwSlh5ZBlsrzwgcF9U2O5hZPs5jghbGjX7Va2nc5AzaVTtKoYS8ithR4bQCXnA==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03b6d29d-e1ae-40d0-572c-08d7c666153f
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 09:16:44.3999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VZDT57fUUOLv6/TqrhDkhvT9oB+59YDfPbY2gersF/+6+blMxFyes27i6nZDDESnpXo32sm2DxeZ8kTfBk1cbQyEKsRaTA14vVMeDxQomMo=
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
> identifiers in Toradex i.MX7-based SoM device trees.
> 2. As X11 is identical to the MIT License, but with an extra sentence
> that prohibits using the copyright holders' names for advertising or
> promotional purposes without written permission, use MIT license instead
> of X11 ('s/X11/MIT/g').
> 3. Replace "Toradex AG" with "Toradex" in the Copyright notice.
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>

Reviewed-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

> ---
>
>  arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi | 41 +--------------------
>  arch/arm/boot/dts/imx7-colibri.dtsi         | 41 +--------------------
>  arch/arm/boot/dts/imx7d-colibri-eval-v3.dts | 41 +--------------------
>  arch/arm/boot/dts/imx7d-colibri.dtsi        | 41 +--------------------
>  arch/arm/boot/dts/imx7s-colibri-eval-v3.dts | 41 +--------------------
>  arch/arm/boot/dts/imx7s-colibri.dtsi        | 41 +--------------------
>  6 files changed, 12 insertions(+), 234 deletions(-)
>
> diff --git a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
> index 6aa123cbdadb..146f00dbf852 100644
> --- a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
> +++ b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
> @@ -1,43 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>  /*
> - * Copyright 2016 Toradex AG
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
> + * Copyright 2016-2020 Toradex
>   */
>
>  / {
> diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
> index 04717cf69db0..729ba8b75310 100644
> --- a/arch/arm/boot/dts/imx7-colibri.dtsi
> +++ b/arch/arm/boot/dts/imx7-colibri.dtsi
> @@ -1,43 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>  /*
> - * Copyright 2016 Toradex AG
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
> + * Copyright 2016-2020 Toradex
>   */
>
>  / {
> diff --git a/arch/arm/boot/dts/imx7d-colibri-eval-v3.dts b/arch/arm/boot/dts/imx7d-colibri-eval-v3.dts
> index 136e11ab4893..87b132bcd272 100644
> --- a/arch/arm/boot/dts/imx7d-colibri-eval-v3.dts
> +++ b/arch/arm/boot/dts/imx7d-colibri-eval-v3.dts
> @@ -1,43 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>  /*
> - * Copyright 2016 Toradex AG
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
> + * Copyright 2016-2020 Toradex
>   */
>
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/imx7d-colibri.dtsi b/arch/arm/boot/dts/imx7d-colibri.dtsi
> index e2e327f437e3..c59d72e50920 100644
> --- a/arch/arm/boot/dts/imx7d-colibri.dtsi
> +++ b/arch/arm/boot/dts/imx7d-colibri.dtsi
> @@ -1,43 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>  /*
> - * Copyright 2016 Toradex AG
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
> + * Copyright 2016-2020 Toradex
>   */
>
>  #include "imx7d.dtsi"
> diff --git a/arch/arm/boot/dts/imx7s-colibri-eval-v3.dts b/arch/arm/boot/dts/imx7s-colibri-eval-v3.dts
> index bd2a49c1ade6..aa70d3f2e2e2 100644
> --- a/arch/arm/boot/dts/imx7s-colibri-eval-v3.dts
> +++ b/arch/arm/boot/dts/imx7s-colibri-eval-v3.dts
> @@ -1,43 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>  /*
> - * Copyright 2016 Toradex AG
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
> + * Copyright 2016-2020 Toradex
>   */
>
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/imx7s-colibri.dtsi b/arch/arm/boot/dts/imx7s-colibri.dtsi
> index 6d16e32aed89..94de220a5965 100644
> --- a/arch/arm/boot/dts/imx7s-colibri.dtsi
> +++ b/arch/arm/boot/dts/imx7s-colibri.dtsi
> @@ -1,43 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>  /*
> - * Copyright 2016 Toradex AG
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
> + * Copyright 2016-2020 Toradex
>   */
>
>  #include "imx7s.dtsi"
> --
> 2.17.1
>


-- 
Best regards
Oleksandr Suvorov

Toradex AG
Ebenaustrasse 10 | 6048 Horw | Switzerland | T: +41 41 500 48 00
