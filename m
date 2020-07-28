Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D85CC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 613FE21775
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 06:37:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="Hx0ATjOC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgG1GhT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 02:37:19 -0400
Received: from mail-mw2nam10on2040.outbound.protection.outlook.com ([40.107.94.40]:24500
        "EHLO NAM10-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728076AbgG1GhR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 02:37:17 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O+7DIsZ7AwzO+BPDGanJiNXSRZgO804qMluAuIc/x2haRmJMZEYhab9pbtCHqgVqxHykgn4xwW8NdLYhGQ6B64KqdzYSXZmxFnYYU1MZCSuMcZNtN1s0KHdawHKS0p+wPwiKJSY0lhdDLC4j69MJK2odhHJ03bMhn5D7yqhUD2LiNobIi1ZXcQspzv9sZa9kzS6aETw6dvhsJlDOOTdgFbsw+bTiOcGRbWr5Z7u/PJtiBrnw8VbONm09+zwdckdqy8Lqa8NmtS19qE08pw+kV961V2wdfhcR1wHJ3OnY5oe7i70wGIYpfcpnrRtQr3M5ERrBt5fzEa+5Zak9c9gROw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5SKzIJ1og6yhBQg+tYtJbSL9+yVsFuMgzcGcGCT57o=;
 b=Asb1mJOsT/OklEI1jEejEfJsDkye2kzUoRgnIA45ydS+OWuSB4Zp9gj5M2jbkojFaELO1pzi/gsr4cAGvfu9OpSUh6KWkwwa5cXKawMvr5Yj9pXLnaHjxW5wGmJNOa080aUfstbC2pTeb3Xl9o8S7HA1/8TIuyg9RlUu9CNQGkbXGe9jsqHgZBUEd+UplKE9x6+lfhEtPB0tjaUkmlv/idpgvpbUN3jhVpPLBN/gnczuO1e/YiP5Ckq1ic62Kb/S8VEHOH2T+CVm6UrYyytTba4SRgdM1p0VjGyxMa1DKyZbCNIsZh2bgcFmTWOWXoJMmf/VIa+YMrS9wH4O8b9naw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O5SKzIJ1og6yhBQg+tYtJbSL9+yVsFuMgzcGcGCT57o=;
 b=Hx0ATjOCMjc/Cy92+PJIYq9X3CzkvZzhlIZl/2pHowihjrmIzaLWanRHK3TBtfsDhzUXWfeF8nnwLyJwYhfAIyjX/RUHgnkVF203QFU7R29zLjftxeaUjMrsgs3jxDGnzCha4jT7caOgYZjNIbBHRaEjEaHX2bKyp2+mzECrsn0=
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=synaptics.com;
Received: from BYAPR03MB3573.namprd03.prod.outlook.com (2603:10b6:a02:ae::15)
 by BYAPR03MB4517.namprd03.prod.outlook.com (2603:10b6:a03:d2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.21; Tue, 28 Jul
 2020 06:37:14 +0000
Received: from BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::b5cc:ca6b:3c25:a99c]) by BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::b5cc:ca6b:3c25:a99c%4]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 06:37:14 +0000
Date:   Tue, 28 Jul 2020 14:36:50 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
List-Id: <soc.lore.kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>, SoC Team <soc@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>
Cc:     linux-kernel@vger.kernel.org,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] ARM: dts: berlin: Align L2 cache-controller nodename
 with dtschema
