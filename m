Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE55C433F2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 07:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D7662250E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 07:42:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Synaptics.onmicrosoft.com header.i=@Synaptics.onmicrosoft.com header.b="RFT78W6R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgG1Hmu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 03:42:50 -0400
Received: from mail-bn7nam10on2059.outbound.protection.outlook.com ([40.107.92.59]:63521
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727906AbgG1Hmt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 03:42:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MxH+AayICp1CjdQvXIlw5INPK1UIgs0cFVfgCw+Rs14spgyN2p3pUbjKbQAaKUzrLxgwuwxJzeSvSoCmX9+adXRpVsrtyyz0eEz4JiAKJ1ecRop5Un/+Lee8CWRbeLzJz5EtXTYuTp7L/W76dqtq9HERNKUObrQVyxyNQ4Yq7Qu7jtRX0YqOETSBpINbuI0S/rjdMgIo0ANWCnn9ETmIfD2PGIyEpV8MM5HAFtznIeWnWpsQT/WlMYQmIh0mkjwcoAy9GmPCQnvpCe3f6hUJXbrIWQOUKSb93BA0sVMhaI9JS2ql0x7flTGTHzZ6cIvYw61F6r04rv+F2hyzEwu1iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vszl4LrHCF9qbcL6OTbMaWkgsLFAU/h3wyuvp/3MVvQ=;
 b=mtNpwGk8Tsd6SzWQJDXwDoW1mUHzuRdS49/gKAmCJGTl3PXSvDv82bZU4+VUiYgF4pNXXX31h1OgwrIUhy6PneL9+JLjqTzdpi3xNSrTk9kN18cNDTg4Zia2HGuA8qVU62PawCxUUwYI7fkpMxePgumgyMroiXpRjEtcfkgmO3MMoYoeyEkAHHvX0uzP5i+LDT8wbLymgyqaBJF6ivRsjN4fJtkHw3s/X5Jo2lBDnPceElcDxZuotOiWqZY/I16MmbYuwP7cIaXtH1msK1Xfph0Nv557/LTyiOXt4+KFZ82oj4J80v6FUmiP578kAHTOpA55CjA/LQkJ867NzJloGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synaptics.com; dmarc=pass action=none
 header.from=synaptics.com; dkim=pass header.d=synaptics.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Synaptics.onmicrosoft.com; s=selector2-Synaptics-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vszl4LrHCF9qbcL6OTbMaWkgsLFAU/h3wyuvp/3MVvQ=;
 b=RFT78W6Rks09SKw+W2ZcciNEs/5oZEEi+GEpxs5L6A7hfD5UrhAp3thltdC52cUvWAXiB0nJdf7qLtwfpjaDxVJl/QdKo3wecBa+4pLWpcyTioMAh6iLTTWxdT0bvip576KDHtrz3ck1G5SbtMyWZmHsBwARkJmqWhOD7qgZIRU=
Authentication-Results: arndb.de; dkim=none (message not signed)
 header.d=none;arndb.de; dmarc=none action=none header.from=synaptics.com;
Received: from BYAPR03MB3573.namprd03.prod.outlook.com (2603:10b6:a02:ae::15)
 by BY5PR03MB5094.namprd03.prod.outlook.com (2603:10b6:a03:1f1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.26; Tue, 28 Jul
 2020 07:42:42 +0000
Received: from BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::b5cc:ca6b:3c25:a99c]) by BYAPR03MB3573.namprd03.prod.outlook.com
 ([fe80::b5cc:ca6b:3c25:a99c%4]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 07:42:42 +0000
Date:   Tue, 28 Jul 2020 15:42:07 +0800
From:   Jisheng Zhang <Jisheng.Zhang@synaptics.com>
To:     Arnd Bergmann <arnd@arndb.de>
List-Id: <soc.lore.kernel.org>
Cc:     Krzysztof Kozlowski <krzk@kernel.org>, SoC Team <soc@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Olof Johansson <olof@lixom.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: berlin: Align L2 cache-controller nodename
 with dtschema
Message-ID: <20200728154207.444ec4cc@xhacker.debian>
In-Reply-To: <CAK8P3a26kvOP=3EEDaOFtO5YbqTwBsUr_eKDc5nWxw=NgzZ0MQ@mail.gmail.com>
References: <20200626080642.4244-1-krzk@kernel.org>
        <20200728143650.32818d3c@xhacker.debian>
        <CAK8P3a26kvOP=3EEDaOFtO5YbqTwBsUr_eKDc5nWxw=NgzZ0MQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYAPR01CA0123.jpnprd01.prod.outlook.com
 (2603:1096:404:2d::15) To BYAPR03MB3573.namprd03.prod.outlook.com
 (2603:10b6:a02:ae::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xhacker.debian (124.74.246.114) by TYAPR01CA0123.jpnprd01.prod.outlook.com (2603:1096:404:2d::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16 via Frontend Transport; Tue, 28 Jul 2020 07:42:39 +0000
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
X-Originating-IP: [124.74.246.114]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ac092f2-4515-409f-358c-08d832c9cf21
X-MS-TrafficTypeDiagnostic: BY5PR03MB5094:
X-Microsoft-Antispam-PRVS: <BY5PR03MB5094C4037EFA9D9CCFC75D67ED730@BY5PR03MB5094.namprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FssryRtRN1FotZXBzOSXh2OMchb4z7CaopY/Ed4jDpW2QfrH/k6lb5/Nke4DmobHaCh66eKxibwqhLFvA8T5g1T8hrwyAbwnLupcJeRm7U9KTnSKDegMbkJM96BW5WKkdbwF/HvQLYs23R1vmDkLUIBZpERKjCzRnmLViF6M8Ryk05+OAqbD/yrD4p7iMtYObh8VOt/jD/1Vdo3kIfLQJeQ67OZjzOoKX/G/BUaFBz+kth/ndf9jXCnBmiUjwcYvfoa4IoNi6Gt43CcExvJ4++0Okfuu9RUkS8zCBZl9RV0cThL3aIYPyYqKBgZsO4yZ
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR03MB3573.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39860400002)(396003)(376002)(366004)(346002)(7416002)(478600001)(4744005)(6506007)(5660300002)(1076003)(53546011)(6916009)(4326008)(8936002)(7696005)(52116002)(54906003)(16526019)(86362001)(55016002)(2906002)(83380400001)(956004)(6666004)(9686003)(316002)(186003)(8676002)(66476007)(66556008)(66946007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: H0xqy1QZvIO5HzAuF8RUiSnJ3xf47b0z+dPiqLC/XC4ExpVb8Y3wX113275wkM/yqHPRIyg3qrBTHVC4eqGBSnTaBrvXhcjOxtFIWpbnCPAdDyYJQlRrOlfyX21mSOHSiTvegT8t+CQ2Nd1sN6gP0CqkBKSdF07wfVztEYOJmZukznVJTIEG4TpPCNxi20EEt0fM7FlbXIZokPCQ+ilHDjisMDI+mUAqybGUJK84Rs1sCPhpTvfmAZVV6T/S+OymzdmVe88FPlY0vUGF1I91EQ8n+KzCp87HhDVRCpsogpwnVTlLINBfAKd0T987BXhOAHFDAUcZam67pjfpjAaZEK+WYSMJWdSXO4/0uuh0s9jAlWj2MIoXZVl53mbnw0D5EeROLX73nNTlfjL8aszPWYynnU2waAMdBUK4ZFn5ngWBEPG/jaNKUJvEuU9lZx8YZHsiKiUKJJcGcdDjzKFcG6QXemC9kYJeuTUTElCI7hcvJHZoYU5bF8WVTz8lisuB
X-OriginatorOrg: synaptics.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ac092f2-4515-409f-358c-08d832c9cf21
X-MS-Exchange-CrossTenant-AuthSource: BYAPR03MB3573.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 07:42:42.1038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 335d1fbc-2124-4173-9863-17e7051a2a0e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P2XxmWJ6PeApzJlAKQfhCfwbR4kKyd1k5cpIPFct5Lcd9C65cO7i/tv3yV86dtGB17hpN5PUAt/P73ZfDAvayg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR03MB5094
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Jul 2020 09:33:05 +0200 Arnd Bergmann wrote:


> 
> 
> On Tue, Jul 28, 2020 at 8:37 AM Jisheng Zhang
> <Jisheng.Zhang@synaptics.com> wrote:
> >
> > Hi arm-soc,
> >
> >
> > On Fri, 26 Jun 2020 10:06:41 +0200 Krzysztof Kozlowski wrote:
> >  
> > >
> > >
> > > Fix dtschema validator warnings like:
> > >     l2-cache-controller@ac0000: $nodename:0:
> > >         'l2-cache-controller@ac0000' does not match '^(cache-controller|cpu)(@[0-9a-f,]+)*$'
> > >
> > > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>  
> >
> > Reviewed-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> >
> > As for berlin linux-5.9, we only have this one patch, could you please
> > directly take this patch?  
> 
> Applied now. To ensure we actually see the patch, it's better if you can just
> send a new copy with your added Signed-off-by to soc@kernel.org than to
> reply to the original email.
> 

Got it. Thanks for the your kind reminding
