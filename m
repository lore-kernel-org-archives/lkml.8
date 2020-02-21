Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14892C11D00
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 01:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF6F320659
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 01:48:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TML/DXtf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729347AbgBUBs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 20:48:29 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44692 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgBUBs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 20:48:29 -0500
Received: by mail-wr1-f65.google.com with SMTP id m16so194049wrx.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2020 17:48:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=GKckSw11VHqNcu+qSeJYrnXEuG76gChYhLz/BDOCfM0=;
        b=TML/DXtfgwJ1XOnEB3hnsHidNRpyV3+EjMUqzthnuLxLTl8fWeGIK58LbIG7dqxH/9
         jr3d/n1dO9k4Z71lInOBddWZ2F4jiWzMMg3FzkMiIGDYIiuo/2fgXzOwSDAwos9Wa1Vl
         /Ubf77JxGVtS2D2oTt7iOGOpk7DYME87EhrbOf2v1nVdC/ogEJWQDeCbe6fgQweLZYx8
         vjRyq1+PWblKSg30+wp+OPIMbX8wWo1gCOgABVp1ESCSgmBlYWwawC2AlVCPFq4ptnka
         GZrykqxKbeAMs/YfTHPPZtn1gpNrcLUitiHq+6EXpzWqZqlYA320e2DMiZm/+99rNqB6
         ok4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=GKckSw11VHqNcu+qSeJYrnXEuG76gChYhLz/BDOCfM0=;
        b=OfYsep7ed5uTH/FnulF2ETmD6RAsmVBIAy6WnOXwAMb/hLe55TkOvKZniUb4qvyZDk
         gilaS3ACE3tUzJhFGgWG+DeCB6LHhSW8jznjiGFMprNTMMBrbcFrnktq/rgGdSQbhzQq
         zPCqVJAe+2fC7mFvCQBfE5jd5UOK56GU28lRDPd6s7EsfkIvdHQBzG0VVSE0j5OLBaEI
         NSps86RxNFbzoOE+dlTn+0SGmA365C+U+fOu7bJKuflwbthJgRqGgTy5i1i5dBGNVYHt
         gappH2vh2aPaRzZcOCWAqO3qgzX0PzAX9KCwgxljfmtcFV/IRn4eehgzqtpZgxY3a86I
         7Rvg==
X-Gm-Message-State: APjAAAXyu7X0W0e3jMxZd/rr0lmnJorTYHPJR8JSXHa96llx7rpXH9iZ
        ++57n7A0TE8OSgCV6o0oyFhDPTxHm+YWT6jZKowfHyE+
X-Google-Smtp-Source: APXvYqwQOmMvD+J60OTR3YX4vIfo56anW1sW7nEaU5d5amSXl3VfORVF1gxNsPb2UJYpll7WAegjC6YP/mJcOim9yE0=
X-Received: by 2002:adf:b60f:: with SMTP id f15mr47220269wre.372.1582249705955;
 Thu, 20 Feb 2020 17:48:25 -0800 (PST)
MIME-Version: 1.0
References: <CAHVeOW-TgaUctUE71jDSofBCM_O3dxrSvbCYLPRKm_eRpmY_MQ@mail.gmail.com>
 <CAHVeOW8+5o51aY58dGd9Qz8wOMa2pvzN0Sz53eSQ+hgso9RiGA@mail.gmail.com> <CAHVeOW_zUcwL7YSe4JVe_WAQjjms+SSc81PXaZ22Df+mXVXifA@mail.gmail.com>
In-Reply-To: <CAHVeOW_zUcwL7YSe4JVe_WAQjjms+SSc81PXaZ22Df+mXVXifA@mail.gmail.com>
From:   Chris Gorman <chrisjohgorman@gmail.com>
Date:   Thu, 20 Feb 2020 20:48:15 -0500
Message-ID: <CAHVeOW9ndr8eSL9Cd9DnAXo_8h47cavPTXax9+2JtqAQKe5jZw@mail.gmail.com>
Subject: Re: digital microphone on google chromebook code name banon
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry folks, I hit send before wanting to...  I will try all over here.

