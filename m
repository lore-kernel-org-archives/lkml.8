Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19DCFC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E838820767
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 13:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=toradex.com header.i=@toradex.com header.b="k2C+RrmN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbgGJNnM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 09:43:12 -0400
Received: from mail-db8eur05on2133.outbound.protection.outlook.com ([40.107.20.133]:25746
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726828AbgGJNnM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 09:43:12 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLkSf07iTADbM2j2TmfwHQ6f1aOB1Ngd+fWZRZ1R0IBc5d6aLc4LNA6gqyp7kQkP7OzsrzvG46CYoPzFmy797F1eG4ieraBn+4SGzt1JRjZXsq0yHoE5NBL/cDv6EBZtAGg71MFZJ5+p0GtYmxQIfjE2WqjyXcNMAVhTdzmn2d6/0WpyTYdFEN9ok7BjP1FUmiC8i34lMMTjFLoMoR9uDz/tNtSgMTbBSs0Z1yKQOFxkqMxk0ZsFKQ2cPM2s7LKkyQTF4UT7ZqYzYVBKj/2w6Ijlkk9/sbb8tEqgqFFj2rpVNaxz0vUL4rNHEdFkO8Htm6JlCEh2ng443evdhmo3Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgNJNdBRgkUGxrFCBtamX5vo/Gxg61CUU0FWWvS5tQs=;
 b=gvWhaEyg9518eFKKPcVnR1hl9V2EJnVJlQTeE0C19QSWJQhP0dosj1GajRBNw8WXk7KMkoz/WSuNoo6iepqXn0AsmbrIdOeWJHejOjNekS7YkM+GTJ6EgPGyHO3vxyAl1ENM3mV1vFFtVwY8HmGanwMVbMm9uA5vPpOPCxHqQK6I13PQhYAwWuf+6CDTeOULyLOj0q2qixuJGDLGSf9uZoR6KTcEyAFOzRAi0qIPEIQQ1BWOjkXgRUWUhepSE8ixBV/WsLZiqvPvAPqHNzUPr5zH2PV5Cru7Pv+QffLs/IZ592x5xVkQaS5REhhRWFB2TjhRu4cYGzbGkVlO7o2V1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=toradex.com; dmarc=pass action=none header.from=toradex.com;
 dkim=pass header.d=toradex.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=toradex.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgNJNdBRgkUGxrFCBtamX5vo/Gxg61CUU0FWWvS5tQs=;
 b=k2C+RrmNu/zpeU3NIvIPFyVtIRJIx73YPAFfUnc1snPuogHj8N542wP0Glad2VdaduR7KMx5/MQzBMVdcrx1Op3EVVwQ0kZBw2OvdDGXVGMULLnOOuI75xc/oTr6Zkn/dDdaqK8C4W/MfXt1VSQqQJijmnzVroGJ+VRE17xAr4E=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=toradex.com;
Received: from AM0PR05MB6002.eurprd05.prod.outlook.com (2603:10a6:208:129::19)
 by AM4PR0501MB2833.eurprd05.prod.outlook.com (2603:10a6:200:5b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 10 Jul
 2020 13:43:09 +0000
Received: from AM0PR05MB6002.eurprd05.prod.outlook.com
 ([fe80::343d:a818:80a7:3e6]) by AM0PR05MB6002.eurprd05.prod.outlook.com
 ([fe80::343d:a818:80a7:3e6%7]) with mapi id 15.20.3174.022; Fri, 10 Jul 2020
 13:43:08 +0000
X-Gm-Message-State: AOAM5333a748V4LQXpEit9B0t9I/A1gEYooQ3To08piw79eH+6sJuXPM
        kQULlh7kzzBz0mPKMTsSgEJrgm943IXOSE/+gRI=
X-Google-Smtp-Source: ABdhPJzNf0IJcF6AyZgQjPPpDtjsZEtOJqHtbO7eitfoyLlOorLzswO7yF6iIACo/O2GM6qhAYwzKY2FZVeRccj52bs=
X-Received: by 2002:a37:a18f:: with SMTP id k137mr68956359qke.249.1594388584261;
 Fri, 10 Jul 2020 06:43:04 -0700 (PDT)
References: <20200710132423.497230-1-philippe.schenker@toradex.com>
In-Reply-To: <20200710132423.497230-1-philippe.schenker@toradex.com>
From:   Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Date:   Fri, 10 Jul 2020 16:42:52 +0300
X-Gmail-Original-Message-ID: <CAGgjyvGrNPgg3uKGSyvQ=CC1DaHJCTLxeW+GHY0GT7+pG2JuEw@mail.gmail.com>
Message-ID: <CAGgjyvGrNPgg3uKGSyvQ=CC1DaHJCTLxeW+GHY0GT7+pG2JuEw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: dts: colibri-imx6: remove pinctrl-names orphan
To:     Philippe Schenker <philippe.schenker@toradex.com>
Cc:     devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-ClientProxiedBy: BL0PR0102CA0069.prod.exchangelabs.com
 (2603:10b6:208:25::46) To AM0PR05MB6002.eurprd05.prod.outlook.com
 (2603:10a6:208:129::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mail-qk1-f171.google.com (209.85.222.171) by BL0PR0102CA0069.prod.exchangelabs.com (2603:10b6:208:25::46) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend Transport; Fri, 10 Jul 2020 13:43:08 +0000
Received: by mail-qk1-f171.google.com with SMTP id b4so5168835qkn.11;        Fri, 10 Jul 2020 06:43:08 -0700 (PDT)
X-Gm-Message-State: AOAM5333a748V4LQXpEit9B0t9I/A1gEYooQ3To08piw79eH+6sJuXPM
        kQULlh7kzzBz0mPKMTsSgEJrgm943IXOSE/+gRI=
X-Google-Smtp-Source: ABdhPJzNf0IJcF6AyZgQjPPpDtjsZEtOJqHtbO7eitfoyLlOorLzswO7yF6iIACo/O2GM6qhAYwzKY2FZVeRccj52bs=
X-Received: by 2002:a37:a18f:: with SMTP id
 k137mr68956359qke.249.1594388584261; Fri, 10 Jul 2020 06:43:04 -0700 (PDT)
X-Gmail-Original-Message-ID: <CAGgjyvGrNPgg3uKGSyvQ=CC1DaHJCTLxeW+GHY0GT7+pG2JuEw@mail.gmail.com>
X-Originating-IP: [209.85.222.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 789b47fb-d9d2-4bbc-ada2-08d824d72e0e
X-MS-TrafficTypeDiagnostic: AM4PR0501MB2833:
X-Microsoft-Antispam-PRVS: <AM4PR0501MB2833B36A1841E2BBBE87817DF9650@AM4PR0501MB2833.eurprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1051;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3yEyqB6nTObZ5LI347jvPc95jEbt0Vb/5nimTqYOPEyo9zwKiObFHCUzo8h0GjoLpuIRQaBsdjb73IOZ3VkzbwdfyeuPzL2JzsGmjo9fY6TNOZtPXYkJ9XkDuNRTdZJsrehuvbzfKkgT0/IpBzcSoBxlj01YCA4D4SzDViMC9FNN6SC0t3FBPSkl33y/6mLMihoYrMdRXnmM3Vazc5STbJnoBM/CZNR+2AXafw8h6psSI9/CJhyOCy900xTG2qq9MYMo6yTSFfBSeUJR6vTRnmQ/eNRd2iLF8bQKyabv6AOcrbipqoxBEg5ysRQijVqG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR05MB6002.eurprd05.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(39850400004)(346002)(376002)(136003)(2906002)(4326008)(86362001)(6862004)(54906003)(55446002)(52116002)(316002)(42186006)(4744005)(450100002)(478600001)(5660300002)(6636002)(6666004)(9686003)(53546011)(26005)(186003)(44832011)(66946007)(83380400001)(8936002)(8676002)(66556008)(66476007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: kHYYm1ZLK3w73X+/34jY7MZaOE1iwnWMwcZzn4gtlMgWKOMy2wqNNesV36/pW7aJ3M044T10lwC+2N73FH/jX2GI5Jge8iS/O2K78dFLbG664Ipac5vqVkHMiLrjPfR+qr/3hA7/QOM4R++WY+oAiZ+O6WKbU+oIqdqtTu5JHeYFCebMzQ0wvWUrgC13697M08EoVl9m5dLSNdq4dJSCogqx95VqBBpW0Tnakk37p/04Of/lDNh76+RLb+Fk4KYojIrHdBkztRXZF5Bxz/sU3vy4PrtvVS7PBvFwNKhsAvaZ5KneYXvhFiDgnrFLxPTDbhzfbawyQuQrK2nwjD/XMYTxIEBvQYp/ijRqTzpxxFS2p9cDUWSdB370fIJzb4iwIrsKb4JIJCusSmjgPiBwPaGrKUMUbnMRZ4ppwe5xIz3LfNxxHLR4rGCznbTOZArPfh+8vg9+mOhpqdqrD089qZpR57cH8HKSVbUwxK6rodQ=
X-OriginatorOrg: toradex.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 789b47fb-d9d2-4bbc-ada2-08d824d72e0e
X-MS-Exchange-CrossTenant-AuthSource: AM0PR05MB6002.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 13:43:08.3716
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: d9995866-0d9b-4251-8315-093f062abab4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lBE9mh+hRSbSwK5vcU1+0UK/uE6hRWqL/cwNuQRnuhP1y4fLH/5CUt7qY2Meppn2V06ZXvxlYu8LpXheq8/0SrQdIojOU5+s90DI5XnwFQ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0501MB2833
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 4:25 PM Philippe Schenker
<philippe.schenker@toradex.com> wrote:
>
> This is not necessary without a pinctrl-0 statement. Remove this
> orphan.
>
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

Reviewed-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>

> ---
>
>  arch/arm/boot/dts/imx6qdl-colibri.dtsi | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/arch/arm/boot/dts/imx6qdl-colibri.dtsi b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> index 240b86d2eb71..a4a54c82e28f 100644
> --- a/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> +++ b/arch/arm/boot/dts/imx6qdl-colibri.dtsi
> @@ -362,7 +362,6 @@ &uart3 {
>  };
>
>  &usbotg {
> -       pinctrl-names = "default";
>         disable-over-current;
>         dr_mode = "peripheral";
>         status = "disabled";
> --
> 2.27.0
>


-- 
Best regards

Oleksandr Suvorov
cryosay@gmail.com

-- 
Best regards
Oleksandr Suvorov

Toradex AG
Ebenaustrasse 10 | 6048 Horw | Switzerland | T: +41 41 500 48 00
