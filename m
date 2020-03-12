Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDC51C4CECE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:17:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993D72067C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 09:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="VGXOSKAk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgCLJRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 05:17:47 -0400
Received: from mail-am6eur05on2131.outbound.protection.outlook.com ([40.107.22.131]:4803
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726000AbgCLJRr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 05:17:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDjFOtHEewD7KTvtvzIMWBc/r97FmmkA4tPt/CFcXmHFxuWo8OQRyOIcxzz+k9OsZIWEwpl8WdJh0XEKkEp0yHCaAsXtcdE+BDB2SfrREctcYhI9C1iZymtsTFNv31umL3RtStc59hRRoOsfjNHykapAJ6CcaYTvSUAz5/mx2hXVrOH48P2Gy7Cq2fY5uBXHZZ/hlprSc8o0V9MKLMx6w0hj3QkcHfCi5J/1ZZiTCL5UhlebSCQ+ZP/fiZm9KiNIXOpTFwhbQTrIr/iTTTLnAZ9BBpo66opY50ibamoEkUtOLOR/BQM1/yXFEzf+4vNxTZCE+0Ia0ToqFbBCtscJNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mjKG86nSUHyARBNohw8DWaNSfMOtckFMucX5tNLCmo=;
 b=GcgGCONvodE+e/EhkcmMmtyM4zA4CYXghzIBSeIrLeM3XbX/OvuM9g/eynzKtQ5zT6bmYAU5C1b9JhCXxyMv5FOOzcEmfkbDvFTx2FE5G2S2vQO4g1RJ63GDr4/GrcvPAX2R8zA85qN61IQtc9ejjhG+lQE1pgsP9k+VDrMZUAkXggP08c9JJLqS71UGs2j/f12U9sJtcbtQyvl1AHcvRIvzCapDodQ9ICm49fCozBwbkNuECK60ZotJMl1OMIxyg+wo6ADzDwS8XfG6QXMmLBhYWlcUhjRTQlMqHXhy59NB5+RfzeficUdyyU5Kaw/iAd8DDqNW8rDGPcb8f0ZDCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3mjKG86nSUHyARBNohw8DWaNSfMOtckFMucX5tNLCmo=;
 b=VGXOSKAkjybK6A1ll3SLiYnSEePdijcJReaNNBLZqENG3S2qajmImithNoV3eXQrULRVHrs42LSwPoxIBfRxjlKVWbnlsGiNplso2LS+lYQcjLQvjisgtS7HKp2rxuljPbnH3Q7MOXkKWQuVu0IpvukKlqHU8lYmxDu3ICn5znc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) by
 VI1PR05MB5053.eurprd05.prod.outlook.com (20.177.50.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2793.14; Thu, 12 Mar 2020 09:16:05 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::7cdd:4feb:a8b6:a6d2]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::7cdd:4feb:a8b6:a6d2%7]) with mapi id 15.20.2793.018; Thu, 12 Mar 2020
 09:16:05 +0000
X-Gm-Message-State: ANhLgQ2Zz7JTx8hqYvezK0+BcloOEgCOEH5LP21UVYE6AiAxQCt8/wOg
        UAJ/hVLRq2lf5QUds3PW0NEXi3kAa/IY9XejY3g=
X-Google-Smtp-Source: ADFU+vvimqeMEQw/EnBW8BRG+fLZ1l/RvtnlUJTfoxQK+b947Kk/iNs61FwWFel/O17ih2qCqVl5wahcIKnRY0k0yGY=
X-Received: by 2002:a0c:c389:: with SMTP id o9mr6504902qvi.232.1584004560440;
 Thu, 12 Mar 2020 02:16:00 -0700 (PDT)
