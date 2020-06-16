Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E5FC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 17:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B93622080D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 17:46:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="dnhPcnhP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730801AbgFPRqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 13:46:24 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:58202 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727083AbgFPRqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 13:46:24 -0400
Received: from pendragon.ideasonboard.com (81-175-216-236.bb.dnainternet.fi [81.175.216.236])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id AEBA6F9;
        Tue, 16 Jun 2020 19:46:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1592329580;
        bh=Ix9rcVGOxVvbzxxwJK2JdywpynNO9C+izdn2hXCu8fM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dnhPcnhP8V1YiZOGHxfwj01/bT4/JmbgYgVIA0V0gywpwZ6FH7ccqa5ixo+m8su7n
         VrHIvulQfeBrGEdsHBsqV76KeR6pAdlFZev3HwIafZ39DYSIyt4qwVAetQOBy8XhsU
         wtoKpIfHRwM5LFWDYB48pd3UpkUScC+CCmfQYgTk=
Date:   Tue, 16 Jun 2020 20:45:58 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Emil Velikov <emil.l.velikov@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Derek Basehore <dbasehore@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>, Sean Paul <sean@poorly.run>,
        linux-tegra@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v2 0/5] 180 degrees rotation support for NVIDIA Tegra DRM
Message-ID: <20200616174558.GA913@pendragon.ideasonboard.com>
References: <20200614200121.14147-1-digetx@gmail.com>
 <CACvgo51QuXMgWhFk4C=3rGvUZDX1_W0RZtVb5RtRPiHTpMebWQ@mail.gmail.com>
 <8f789ef5-bebf-c869-784d-afda70fc1fb8@gmail.com>
 <CACvgo50oSMbgXw1vHwVT4hhGe6g3YzKQEohCLJdfDq+0UaN1jw@mail.gmail.com>
 <646b3f37-0f72-7f3b-388f-f71dbcdd5c84@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <646b3f37-0f72-7f3b-388f-f71dbcdd5c84@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 08:20:57PM +0300, Dmitry Osipenko wrote:
