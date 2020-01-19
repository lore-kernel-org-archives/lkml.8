Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A03CBC33CB6
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 21:38:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E20F206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 21:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbgASViY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 16:38:24 -0500
Received: from asavdk4.altibox.net ([109.247.116.15]:44552 "EHLO
        asavdk4.altibox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbgASViY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 16:38:24 -0500
Received: from ravnborg.org (unknown [158.248.194.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by asavdk4.altibox.net (Postfix) with ESMTPS id 95E5780402;
        Sun, 19 Jan 2020 22:38:17 +0100 (CET)
Date:   Sun, 19 Jan 2020 22:38:16 +0100
From:   Sam Ravnborg <sam@ravnborg.org>
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     "robh@kernel.org" <robh@kernel.org>,
        "info@logictechno.com" <info@logictechno.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "airlied@linux.ie" <airlied@linux.ie>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "j.bauer@endrich.com" <j.bauer@endrich.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>
Subject: Re: [PATCH v2 3/3] dt-bindings: display: panel: add bindings for
 logic technologies displays
Message-ID: <20200119213815.GA3363@ravnborg.org>
References: <20191027142609.12754-1-marcel@ziswiler.com>
 <20191027142609.12754-3-marcel@ziswiler.com>
 <20191030142835.GA31293@bogus>
 <db84ef6c90a9f327bc32c4948109c759b572a2af.camel@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db84ef6c90a9f327bc32c4948109c759b572a2af.camel@toradex.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=VcLZwmh9 c=1 sm=1 tr=0
        a=UWs3HLbX/2nnQ3s7vZ42gw==:117 a=UWs3HLbX/2nnQ3s7vZ42gw==:17
        a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=kj9zAlcOel0A:10 a=m8ToADvmAAAA:8
        a=k76NmfXvAAAA:8 a=mQzObvnkkXBxZI0lgikA:9 a=jNJEgBlmj-K6qGMv:21
        a=WmImvuMBWUKtNAjK:21 a=CjuIK1q_8ugA:10 a=kCrBFHLFDAq2jDEeoMj9:22
        a=xklTzJp5TIrWR6y8xC-k:22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcel.

On Sun, Jan 19, 2020 at 09:25:02PM +0000, Marcel Ziswiler wrote:
> Sorry, just noticed that this has not gone through yet.
> 
> On Wed, 2019-10-30 at 09:28 -0500, Rob Herring wrote:
> > On Sun, Oct 27, 2019 at 03:26:09PM +0100, Marcel Ziswiler wrote:
> > > From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > > 
> > > Add bindings for the following 3 previously added display panels
> > > manufactured by Logic Technologies Limited:
> > > 
> > > - LT161010-2NHC e.g. as found in the Toradex Capacitive Touch
> > > Display
> > > 7" Parallel [1]
> > > - LT161010-2NHR e.g. as found in the Toradex Resistive Touch
> > > Display 7"
> > > Parallel [2]
> > > - LT170410-2WHC e.g. as found in the Toradex Capacitive Touch
> > > Display
> > > 10.1" LVDS [3]
> > > 
> > > Those panels may also be distributed by Endrich Bauelemente
> > > Vertriebs
> > > GmbH [4].
> > > 
> > > [1] 
> > > https://docs.toradex.com/104497-7-inch-parallel-capacitive-touch-display-800x480-datasheet.pdf
> > > [2] 
> > > https://docs.toradex.com/104498-7-inch-parallel-resistive-touch-display-800x480.pdf
> > > [3] 
> > > https://docs.toradex.com/105952-10-1-inch-lvds-capacitive-touch-display-1280x800-datasheet.pdf
> > > [4] 
> > > https://www.endrich.com/isi50_isi30_tft-displays/lt170410-1whc_isi30
> > > 
> > > Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> > > 
> > > ---
> > > 
> > > Changes in v2:
> > > - New patch adding display panel bindings as well as suggested by
> > > Rob.
> > > 
> > >  .../panel/logictechno,lt161010-2nhc.yaml      | 44
> > > +++++++++++++++++++
> > >  .../panel/logictechno,lt161010-2nhr.yaml      | 44
> > > +++++++++++++++++++
> > >  .../panel/logictechno,lt170410-2whc.yaml      | 44
> > > +++++++++++++++++++
> > >  3 files changed, 132 insertions(+)
> > >  create mode 100644
> > > Documentation/devicetree/bindings/display/panel/logictechno,lt16101
> > > 0-2nhc.yaml
> > >  create mode 100644
> > > Documentation/devicetree/bindings/display/panel/logictechno,lt16101
> > > 0-2nhr.yaml
> > >  create mode 100644
> > > Documentation/devicetree/bindings/display/panel/logictechno,lt17041
> > > 0-2whc.yaml
> > 
> > I would just put these into 1 document as the compatible is the only 
> > difference.
> 
> No, not quite just the compatible are different as the first and last
> panel feature capacitive touch while the middle one is resistive and
> the first two panels are parallel RGB ones while the last one is an
> LVDS panel.

We have recently introduced panel-simple.yaml.
This is for dumb panels - where some of your panels could be candidates.
Please see the file in drm-misc-next, which is also where we will apply
you patch in the end.
So base the patch on drm-misc-next so we do not get conflicts when applying.

	Sam
