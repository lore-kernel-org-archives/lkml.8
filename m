Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA42C83003
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 03:36:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC02520733
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 03:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=Analogixsemi.onmicrosoft.com header.i=@Analogixsemi.onmicrosoft.com header.b="bbOosWt9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726454AbgD3Dg2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 23:36:28 -0400
Received: from mail-bn8nam11on2125.outbound.protection.outlook.com ([40.107.236.125]:10592
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726309AbgD3Dg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 23:36:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GsW6z1TNwNgnVO8Jtm95REVlh3cXYqHa7zRLyInLUwXNwfk3lL/8C6Ok0VNDQOYnXwjiIOvYDP7LgJwDYGqgKrYZEEC4c7s24hsaFJMaifIGgFl11CuVzG5TnjbqoIwiaWUOl6WWDgnU9nrQOxDXgA8s6FqJ7DsgiDvqrQRVWmBVkmLNYOqOP0rX+UENom9clsMu9oTmZhDubUhvD9qiiOBw069EvUkDGB3+WgZMgMCJTn85RtMnin7kMsDcU90dBbdsId8nxcMYVkDsVeiwY+2ucpiZGkwO21z6BG65MQo39MKWMllP5zFwlwOiJpODpfW2Jp4u2Y9E8FZW5mok2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NobJXkBPXkhSADDNjB5Em1tDmWoTMnJuWf4RyXVOZgE=;
 b=dX1OMnvdTc1SXjNEBXppz5bsfMIrbNOyxDT1prJFF5m6z2J0BXC865CAcnvuX0/wFsdcwgUcmH/fRYopFTBhn6zUgMO/X42xS6ulpCGT34ypZH+gOxVAxPU3iOpomeWbcgnaZEyx1i9PSFag0R3+BuANHdG0+S7ruBQHCkAcWQdfpuMZbLEqnABwwsj/VURqkiNlBtqw/FD6LJx0BH1DHOyV8gcx5SV9JYRe8a1GFx3/ZIE9UB1iWi1FNbrVsvkVgFL3xt2IK1wjiANn/St9JIg7Pg84cwsbDQ2COGCfcR453XsaBjrJLVrFDShHR73sR7OSQj1JYoZtf6Yu0RQDpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analogixsemi.com; dmarc=pass action=none
 header.from=analogixsemi.com; dkim=pass header.d=analogixsemi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=Analogixsemi.onmicrosoft.com; s=selector2-Analogixsemi-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NobJXkBPXkhSADDNjB5Em1tDmWoTMnJuWf4RyXVOZgE=;
 b=bbOosWt9g75v9D0E6bTYiFdMgK0wEKVA4hJShHWgjL8kXgPIokSE4FOCbxTwPde9VnCquaoiysowg5WQse+m/bUxC3JVmQnCMXXcbAzyolpeTUUa6Ye1c9K5Vtbaqrm9NuA11vlnzSWJuS7V8xXOse4GKzu3i7otX0OROELaFCQ=
Authentication-Results: analogixsemi.com; dkim=none (message not signed)
 header.d=none;analogixsemi.com; dmarc=none action=none
 header.from=analogixsemi.com;
Received: from BY5PR04MB6739.namprd04.prod.outlook.com (2603:10b6:a03:229::8)
 by BY5PR04MB6689.namprd04.prod.outlook.com (2603:10b6:a03:228::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Thu, 30 Apr
 2020 03:36:21 +0000
Received: from BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::4517:bcc8:a3bd:407f]) by BY5PR04MB6739.namprd04.prod.outlook.com
 ([fe80::4517:bcc8:a3bd:407f%6]) with mapi id 15.20.2958.020; Thu, 30 Apr 2020
 03:36:21 +0000
Date:   Thu, 30 Apr 2020 11:36:14 +0800
From:   Xin Ji <xji@analogixsemi.com>
To:     Daniel Vetter <daniel@ffwll.ch>,
        Nicolas Boichat <drinkcat@google.com>
Cc:     devel@driverdev.osuosl.org,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Sheng Pan <span@analogixsemi.com>,
        Qilin Wen <qwen@analogixsemi.com>,
        Ming Liu <mliu@analogixsemi.com>
Subject: Re: [PATCH v7 2/2] drm/bridge: anx7625: Add anx7625 MIPI DSI/DPI to
 DP bridge driver