I have found the problem occurring with the previous warning messages.
I have contacted the developer and they are fixing them.

I am trying to figure out how to properly enable pmc_plt_clk so that
when arecord is run they toggle enable count, and prepare count in the
clk_summary as is done with an aplay command.  I have a realtek
5645/5650 and am running a braswell / cherrytrail chromebook.

The clk_summary has the following in it with nothing running.

                                enable  prepare  protect
                           duty
   clock                          count    count    count        rate
accuracy phase  cycle
---------------------------------------------------------------------------------------------
 xtal                                         0        0        0
19200000        0     0  50000
    pmc_plt_clk_5                     0        0        0    19200000
      0     0  50000
    pmc_plt_clk_4                     0        0        0    19200000
      0     0  50000
    pmc_plt_clk_3                     0        0        0    19200000
      0     0  50000
    pmc_plt_clk_2                     0        0        0    19200000
      0     0  50000
    pmc_plt_clk_1                     0        0        0    19200000
      0     0  50000
    pmc_plt_clk_0                     0        0        0    19200000
      0     0  50000
 lpss_clk                                  2        2        0
100000000        0     0  50000
    8086228A:00                      0        0        0   100000000
     0     0  50000
       8086228A:00-div              0        0        0   100000000
    0     0  50000
          8086228A:00-update     0        0        0   100000000
 0     0  50000

When I run aplay pmc_plt_clk_0 is set 1 1 (enable count and prepare
count) and xtal is also set 1 1.  When the playing file stops lpss_clk
is set 4 4, then back to 2 2.  When I run arecord the enable count and
prepare count are both 0.  I'm looking for some hints as to where to
go to have arecord speak to the xtal properly.  Please cc me your
suggestions directly as I am not on the list.

Thanks in advance.

Chris





