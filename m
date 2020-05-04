Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D80C4724C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BC17206B8
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 19:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgEDTEN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 15:04:13 -0400
Received: from smtprelay0193.hostedemail.com ([216.40.44.193]:45406 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727866AbgEDTEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 15:04:09 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 90A1018022F46;
        Mon,  4 May 2020 19:04:05 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: scarf42_6021543c5600
X-Filterd-Recvd-Size: 2806
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Mon,  4 May 2020 19:04:01 +0000 (UTC)
Message-ID: <7af4a2979fb5c060af769a996d3e5917b4d265d0.camel@perches.com>
Subject: Re: [PATCH] docs: dt: fix broken links due to txt->yaml renames
From:   Joe Perches <joe@perches.com>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Sam Ravnborg <sam@ravnborg.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        alsa-devel@alsa-project.org,
        Olivier Moysan <olivier.moysan@st.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        Liam Girdwood <lgirdwood@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>, Jyri Sarha <jsarha@ti.com>,
        Mark Brown <broonie@kernel.org>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Sandy Huang <hjc@rock-chips.com>, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
Date:   Mon, 04 May 2020 12:04:00 -0700
In-Reply-To: <20200504175553.jdm7a7aabloevxba@pengutronix.de>
References: <967df5c3303b478b76199d4379fe40f5094f3f9b.1588584538.git.mchehab+huawei@kernel.org>
         <20200504174522.GA3383@ravnborg.org>
         <20200504175553.jdm7a7aabloevxba@pengutronix.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-05-04 at 19:55 +0200, Uwe Kleine-König wrote:
> Hi Sam,
> 
> On Mon, May 04, 2020 at 07:45:22PM +0200, Sam Ravnborg wrote:
> > On Mon, May 04, 2020 at 11:30:20AM +0200, Mauro Carvalho Chehab wrote:
> > > There are some new broken doc links due to yaml renames
> > > at DT. Developers should really run:
> > > 
> > > 	./scripts/documentation-file-ref-check
> > > 
> > > in order to solve those issues while submitting patches.
> > Would love if some bot could do this for me on any patches that creates
> > .yaml files or so.
> > I know I will forget this and it can be automated.
> > If I get a bot mail that my patch would broke a link I would
> > have it fixed before it hits any tree.
> 
> What about adding a check to check_patch?

There's already a checkpatch warning when a patch renames
a file without a MAINTAINERS update.

