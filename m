Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24DF7C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 00:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F30CF20835
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 00:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Xi6u5uOO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbgFLAOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 20:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgFLAOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 20:14:00 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8253C03E96F
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 17:13:59 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id x14so7981737wrp.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 17:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Tky5NjDKbemUweafcIRmfslQyaen8uSXwRARmDTO8b4=;
        b=Xi6u5uOO5XaS7GvzSkkqojjKAn71pB3/euFy6FGspBmCHaS80zY/5PDAPWPEnqq2+J
         DExPT4MVxD/R8XfMm8OWi9R83ShDYoy6lwOu06nOL1qcJdrS89Z5zcZTD6so6CrWDl1e
         jIuvXpd747BTzdt46isKff0yR1Gms1B9ah3feIFPS/g1Mq638o8rRuHIIIM/h2i0W8d3
         13TYSSEjPgTEVYi9hrKfvM1XicYMmduBpWpWy+PObROE3aACfyVZV6lhZ/vPmVK+PqE7
         qw7lbV+mwLAHCt/iP/440xj2F2i5WS/uSLoYZ6IDvTZOrjFB3Mj+a1wD+/kGWGmBvX/n
         3PoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Tky5NjDKbemUweafcIRmfslQyaen8uSXwRARmDTO8b4=;
        b=BIrnywEtWG/E54v11WDsOKfI+PYgjfcfzAIeiPtYiuD7qdzaVH5NfkvRA4DUGplCE9
         fwL2TtdPM8UTA9KVz0OLigekK5hlQd86WeNr9WkHmQw9XFauuluSYVAS8ldhxyPRsyV9
         +e+/5wsy/QdlioXPu/XKl65WWnK7tlCp8iEwR6ETyJcOaOHMe2sKjL7LAdZeYOSdvBK/
         8ZTzjfdWJJqhoo50yBhPt7+CkP5RzWrGlA7AjuYbhtsY218v/d0SflLcVBSeAGt2qz23
         yq/BSm3utl2bhVtY0aSS14wLMw7roUVOfBEEKa9a1v2tu78b2NzBsMVw+Hhlb76KNpdB
         wgPQ==
X-Gm-Message-State: AOAM53203cySZzchHTXFFiSYCK0lfNlh8oGFtqqvjuYTJz3LscpCyY0a
        2zerlI0pXho1OmHlH6s6lrrITFlIO3o9Ft0Endo=
X-Google-Smtp-Source: ABdhPJyVsvtU7MR0WC9qCGKKtUViKOCpAjfEErH1yck5in+qmhq32ThfxOV+PTXKguXIOQcCr6Z0f2SueTQTOwDm0XU=
X-Received: by 2002:adf:9544:: with SMTP id 62mr11598440wrs.32.1591920838228;
 Thu, 11 Jun 2020 17:13:58 -0700 (PDT)
MIME-Version: 1.0
References: <s5himfxet1c.wl-tiwai@suse.de>
In-Reply-To: <s5himfxet1c.wl-tiwai@suse.de>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 11 Jun 2020 17:13:45 -0700
Message-ID: <CANcMJZAG4QqJ2Cxt+1RLsa8Z4oR=2y8zyD_sqy3sm_8MXyhg2g@mail.gmail.com>
Subject: Re: [GIT PULL] sound fixes for 5.8-rc1
To:     Takashi Iwai <tiwai@suse.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Vinod Koul <vinod.koul@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 6:39 AM Takashi Iwai <tiwai@suse.de> wrote:
> sound fixes for 5.8-rc1
>
> Here are last-minute fixes gathered before merge window close;
> a few fixes are for the core while the rest majority are driver
> fixes.
>
> * PCM locking annotation fixes and the possible self-lock fix
> * ASoC DPCM regression fixes with multi-CPU DAI

Just as a heads up, we just recently got HDMI audio working on the
Dragonboard 845c (Vinod has patches he's sending out here in the next
few days), but they suddenly stopped working today with the following
error:
[   13.110725] msm-snd-sdm845 soc@0:sound: snd-soc-dummy-dai <->
MultiMedia1 mapping ok
[   13.119343] msm-snd-sdm845 soc@0:sound: snd-soc-dummy-dai <->
MultiMedia2 mapping ok
[   13.127969] msm-snd-sdm845 soc@0:sound: snd-soc-dummy-dai <->
MultiMedia3 mapping ok
[   13.135891] msm-snd-sdm845 soc@0:sound: Compress ASoC:
snd-soc-dummy-dai <-> MultiMedia4 mapping ok
[   13.145042] msm-snd-sdm845 soc@0:sound: CPU DAI QUAT_MI2S_RX for
rtd HDMI Playback does not support capture
[   13.154873] msm-snd-sdm845 soc@0:sound: ASoC: can't create pcm HDMI
Playback :-22
[   13.165634] snd-malloc: invalid device type 0
[   13.170057] snd-malloc: invalid device type 0
[   13.174888] msm-snd-sdm845 soc@0:sound: Sound card registration failed
[   13.181574] msm-snd-sdm845: probe of soc@0:sound failed with error -22

 I've bisected it down to the following commit from this pull req:
  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b73287f0b0745961b14e5ebcce92cc8ed24d4d52

Without this patch:
[   13.056906] msm-snd-sdm845 soc@0:sound: snd-soc-dummy-dai <->
MultiMedia1 mapping ok
[   13.075465] msm-snd-sdm845 soc@0:sound: snd-soc-dummy-dai <->
MultiMedia2 mapping ok
[   13.092949] msm-snd-sdm845 soc@0:sound: snd-soc-dummy-dai <->
MultiMedia3 mapping ok
[   13.109704] msm-snd-sdm845 soc@0:sound: Compress ASoC:
snd-soc-dummy-dai <-> MultiMedia4 mapping ok
[   13.125584] msm-snd-sdm845 soc@0:sound: i2s-hifi <-> QUAT_MI2S_RX mapping ok
[   13.125621] msm-snd-sdm845 soc@0:sound: multicodec <-> SLIMBUS_0_RX
mapping ok
[   13.141682] msm-snd-sdm845 soc@0:sound: wcd934x_tx1 <->
SLIMBUS_0_TX mapping ok
...

I've not managed to dig in with much analysis yet (possibly something
off with the current patches we have), but wanted to raise the issue
in case others start to see it too.

thanks
-john