On Thu, Feb 20, 2020 at 8:34 PM Chris Gorman <chrisjohgorman@gmail.com> wrote:
>
> Hello Again,
>
> I have found the problem occurring with the previous warning messages.
> I have contacted the developer and they are fixing them.
>
> I am trying to figure out how to properly enable pmc_plt_clk so that
> when arecord is run they toggle enable count, and prepare count in the
> clk_summary as is done with an aplay command.  I have a realtek
> 5645/5650 and am running a braswell / cherrytrail chromebook.
>
> The clk_summary has the following in it with nothing running.
>
>                                 enable  prepare  protect
>                  duty
>    clock                          count    count    count        rate
>  accuracy phase  cycle
> ---------------------------------------------------------------------------------------------
>  xtal                                 0        0        0    19200000
>         0     0  50000
>     pmc_plt_clk_5                     0        0        0    19200000
>         0     0  50000
>     pmc_plt_clk_4                     0        0        0    19200000
>         0     0  50000
>     pmc_plt_clk_3                     0        0        0    19200000
>         0     0  50000
>     pmc_plt_clk_2                     0        0        0    19200000
>         0     0  50000
>     pmc_plt_clk_1                     0        0        0    19200000
>         0     0  50000
>     pmc_plt_clk_0                     0        0        0    19200000
>         0     0  50000
>  lpss_clk                             2        2        0   100000000
>         0     0  50000
>     8086228A:00                       0        0        0   100000000
>         0     0  50000
>        8086228A:00-div                0        0        0   100000000
>         0     0  50000
>           8086228A:00-update          0        0        0   100000000
>         0     0  50000
>
>
> On Tue, Feb 18, 2020 at 10:31 PM Chris Gorman <chrisjohgorman@gmail.com> wrote:
> >
> > Hello All,
> >
> > I have been doing some more research into my problem microphone and
> > came up with some kernel error messages.  The dmesg output from my
> > machine follows with a few bits cut out.  Everything below after
> > 19.828677 shows an error. I am particularly interested in 723.334601
> > and 723.334661 which show up during running aplay.  It seems that
> > there is something wrong with my intel_sst_acpi driver?  It
> > initializes, but then errors due to wait timeouts.  The last two error
> > messages 1867.44593 and 1867.446002, are from an arecord.
> > Interestingly no further wait timeout messages occur after the record
> > attempt.  I will try git bisect tomorrow to see if I can isolate when
> > the error messages start showing up.  I don't believe they existed in
> > 5.5-rc6, but I will find out.  If anyone has ideas on how to fix
> > either my error messages or my dmic, please let me know.  I am not on
> > the mailing list due to the high volume of messages, so if you respond
> > please cc me directly.  Thanks for your time.
> >
> > Chris
> >
> > [    1.050358] rt5645 i2c-10EC5650:00: Detected Google Chrome platform
> > ---snip---
> > [    1.477956] intel_sst_acpi 808622A8:00: LPE base: 0xd1000000 size:0x200000
> > [    1.477962] intel_sst_acpi 808622A8:00: IRAM base: 0xd10c0000
> > [    1.477994] intel_sst_acpi 808622A8:00: DRAM base: 0xd1100000
> > [    1.478010] intel_sst_acpi 808622A8:00: SHIM base: 0xd1140000
> > [    1.478023] intel_sst_acpi 808622A8:00: Mailbox base: 0xd1144000
> > [    1.478034] intel_sst_acpi 808622A8:00: DDR base: 0x20000000
> > [    1.478544] intel_sst_acpi 808622A8:00: Got drv data max stream 25
> > [    1.478938] cht-bsw-rt5645 cht-bsw-rt5645: quirk PMC_PLT_CLK_0 enabled
> > [    1.484286] cht-bsw-rt5645 cht-bsw-rt5645: snd-soc-dummy-dai <->
> > media-cpu-dai mapping ok
> > [    1.484364] cht-bsw-rt5645 cht-bsw-rt5645: snd-soc-dummy-dai <->
> > deepbuffer-cpu-dai mapping ok
> > [    1.485720] cht-bsw-rt5645 cht-bsw-rt5645: rt5645-aif1 <->
> > ssp2-port mapping ok
> > ---snip---
> > [   19.828677] intel_sst_acpi 808622A8:00: FW Version 01.0b.02.02
> > ---errors from here on---
> > [   31.278276] intel_sst_acpi 808622A8:00: Wait timed-out
> > condition:0x0, msg_id:0x1 fw_state 0x3
> > [   31.278287] intel_sst_acpi 808622A8:00: fw returned err -16
> > [   31.278299] sst-mfld-platform sst-mfld-platform: ASoC: PRE_PMD:
> > pcm0_in event failed: -16
> > [   32.300753] intel_sst_acpi 808622A8:00: Wait timed-out
> > condition:0x0, msg_id:0x1 fw_state 0x3
> > [   32.300761] intel_sst_acpi 808622A8:00: fw returned err -16
> > [   32.300770] sst-mfld-platform sst-mfld-platform: ASoC: POST_PMD:
> > media0_out event failed: -16
> > [   33.324565] intel_sst_acpi 808622A8:00: Wait timed-out
> > condition:0x0, msg_id:0x1 fw_state 0x3
> > [   33.324593] intel_sst_acpi 808622A8:00: fw returned err -16
> > [   33.324623] sst-mfld-platform sst-mfld-platform: ASoC: POST_PMD:
> > codec_out0 mix 0 event failed: -16
> > [   34.347757] intel_sst_acpi 808622A8:00: Wait timed-out
> > condition:0x0, msg_id:0x1 fw_state 0x3
> > [   34.347766] intel_sst_acpi 808622A8:00: fw returned err -16
> > [   34.347779] sst-mfld-platform sst-mfld-platform: ASoC: POST_PMD:
> > media0_out mix 0 event failed: -16
> > [  723.334601] intel_sst_acpi 808622A8:00: FW sent error response 0x40015
> > [  723.334661] intel_sst_acpi 808622A8:00: FW sent error response 0x40006
> > [  768.479671] intel_sst_acpi 808622A8:00: Wait timed-out
> > condition:0x0, msg_id:0x1 fw_state 0x3
> > [  768.479702] intel_sst_acpi 808622A8:00: fw returned err -16
> > [  768.479739] sst-mfld-platform sst-mfld-platform: ASoC: PRE_PMD:
> > pcm0_in event failed: -16
> > [  769.503586] intel_sst_acpi 808622A8:00: Wait timed-out
> > condition:0x0, msg_id:0x1 fw_state 0x3
> > [  769.503614] intel_sst_acpi 808622A8:00: fw returned err -16
> > [  769.503643] sst-mfld-platform sst-mfld-platform: ASoC: POST_PMD:
> > media0_out event failed: -16
> > [  770.527829] intel_sst_acpi 808622A8:00: Wait timed-out
> > condition:0x0, msg_id:0x1 fw_state 0x3
> > [  770.527837] intel_sst_acpi 808622A8:00: fw returned err -16
> > [  770.527846] sst-mfld-platform sst-mfld-platform: ASoC: POST_PMD:
> > codec_out0 mix 0 event failed: -16
> > [  771.552544] intel_sst_acpi 808622A8:00: Wait timed-out
> > condition:0x0, msg_id:0x1 fw_state 0x3
> > [  771.552575] intel_sst_acpi 808622A8:00: fw returned err -16
> > [  771.552613] sst-mfld-platform sst-mfld-platform: ASoC: POST_PMD:
> > media0_out mix 0 event failed: -16
> > ---snip---
> > [ 1867.445943] intel_sst_acpi 808622A8:00: FW sent error response 0x40015
> > [ 1867.446002] intel_sst_acpi 808622A8:00: FW sent error response 0x40006
> >
> > On Fri, Feb 14, 2020 at 2:26 PM Chris Gorman <chrisjohgorman@gmail.com> wrote:
> > >
> > > Hello All,
> > >
> > > I have a problem with my laptop recording via the digital microphone.
> > > I did try to explain the problem on
> > > https://bugzilla.kernel.org/show_bug.cgi?id=95681, but I have heard no
> > > response on the issue, so I am bugging the mailing list in hopes that
> > > someone will have a magic fix for me. ;)
> > >
> > > My laptop is a google chromebook, braswell, banon.  It is of the intel
> > > strago family.  When I try to record all I get is white noise.  I can
> > > reduce the level of noise via alsamixer, but I have to reduce all the
> > > capture levels to 5 or lower.
> > >
> > > I reached out to Sam McNally (thank you sam) from chromium regarding
> > > his patch to cht_bsw_rt5645.c
> > > adebb11139029ddf1fba6f796c4a476f17eacddc.  He was quite nice and
> > > helpful.  According to Sam, the banon chromebooks dmic works with
> > > their chromeos 4.9 and chromeos 5.4 kernels.  Unfortunately the dmic
> > > still failed on my system when I tried the chromeos 5.4 kernel.
> > > Perhaps the problem is my new coreboot 4.11 bios, whereas chrome uses
> > > an older bios? I don't know.
> > >
> > > Sam also pointed me to checking /sys/kernel/debug/clk/clk_summary.
> > > While recording I get..
> > >
> > > pmc_plt_clk_0                     0        0        0    19200000
> > >        0     0  50000
> > >
> > > and while playing everything's fine and I get...
> > >
> > > pmc_plt_clk_0                     1        1        0    19200000
> > >        0     0  50000
> > >
> > > This is clearly the problem.  I don't know how to get the clock
> > > working with the capture function though.
> > >
> > > My kernel configs are ...
> > >
> > > SOUND = y
> > > SND = y
> > > SND_SOC = y
> > > SND_SOC_INTEL_MACH = y
> > > SND_SST_ATOM_HIFI2_PLATFORM = y
> > > SND_SST_ATOM_HIFI2_PLATFORM_ACPI = y
> > > I2C = y
> > > ACPI = y
> > > X86_INTEL_LPSS = y
> > > SND_SOC_ACPI = y
> > > SND_SOC_INTEL_CHT_BSW_RT5645_MACH = y
> > > SND_SOC_RT5645 = y
> > > SND_SOC_DMIC = y
> > >
> > > and I am running linux 5.5.0.  I welcome patches and suggestions, but
> > > have not subscribed to the mailing list because of the volume of
> > > emails, so please cc me with any response.
> > >
> > > Thanks in advance.
> > >
> > > Chris Gorman
