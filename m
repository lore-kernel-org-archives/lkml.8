Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80C0AC83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E2CB2074A
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 10:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtVONm21"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgD2Kmp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 06:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgD2Kmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 06:42:45 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BDDBC03C1AD;
        Wed, 29 Apr 2020 03:42:45 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id s10so1902367iln.11;
        Wed, 29 Apr 2020 03:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HQCeKCJ5flepvrlwaiupKHsPEVU0GNt4+HY/TULi0WE=;
        b=AtVONm21nVueyYOEjkLYejUuBgYmxhMXAOBhsMlPX4Y63BJoJJznDF9cqHZmyfgW0O
         04PtTzKuPGXkTqiqqqBvOSFQU/tY5aTy3h+MquydTM6cAPaBtEd6QeD2Uzsepwoacgm7
         EUrA3PX0EU8XgdtbJ+bZsdmKkufFj0oNquC3cxRGn+RecOq7qZDjjp7hZ3uPz2wH+Ry3
         NBfwS8axrMNb1W6FT32Z/fQgaiBUd8Qps4nva+s2HqC0qOFnAJ9rzcatLlD9PeMgx70t
         136uEHWPN8bvCD/EyvQ9ojuvl8tslWqieT1qIV8Aa3jT2L0yGihxHY1V4GtkXlSo53l+
         B9EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HQCeKCJ5flepvrlwaiupKHsPEVU0GNt4+HY/TULi0WE=;
        b=XrcXS2OatrR2TBXsLmIDqbgpZwHssz6NFDE0u5b1VVr6rx/nfpdxGwb9hAjhfo8pTK
         eVTfZ1NFapIVZjwYHMjVtVSL2VDdFISPK8E5xpAjIQNlErrNabagCrtzWj/cfP1UIRPV
         2fxdPxgxJ1mlACHtP7kuuykInORUHOgCewKlk328WpIbZ94esxi4ZUPtIExkdsbJkYwP
         sJV4aW87m0PgDqKL9i2pwi3qSIYtYFRy7IqyBKQmdCMiaAjzMs6MwEzUoo7Oo7G+hTcL
         DAaKpd6z3NSkFpHPAc5Ie5yCmi06ImxXCCuXmlqV1W3RniXNhBNtHkAg8uTaO04Dt8Un
         +/tA==
X-Gm-Message-State: AGi0PuaiazBJLju45AVza/AroyevKaffrrgLig+V1c8B5iDBkHJ1Yc/5
        MI00csM+VaoJk2u6O6e1gVZUyCIadbdELUI8fv+bgvJwZG6Spg==
X-Google-Smtp-Source: APiQypKL531i2NUS2jYYEqcP5uqHNVeBcZJLsXULczyPxkeF1g0mvYUtPJLWYzGXNriIVhhoi4PDnZCKXk4FbGoGWwc=
X-Received: by 2002:a92:d443:: with SMTP id r3mr31485691ilm.293.1588156964317;
 Wed, 29 Apr 2020 03:42:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200426120442.11560-1-peron.clem@gmail.com> <20200426120442.11560-5-peron.clem@gmail.com>
 <20200428080020.35qcuylwq2ylmubu@gilmour.lan> <CAJiuCcc2LQ4L36KSfO8iLVFBUO6k+zsZFX+_Ovm_10PoWO4AsA@mail.gmail.com>
 <20200428160417.6q5oab2guaumhhwi@gilmour.lan> <CAJiuCccFFUJJzXwygLQbDK4fGJ61p72Hv7vj3WVP-=z=J1Yj0Q@mail.gmail.com>
 <031ee5d3-8a30-82ee-76db-c0e8a1073046@arm.com> <CAGb2v65rRbRpUTdkTF3hd5LnLQQt19YVOyVzM5te5XNVhQQH=A@mail.gmail.com>
 <20200429081729.qa3gqtl5sof2jhem@gilmour.lan>
In-Reply-To: <20200429081729.qa3gqtl5sof2jhem@gilmour.lan>
From:   =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
Date:   Wed, 29 Apr 2020 12:42:33 +0200
Message-ID: <CAJiuCceGDm3HJydesXvL=Wr1_LCAsewfKAB73YV5J7eAgTRpOA@mail.gmail.com>
Subject: Re: [linux-sunxi] Re: Audio sound card name [was [PATCH 4/7] arm64:
 dts: allwinner: a64: Add HDMI audio]
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     Chen-Yu Tsai <wens@csie.org>, Robin Murphy <robin.murphy@arm.com>,
        Mark Brown <broonie@kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Takashi Iwai <tiwai@suse.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Marcus Cooper <codekipper@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 29 Apr 2020 at 10:17, Maxime Ripard <maxime@cerno.tech> wrote:
>
> On Wed, Apr 29, 2020 at 02:24:00PM +0800, Chen-Yu Tsai wrote:
> > On Wed, Apr 29, 2020 at 1:11 AM Robin Murphy <robin.murphy@arm.com> wro=
te:
> > >
> > > On 2020-04-28 5:49 pm, Cl=C3=A9ment P=C3=A9ron wrote:
> > > > Hi Mark, Rob,
> > > >
> > > > On Tue, 28 Apr 2020 at 18:04, Maxime Ripard <maxime@cerno.tech> wro=
te:
> > > >>
> > > >> On Tue, Apr 28, 2020 at 10:54:00AM +0200, Cl=C3=A9ment P=C3=A9ron =
wrote:
> > > >>> Hi Maxime,
> > > >>>
> > > >>> On Tue, 28 Apr 2020 at 10:00, Maxime Ripard <maxime@cerno.tech> w=
rote:
> > > >>>>
> > > >>>> On Sun, Apr 26, 2020 at 02:04:39PM +0200, Cl=C3=A9ment P=C3=A9ro=
n wrote:
> > > >>>>> From: Marcus Cooper <codekipper@gmail.com>
> > > >>>>>
> > > >>>>> Add a simple-soundcard to link audio between HDMI and I2S.
> > > >>>>>
> > > >>>>> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> > > >>>>> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> > > >>>>> Signed-off-by: Cl=C3=A9ment P=C3=A9ron <peron.clem@gmail.com>
> > > >>>>> ---
> > > >>>>>   arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 21 ++++++++++=
+++++++++
> > > >>>>>   1 file changed, 21 insertions(+)
> > > >>>>>
> > > >>>>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/ar=
ch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > > >>>>> index e56e1e3d4b73..08ab6b5e72a5 100644
> > > >>>>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > > >>>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
> > > >>>>> @@ -102,6 +102,25 @@
> > > >>>>>                status =3D "disabled";
> > > >>>>>        };
> > > >>>>>
> > > >>>>> +     hdmi_sound: hdmi-sound {
> > > >>>>> +             compatible =3D "simple-audio-card";
> > > >>>>> +             simple-audio-card,format =3D "i2s";
> > > >>>>> +             simple-audio-card,name =3D "allwinner,hdmi";
> > > >>>>
> > > >>>> I'm not sure what the usual card name should be like though. I w=
ould assume that
> > > >>>> this should be something specific enough so that you're able to =
differentiate
> > > >>>> between boards / SoC so that the userspace can choose a differen=
t configuration
> > > >>>> based on it?
> > > >>>
> > > >>> I really don't know what we should use here,
> > > >>> I just have a look at other SoC:
> > > >>> rk3328: "HDMI"
> > > >>> rk3399: "hdmi-sound"
> > > >>> r8a774c0-cat874: "CAT874 HDMI sound"
> > > >>>
> > > >>> But maybe it's time to introduce proper name:
> > > >>> What about :
> > > >>> pat
> > > >>> sun50i-h6-hdmi
> > > >>
> > > >> It's pretty much what we've been using for the other sound cards w=
e have, so it
> > > >> makes sense to me.
> > > >
> > > > I have a question regarding the simple-audio-card,name.
> > > > In this patch, I would like to introduce a simple-audio-card for th=
e
> > > > Allwinner A64 HDMI.
> > > >
> > > > What should be the preferred name for this sound card?
> > > > "sun50i-a64-hdmi" ? "allwinner, sun50i-a64-hdmi" ?
> > >
> > > I can at least speak for RK3328, and the reasoning there was that as =
the
> > > user looking at what `aplay -l` says, I don't give a hoot about what =
the
> > > SoC may be called, I see two cards and I want to know, with the least
> > > amount of uncertainty, which one will make the sound come out of the
> > > port that's labelled "HDMI" on the box ;)
> >
> > I agree. The user really doesn't care what SoC the system uses. The onl=
y
> > real requirement is to be able to tell which output the card is related
> > to, i.e. is it onboard or an external DAC, is it analog or HDMI, etc..
>
> Yeah, but it's exactly the point.
>
> If we also end up with "HDMI" as our card name, then the userspace has no=
 way to
> tell anymore if it's running from an rk3328 or an allwinner SoC, or somet=
hing
> else entirely. And therefore it cannot really configure anything to work =
out of
> the box anymore.

Yes the final user doesn't care if it's sun50i A64 HDMI or sun50i H6
HDMI, but like Maxime said between final user and the sound-card name
you may want to have a configuration layer.
This configuration layer can apply different settings depending on the
sound card.
Having too generic name will make impossible specific card configuration.

Also you can have specific name per board which can be quite clear for
final user.
 - sun50i-a64-hdmi
 - sun50i-a64-spdif
is not so hard to understand that one point to the HDMI whereas the
other point to SPDIF.

Regards,
Clement

>
> Maxime