Message-ID: <20200728143650.32818d3c@xhacker.debian>
In-Reply-To: <20200626080642.4244-1-krzk@kernel.org>
References: <20200626080642.4244-1-krzk@kernel.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0182.jpnprd01.prod.outlook.com
 (2603:1096:404:ba::26) To BYAPR03MB3573.namprd03.prod.outlook.com
 (2603:10b6:a02:ae::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TYAPR01CA0182.jpnprd01.prod.outlook.com (2603:1096:404:ba::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23 via Frontend Transport; Tue, 28 Jul 2020 06:37:11 +0000
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b3c113a-2f40-46d9-87ed-08d832c0a9ff
X-MS-TrafficTypeDiagnostic: BYAPR03MB4517:
X-Microsoft-Antispam-PRVS: <BYAPR03MB4517BE2F10DB5755C404E9D2ED730@BYAPR03MB4517.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CrTpUdolEq5US32RSEXYJQZSrihhHffOywuzEi6oC3Db3dQ4hcEwVUkLzMjS8wiFF61Ey4Zrd+XDAFmpA9E54vOQA1KNNwWXKlU4LLR/7RjtxapKkEpMOHD3XjGrHMrGUIXHEhml92pr9KtBq/1vJBhakbVQZqXcrBc+b3v6sP7rXVVtg2euooQOb3lnHVhGWnY4WtvpsMwhw934u2FjlDEo2ztltOWJw1JUcB2W9hkHz6sFZUtFjSVZtVpTVwrIPCbIvankms9+0R3miZK3AeKagxpfQOx/QFJpNJzSlJHwxlAueo43j7d/JkgQr6ie2kOuNR78veMaHmyhTermKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3573.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(346002)(39860400002)(366004)(376002)(136003)(396003)(66946007)(66556008)(5660300002)(66476007)(8676002)(86362001)(6506007)(55016002)(52116002)(9686003)(7696005)(110136005)(478600001)(316002)(54906003)(1076003)(186003)(4326008)(16526019)(26005)(956004)(8936002)(83380400001)(2906002)(6666004)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: +UbqYLW1OcvJV6g2JaTvIfJXGew4/zXFF1FtGzE/ivywTMR3Qx+n2mU+y0wDO/TAdOkvVktmMVJ4kkJmT+3CvwBO3ZgWFtphp+dmovWHKtjju9jydRYL9Din5YTf3ecYFYDlFQ3LU9ZEVOd8GJxfmAKCoEGpFJncD7xmSPn8eUebuDOL4wH7BulRavfh3c+mgJhRexL/99sMLjgac0MfXU58ybu0ToQw/1/fAwdEJN3dXOop/N6GgOZ+ibRfu2Om6WmoJWvExSqeHdAaPZeRaOgPGogBPNf2TmAtcbcieaDyxD9+tNl+JEfqgL7ZhkcI290l51tMOGCKTqq3EKVN2BrmwwxvY3LIryBDR1mA3wegllLLN2TLagtqIq3PohjX01+kRtMs95PPcjDLldZjvP5eWIGvVsPaSEVs+sP4t8Ip+J/byd/B/ChaLqV1PEp7LsK0dE1/ls9mOunVEGxY8+8GLybPJ3uX9XGxA/FlfbCpkRtPe5r0I5k6D52l62wj
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b3c113a-2f40-46d9-87ed-08d832c0a9ff
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3573.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 06:37:14.2259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mfo6VlIQtp05hfurA0FQlobL8liOSkjFAe+rTU7AKaDKNBM/addm8t0xbKO+74ski57COuvp8I3YOJhbJX/Pcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR03MB4517
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi arm-soc,


On Fri, 26 Jun 2020 10:06:41 +0200 Krzysztof Kozlowski wrote:

> 
> 
> Fix dtschema validator warnings like:
>     l2-cache-controller@ac0000: $nodename:0:
>         'l2-cache-controller@ac0000' does not match '^(cache-controller|cpu)(@[0-9a-f,]+)*$'
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

Reviewed-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

As for berlin linux-5.9, we only have this one patch, could you please
directly take this patch?

Thanks

> ---
>  arch/arm/boot/dts/berlin2.dtsi   | 2 +-
>  arch/arm/boot/dts/berlin2cd.dtsi | 2 +-
>  arch/arm/boot/dts/berlin2q.dtsi  | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/berlin2.dtsi b/arch/arm/boot/dts/berlin2.dtsi
> index 3ab3cd250da7..6194857f8a02 100644
> --- a/arch/arm/boot/dts/berlin2.dtsi
> +++ b/arch/arm/boot/dts/berlin2.dtsi
> @@ -106,7 +106,7 @@
>                         status = "disabled";
>                 };
> 
> -               l2: l2-cache-controller@ac0000 {
> +               l2: cache-controller@ac0000 {
>                         compatible = "marvell,tauros3-cache", "arm,pl310-cache";
>                         reg = <0xac0000 0x1000>;
>                         cache-unified;
> diff --git a/arch/arm/boot/dts/berlin2cd.dtsi b/arch/arm/boot/dts/berlin2cd.dtsi
> index 7cf3e6302d75..6f30d7eb3b41 100644
> --- a/arch/arm/boot/dts/berlin2cd.dtsi
> +++ b/arch/arm/boot/dts/berlin2cd.dtsi
> @@ -71,7 +71,7 @@
>                         status = "disabled";
>                 };
> 
> -               l2: l2-cache-controller@ac0000 {
> +               l2: cache-controller@ac0000 {
>                         compatible = "arm,pl310-cache";
>                         reg = <0xac0000 0x1000>;
>                         cache-unified;
> diff --git a/arch/arm/boot/dts/berlin2q.dtsi b/arch/arm/boot/dts/berlin2q.dtsi
> index c44a32e873f4..b6a0acac6836 100644
> --- a/arch/arm/boot/dts/berlin2q.dtsi
> +++ b/arch/arm/boot/dts/berlin2q.dtsi
> @@ -149,7 +149,7 @@
>                         status = "disabled";
>                 };
> 
> -               l2: l2-cache-controller@ac0000 {
> +               l2: cache-controller@ac0000 {
>                         compatible = "arm,pl310-cache";
>                         reg = <0xac0000 0x1000>;
>                         cache-unified;
> --
> 2.17.1
> 