References: <20200312083830.18011-1-igor.opaniuk@gmail.com> <20200312083830.18011-2-igor.opaniuk@gmail.com>
In-Reply-To: <20200312083830.18011-2-igor.opaniuk@gmail.com>
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Date:   Thu, 12 Mar 2020 11:15:49 +0200
X-Gmail-Original-Message-ID: <CAGgjyvFuR_PhKOZUJFJV1Lrf5SKCF9bc+v8f7RgEY7kHEv7saw@mail.gmail.com>
Message-ID: <CAGgjyvFuR_PhKOZUJFJV1Lrf5SKCF9bc+v8f7RgEY7kHEv7saw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm: dts: imx6: toradex: use SPDX-License-Identifier
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
X-ClientProxiedBy: MN2PR12CA0031.namprd12.prod.outlook.com
 (2603:10b6:208:a8::44) To VI1PR05MB3279.eurprd05.prod.outlook.com
 (2603:10a6:802:1c::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mail-qv1-f45.google.com (209.85.219.45) by MN2PR12CA0031.namprd12.prod.outlook.com (2603:10b6:208:a8::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15 via Frontend Transport; Thu, 12 Mar 2020 09:16:05 +0000
Received: by mail-qv1-f45.google.com with SMTP id a10so2222107qvq.8;        Thu, 12 Mar 2020 02:16:05 -0700 (PDT)
X-Gm-Message-State: ANhLgQ2Zz7JTx8hqYvezK0+BcloOEgCOEH5LP21UVYE6AiAxQCt8/wOg
        UAJ/hVLRq2lf5QUds3PW0NEXi3kAa/IY9XejY3g=
X-Google-Smtp-Source: ADFU+vvimqeMEQw/EnBW8BRG+fLZ1l/RvtnlUJTfoxQK+b947Kk/iNs61FwWFel/O17ih2qCqVl5wahcIKnRY0k0yGY=
X-Received: by 2002:a0c:c389:: with SMTP id o9mr6504902qvi.232.1584004560440;
 Thu, 12 Mar 2020 02:16:00 -0700 (PDT)
X-Gmail-Original-Message-ID: <CAGgjyvFuR_PhKOZUJFJV1Lrf5SKCF9bc+v8f7RgEY7kHEv7saw@mail.gmail.com>
X-Originating-IP: [209.85.219.45]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1ce36ed-1897-41eb-77ca-08d7c665fdfb
X-MS-TrafficTypeDiagnostic: VI1PR05MB5053:
X-Microsoft-Antispam-PRVS: <VI1PR05MB50535E427C92F81CEFCF2887F9FD0@VI1PR05MB5053.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0340850FCD
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(346002)(376002)(366004)(39850400004)(396003)(199004)(186003)(316002)(86362001)(42186006)(26005)(8676002)(44832011)(9686003)(8936002)(81156014)(53546011)(81166006)(66556008)(66946007)(54906003)(5660300002)(66476007)(2906002)(450100002)(55236004)(52116002)(478600001)(6666004)(30864003)(55446002)(6862004)(4326008)(2004002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB5053;H:VI1PR05MB3279.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
Received-SPF: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8RDURYYJ7b392ChgBG+Fdn8NJeuRko4HCkuHP138BfZyaaJnKSTOdAiJrj/s8cHwLHrf9FujCeOxRkP2lphfoUjCUzYLSvZyPwX8W5tw9BJh6qOTs1c6r2fQ+dWUOqoO/rEws1ILHmYkSNu9iqaeQLWculZUOJqyB6/VFIwyqb2StaxYdBCGxybkmkHVNj2fbHW/3yPmXeANyq5lgWX888N4MM6uGA/Rg+IxCB0sFra7H/VBZL3kX2KGVkmKHYotsPPJV+f3bpz36o7aBmHhHFkpmS36VXNgsL+nEgCcG61972cKqskhPkYWAS1k7St/5Rzphf5T2YxAh20ZlaGwrq5jxmlFsHJ8zZod8xF5Fzh1h/BSJ8s9o+NIN5huvwbVJ8rx9k6PJqJ5qqCJnRIvN267YpsTVGf0ZMBuBFSzK8ilV1im37xwbX6xy9QXTGf1rL4+fy9rdJcCXDk7yPnWA2ohDENCXar2kDCRsfcK7io=
X-MS-Exchange-AntiSpam-MessageData: lKgGpski4WxBOywNa9wWwiM0BXtyFMNmqAId94T0Uph9+Q98sREF+c9C8lkgWrjxGhpI9m6rQG0DiPGvz3AyaiYnJa4NYdfyECQYJxcCfTqp939IKViZKkBl7RPx4JDy3QizaZdtvbadwU10996/hA==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1ce36ed-1897-41eb-77ca-08d7c665fdfb
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2020 09:16:05.3695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZM0OM3igQi0K8ZEas4cTLk0P9P9DqdtrzsoEcbkBqIMOhx05FJXbYm3Z4BmvQ4zMYlXFmknDgW9CYDScygc7PMy7lWJ6rL7BAzrfBYwK1JM=
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
> identifiers in Toradex iMX6-based SoM device trees.
> 2. As X11 is identical to the MIT License, but with an extra sentence
> that prohibits using the copyright holders' names for advertising or
> promotional purposes without written permission, use MIT license instead
> of X11 ('s/X11/MIT/g').
> 3. Replace "Toradex AG" with "Toradex" in the Copyright notice.
> 4. Use GPL2.0+ instead of GPL2.0, as it's used now by default for all
> new DTS files from Toradex.
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>

Reviewed-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

> ---
>
>  arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts  | 40 +------------------
>  arch/arm/boot/dts/imx6q-apalis-eval.dts       | 40 +------------------
>  arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts | 40 +------------------
>  arch/arm/boot/dts/imx6q-apalis-ixora.dts      | 40 +------------------
>  arch/arm/boot/dts/imx6qdl-apalis.dtsi         | 40 +------------------
>  arch/arm/boot/dts/imx6qdl-colibri.dtsi        | 40 +------------------
>  6 files changed, 12 insertions(+), 228 deletions(-)
>
> diff --git a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
> index 84fcc203a2e4..65359aece950 100644
> --- a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
> +++ b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
> @@ -1,44 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>  /*
> - * Copyright 2014-2016 Toradex AG
> + * Copyright 2014-2020 Toradex
>   * Copyright 2012 Freescale Semiconductor, Inc.
>   * Copyright 2011 Linaro Ltd.
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
>   */
>
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/imx6q-apalis-eval.dts b/arch/arm/boot/dts/imx6q-apalis-eval.dts
> index 4665e15b196d..fab83abb6466 100644
> --- a/arch/arm/boot/dts/imx6q-apalis-eval.dts
> +++ b/arch/arm/boot/dts/imx6q-apalis-eval.dts
> @@ -1,44 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>  /*
> - * Copyright 2014-2017 Toradex AG
> + * Copyright 2014-2020 Toradex
>   * Copyright 2012 Freescale Semiconductor, Inc.
>   * Copyright 2011 Linaro Ltd.
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
>   */
>
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts b/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
> index a3fa04a97d81..1614b1ae501d 100644
> --- a/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
> +++ b/arch/arm/boot/dts/imx6q-apalis-ixora-v1.1.dts
> @@ -1,44 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>  /*
> - * Copyright 2014-2017 Toradex AG
> + * Copyright 2014-2020 Toradex
>   * Copyright 2012 Freescale Semiconductor, Inc.
>   * Copyright 2011 Linaro Ltd.
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
>   */
>
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/imx6q-apalis-ixora.dts b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
> index 5ba49d0f4880..fa9f98dd15ac 100644
> --- a/arch/arm/boot/dts/imx6q-apalis-ixora.dts
> +++ b/arch/arm/boot/dts/imx6q-apalis-ixora.dts
> @@ -1,44 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>  /*
> - * Copyright 2014-2017 Toradex AG
> + * Copyright 2014-2020 Toradex
>   * Copyright 2012 Freescale Semiconductor, Inc.
>   * Copyright 2011 Linaro Ltd.
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
>   */
>
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/imx6qdl-apalis.dtsi b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> index 1b5bc6b5e806..8382f01affbe 100644
> --- a/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-apalis.dtsi
> @@ -1,44 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>  /*
> - * Copyright 2014-2017 Toradex AG
> + * Copyright 2014-2020 Toradex
>   * Copyright 2012 Freescale Semiconductor, Inc.
>   * Copyright 2011 Linaro Ltd.
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
>   */
>
>  #include <dt-bindings/gpio/gpio.h>
> diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> index d03dff23863d..6e3c6b4925a7 100644
> --- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> @@ -1,44 +1,8 @@
> +// SPDX-License-Identifier: GPL-2.0+ OR MIT
>  /*
> - * Copyright 2014-2016 Toradex AG
> + * Copyright 2014-2020 Toradex
>   * Copyright 2012 Freescale Semiconductor, Inc.
>   * Copyright 2011 Linaro Ltd.
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
>   */
>
>  #include <dt-bindings/gpio/gpio.h>
> --
> 2.17.1
>


-- 
Best regards
Oleksandr Suvorov

Toradex AG
Ebenaustrasse 10 | 6048 Horw | Switzerland | T: +41 41 500 48 00