> 16.06.2020 18:48, Emil Velikov пишет:
> > On Tue, 16 Jun 2020 at 12:40, Dmitry Osipenko <digetx@gmail.com> wrote:
> >>
> >> 16.06.2020 01:26, Emil Velikov пишет:
> >>> Hi Dmitry,
> >>>
> >>> On Mon, 15 Jun 2020 at 08:28, Dmitry Osipenko <digetx@gmail.com> wrote:
> >>>>
> >>>> Hello!
> >>>>
> >>>> This series adds 180° display plane rotation support to the NVIDIA Tegra
> >>>> DRM driver which is needed for devices that have display panel physically
> >>>> mounted upside-down, like Nexus 7 tablet device for example [1]. Since
> >>>> DRM panel rotation is a new thing for a userspace, currently only
> >>>> Opentegra Xorg driver handles the rotated display panel [2], but this
> >>>> is good enough for the start.
> >>>>
> >>>> Note that later on it should be possible to implement a transparent 180°
> >>>> display rotation for Tegra DRM driver which will remove the need to have
> >>>> a bleeding edge userspace that knows how to rotate display planes and I'm
> >>>> slowly working on it. For the starter we can go with the minimal rotation
> >>>> support, so it's not a blocker.
> >>>>
> >>>> This series is based on the work that was made by Derek Basehore for the
> >>>> Mediatek driver [3], his patch is included into this patchset. I added
> >>>> my tested-by tag to the Derek's patch.
> >>>>
> >>>> Please review and apply, thanks in advance!
> >>>>
> >>>> [1] https://patchwork.ozlabs.org/project/linux-tegra/patch/20200607154327.18589-3-digetx@gmail.com/
> >>>> [2] https://github.com/grate-driver/xf86-video-opentegra/commit/28eb20a3959bbe5bc3a3b67e55977093fd5114ca
> >>>> [3] https://lkml.org/lkml/2020/3/5/1119
> >>>>
> >>>> Changelog:
> >>>>
> >>>> v2: - Dropped "drm/panel: Set display info in panel attach" patch, which
> >>>>       turned out to be obsolete now.
> >>>>
> >>>>     - Renamed the cover-latter, hopefully this will fix the bouncing emails.
> >>>>
> >>>> Derek Basehore (1):
> >>>>   drm/panel: Add helper for reading DT rotation
> >>>>
> >>>> Dmitry Osipenko (4):
> >>>>   drm/panel: lvds: Set up panel orientation
> >>>
> >>> IMHO it's perfectly reasonable to report the panel orientation to
> >>> userspace, which can apply plane rotation as needed.
> >>>
> >>> Although I see that this series, alike Derek's, has a couple of issues:
> >>>  - only a single panel driver is updated
> >>>  - rotation is _not_ listed as supported property, in said panel
> >>> driver device-tree bindings
> >>>
> >>> My personal inclination is that we should aim for a comprehensive solution:
> >>>  - wire all panel drivers, as currently documented (quick grep list below)
> >>>  - document and wire-up the lvds and boe panels - as proposed by you
> >>> and Derek respectively
> >>>
> >>> HTH
> >>> Emil
> >>>
> >>> Documentation/devicetree/bindings/display/himax,hx8357d.txt:2
> >>> Documentation/devicetree/bindings/display/ilitek,ili9225.txt:2
> >>> Documentation/devicetree/bindings/display/ilitek,ili9341.txt:2
> >>> Documentation/devicetree/bindings/display/ilitek,ili9486.yaml:2
> >>> Documentation/devicetree/bindings/display/multi-inno,mi0283qt.txt:2
> >>> Documentation/devicetree/bindings/display/panel/panel-common.yaml:2
> >>> Documentation/devicetree/bindings/display/sitronix,st7586.txt:1
> >>> Documentation/devicetree/bindings/display/sitronix,st7735r.yaml:2
> >>
> >> Rotation is a common DT panel property that is described in the
> >> panel-common.yaml.
> > The property was introduced almost exclusively for tiny drm panels.
> > Those ones are a bit different from the rest (in panel/) -
> > MIPI-DBI/SPI w/o (not connected at least) an actual GPU.
> > 
> > To make it a bit better, the rotation is seemingly performed in the
> > tiny driver itself ouch.
> > 
> >> This property is supported by all panel bindings
> >> because these bindings inherent the common properties from the
> >> panel-common.yaml.
> >>
> > Seems like that was an unintentional change with the conversion to YAML.
> > Beforehand only a few selected panels had rotation. Upon closer look -
> > some panels do have follow-up fixes, to remove/limit the implicit
> > inclusion.
> 
> Interesting.. my understanding that the rotation property is supposed to
> be a generic property which represents physical orientation of a display
> panel and hence it should be applicable to all panels.

Adding a bit more food for thoughts, the DT rotation property for camera
sensor modules has recently been documented with lots of details. See
https://lore.kernel.org/linux-media/20200509090456.3496481-3-jacopo@jmondi.org/,
part of the documentation may be useful for panels.

> > Sam seems like you've done most of the YAML conversion. IMHO it would
> > make sense to revisit the patches and inherit common properties only
> > as applicable.
> > 
> >> I don't think that it makes sense to wire up rotation property to all
> >> panel drivers at once because those drivers will be untested, at least I
> >> don't know anything about those other panels and can't test them. It
> >> will be much better to support the rotation on by as-needed basis for
> >> each panel driver individually.
> > 
> > How about CCing the author and reviewer asking them to test the patch?
> > The only place where the patches might cause an issue is with tiny,
> > although patches would still be appreciated.
> 
> There are quite a lot of panel drivers and I'm a bit doubtful that at
> least half of devices that use those panels have any real use for the
> rotation property. I could write the patches.. but in the end it could
> be a wasted effort if nobody needs it, so I'd prefer not to do it.

-- 
Regards,

Laurent Pinchart
