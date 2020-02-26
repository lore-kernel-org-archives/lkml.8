Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F03C4BA11
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:32:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A76921556
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="k3TAXMkO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727590AbgBZJcO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 04:32:14 -0500
Received: from mail-eopbgr50118.outbound.protection.outlook.com ([40.107.5.118]:3718
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726764AbgBZJcN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 04:32:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E1W9m16k46Fl9Vh+ZPjzz9J0adXwfOoMnQfxFwl1xAMlse/+jeApPwJeWC4byP95Wdr2130HopRK6IH8bTp6UX1qlKEX6dBISfIrxAFPww7YN9bFLchSSzm6XEjbBW27+OuBGp+ZEu/480Ijlo6AICSNE9AFMWfclVdKesrsOurBCfYN/32nLR7dPR4vDsco4xFG7ZOzDuZWboxv5x3aq0I3uchOOEwpT/IVFFezu+3GwGXipNBIICod1wfL+GdOcxsFlccsOIoN5tqDiGWKT254vlpwF/tabOAF41EBk7uSGK3/qo7cKfl2vePQg5da3S1tX6gDLvE+UpNdLaMsLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jm6wCoIrSRdae9+OcWUOGpbLSQoLy5TGjyW0FAWqe3w=;
 b=mdaNsU56fLsSTMeoEXja6cjFGBkmrVxgyMqchZga697bIaFlfMLoNJnZ13VHMLqCk8qSb1QSBUsD+iCYA5j8+1vT2fuNwyLDDlbMVwmpwyBe6Eqk8Kp7GarN9iUIhhOtK4LpBV9zOlC/Pp4b5FQKZdrfWWFSvfmn1gMVOHxbv9C7PpIZ25EMLST5EuhMA71NnUHE/iQdMmI9/C0sgeLVygxR8Pp0ZeqkQhyV8ZKXGSSa4ssJ35P9qchW0m4FmQHMZZL/ey7jFSFXJoEg4Va/CXM4IUQdIB9shLGvqa5D4sTnfT8/NeJSyewNM0eTo8CFzh4iRy4dlJXHOX9KgOusXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jm6wCoIrSRdae9+OcWUOGpbLSQoLy5TGjyW0FAWqe3w=;
 b=k3TAXMkOCgNu115rzopY3b6dLGmEoy6VUXa+42Gm5aOeEkAWH1E8TEcfbUcMDKyF6LVhJE0WQt47XzvsLFMROkAnK5Cd9zE/sEZle5WYymIv7o5yf+3/NHJfaENDsVCoIpqic2zcvX4XiOpRYIZpVRvlmlwpHsnzjOsYWWfdbgc=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=oleksandr.suvorov@toradex.com; 
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com (10.170.238.24) by
 VI1PR05MB7038.eurprd05.prod.outlook.com (10.141.234.204) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Wed, 26 Feb 2020 09:32:05 +0000
Received: from VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52]) by VI1PR05MB3279.eurprd05.prod.outlook.com
 ([fe80::c14f:4592:515f:6e52%7]) with mapi id 15.20.2750.021; Wed, 26 Feb 2020
 09:32:04 +0000
X-Gm-Message-State: APjAAAXFa+JLCMltOaVWS7+RxiJgV+84S3bJQFLgc/ipNxvAVp3AuDtF
        iqDj38YbzQ+ODZ1Y6jEAK4gzKJWADSTxhO9uuak=
X-Google-Smtp-Source: APXvYqyqlowJsnKaBefZeDsevUoluXp6clUEDmq1O7fLzUohW6ee/wUVB4wIp1NvZgoJnYzGHWN269GF+EtFofTy6/g=
X-Received: by 2002:a05:620a:22b0:: with SMTP id p16mr3974239qkh.468.1582709166158;
 Wed, 26 Feb 2020 01:26:06 -0800 (PST)
