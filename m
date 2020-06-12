Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B78C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 11:42:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4FEE2065C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 11:42:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u9p920yK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgFLLmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 07:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725791AbgFLLmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 07:42:02 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67CE0C03E96F
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 04:42:02 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c3so9373121wru.12
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 04:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=grdmcQt0Z5YD/EXRctCi12MHmD2jkRbFTQnSiCGluYk=;
        b=u9p920yKmhy95y1XfuC+WtH98U42jPmW95aXleEreYtSPN8+Cbi926lLY211PQ+o0U
         lOTSN6o9MrClt7ThL7GxdnZuK65IDFD8GAHhRzXTIOG+7zk5pFVXeZrsRFTZscbEIWqS
         DrMB8iamR08lqO3Bc3xyKo7RS+knTsCrQLntQR2sumTQ8mZFTRoQH73lwupvv41l8oaK
         SDL1YWojGkZN43xodq6dGmatKP7LfanYIGN2fnL4VVH3R1OL4LxtDUXlmkLA6L77f3ww
         nnp6biG0f2TfNJcIbTuuPrIjo4elYc0zpMAnhCt/bqTtP7BkiU4hQMaodql1wVQH+7rm
         cvog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=grdmcQt0Z5YD/EXRctCi12MHmD2jkRbFTQnSiCGluYk=;
        b=JH/MSZAV7YZagBj+/KiIuz51zMe0Aphi0IZYyNsVL4aKLXRbYgIhqgHk1KXavEtLig
         anpDdVjZcIamEqzGYqHSjPwCpMdIueHQqDud/dQVA5PbniCZYy0XxSloF3Y2an0D+qjQ
         L3ZrYkwm8KTrtqalyg27zbUv/AWULl1J1LBtQTrBeU3kRrl/evzD607yKyh201gSaKIb
         +deQjLQAWKTUNKH/WLCK9X9IKMNqli7/afrYjn00eCWN38YVeFsKU0cxFe+HU8WAc/sK
         2kAYzhRuZPBB1Zwud2MtxJlOpymHYKEQqM7nnplS7HjjZRjGS6SqjrVLsSiehKPdsWi1
         QipQ==
X-Gm-Message-State: AOAM530wIa/Z81CPSvBSe2ZrfW30vM0GEeBlc6mvhIsm15/QWBuexl5S
        lhKhv2dMpszQvKPEZ7mK+K9u3A==
X-Google-Smtp-Source: ABdhPJzdiOhOFY2ccDSPhjuBUs2VcqMjBOF0aG3MCIHCObQOb92PjO5BBgE/5y23b1CJ9bn+Axs+6A==
X-Received: by 2002:adf:dccc:: with SMTP id x12mr14209293wrm.72.1591962120806;
        Fri, 12 Jun 2020 04:42:00 -0700 (PDT)
