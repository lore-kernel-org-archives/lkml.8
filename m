Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0F89C33CAA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:03:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACFBC217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:03:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oSkJmsMP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729991AbgAUQDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:03:23 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33375 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729030AbgAUQDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 11:03:22 -0500
Received: by mail-lf1-f65.google.com with SMTP id n25so2750186lfl.0;
        Tue, 21 Jan 2020 08:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qjcDJDT5ZhsuJU+cktfSQ3R47ar0BoE5LFZ4QYOhvk4=;
        b=oSkJmsMPFvlrGrBgt/E7oyZ7wGMURN57NLfvXkRGUfFsMcqdMQxLpm2Bz38hClF7Ln
         ShLcsQB78iaEi+nE1RjpRnLjH6+ka2Y4If1K8tbkLYtT5lV1/3zFNNRLyAGrURJlyE8W
         mMWg/hkKqaT3aoM++ZzTwhHFPcyy2/ecRP8Pv0g+7JIPrbDTLEheR0JiAzwV+e/Ur0dr
         pNYHzfUgFTYMjXWYop3hoUUsMJaPNO2kbYZsDkzP0HxdYKy4xccXnf2fuvYcjwD6enz3
         e12I1oL1VSsvUHi56JrA6kwd0pTVkYNmlVysL/n3hJ8Hn0w/lswn6moIte9zZJRUJxrc
         U39w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qjcDJDT5ZhsuJU+cktfSQ3R47ar0BoE5LFZ4QYOhvk4=;
        b=IWurWOO84AIDRfvjE0Clt4ROTHoK/gnoLL3i75iJKNROY+QzC5pendzZdlYg2rgFDh
         Efw8BJFST08KhPo3iyTs8/nZwPWOjSIf8m2Pa+9DZIUqOdT5eAf1iapljzbW0EKC40GO
         Z7PhyK+Hf4K10TehkubO8w0u4EXFpzxUF4fBTTnEIw1q0LUDF0FnHnaMMTXTRdQBtfeG
         GE4cBTuesumIKdvDGevOIE9xIkH5syotBV73OKY1jPSEcKxv2NKcGIHI7LPtb4w7faOu
         s70i02KgGDaeOLHu9rkdx/APfGSj4uxi7qcrlI997OvxpemXmXtQ0xCaqMt9S3iDXKKg
         3p1g==
X-Gm-Message-State: APjAAAVA0I7BsiuyrEEj2nzK0ji+e49o3yzk2r+BIs6udgdsnLZAottF
        kBOS2kRcBd2aLTAW7BoLVQU=
X-Google-Smtp-Source: APXvYqzclMF2A4gK1qZbpXyXqercR78rGBMYz+1kp1LUvr0QDXRGPs35zL7ilE/pQbIxRvtkvvNXRA==
X-Received: by 2002:ac2:515b:: with SMTP id q27mr2939168lfd.119.1579622599111;
        Tue, 21 Jan 2020 08:03:19 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id w16sm19566502lfc.1.2020.01.21.08.03.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 08:03:18 -0800 (PST)
Subject: Re: [alsa-devel] [PATCH 4/9] ASoC: tegra: add Tegra210 based I2S
 driver
To:     Sameer Pujar <spujar@nvidia.com>, perex@perex.cz, tiwai@suse.com,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        atalambedu@nvidia.com, linux-kernel@vger.kernel.org,
        lgirdwood@gmail.com, jonathanh@nvidia.com, viswanathl@nvidia.com,
        sharadg@nvidia.com, broonie@kernel.org, thierry.reding@gmail.com,
        linux-tegra@vger.kernel.org, rlokhande@nvidia.com,
        mkumard@nvidia.com, dramesh@nvidia.com
References: <1579530198-13431-1-git-send-email-spujar@nvidia.com>
 <1579530198-13431-5-git-send-email-spujar@nvidia.com>
 <a440d105-8db9-ecf1-3718-e58804ce14b8@gmail.com>
 <0c571858-d72c-97c2-2d6a-ead6fdde06eb@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <444731da-c4cd-8578-a732-c803eef31ef0@gmail.com>
Date:   Tue, 21 Jan 2020 19:03:15 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <0c571858-d72c-97c2-2d6a-ead6fdde06eb@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

21.01.2020 17:21, Sameer Pujar пишет:

[snip]

>>> +static int tegra210_i2s_put_control(struct snd_kcontrol *kcontrol,
>>> +     struct snd_ctl_elem_value *ucontrol)
>> Checkpatch should complain about the wrong indentation here.
> 
> I had run checkpatch before sending the patch, below is the result.
> -----
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #70:
> new file mode 100644
> 
> total: 0 errors, 1 warnings, 1103 lines checked
> 
> NOTE: For some of the reported defects, checkpatch may be able to
>       mechanically convert to the typical style using --fix or
> --fix-inplace.
> -----

Using 'checkpatch --strict':