References: <1582565548-20627-1-git-send-email-igor.opaniuk@gmail.com> <1582565548-20627-2-git-send-email-igor.opaniuk@gmail.com>
In-Reply-To: <1582565548-20627-2-git-send-email-igor.opaniuk@gmail.com>
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Date:   Wed, 26 Feb 2020 11:25:54 +0200
X-Gmail-Original-Message-ID: <CAGgjyvGhTCatjR5-qCNn=bfjBhgPOAynYZPh3WF1w7civEuKJw@mail.gmail.com>
Message-ID: <CAGgjyvGhTCatjR5-qCNn=bfjBhgPOAynYZPh3WF1w7civEuKJw@mail.gmail.com>
Subject: Re: [PATCH v1 2/5] arm: dts: imx7: toradex: use SPDX-License-Identifier
To:     Igor Opaniuk <igor.opaniuk@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Stefan Agner <stefan.agner@toradex.com>,
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
X-ClientProxiedBy: CH2PR05CA0029.namprd05.prod.outlook.com (2603:10b6:610::42)
 To VI1PR05MB3279.eurprd05.prod.outlook.com (2603:10a6:802:1c::24)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mail-io1-f50.google.com (209.85.166.50) by CH2PR05CA0029.namprd05.prod.outlook.com (2603:10b6:610::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.12 via Frontend Transport; Wed, 26 Feb 2020 09:32:04 +0000
Received: by mail-io1-f50.google.com with SMTP id m25so2575282ioo.8;        Wed, 26 Feb 2020 01:32:04 -0800 (PST)
X-Gm-Message-State: APjAAAXFa+JLCMltOaVWS7+RxiJgV+84S3bJQFLgc/ipNxvAVp3AuDtF
        iqDj38YbzQ+ODZ1Y6jEAK4gzKJWADSTxhO9uuak=
X-Google-Smtp-Source: APXvYqyqlowJsnKaBefZeDsevUoluXp6clUEDmq1O7fLzUohW6ee/wUVB4wIp1NvZgoJnYzGHWN269GF+EtFofTy6/g=
X-Received: by 2002:a05:620a:22b0:: with SMTP id
 p16mr3974239qkh.468.1582709166158; Wed, 26 Feb 2020 01:26:06 -0800 (PST)
X-Gmail-Original-Message-ID: <CAGgjyvGhTCatjR5-qCNn=bfjBhgPOAynYZPh3WF1w7civEuKJw@mail.gmail.com>
X-Originating-IP: [209.85.166.50]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d39fa997-1ab0-4b53-7c71-08d7ba9ebda4
X-MS-TrafficTypeDiagnostic: VI1PR05MB7038:
X-Microsoft-Antispam-PRVS: <VI1PR05MB70381CE7E51FB7D498E0203EF9EA0@VI1PR05MB7038.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-Forefront-PRVS: 0325F6C77B
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(376002)(39850400004)(136003)(346002)(366004)(199004)(189003)(316002)(86362001)(26005)(6862004)(2906002)(478600001)(52116002)(66946007)(55446002)(5660300002)(66476007)(81156014)(53546011)(4326008)(6666004)(66556008)(44832011)(9686003)(54906003)(30864003)(450100002)(8936002)(8676002)(81166006)(42186006)(186003)(2004002);DIR:OUT;SFP:1102;SCL:1;SRVR:VI1PR05MB7038;H:VI1PR05MB3279.eurprd05.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
Received-SPF: None (protection.outlook.com: toradex.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yQ6NGOu1w3tZP/YAuJUm6C2QtfhIcrM8s9/ehzi7hQA624Pm7RfYb0/uBHAAoBr7eYdU3aExrASAB83k3n8jJJxgu2fkKaciweNLL3UPSxJljn+G8yZlQOLG4a+vZOhGJ3tnuz7G74PE6KqaBTA3U/pJWgEzJ974NS+8pHsGvhKE02dngF3/PqxpMgIbl5JUavW1f/ZSNAYb04S/eryLyRsmOGVkbKFmrMmsm37pCE7EpaRpI7VmHMlG7uSJv+zosU/ihMN9gSokiI30iDgB2EOgHpVMCRZOWAU/o2I20Zx5N1w+xyGA+Sj/MrrIIMfuMY2hBy1Tq4lGw1WVARm+bOhUifp5+SdvKXX4wHSHJNjpToaMPVQsSJqfR2yE2xNpVZ1qNNxRJKWyYF1HUVgnX+Cd4u2xSSrgDyVCgtb9foPtx7b6M+rGklDlQwctpteSDDyaaxnYaMH7KDkk3SaoWTlrBr5IosFMzdPH7jMSmm0=
X-MS-Exchange-AntiSpam-MessageData: sw6OrcCXcb8s52rIEjCyBlH2oWOfNuZ79q0Lt/3+mt6YB70jLcvP6+8R3jB9SfzvDqJt6IhM002q4WvTUKfoqOk/CCR4luFqJfmsr038Ukof3mIOUuQY3tzJS3txRAnQgFXA2KNPx2iJdHai9tabUQ==
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d39fa997-1ab0-4b53-7c71-08d7ba9ebda4
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2020 09:32:04.8625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YJ5Lab0UY47zIwuRB5GOD1Jic9eBLUu89L5Kwuaep2oKJRA/40ofQJNP0ddg+3LYFaie96tIVXY2sOM+BL1Zu1xs8lCWLcwhwX6fGqB9GhA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR05MB7038
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 7:34 PM Igor Opaniuk <igor.opaniuk@gmail.com> wrote:
>
> From: Igor Opaniuk <igor.opaniuk@toradex.com>
>
> 1. Replace boiler plate licenses texts with the SPDX license
> identifiers in Toradex i.MX7-based SoM device trees.
> 2. As X11 is identical to the MIT License, but with an extra sentence
> that prohibits using the copyright holders' names for advertising or
> promotional purposes without written permission, use MIT license instead
> of X11 ('s/X11/MIT/g').
>
> Signed-off-by: Igor Opaniuk <igor.opaniuk@toradex.com>

Reviewed-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

> ---
>
>  arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi | 41 ++---------------------------
>  arch/arm/boot/dts/imx7-colibri.dtsi         | 41 ++---------------------------
>  arch/arm/boot/dts/imx7d-colibri-eval-v3.dts | 41 ++---------------------------
>  arch/arm/boot/dts/imx7d-colibri.dtsi        | 41 ++---------------------------
>  arch/arm/boot/dts/imx7s-colibri-eval-v3.dts | 41 ++---------------------------
>  arch/arm/boot/dts/imx7s-colibri.dtsi        | 41 ++---------------------------
>  6 files changed, 12 insertions(+), 234 deletions(-)
>
> diff --git a/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi b/arch/arm/boot/dts/imx7-colibri-eval-v3.dtsi
> index 6aa123c..0ec2b81 100644
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
> + * Copyright 2016-2020 Toradex AG
>   */
>
>  / {
> diff --git a/arch/arm/boot/dts/imx7-colibri.dtsi b/arch/arm/boot/dts/imx7-colibri.dtsi
> index d05be3f..70fc3a6 100644
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
> + * Copyright 2016-2020  Toradex AG
>   */
>
>  / {
> diff --git a/arch/arm/boot/dts/imx7d-colibri-eval-v3.dts b/arch/arm/boot/dts/imx7d-colibri-eval-v3.dts
> index 136e11a..8ae4c58 100644
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
> + * Copyright 2016-2020 Toradex AG
>   */
>
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/imx7d-colibri.dtsi b/arch/arm/boot/dts/imx7d-colibri.dtsi
> index e2e327f..13331df 100644
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
> + * Copyright 2016-2020 Toradex AG
>   */
>
>  #include "imx7d.dtsi"
> diff --git a/arch/arm/boot/dts/imx7s-colibri-eval-v3.dts b/arch/arm/boot/dts/imx7s-colibri-eval-v3.dts
> index bd2a49c..1d1b438 100644
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
> + * Copyright 2016-2020 Toradex AG
>   */
>
>  /dts-v1/;
> diff --git a/arch/arm/boot/dts/imx7s-colibri.dtsi b/arch/arm/boot/dts/imx7s-colibri.dtsi
> index 6d16e32..3b85b0b 100644
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
> + * Copyright 2016-2020 Toradex AG
>   */
>
>  #include "imx7s.dtsi"
> --
> 2.7.4
>


-- 
Best regards
Oleksandr Suvorov

Toradex AG
Ebenaustrasse 10 | 6048 Horw | Switzerland | T: +41 41 500 48 00
