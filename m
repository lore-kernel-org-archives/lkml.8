Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2766C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76E720739
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 16:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727516AbgCTQy0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 12:54:26 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:50877 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbgCTQy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 12:54:26 -0400
Received: from mail.cetitecgmbh.com ([87.190.42.90]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MulyX-1jXYUF3hTf-00rpfa for <linux-kernel@vger.kernel.org>; Fri, 20 Mar
 2020 17:54:24 +0100
Received: from pflvmailgateway.corp.cetitec.com (unknown [127.0.0.1])
        by mail.cetitecgmbh.com (Postfix) with ESMTP id AF3E2650318
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 16:54:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at cetitec.com
Received: from mail.cetitecgmbh.com ([127.0.0.1])
        by pflvmailgateway.corp.cetitec.com (pflvmailgateway.corp.cetitec.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id uvAGQZS8lGqp for <linux-kernel@vger.kernel.org>;
        Fri, 20 Mar 2020 17:54:24 +0100 (CET)
Received: from pfwsexchange.corp.cetitec.com (unknown [10.10.1.99])
        by mail.cetitecgmbh.com (Postfix) with ESMTPS id 7302564F824
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 17:54:24 +0100 (CET)
Received: from pflmari.corp.cetitec.com (10.8.5.41) by
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 20 Mar 2020 17:54:23 +0100
Received: by pflmari.corp.cetitec.com (Postfix, from userid 1000)
        id 6E020804FB; Fri, 20 Mar 2020 17:15:39 +0100 (CET)
Date:   Fri, 20 Mar 2020 17:15:39 +0100
From:   Alex Riesen <alexander.riesen@cetitec.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v2 07/10] dt-bindings: adv748x: add information about
 serial audio interface (I2S/TDM)
Message-ID: <20200320161539.GM4344@pflmari>
Mail-Followup-To: Alex Riesen <alexander.riesen@cetitec.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        driverdevel <devel@driverdev.osuosl.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
References: <cover.1584639664.git.alexander.riesen@cetitec.com>
 <c9ff553f804f178a247dca356306948e971432fb.1584639664.git.alexander.riesen@cetitec.com>
 <20200319180125.GJ14585@pendragon.ideasonboard.com>
 <20200320084406.GB4344@pflmari>
 <CAMuHMdUdVb0LwZDx-MH2FLYYPvgq=uj_3Nrzo9obWAi-Q-2ZnA@mail.gmail.com>
 <20200320090339.GD4344@pflmari>
 <20200320095907.GB5193@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200320095907.GB5193@pendragon.ideasonboard.com>
X-Originating-IP: [10.8.5.41]
X-ClientProxiedBy: PFWSEXCHANGE.corp.cetitec.com (10.10.1.99) To
 PFWSEXCHANGE.corp.cetitec.com (10.10.1.99)
X-EsetResult: clean, is OK
X-EsetId: 37303A290D7F536A6D7660
X-Provags-ID: V03:K1:HxZv8y8RcH6y4dcwnr7xyDX28Qtqcez9PsPtHS+SJv6XYbTCw3n
 yJvD/HG8k26lBLxP9KIKm3/b8kktYePgnnkvlSkmBjaTTXzMBXkGUkxkwaOiJ/3KSV2LaKx
 ey1RiiQXMd3eRv1UmCMfRzeoOyVZdG1I/DqVTdgSZSy7mo4C1GyFpxErnqUQHLgnMhQxRTy
 FCKxUauKIxhBroWV2iknw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xHKqDly397I=:PlliUZ2I8bFROcuS6GXTaJ
 xjB4raWYziO6tivses82KhXFHNgUsXBep+oZkiNuiVBwdKsNPo1YiVHVpw1AJhoY+lVyDUqew
 7ZTyOFyybD549d2ja5uzj0ADjeV5AqwiLCx6y8u14I69hsFLndF6ktcI7y8z65HwxbuiqYhnm
 4fwyW+GP4HIL8OqlqB7iq8VHNTYhU/WlyLwwiJD1as8lUvNaO+zcqUIB8vno9ePVnAuWbBha5
 u8AqC9pX4uwfGX2W+/n89ewMui3PXdnvkH0vzPqWKMK5mXzrcKbhYZJ6LCbD0jVxzr+rV3Gmk
 W/ZHBFBq8K020BlvsU/PgNnp4Avt92/POG7/9Y/XuckiTvzlOYE7bixGAX1l8VLdYJWbiFb6T
 0EDwj7sq0I5ERCCcjgfcmrr+6Bpfdpv3HpSMAZMYqBKVTk/oGSD2K49KRvMv59bu8KH5AjJhn
 zrAKKmtC8Z3UFeDl41in+5QETqS794NP21o2qMylKeugq7U3zWaGMWHy38i7/dwtKdy2UIxYa
 li8opedF+BIDq+ttsxGrz9Pjyva4ORpaoJadw0M+jTYD9il0ZjTB3ri/SDv5PDLoDExAcLFIf
 LGBh3YNGCF0HjLfOjRmJVZk08Z95dquS1Z61QAGlkco+qF4FODqFGNGraoRQI13WapkIkOzbi
 SZxdmHyBfN9hZIYr65milZ4aALk1NUwzj/2e+QlFb5Qwlbn1PlPlZNapAIe1gLHChSXeVwA5O
 j5QNdUTQtoKu9m4KQM2ejcRSh/PYPIjVcp0MbAEY6CMOnOnQV9MGQQU+odSfSueAh7gQxshYo
 U98KB5HOXv81r7XsZQZ+UxnsoAahmejgm/+n8IJWxj0ljZ2LEwDpZHzaQHhoIzOxThARAzy
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Laurent,

Laurent Pinchart, Fri, Mar 20, 2020 10:59:07 +0100:
> On Fri, Mar 20, 2020 at 10:03:39AM +0100, Alex Riesen wrote:
> > Geert Uytterhoeven, Fri, Mar 20, 2020 09:48:14 +0100:
> > > 
> > > You'd be surprised how many board designers would consider this a cheap
> > > 12.288 MHz clock source, without using the I2S port ;-)
> > 
> > Well, I am :-)
> > 
> > Especially considering that the driver will not switch the MCLK pin aktive
> > (all I2S-related pins are tristate by default).
> 
> If the MCLK can't be output without enabling the I2S then I don't mind
> if we make the #clock-cells optional, although, as Geert mentioned,
> someone may still want to use it.

So I settled on just removing the option.

> > And how do I require it to be set unconditionally? By just removing the
> > "if ..." part of the statement?
> 
> Yes. For YAML it's easy too, the hard part is making properties
> conditional :-)

Converting it into YAML turned out a bit more than just reformatting:
some of the explicit bindings schema is only implied in the text format :-(

Takes a while to find out what is what.

Regards,
Alex
