Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0C0C4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6717F20728
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mvAJsBF6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgD0SoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 14:44:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgD0SoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 14:44:08 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA63C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 11:44:06 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id j1so21792332wrt.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 11:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0Se2gPfDV6dVLvV3dXJUZA0zMn+AJUdOhH51aQhU8nY=;
        b=mvAJsBF6xtNVqZlDIr30mT2dIhPkFK1Re5Y61Bsb3yJir9WZZZBw1V4vW/rgAeJ/o4
         oJYSrGUy7rAmuzyWJIEE9ohlmS9i+PyO1wfkmP2MmNUtgiQyehwDRVnfyImwoWBoZbRE
         4P9w5m0G8BMJ9fdhzUe2015uC/D38gq0dLRWRJGpQIlxIphl/zb18ESMDvwBmCWQc88O
         OOGvEFhnylQ2GfIJFRHXh4VOhcjccDIgv4GBI8pZOsoxh7Ii2wVvBlAvOiS/pI1kxQcm
         9IQCriUOal/bQkOU5FpgG4fNmNmfawIvG0q4PPAIOAWpYQUnLi3sYEn8uodsn1Q3jEXg
         epVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0Se2gPfDV6dVLvV3dXJUZA0zMn+AJUdOhH51aQhU8nY=;
        b=SBD/c5dwzuJX/FTtbE3zSVH4l0BEiGDM084qgjyT51n+UVxuU3/9fp2vU8dbXQn+hX
         +Ds1dc2eYCQJk2Z41fuz3LIl5f9z7BuouOGxpLw2ExZXsBgXkRQjm5ONPVJ8fjoVortx
         +0ncLMcPX7AjFGENjnbxi3+UqzPDKl2ZzitEtVYURD8RHs+2zRL+trHwtyfRjoHRwGuu
         B7lUACuGi7S5rBcna60tgWgZb1Y1cPOrC8nG8+f3v/jlDCpoB7sMJuoySMrtjGBNJ01a
         Ax+iZLuIygg8jXWoJFyZsAFUnZlvrTPtq3RLfg/jDvBLhVQ8GbV6yr3e6Y7occbhJfHP
         X1WQ==
X-Gm-Message-State: AGi0PuZsXNhcGkRYCwEHPRDj8gl+7Np2OPnCBaPtFxqiruSDQV4qpibR
        dUkSg73qLFlsywVWXYIkAQQlM/bldVbvgmUZFJseSw==
X-Google-Smtp-Source: APiQypKiKwKYtbSbOSLIBpG/gIsOpmDej3C0UjThZPtiVEfG/LmwWku50637FeQfIQxYOBGMc4idFWIHgW3d8v+gsW0=
X-Received: by 2002:adf:fe45:: with SMTP id m5mr30783793wrs.124.1588013045413;
 Mon, 27 Apr 2020 11:44:05 -0700 (PDT)
MIME-Version: 1.0
References: <PSXP216MB0438D2AF96CE0D4F83F48C4D80AE0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <MN2PR12MB4488E4909C1488FB507E0BF5F7AF0@MN2PR12MB4488.namprd12.prod.outlook.com>
 <s5ho8rdnems.wl-tiwai@suse.de> <PSXP216MB04387BF6B5F8DA84749E5D6F80AF0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <CADnq5_M=QEqxuCKjb_qZvFSvwM5eLEFfsepxYYXoouFoe5bn7A@mail.gmail.com> <s5h4kt4ojrf.wl-tiwai@suse.de>
