Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3551CC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 11:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10B8020657
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 11:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rCwFb7kg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgGPLth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 07:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726383AbgGPLtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 07:49:36 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B8BC061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 04:49:36 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id f18so11294617wml.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 04:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=yfbzLHHcXrWqLy0p2f9WLJbzwEat6UUwiUFItT++s0M=;
        b=rCwFb7kgVyJSCd4OZIYO2btf/9sxzypDeCAzFC2W+oN+yF4GDR60mvZsGmXQKJ6hEm
         nzy+adXMh2SeEzYD5taL9P4WuPfTWHPGgiDTLzwn23scQZD3QuxcdIDGdfaVozEM9bba
         WQqujfP5eUlLE24haAD1Jn+QfimAyVW1Ct5iJbx2H7ox6kmHltGmXQSBWv7Ct2wmVVqA
         P8BEgeExHFIu8BE2Lvk3vRnmD10gdP0dAoMJ7ez4cRwUxOY6Xa7JE8ijFTvc1ckTz83F
         d+zFUCzzPr+nlXJGKL8mzjIJ6whQXEcDVq4PNE5VQmGWjiyYiY4nxgOtcwdKSNgbrHz9
         5YJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=yfbzLHHcXrWqLy0p2f9WLJbzwEat6UUwiUFItT++s0M=;
        b=VbCUlYR/1ref3vOHvc6zqCnKJvAouh3tBPj2X61jssw8ktG7VoqERYAbydxY1fP54P
         7aX78tDBfrpdbxdySavFZaLoHSju/OxUM7vhYrtso4NLlRkXGdbGPfQBZDoG4VNETsOd
         ePcgASZYXSVqNuNizkrpY057gSW4tTd4LheG1DY1V97jveG5d8JX3MJ+MsEbtlkRJAW8
         edlkWMnWCzYOAHCQZwlZru9zT8yN/TSAbT4gdtRByxYS5vUOUmNKajzmi4NJdPltN1wP
         lfjSrY1ODg97TZ8FrNBT+gMjCCkDo/HS/edL6v5hYK629ee7Fv3Bmr0qwI0fAKAwd2ge
         sNOg==
X-Gm-Message-State: AOAM533X7At2Eu8vmq9Lom3a3N7oxlSL3b4SguSGtS4iWIivts55ZAdb
        Gly7vDLfgcpsAq5SpIodfsw=
X-Google-Smtp-Source: ABdhPJw0OtWlYMt7xDWjMv8pWSP74h3A1lsoV4P/FVFzX+6kZb91pM40rn9jF9vo7hHlub3nWJ6AHg==
X-Received: by 2002:a1c:9a06:: with SMTP id c6mr3826398wme.23.1594900175364;
        Thu, 16 Jul 2020 04:49:35 -0700 (PDT)
Received: from [192.168.0.74] ([178.233.178.9])
        by smtp.gmail.com with ESMTPSA id v12sm8835593wrt.31.2020.07.16.04.49.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jul 2020 04:49:34 -0700 (PDT)
From:   Alper Nebi Yasak <alpernebiyasak@gmail.com>
Subject: Speaker pops with max98357a on rk3399-gru-kevin since v5.7
To:     Tzung-Bi Shih <tzungbi@google.com>, Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Message-ID: <f2ca985f-7dbd-847a-1875-dd0e1044ef02@gmail.com>
Date:   Thu, 16 Jul 2020 14:49:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have been getting "pop" sounds from the speaker on my rk3399-gru-kevin
for a while, and bisected it to 128f825aeab7 ("ASoC: max98357a: move
control of SD_MODE to DAPM"), but looks like the pops were somewhat
expected:

On 12 Feb 2020 13:55:15 +0800, Tzung-Bi Shih wrote [1]:
> Possible drawback: may generate pop noise when BCLK=on but LRCLK=off.
> As the datasheet[2] mentioned:
> > Do not remove LRCLK while BCLK is present.
> > Removing LRCLK while BCLK is present can cause unexpected output behavior
> > including a large DC output voltage.

[1] https://lore.kernel.org/alsa-devel/20200212055517.122728-1-tzungbi@google.com/

As of v5.8-rc5 I'm still getting the speaker pops. More info below, but
not all pops coincide with "set sdmode" messages, and vice versa.
Reverting that commit stops the pops, but then the "Speakers Switch" can
no longer mute the speakers.

I don't really know much about these things, could anyone have a look at
it? I'll try to read relevant documentation and code to make sense of it,
but wanted to send an email in case there is an immediately obvious
solution (besides reverting) and maybe just nobody had the time to
implement it yet.

Thanks in advance.

---

I've experimented a bit on a Debian userspace (with #define DEBUG 1
to get sdmode messages), here's what happens without PulseAudio:
- When playback starts, speaker pops with "set sdmode to 1".
- During playback, toggling "Speakers Switch" sets sdmode to 0/1 and
  mutes/unmutes speakers without any pops.
- Pausing/resuming playback (like seeking on a media player) make pops
  without changing sdmode. Also pops when playback ends (e.g. when
  "speaker-test -l 1" quits).
- A few seconds after playback ends, speaker pops for the last time with
  "set sdmode to 0".
- Within that few seconds, toggling "Speakers Switch" sets sdmode to 0/1
  and makes a pop each time.

It's mostly the same with PulseAudio but:
- Pause/resume during playback doesn't make any pops.
- The penultimate pop happens a few seconds after playback stops, when
  PA says it's suspending the max98357a device (no sdmode changes).
- The final pop comes a few seconds after that (still with "set sdmode
  to 0").

Even without any playback it makes several pops during boot when e.g.
PulseAudio starts/stops running in the display manager or in the user
session.
