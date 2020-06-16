Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93624C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64DCA207E8
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:57:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ucqd3uRf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730573AbgFPS5t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 14:57:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730543AbgFPS5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 14:57:48 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A70C061573;
        Tue, 16 Jun 2020 11:57:48 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id g44so7267023uae.12;
        Tue, 16 Jun 2020 11:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=++LLNhIunq6DJtsYt7QZbdqySyg8Go49MpsG3rgmJFk=;
        b=ucqd3uRfFrWWfhaWf9cHHzOjFfxjf+pM4uKzNCUtF/d+yZgJyda2W8vRmNZTm1bayL
         ApfngBOpOMdN6PzBTFTDn5ZDvzQ+hZTx/O5Bc61BarswK4M3/TWkbP3G/EDw7yFl6FfN
         b0WGuUH8p94o8xa78M0Pw5GtNyBAXLSbVfEAZ3JVVtxB52wjpaXUrbWmvhrHK7amPaTC
         I89MkXxWZL+P9zfwnOofiMiR05w0LUtemmqwx9eF7rxbYZV5LbvLH4BW4vn5xvvlZeKa
         rO44opmN0Vbscb9rd2pRP5SMuncZsYxio5xx/pJuIGqU3W5RlSOKaL20wL3KjIhGOarv
         eIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=++LLNhIunq6DJtsYt7QZbdqySyg8Go49MpsG3rgmJFk=;
        b=GRIC7JJ91raUgO2YCmNEzq1WuxJgiG5Rgj4dbdbe/LGMW4hteZwH8a4+ACGxmS+Rqt
         /RFK8UEoLBxDMRGmR0MkS/VaAC85aCfwh3d7P7idNbQsF12eI1DII3ylI8ROcs9mXQxl
         zfhIgY2JCpZBvIOh8pdGOiH8xlvZNFbC4PE5mcGail2+7MyW+EL4YAMPf0+EJabvqCxt
         ICglS+iRiGa6V0EGO5uRabtqnF5LA9a5gdOkmCWZ2Fgx6Dccble4GkH3xQh5kxR82aqj
         ucRu33D8zqyJUWw/o7xcct7l4kQVrpgkHJHYp+yhOgUtlg1ZO0U923DU0RmrmjWdIVpX
         0g5w==
X-Gm-Message-State: AOAM533D7f1ElUVAShSB/Yxy6wZlyGv+tB0dDCncPJqdxW5N6GJohFWq
        7hL3QU2HZcv+Zuv9dhdRhy4aMc2k6/TdJlWbIQE=
X-Google-Smtp-Source: ABdhPJyYmytGR8vTEkPVUPgo49cK7EQnTHmS8BVcg2vn5GTHd6Fgny/W6WxC0wlrw/Rf9G2X+D5P4Lx6cnQx09zgPeI=
X-Received: by 2002:ab0:71ce:: with SMTP id n14mr3669545uao.46.1592333867137;
 Tue, 16 Jun 2020 11:57:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200614200121.14147-1-digetx@gmail.com> <CACvgo51QuXMgWhFk4C=3rGvUZDX1_W0RZtVb5RtRPiHTpMebWQ@mail.gmail.com>
 <8f789ef5-bebf-c869-784d-afda70fc1fb8@gmail.com> <CACvgo50oSMbgXw1vHwVT4hhGe6g3YzKQEohCLJdfDq+0UaN1jw@mail.gmail.com>
 <646b3f37-0f72-7f3b-388f-f71dbcdd5c84@gmail.com>