Received: from [192.168.86.34] (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.googlemail.com with ESMTPSA id 40sm10332448wrc.15.2020.06.12.04.41.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jun 2020 04:42:00 -0700 (PDT)
Subject: Re: [GIT PULL] sound fixes for 5.8-rc1
To:     John Stultz <john.stultz@linaro.org>, Takashi Iwai <tiwai@suse.de>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Vinod Koul <vinod.koul@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>
References: <s5himfxet1c.wl-tiwai@suse.de>
 <CANcMJZAG4QqJ2Cxt+1RLsa8Z4oR=2y8zyD_sqy3sm_8MXyhg2g@mail.gmail.com>
 <CALAqxLWEfRJ_Jr0iDgmvqop5Etz5xve89Zy3OeUbnKUGtqjCqQ@mail.gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <4d692acd-6fe8-7a5f-34d5-78a4d6dd03cf@linaro.org>
Date:   Fri, 12 Jun 2020 12:41:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CALAqxLWEfRJ_Jr0iDgmvqop5Etz5xve89Zy3OeUbnKUGtqjCqQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks John for reporting this,

On 12/06/2020 01:49, John Stultz wrote:
> On Thu, Jun 11, 2020 at 5:13 PM John Stultz <john.stultz@linaro.org> wrote:
>>
>> On Thu, Jun 11, 2020 at 6:39 AM Takashi Iwai <tiwai@suse.de> wrote:
>>> sound fixes for 5.8-rc1
>>>
>>> Here are last-minute fixes gathered before merge window close;
>>> a few fixes are for the core while the rest majority are driver
>>> fixes.
>>>
>>> * PCM locking annotation fixes and the possible self-lock fix
>>> * ASoC DPCM regression fixes with multi-CPU DAI
>>
>> Just as a heads up, we just recently got HDMI audio working on the
>> Dragonboard 845c (Vinod has patches he's sending out here in the next
>> few days), but they suddenly stopped working today with the following
>> error:
>> [   13.110725] msm-snd-sdm845 soc@0:sound: snd-soc-dummy-dai <->
>> MultiMedia1 mapping ok
>> [   13.119343] msm-snd-sdm845 soc@0:sound: snd-soc-dummy-dai <->
>> MultiMedia2 mapping ok
>> [   13.127969] msm-snd-sdm845 soc@0:sound: snd-soc-dummy-dai <->
>> MultiMedia3 mapping ok
>> [   13.135891] msm-snd-sdm845 soc@0:sound: Compress ASoC:
>> snd-soc-dummy-dai <-> MultiMedia4 mapping ok
>> [   13.145042] msm-snd-sdm845 soc@0:sound: CPU DAI QUAT_MI2S_RX for
>> rtd HDMI Playback does not support capture
>> [   13.154873] msm-snd-sdm845 soc@0:sound: ASoC: can't create pcm HDMI
>> Playback :-22
>> [   13.165634] snd-malloc: invalid device type 0
>> [   13.170057] snd-malloc: invalid device type 0
>> [   13.174888] msm-snd-sdm845 soc@0:sound: Sound card registration failed
>> [   13.181574] msm-snd-sdm845: probe of soc@0:sound failed with error -22
>>
>>   I've bisected it down to the following commit from this pull req:
>>    https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b73287f0b0745961b14e5ebcce92cc8ed24d4d52
>>
>> Without this patch:
>> [   13.056906] msm-snd-sdm845 soc@0:sound: snd-soc-dummy-dai <->
>> MultiMedia1 mapping ok
>> [   13.075465] msm-snd-sdm845 soc@0:sound: snd-soc-dummy-dai <->
>> MultiMedia2 mapping ok
>> [   13.092949] msm-snd-sdm845 soc@0:sound: snd-soc-dummy-dai <->
>> MultiMedia3 mapping ok
>> [   13.109704] msm-snd-sdm845 soc@0:sound: Compress ASoC:
>> snd-soc-dummy-dai <-> MultiMedia4 mapping ok
>> [   13.125584] msm-snd-sdm845 soc@0:sound: i2s-hifi <-> QUAT_MI2S_RX mapping ok
>> [   13.125621] msm-snd-sdm845 soc@0:sound: multicodec <-> SLIMBUS_0_RX
>> mapping ok
>> [   13.141682] msm-snd-sdm845 soc@0:sound: wcd934x_tx1 <->
>> SLIMBUS_0_TX mapping ok
>> ...
>>
>> I've not managed to dig in with much analysis yet (possibly something
>> off with the current patches we have), but wanted to raise the issue
>> in case others start to see it too.
> 
> I don't know the backgroun again, but would something like the
> following make sense?
> https://git.linaro.org/people/john.stultz/android-dev.git/commit/?h=dev/db845c-mainline-WIP&id=7e49b248db77b5ed29b2aa278268e77650c75482
> 
> It avoids failing completely if playback or capture isn't found.

Can you please try these two patches, I think the problem is that FE 
dailinks are always set to bidirectional, this two patches should fix it.

https://git.linaro.org/people/srinivas.kandagatla/linux.git/commit/?h=gapless/v2&id=bb7ce65a0ca1640cd9ff301c885f56ce00519834

https://git.linaro.org/people/srinivas.kandagatla/linux.git/commit/?h=gapless/v2&id=9b568e491f0410b453aaf5a147b75252a6943ffd


Once you confirm I can send them to list as fixes.


Thanks,
srini

> 
> thanks
> -john
> 
