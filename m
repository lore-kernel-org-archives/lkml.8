Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8F39C54EEB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83C1320775
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeSCH/YD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbgD0S20 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 14:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726162AbgD0S2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 14:28:24 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4A7C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 11:28:24 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j2so21729208wrs.9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 11:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=lXoPhVMfsKSjXcvEC4GjUyNrcGXob5ebBeEqDOWzHlU=;
        b=OeSCH/YDMQ+JrgCBjJ02MHSwpLtRzzaMaag7ittEf0LsyD3oTG86J2AA2exhr5xz70
         0tIwh7DDykaSyMtaIICAwNJ67aWOjWZJXwIC+idSPGfQalzHoqUeD4UHZUcJ6kX4P+F5
         tXvzFjlF/Tp8USxBRpNEuk5sfPDmrOW8nT0m4qO6iPAdO4eGuWqYGaaN+/GHAOXid6ok
         XrdwWsXz+nnqxM/iCOOZO6xNwJAjZS66pOrHgKRYQME3BIbShlIYPWdVevPluDPLj+JN
         ZEG10AiOwHmQNdBQffa4RRulQJjl2krt2NyC9gZzOKQXrh/6CkjkYLYpgGSItNdRyxA3
         +htQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=lXoPhVMfsKSjXcvEC4GjUyNrcGXob5ebBeEqDOWzHlU=;
        b=DtXNceSP6FWs/Xyn8G/N7ifXXejlCY/sansB087V5vZJMd3fLzmP6AKonBvGp0n/5k
         5YxG/ynGJGQ3mslpECkUktXjSVjtnhzgyekN349QR24aIjOCZv9I4VT+NW0/rf/yIY0v
         BEj1YUwKd/BxPINE+nRdz4VAw7Pj7/NHPHmPaguur546gPpYGYKIIRfJ7g8y7FDnurnM
         rXKjOBKSNEztsE3JkpTSXeGrrxaSfM5CCe0DKOt40BkDGGyvp+NQ885Tv44axXzW4Ez2
         f9dB72olLl0Xj58QLW5ayYy82+ZqGHRZa/TbkK+mJnKQ5nNGx4v0z38oscqTZ7jon/rQ
         V/ZQ==
X-Gm-Message-State: AGi0PubQU/wmyNlJolxek6gSK52lb4nV/7+ezuSapF2Wt6T3T6mUmtxo
        qlGQ2LXVR6PtqkAlLV94iOkR2xjh95kCXCw6Y/U=
X-Google-Smtp-Source: APiQypLyJNAQaCoCAGEpaPUaX9vI3nIlNU+dqROwIziN6xJTgTak3u/+d2Q31LJEwgTqtk5eydTCstzIr975qPzkDYU=
X-Received: by 2002:a5d:498d:: with SMTP id r13mr29815025wrq.374.1588012103103;
 Mon, 27 Apr 2020 11:28:23 -0700 (PDT)
MIME-Version: 1.0
References: <PSXP216MB0438D2AF96CE0D4F83F48C4D80AE0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <MN2PR12MB4488E4909C1488FB507E0BF5F7AF0@MN2PR12MB4488.namprd12.prod.outlook.com>
 <s5ho8rdnems.wl-tiwai@suse.de> <PSXP216MB04387BF6B5F8DA84749E5D6F80AF0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <PSXP216MB04387BF6B5F8DA84749E5D6F80AF0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Mon, 27 Apr 2020 14:28:12 -0400
Message-ID: <CADnq5_M=QEqxuCKjb_qZvFSvwM5eLEFfsepxYYXoouFoe5bn7A@mail.gmail.com>
Subject: Re: [PATCH 0/1] Fiji GPU audio register timeout when in BACO state
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     Takashi Iwai <tiwai@suse.de>,
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