Message-ID: <20200430033614.GA6645@xin-VirtualBox>
References: <cover.1582529411.git.xji@analogixsemi.com>
 <a81adcf2e79d440edcb7b3989f31efcb80a6e9ff.1582529411.git.xji@analogixsemi.com>
 <CANMq1KBfB6tXFqYGvr=8fV_bpCV5GbVHeEbRs+fuaZba65-OPw@mail.gmail.com>
 <20200424065124.GA31922@xin-VirtualBox>
 <CANMq1KBJ6f74aNAr8BwC3wz8MEeJzwXOQE44gv6C=DNzYmUWCQ@mail.gmail.com>
 <20200428100508.GD3456981@phenom.ffwll.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428100508.GD3456981@phenom.ffwll.local>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-ClientProxiedBy: HK0PR03CA0097.apcprd03.prod.outlook.com
 (2603:1096:203:b0::13) To BY5PR04MB6739.namprd04.prod.outlook.com
 (2603:10b6:a03:229::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from xin-VirtualBox (114.247.245.254) by HK0PR03CA0097.apcprd03.prod.outlook.com (2603:1096:203:b0::13) with Microsoft SMTP Server (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA) id 15.20.2958.19 via Frontend Transport; Thu, 30 Apr 2020 03:36:21 +0000
X-Originating-IP: [114.247.245.254]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: afd949fc-13f3-4530-db6c-08d7ecb7a696
X-MS-TrafficTypeDiagnostic: BY5PR04MB6689:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR04MB66892C68B5FAB0B2EDBDEFC7C7AA0@BY5PR04MB6689.namprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-Forefront-PRVS: 0389EDA07F
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR04MB6739.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39840400004)(376002)(396003)(366004)(136003)(346002)(54906003)(33656002)(2906002)(86362001)(33716001)(966005)(6496006)(8676002)(53546011)(478600001)(956004)(6666004)(110136005)(186003)(52116002)(16526019)(66556008)(66476007)(4326008)(5660300002)(9686003)(26005)(1076003)(8936002)(316002)(55016002)(107886003)(66946007)(83080400001)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J8qfGlcmC+zJfoJRULtpnFIIIxLF2e9KlZcOdFy86THRh8q4gzj1wuXHjW/wbZ2BQgz2gBLV86OLd6T8sYJjhLx2AmP69spvcc9BUE+V9x5gnwFriXAn6hXTL2ATtezt5OE7CprgeBZhwNcWsha0VjCNdaG9GGT8DYU5DAFmzVaifYSxexlEZ+V9LSxlsk0wMkamns84nYTqnV0vrpZM9oMGyUfrvxk6QE89Zl3WYqJiEF4RG6nVGB95iEmPPN0cNwMZQQfrKHxekGptj5V7zxBz+VDXJeaQIQJTMdqEYDHgpkdRadVIrozW4E8yZVncZPAo1VcwGdarcR4L9SehVTSEDB1dTeTFFwLQxzjYlVU6S0bxKeqZTgX8qNigcnHIuRmF4bN48ZJDH5ClBzY1amxLGjznYEQk69ooQE9Eu7wlVDeVloHaHEhvRvcBvdBYhUwU6Jbbprbs/0eatVqw2sB84SMpiaCxNatSzYre4jntwA1KryoY/GqksELVNBjamlWyrNO8fpCv1oci+KCrew==
X-MS-Exchange-AntiSpam-MessageData: OwR1GrqwP0B0d49LgRW34Qxp0S19hefkb47QgPvh5CGYyA0CaFkO7KQS4cHKucP15T2NuHQxRtSFcB3Hli8WWXE1L8sApcQzkwrl5es5chl8DQtNBQ9KzmYwG7DgzGA8Yv7olkUWRG8zZ3y8k081L0TnS/EytJ/zpBd3p7bbkjJ7Oo8K715N/+ntp5oJua3qh7XH//d88l+u9fXG5Nmt1mm2xng+DJ/BsCgYyWU15GXG+bYSxek2skYFtple96KK59DOemvVRyRixMw/iCFF8n4NXqIQ6Pygt3yL5eRA3QUzrQGx5lGvU+iLqCT54KjIRVhEI1HYTXOW3yZ75a7ZSUb01+HLyFHtQ7cO3sY+gWhXZbvBF3YmSuhlZYwFi03fYhmo2ot6ihptdNBQsSRMGyBM31/ZuyVujLEr+Rxl2yr3oESaVp6NXslra67FX5TSP46jlqPt+rp+051wu8NoYCRZmJJNJ4dhQCsbxTCWr7z7t8Z1Z4bmk+Qcfkb52UUdfPAUhOSNvB/jaVHt6bYpU+pURKSQy1VmgnH97SVbv282DLjpd1W6YKreTy65gXv8Db13LbSTyOeiD+bmSMc9rKpuQY5L9GizBGn7FX2tibNPO4ke4jztOCx7+mn+ULKt3AucZoH3tKxxI5ELHA1GJ1WkcuiVNtdv1+zF11AsIwl9p96PWPv4MCdb3Aihef0Lpc435lJX24vwRPApJJAEEw7SfMwYu5JS2jvo8SjL0MdL8ZmRQRZ/izv9GlhN3Evo0HFOVYyPvP9FDL8eDgScFqqjMdej29ScPTV65OBSiJ9jetkugCx/rwqRVcTlvtwJ
X-OriginatorOrg: analogixsemi.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afd949fc-13f3-4530-db6c-08d7ecb7a696
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2020 03:36:21.8142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b099b0b4-f26c-4cf5-9a0f-d5be9acab205
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZu3UXc5OZOqfS1+eQaQojDNiqgtL/weWTK3JV8Ge9YpTbhm5R9M3GS2HhApxB7FeaMRmAUnKeIlNEzx9BtVkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR04MB6689
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 28, 2020 at 12:05:08PM +0200, Daniel Vetter wrote:
> On Fri, Apr 24, 2020 at 08:12:04PM +0800, Nicolas Boichat wrote:
> > On Fri, Apr 24, 2020 at 2:51 PM Xin Ji <xji@analogixsemi.com> wrote:
> > >
> > > On Thu, Apr 23, 2020 at 07:55:15PM +0800, Nicolas Boichat wrote:
> > > > Hi,
> > > >
> > > > Just commenting on the mode_fixup function that was added in v7.
> > > >
> > > [snip]
> > > > > +       /*
> > > > > +        * once illegal timing detected, use default HFP, HSYNC, HBP
> > > > > +        */
> > > > > +       if (hblanking < HBLANKING_MIN || (hfp < HP_MIN && hbp < HP_MIN)) {
> > > >
> > > > should this be adj_hblanking/adj_hfp/adj_hbp?
> > > NO, need check original HFP and HBP, if they are not legal, driver need
> > > set default value to adj_hsync, adj_hfp, adj_hbp.
> > > >
> > > > > +               adj_hsync = SYNC_LEN_DEF;
> > > > > +               adj_hfp = HFP_HBP_DEF;
> > > > > +               adj_hbp = HFP_HBP_DEF;
> > > > > +               vref = adj->clock * 1000 / (adj->htotal * adj->vtotal);
> > > > > +               if (hblanking < HBLANKING_MIN) {
> > > > > +                       delta_adj = HBLANKING_MIN - hblanking;
> > > > > +                       adj_clock = vref * delta_adj * adj->vtotal;
> > > > > +                       adj->clock += DIV_ROUND_UP(adj_clock, 1000);
> > > > > +               } else {
> > > > > +                       delta_adj = hblanking - HBLANKING_MIN;
> > > > > +                       adj_clock = vref * delta_adj * adj->vtotal;
> > > > > +                       adj->clock -= DIV_ROUND_UP(adj_clock, 1000);
> > > > > +               }
> > > > > +
> > > > > +               DRM_WARN("illegal hblanking timing, use default.\n");
> > > > > +               DRM_WARN("hfp(%d),hbp(%d),hsync(%d).\n", hfp, hbp, hsync);
> > > >
> > > > How likely is it that this mode is going to work? Can you just return
> > > > false here to reject the mode?
> > > We want to set the default minimal Hblancking value, then it may display,
> > > otherwise. If we just return false, there is no display for sure.
> > 
> > Right, understand your argument. I'm pondering if it's not just better
> > to reject the mode rather than trying a timing that is definitely
> > quite different from what the monitor was asking for. No super strong
> > opinion, I'll let other people on the list weigh in.
> 
> Yeah mode_fixup is supposed to be used to adjust the mode in intermediate
> stages (e.g. if you go from progressive to interlaced only at the end of
> your pipeline or something like that). It's not meant for adjusting the
> mode yout actually put out through a hdmi or dp connector. For fixed
> panels adjusting modes to fit the panel is also fairly common, but not for
> external outputs.
> 
> Since this is a DP bridge I'd say no adjusting, just reject what doesn't
> fit.
We have found some panel which HBP less than 8, if we reject to adjust
video timing, then there is no display. The customer does not accept it,
they push us to fix it, the only resolve way is to adjust timing.
> -Daniel
> -- 
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
