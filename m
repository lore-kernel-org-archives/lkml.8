Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B95EC2BB85
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 70F09214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 07:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729075AbgDQHdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 03:33:00 -0400
Received: from smtprelay0233.hostedemail.com ([216.40.44.233]:57740 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728419AbgDQHdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 03:33:00 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 2884B180284E9;
        Fri, 17 Apr 2020 07:32:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: food81_710b3da05d519
X-Filterd-Recvd-Size: 2062
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Fri, 17 Apr 2020 07:32:56 +0000 (UTC)
Message-ID: <df23fe6083baad4781a2b79bcbd7d3db055eecd3.camel@perches.com>
Subject: Re: [PATCH v2 7/9] media: MAINTAINERS: rkisp1: add path to
 dt-bindings
From:   Joe Perches <joe@perches.com>
To:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Helen Koike <helen.koike@collabora.com>,
        devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        robh+dt@kernel.org, heiko@sntech.de, kernel@collabora.com,
        dafna.hirschfeld@collabora.com, ezequiel@collabora.com,
        mark.rutland@arm.com, karthik.poduval@gmail.com, jbx6244@gmail.com,
        kishon@ti.com
Date:   Fri, 17 Apr 2020 00:30:44 -0700
In-Reply-To: <9a95d227-9592-2c5c-fe6d-dff9b84f4292@xs4all.nl>
References: <20200403161538.1375908-1-helen.koike@collabora.com>
         <20200403161538.1375908-8-helen.koike@collabora.com>
         <9a95d227-9592-2c5c-fe6d-dff9b84f4292@xs4all.nl>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-04-17 at 09:18 +0200, Hans Verkuil wrote:
> On 03/04/2020 18:15, Helen Koike wrote:
> > The Rockchip ISP bindings was moved out of staging.
> > Update MAINTAINERS file with the new path.
> 
> Shouldn't there be a reference to Documentation/devicetree/bindings/phy/rockchip-mipi-dphy-rx0.yaml
> as well in MAINTAINERS?

And please keep the file references F: fields in
alphabetic order.

> > diff --git a/MAINTAINERS b/MAINTAINERS
[]
> > @@ -14303,6 +14303,7 @@ M:	Helen Koike <helen.koike@collabora.com>
> >  L:	linux-media@vger.kernel.org
> >  S:	Maintained
> >  F:	drivers/staging/media/rkisp1/
> > +F:	Documentation/devicetree/bindings/media/rockchip-isp1.yaml
> >  
> >  ROCKCHIP RASTER 2D GRAPHIC ACCELERATION UNIT DRIVER
> >  M:	Jacob Chen <jacob-chen@iotwrt.com>
> > 