On Mon, Apr 27, 2020 at 2:07 PM Nicholas Johnson
<nicholas.johnson-opensource@outlook.com.au> wrote:
>
> On Mon, Apr 27, 2020 at 05:15:55PM +0200, Takashi Iwai wrote:
> > On Mon, 27 Apr 2020 16:22:21 +0200,
> > Deucher, Alexander wrote:
> > >
> > > [AMD Public Use]
> > >
> > > > -----Original Message-----
> > > > From: Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
> > > > Sent: Sunday, April 26, 2020 12:02 PM
> > > > To: linux-kernel@vger.kernel.org
> > > > Cc: Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christi=
an
> > > > <Christian.Koenig@amd.com>; Zhou, David(ChunMing)
> > > > <David1.Zhou@amd.com>; Nicholas Johnson <nicholas.johnson-
> > > > opensource@outlook.com.au>
> > > > Subject: [PATCH 0/1] Fiji GPU audio register timeout when in BACO s=
tate
> > > >
> > > > Hi all,
> > > >
> > > > Since Linux v5.7-rc1 / commit 4fdda2e66de0 ("drm/amdgpu/runpm: enab=
le
> > > > runpm on baco capable VI+ asics"), my AMD R9 Nano has been using ru=
npm /
> > > > BACO. You can tell visually when it sleeps, because the fan on the =
graphics
> > > > card is switched off to save power. It did not spin down the fan in=
 v5.6.x.
> > > >
> > > > This is great (I love it), except that when it is sleeping, the PCI=
e audio function
> > > > of the GPU has issues if anything tries to access it. You get dmesg=
 errors such
> > > > as these:
> > > >
> > > > snd_hda_intel 0000:08:00.1: spurious response 0x0:0x0, last cmd=3D0=
x170500
> > > > snd_hda_intel 0000:08:00.1: azx_get_response timeout, switching to =
polling
> > > > mode: last cmd=3D0x001f0500 snd_hda_intel 0000:08:00.1: No response=
 from
> > > > codec, disabling MSI: last cmd=3D0x001f0500 snd_hda_intel 0000:08:0=
0.1: No
> > > > response from codec, resetting bus: last cmd=3D0x001f0500
> > > > snd_hda_codec_hdmi hdaudioC1D0: Unable to sync register 0x2f0d00. -=
11
> > > >
> > > > The above is with the Fiji XT GPU at 0000:08:00.0 in a Thunderbolt =
enclosure
> > > > (not that Thunderbolt should affect it, but I feel I should mention=
 it just in
> > > > case). I dropped a lot of duplicate dmesg lines, as some of them re=
peated a
> > > > lot of times before the driver gave up.
> > > >
> > > > I offer this patch to disable runpm for Fiji while a fix is found, =
if you decide
> > > > that is the best approach. Regardless, I will gladly test any patch=
es you come
> > > > up with instead and confirm that the above issue has been fixed.
> > > >
> > > > I cannot tell if any other GPUs are affected. The only other cards =
to which I
> > > > have access are a couple of AMD R9 280X (Tahiti XT), which use rade=
on driver
> > > > instead of amdgpu driver.
> > >
> > > Adding a few more people.  Do you know what is accessing the audio?  =
The audio should have a dependency on the GPU device.  The GPU won't enter =
runtime pm until the audio has entered runtime pm and vice versa on resume.=
 Please attach a copy of your dmesg output and lspci output.
>
> pci 0000:08:00.1: D0 power state depends on 0000:08:00.0
> The above must be the dependency of which you speak from dmesg.
>
> Accessing the audio? I did not have a single method for triggering it.
> Sometimes it happened on shutdown. Sometimes when restarting gdm.
> Sometimes when playing with audio settings in Cinnamon Desktop. But most
> often when changing displays. It might have something to do with the
> audio device associated with a monitor being created when the monitor is
> found. If an audio device is created, then pulseaudio might touch it.
> Sorry, this is a very verbose "not quite sure".
>
> To trigger the bug, this time I did the following:
>
> 1. Boot laptop without Fiji and log in
>
> 2. Attach Fiji via Thunderbolt (no displays attached to Fiji) and
> approve Thunderbolt device
>
> 3. Log in again because the session gets killed when GPU is hot-added
>
> 4. Wait for Fiji to fall asleep (fan stops)
>
> 5. Open "dmesg -w" on laptop display
>
> 6. Attach display to DisplayPort on Fiji (it should still stay asleep)
>
> 7. Do WindowsKey+P to activate external display. The error appears in
> dmesg window that instant.
>
> Could it be a race condition when waking the card up?
>
> I cannot get the graphics card fan to spin down if the Thunderbolt
> enclosure is attached at boot time. It only does it if hot-added.
>
> If you think it will help, I can take out the Fiji and put it in a test
> rig and try to replicate the issue without Thunderbolt, but it looks
> like it will not spin the fan down if Fiji is attached at boot time.
>
> Question, why would the fan not spin down if Fiji is attached at boot
> time, and how would one make the said fan turn off? Aside from being
> useful for pinning down the audio register issue, I would like to make
> sure the power savings are realised whenever the GPU is not being used.

Presumably something is using the device.  Maybe a framebuffer console
or X?  Or maybe the something like tlp has disabled runtime pm on your
device?  You can see the current status by reading the files in
/sys/class/drm/cardX/device/power/ .  Replace cardX with card0, card1,
etc. depending on which device is the radeon card.

FWIW, I have a fiji board in a desktop system and it worked fine when
this code was enabled.

Alex

>
> >
> > Also, please retest with the fresh 5.7-rc3.  There was a known
> > regression regarding HD-audio PM in 5.7-rc1/rc2, and it's been fixed
> > there (commit 8d6762af302d).
> Linux v5.7-rc3 still has the same problem, unfortunately.
>
> The dmesg is attached.
>
> Thanks for your replies. Kind regards,
> Nicholas
>
> >
> >
> > thanks,
> >
> > Takashi
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