In-Reply-To: <646b3f37-0f72-7f3b-388f-f71dbcdd5c84@gmail.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Tue, 16 Jun 2020 19:54:04 +0100
Message-ID: <CACvgo50BFH5qsPyWx9a1aZ4k5bzjSN-3KTU0BvnZ-nG-hfzKOQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] 180 degrees rotation support for NVIDIA Tegra DRM
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Derek Basehore <dbasehore@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Sean Paul <sean@poorly.run>, linux-tegra@vger.kernel.org,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 16 Jun 2020 at 18:20, Dmitry Osipenko <digetx@gmail.com> wrote:
>
> 16.06.2020 18:48, Emil Velikov =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> > On Tue, 16 Jun 2020 at 12:40, Dmitry Osipenko <digetx@gmail.com> wrote:
> >>
> >> 16.06.2020 01:26, Emil Velikov =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> >>> Hi Dmitry,
> >>>
> >>> On Mon, 15 Jun 2020 at 08:28, Dmitry Osipenko <digetx@gmail.com> wrot=
e:
> >>>>
> >>>> Hello!
> >>>>
> >>>> This series adds 180=C2=B0 display plane rotation support to the NVI=
DIA Tegra
> >>>> DRM driver which is needed for devices that have display panel physi=
cally
> >>>> mounted upside-down, like Nexus 7 tablet device for example [1]. Sin=
ce
> >>>> DRM panel rotation is a new thing for a userspace, currently only
> >>>> Opentegra Xorg driver handles the rotated display panel [2], but thi=
s
> >>>> is good enough for the start.
> >>>>
> >>>> Note that later on it should be possible to implement a transparent =
180=C2=B0
> >>>> display rotation for Tegra DRM driver which will remove the need to =
have
> >>>> a bleeding edge userspace that knows how to rotate display planes an=
d I'm
> >>>> slowly working on it. For the starter we can go with the minimal rot=
ation
> >>>> support, so it's not a blocker.
> >>>>
> >>>> This series is based on the work that was made by Derek Basehore for=
 the
> >>>> Mediatek driver [3], his patch is included into this patchset. I add=
ed
> >>>> my tested-by tag to the Derek's patch.
> >>>>
> >>>> Please review and apply, thanks in advance!
> >>>>
> >>>> [1] https://patchwork.ozlabs.org/project/linux-tegra/patch/202006071=
54327.18589-3-digetx@gmail.com/
> >>>> [2] https://github.com/grate-driver/xf86-video-opentegra/commit/28eb=
20a3959bbe5bc3a3b67e55977093fd5114ca
> >>>> [3] https://lkml.org/lkml/2020/3/5/1119
> >>>>
> >>>> Changelog:
> >>>>
> >>>> v2: - Dropped "drm/panel: Set display info in panel attach" patch, w=
hich
> >>>>       turned out to be obsolete now.
> >>>>
> >>>>     - Renamed the cover-latter, hopefully this will fix the bouncing=
 emails.
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
> >>> Although I see that this series, alike Derek's, has a couple of issue=
s:
> >>>  - only a single panel driver is updated
> >>>  - rotation is _not_ listed as supported property, in said panel
> >>> driver device-tree bindings
> >>>
> >>> My personal inclination is that we should aim for a comprehensive sol=
ution:
> >>>  - wire all panel drivers, as currently documented (quick grep list b=
elow)
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
> > Seems like that was an unintentional change with the conversion to YAML=
.
> > Beforehand only a few selected panels had rotation. Upon closer look -
> > some panels do have follow-up fixes, to remove/limit the implicit
> > inclusion.
>
> Interesting.. my understanding that the rotation property is supposed to
> be a generic property which represents physical orientation of a display
> panel and hence it should be applicable to all panels.
>
You're spot on - it is/should be a generic property.

I believe that in general many panels were mounted in the correct
orientation so the property, kernel and userspace were slow to catch
up. In some cases panels will use flip x+y to denote 180 rotation, yet
lacking the rotation property.
The s6e8aa0 is an example of the last oddity. To make it better, the
two dts in-tree always set both flip x and y.

Tl;Dr: Hysterical raisins

> > Sam seems like you've done most of the YAML conversion. IMHO it would
> > make sense to revisit the patches and inherit common properties only
> > as applicable.
> >
> >> I don't think that it makes sense to wire up rotation property to all
> >> panel drivers at once because those drivers will be untested, at least=
 I
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

That's why I mentioned the rotation introduction or "confusion" if I
may. Skimming through the pre/post YAML device tree bindings and grep
through the panel themselves will greatly reduce the list.
In other words: if neither binding documentation/in-tree dts nor panel
mentions rotation - omit it.

-Emil
