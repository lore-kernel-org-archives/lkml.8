Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E251C33CA4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 08:00:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B28C2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 08:00:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgAJIAM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 03:00:12 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:33701 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbgAJIAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 03:00:12 -0500
X-Originating-IP: 91.224.148.103
Received: from xps13 (unknown [91.224.148.103])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 846836000E;
        Fri, 10 Jan 2020 08:00:04 +0000 (UTC)
Date:   Fri, 10 Jan 2020 09:00:03 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: display: simple: Add Satoz panel
Message-ID: <20200110090003.1e233d15@xps13>
In-Reply-To: <20200109193203.GA22666@ravnborg.org>
References: <20200109184037.9091-1-miquel.raynal@bootlin.com>
        <20200109193203.GA22666@ravnborg.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Sam Ravnborg <sam@ravnborg.org> wrote on Thu, 9 Jan 2020 20:32:03 +0100:

> Hi Miquel.
> 
> On Thu, Jan 09, 2020 at 07:40:36PM +0100, Miquel Raynal wrote:
> > Satoz is a Chinese TFT manufacturer.
> > Website: http://www.sat-sz.com/English/index.html
> > 
> > Add the compatible for its SAT050AT40H12R2 5.0 inch LCD panel.
> > 
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>  
> 
> Applied this and the following patch to drm-misc-next.
> I manually resolved the conflict in panel-simple.yaml.

Thanks for your work, Sam, this is very appreciated.

Cheers,
Miquèl