In-Reply-To: <s5h4kt4ojrf.wl-tiwai@suse.de>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 27 Apr 2020 14:43:54 -0400
Message-ID: <CADnq5_MMQ5_MjEg=bkJJGMJP53RjB3yxvOW0nUDeWxzg3Q0pVQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] Fiji GPU audio register timeout when in BACO state
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Takashi Iwai <tiwai@suse.com>, Lukas Wunner <lukas@wunner.de>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 2:39 PM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Mon, 27 Apr 2020 20:28:12 +0200,
> Alex Deucher wrote:
> >
> > On Mon, Apr 27, 2020 at 2:07 PM Nicholas Johnson
> > <nicholas.johnson-opensource@outlook.com.au> wrote:
> > >
> > > On Mon, Apr 27, 2020 at 05:15:55PM +0200, Takashi Iwai wrote:
> > > > On Mon, 27 Apr 2020 16:22:21 +0200,
> > > > Deucher, Alexander wrote:
> > > > >
> > > > > [AMD Public Use]
> > > > >
> > > > > > -----Original Message-----
> > > > > > From: Nicholas Johnson <nicholas.johnson-opensource@outlook.com=
.au>
> > > > > > Sent: Sunday, April 26, 2020 12:02 PM
> > > > > > To: linux-kernel@vger.kernel.org
> > > > > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Chr=
istian
> > > > > > <Christian.Koenig@amd.com>; Zhou, David(ChunMing)
> > > > > > <David1.Zhou@amd.com>; Nicholas Johnson <nicholas.johnson-
> > > > > > opensource@outlook.com.au>
> > > > > > Subject: [PATCH 0/1] Fiji GPU audio register timeout when in BA=
CO state
> > > > > >
> > > > > > Hi all,
> > > > > >
> > > > > > Since Linux v5.7-rc1 / commit 4fdda2e66de0 ("drm/amdgpu/runpm: =
enable
> > > > > > runpm on baco capable VI+ asics"), my AMD R9 Nano has been usin=
g runpm /
> > > > > > BACO. You can tell visually when it sleeps, because the fan on =
the graphics
> > > > > > card is switched off to save power. It did not spin down the fa=
n in v5.6.x.
> > > > > >
> > > > > > This is great (I love it), except that when it is sleeping, the=
 PCIe audio function
> > > > > > of the GPU has issues if anything tries to access it. You get d=
mesg errors such
> > > > > > as these:
> > > > > >
> > > > > > snd_hda_intel 0000:08:00.1: spurious response 0x0:0x0, last cmd=
=3D0x170500
> > > > > > snd_hda_intel 0000:08:00.1: azx_get_response timeout, switching=
 to polling
> > > > > > mode: last cmd=3D0x001f0500 snd_hda_intel 0000:08:00.1: No resp=
onse from
> > > > > > codec, disabling MSI: last cmd=3D0x001f0500 snd_hda_intel 0000:=
08:00.1: No
> > > > > > response from codec, resetting bus: last cmd=3D0x001f0500
> > > > > > snd_hda_codec_hdmi hdaudioC1D0: Unable to sync register 0x2f0d0=
0. -11
> > > > > >
> > > > > > The above is with the Fiji XT GPU at 0000:08:00.0 in a Thunderb=
olt enclosure
> > > > > > (not that Thunderbolt should affect it, but I feel I should men=
tion it just in
> > > > > > case). I dropped a lot of duplicate dmesg lines, as some of the=
m repeated a
> > > > > > lot of times before the driver gave up.
> > > > > >
> > > > > > I offer this patch to disable runpm for Fiji while a fix is fou=
nd, if you decide
> > > > > > that is the best approach. Regardless, I will gladly test any p=
atches you come
> > > > > > up with instead and confirm that the above issue has been fixed=
.
> > > > > >
> > > > > > I cannot tell if any other GPUs are affected. The only other ca=
rds to which I
> > > > > > have access are a couple of AMD R9 280X (Tahiti XT), which use =
radeon driver
> > > > > > instead of amdgpu driver.
> > > > >
> > > > > Adding a few more people.  Do you know what is accessing the audi=
o?  The audio should have a dependency on the GPU device.  The GPU won't en=
ter runtime pm until the audio has entered runtime pm and vice versa on res=
ume. Please attach a copy of your dmesg output and lspci output.
> > >
> > > pci 0000:08:00.1: D0 power state depends on 0000:08:00.0
> > > The above must be the dependency of which you speak from dmesg.
> > >
> > > Accessing the audio? I did not have a single method for triggering it=
.
> > > Sometimes it happened on shutdown. Sometimes when restarting gdm.
> > > Sometimes when playing with audio settings in Cinnamon Desktop. But m=
ost
> > > often when changing displays. It might have something to do with the
> > > audio device associated with a monitor being created when the monitor=
 is
> > > found. If an audio device is created, then pulseaudio might touch it.
> > > Sorry, this is a very verbose "not quite sure".
> > >
> > > To trigger the bug, this time I did the following:
> > >
> > > 1. Boot laptop without Fiji and log in
> > >
> > > 2. Attach Fiji via Thunderbolt (no displays attached to Fiji) and
> > > approve Thunderbolt device
> > >
> > > 3. Log in again because the session gets killed when GPU is hot-added
> > >
> > > 4. Wait for Fiji to fall asleep (fan stops)
> > >
> > > 5. Open "dmesg -w" on laptop display
> > >
> > > 6. Attach display to DisplayPort on Fiji (it should still stay asleep=
)
> > >
> > > 7. Do WindowsKey+P to activate external display. The error appears in
> > > dmesg window that instant.
> > >
> > > Could it be a race condition when waking the card up?
> > >
> > > I cannot get the graphics card fan to spin down if the Thunderbolt
> > > enclosure is attached at boot time. It only does it if hot-added.
> > >
> > > If you think it will help, I can take out the Fiji and put it in a te=
st
> > > rig and try to replicate the issue without Thunderbolt, but it looks
> > > like it will not spin the fan down if Fiji is attached at boot time.
> > >
> > > Question, why would the fan not spin down if Fiji is attached at boot
> > > time, and how would one make the said fan turn off? Aside from being
> > > useful for pinning down the audio register issue, I would like to mak=
e
> > > sure the power savings are realised whenever the GPU is not being use=
d.
> >
> > Presumably something is using the device.  Maybe a framebuffer console
> > or X?  Or maybe the something like tlp has disabled runtime pm on your
> > device?  You can see the current status by reading the files in
> > /sys/class/drm/cardX/device/power/ .  Replace cardX with card0, card1,
> > etc. depending on which device is the radeon card.
> >
> > FWIW, I have a fiji board in a desktop system and it worked fine when
> > this code was enabled.
>
> Is the new DC code used for Fiji boards?  IIRC, the audio component
> binding from amdgpu is enabled only for DC, and without the audio
> component binding the runtime PM won't be linked up, hence you can't
> power up GPU from the audio side access automatically.
>

Yes, DC is enabled by default for all cards with runtime pm enabled.

Alex

>
> Takashi
>
> >
> > Alex
> >
> > >
> > > >
> > > > Also, please retest with the fresh 5.7-rc3.  There was a known
> > > > regression regarding HD-audio PM in 5.7-rc1/rc2, and it's been fixe=
d
> > > > there (commit 8d6762af302d).
> > > Linux v5.7-rc3 still has the same problem, unfortunately.
> > >
> > > The dmesg is attached.
> > >
> > > Thanks for your replies. Kind regards,
> > > Nicholas
> > >
> > > >
> > > >
> > > > thanks,
> > > >
> > > > Takashi
> > > _______________________________________________
> > > amd-gfx mailing list
> > > amd-gfx@lists.freedesktop.org
> > > https://lists.freedesktop.org/mailman/listinfo/amd-gfx
> >