CHECK: Alignment should match open parenthesis
#2693: FILE: sound/soc/tegra/tegra210_i2s.c:362:
+static int tegra210_i2s_put_control(struct snd_kcontrol *kcontrol,
+       struct snd_ctl_elem_value *ucontrol

[snip]

>>> +
>>> +     } else if (strstr(kcontrol->id.name, "Playback Audio Bit Format"))
>>> +             i2s->audio_fmt_override[I2S_RX_PATH] = value;
>>> +     else if (strstr(kcontrol->id.name, "Capture Audio Bit Format"))
>>> +             i2s->audio_fmt_override[I2S_TX_PATH] = value;
>>> +     else if (strstr(kcontrol->id.name, "Client Bit Format"))
>>> +             i2s->client_fmt_override = value;
>>> +     else if (strstr(kcontrol->id.name, "Playback Audio Channels"))
>>> +             i2s->audio_ch_override[I2S_RX_PATH] = value;
>>> +     else if (strstr(kcontrol->id.name, "Capture Audio Channels"))
>>> +             i2s->audio_ch_override[I2S_TX_PATH] = value;
>>> +     else if (strstr(kcontrol->id.name, "Client Channels"))
>>> +             i2s->client_ch_override = value;
>>> +     else if (strstr(kcontrol->id.name, "Capture Stereo To Mono"))
>>> +             i2s->stereo_to_mono[I2S_TX_PATH] = value;
>>> +     else if (strstr(kcontrol->id.name, "Capture Mono To Stereo"))
>>> +             i2s->mono_to_stereo[I2S_TX_PATH] = value;
>>> +     else if (strstr(kcontrol->id.name, "Playback Stereo To Mono"))
>>> +             i2s->stereo_to_mono[I2S_RX_PATH] = value;
>>> +     else if (strstr(kcontrol->id.name, "Playback Mono To Stereo"))
>>> +             i2s->mono_to_stereo[I2S_RX_PATH] = value;
>>> +     else if (strstr(kcontrol->id.name, "Playback FIFO Threshold"))
>>> +             i2s->rx_fifo_th = value;
>>> +     else if (strstr(kcontrol->id.name, "BCLK Ratio"))
>>> +             i2s->bclk_ratio = value;
>> I'm pretty sure that checkpatch should complain about the missing
>> brackets, they should make code's indentation uniform and thus easier to
>> read. Same for all other occurrences in the code.
> 
> same as above

CHECK: braces {} should be used on all arms of this statement
#2699: FILE: sound/soc/tegra/tegra210_i2s.c:368:
+       if (strstr(kcontrol->id.name, "Loopback")) {
[...]
+       } else if (strstr(kcontrol->id.name, "Sample Rate"))
[...]
+       else if (strstr(kcontrol->id.name, "FSYNC Width")) {
[...]
+       } else if (strstr(kcontrol->id.name, "Playback Audio Bit Format"))
[...]
+       else if (strstr(kcontrol->id.name, "Capture Audio Bit Format"))
[...]
+       else if (strstr(kcontrol->id.name, "Client Bit Format"))
[...]
+       else if (strstr(kcontrol->id.name, "Playback Audio Channels"))
[...]
+       else if (strstr(kcontrol->id.name, "Capture Audio Channels"))
[...]
+       else if (strstr(kcontrol->id.name, "Client Channels"))
[...]
+       else if (strstr(kcontrol->id.name, "Capture Stereo To Mono"))
[...]
+       else if (strstr(kcontrol->id.name, "Capture Mono To Stereo"))
[...]
+       else if (strstr(kcontrol->id.name, "Playback Stereo To Mono"))
[...]
+       else if (strstr(kcontrol->id.name, "Playback Mono To Stereo"))
[...]
+       else if (strstr(kcontrol->id.name, "Playback FIFO Threshold"))
[...]
+       else if (strstr(kcontrol->id.name, "BCLK Ratio"))
[...]

[snip]

>>> +     pm_runtime_enable(dev);
>> Error checking?
> 
> return type for above is void()

Ok

>>> +     return 0;
>>> +}
>>> +
>>> +static int tegra210_i2s_remove(struct platform_device *pdev)
>>> +{
>>> +     pm_runtime_disable(&pdev->dev);
>>> +     if (!pm_runtime_status_suspended(&pdev->dev))
>>> +             tegra210_i2s_runtime_suspend(&pdev->dev);
>> This breaks device's RPM refcounting if it was disabled in the active
>> state. This code should be removed. At most you could warn about the
>> unxpected RPM state here, but it shouldn't be necessary.
> 
> I guess this was added for safety and explicit suspend keeps clock
> disabled.
> Not sure if ref-counting of the device matters when runtime PM is
> disabled and device is removed.
> I see few drivers using this way.

It should matter (if I'm not missing something) because RPM should be in
a wrecked state once you'll try to re-load the driver's module. Likely
that those few other drivers are wrong.

[snip]

> 
>>> +     int rx_fifo_th;
>> Could rx_fifo_th be negative?
> 
> rx_fifo_th itself does not take negative values, explicit typecasting> is avoided in "if" condition by declaring this as "int"
Explicit typecasting isn't needed for integers.
