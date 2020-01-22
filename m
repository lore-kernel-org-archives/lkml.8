Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A7AC32771
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 04:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ABFD20828
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 04:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WGBvzz7K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgAVEci (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 23:32:38 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:16443 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbgAVEci (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 23:32:38 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e27d0530000>; Tue, 21 Jan 2020 20:32:19 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 21 Jan 2020 20:32:33 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 21 Jan 2020 20:32:33 -0800
Received: from [10.24.44.92] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 22 Jan
 2020 04:32:28 +0000
Subject: Re: [alsa-devel] [PATCH 4/9] ASoC: tegra: add Tegra210 based I2S
 driver
To:     Dmitry Osipenko <digetx@gmail.com>, <perex@perex.cz>,
        <tiwai@suse.com>, <robh+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <atalambedu@nvidia.com>, <linux-kernel@vger.kernel.org>,
        <lgirdwood@gmail.com>, <jonathanh@nvidia.com>,
        <viswanathl@nvidia.com>, <sharadg@nvidia.com>,
        <broonie@kernel.org>, <thierry.reding@gmail.com>,
        <linux-tegra@vger.kernel.org>, <rlokhande@nvidia.com>,
        <mkumard@nvidia.com>, <dramesh@nvidia.com>
References: <1579530198-13431-1-git-send-email-spujar@nvidia.com>
 <1579530198-13431-5-git-send-email-spujar@nvidia.com>
 <a440d105-8db9-ecf1-3718-e58804ce14b8@gmail.com>
 <0c571858-d72c-97c2-2d6a-ead6fdde06eb@nvidia.com>
 <444731da-c4cd-8578-a732-c803eef31ef0@gmail.com>
From:   Sameer Pujar <spujar@nvidia.com>
Message-ID: <bdc749bc-b62c-a041-c17c-33fd49fe8e2e@nvidia.com>
Date:   Wed, 22 Jan 2020 10:02:25 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <444731da-c4cd-8578-a732-c803eef31ef0@gmail.com>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-GB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1579667539; bh=KdmKX9d8S+PQrtUkIVTaIyhy3ejgQLwLEoBvJKFTNnE=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=WGBvzz7KG05TcenZvck/dp97lpcrgOKH51OcIQnur3eIJ4HBue9LyYqC5M6j67Are
         Oa/gGGlwdl75oHpwowTo6ELVDM92lhTQjkeqeSwtnOnuMFuxA/Y8CXKjariz5Poj09
         C1snVF41uhsttluLGDnquh8qu7akwvNPjuEg1Z7nCjKvtEDWz7hs2Z/7/MdEBZCsrR
         LY4gkxw//Q4YwslGwy9XMBzIK274GR63dJQ6QmkLMNBTbZSXr09UAEwWqwlqUkNnCv
         e5y+/SB796VoegRoJIXRcLrVXz/FHwAbkeJAlrgnAMNvw9vmayJ1zd+fBZ+zMjDF38
         wC0lDvnkC19Zg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/21/2020 9:33 PM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
>
>
> 21.01.2020 17:21, Sameer Pujar =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
>
> [snip]
>
>>>> +static int tegra210_i2s_put_control(struct snd_kcontrol *kcontrol,
>>>> +     struct snd_ctl_elem_value *ucontrol)
>>> Checkpatch should complain about the wrong indentation here.
>> I had run checkpatch before sending the patch, below is the result.
>> -----
>> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating=
?
>> #70:
>> new file mode 100644
>>
>> total: 0 errors, 1 warnings, 1103 lines checked
>>
>> NOTE: For some of the reported defects, checkpatch may be able to
>>        mechanically convert to the typical style using --fix or
>> --fix-inplace.
>> -----
> Using 'checkpatch --strict':
>
> CHECK: Alignment should match open parenthesis
> #2693: FILE: sound/soc/tegra/tegra210_i2s.c:362:
> +static int tegra210_i2s_put_control(struct snd_kcontrol *kcontrol,
> +       struct snd_ctl_elem_value *ucontrol
>
> [snip]

will fix
>>>> +
>>>> +     } else if (strstr(kcontrol->id.name, "Playback Audio Bit Format"=
))
>>>> +             i2s->audio_fmt_override[I2S_RX_PATH] =3D value;
>>>> +     else if (strstr(kcontrol->id.name, "Capture Audio Bit Format"))
>>>> +             i2s->audio_fmt_override[I2S_TX_PATH] =3D value;
>>>> +     else if (strstr(kcontrol->id.name, "Client Bit Format"))
>>>> +             i2s->client_fmt_override =3D value;
>>>> +     else if (strstr(kcontrol->id.name, "Playback Audio Channels"))
>>>> +             i2s->audio_ch_override[I2S_RX_PATH] =3D value;
>>>> +     else if (strstr(kcontrol->id.name, "Capture Audio Channels"))
>>>> +             i2s->audio_ch_override[I2S_TX_PATH] =3D value;
>>>> +     else if (strstr(kcontrol->id.name, "Client Channels"))
>>>> +             i2s->client_ch_override =3D value;
>>>> +     else if (strstr(kcontrol->id.name, "Capture Stereo To Mono"))
>>>> +             i2s->stereo_to_mono[I2S_TX_PATH] =3D value;
>>>> +     else if (strstr(kcontrol->id.name, "Capture Mono To Stereo"))
>>>> +             i2s->mono_to_stereo[I2S_TX_PATH] =3D value;
>>>> +     else if (strstr(kcontrol->id.name, "Playback Stereo To Mono"))
>>>> +             i2s->stereo_to_mono[I2S_RX_PATH] =3D value;
>>>> +     else if (strstr(kcontrol->id.name, "Playback Mono To Stereo"))
>>>> +             i2s->mono_to_stereo[I2S_RX_PATH] =3D value;
>>>> +     else if (strstr(kcontrol->id.name, "Playback FIFO Threshold"))
>>>> +             i2s->rx_fifo_th =3D value;
>>>> +     else if (strstr(kcontrol->id.name, "BCLK Ratio"))
>>>> +             i2s->bclk_ratio =3D value;
>>> I'm pretty sure that checkpatch should complain about the missing
>>> brackets, they should make code's indentation uniform and thus easier t=
o
>>> read. Same for all other occurrences in the code.
>> same as above
> CHECK: braces {} should be used on all arms of this statement
> #2699: FILE: sound/soc/tegra/tegra210_i2s.c:368:
> +       if (strstr(kcontrol->id.name, "Loopback")) {
> [...]
> +       } else if (strstr(kcontrol->id.name, "Sample Rate"))
> [...]
> +       else if (strstr(kcontrol->id.name, "FSYNC Width")) {
> [...]
> +       } else if (strstr(kcontrol->id.name, "Playback Audio Bit Format")=
)
> [...]
> +       else if (strstr(kcontrol->id.name, "Capture Audio Bit Format"))
> [...]
> +       else if (strstr(kcontrol->id.name, "Client Bit Format"))
> [...]
> +       else if (strstr(kcontrol->id.name, "Playback Audio Channels"))
> [...]
> +       else if (strstr(kcontrol->id.name, "Capture Audio Channels"))
> [...]
> +       else if (strstr(kcontrol->id.name, "Client Channels"))
> [...]
> +       else if (strstr(kcontrol->id.name, "Capture Stereo To Mono"))
> [...]
> +       else if (strstr(kcontrol->id.name, "Capture Mono To Stereo"))
> [...]
> +       else if (strstr(kcontrol->id.name, "Playback Stereo To Mono"))
> [...]
> +       else if (strstr(kcontrol->id.name, "Playback Mono To Stereo"))
> [...]
> +       else if (strstr(kcontrol->id.name, "Playback FIFO Threshold"))
> [...]
> +       else if (strstr(kcontrol->id.name, "BCLK Ratio"))
> [...]
>
> [snip]

will fix
>>>> +     pm_runtime_enable(dev);
>>> Error checking?
>> return type for above is void()
> Ok
>
>>>> +     return 0;
>>>> +}
>>>> +
>>>> +static int tegra210_i2s_remove(struct platform_device *pdev)
>>>> +{
>>>> +     pm_runtime_disable(&pdev->dev);
>>>> +     if (!pm_runtime_status_suspended(&pdev->dev))
>>>> +             tegra210_i2s_runtime_suspend(&pdev->dev);
>>> This breaks device's RPM refcounting if it was disabled in the active
>>> state. This code should be removed. At most you could warn about the
>>> unxpected RPM state here, but it shouldn't be necessary.
>> I guess this was added for safety and explicit suspend keeps clock
>> disabled.
>> Not sure if ref-counting of the device matters when runtime PM is
>> disabled and device is removed.
>> I see few drivers using this way.
> It should matter (if I'm not missing something) because RPM should be in
> a wrecked state once you'll try to re-load the driver's module. Likely
> that those few other drivers are wrong.
>
> [snip]

Once the driver is re-loaded and RPM is enabled, I don't think it would use
the same 'dev' and the corresponding ref count. Doesn't it use the new=20
counters?
If RPM is not working for some reason, most likely it would be the case=20
for other
devices. What best driver can do is probably do a force suspend during=20
removal if
already not done. I would prefer to keep, since multiple drivers still=20
have it,
unless there is a real harm in doing so.
>
>>>> +     int rx_fifo_th;
>>> Could rx_fifo_th be negative?
>> rx_fifo_th itself does not take negative values, explicit typecasting> i=
s avoided in "if" condition by declaring this as "int"
> Explicit typecasting isn't needed for integers.

What I meant was, rx_fifo_th is checked against a 'int' variable in an=20
"if" condition.

