Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3E4C433E8
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 17:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4275F20656
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 17:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgGORoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 13:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgGORop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 13:44:45 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52FBFC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 10:44:45 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 0794B2A18A0
Subject: Re: [PATCH] ASoC: cros_ec_codec: Reset I2S RX when probing
To:     Yu-Hsuan Hsu <yuhsuan@chromium.org>,
        Guenter Roeck <groeck@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Gwendal Grignou <gwendal@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Yicheng Li <yichengli@chromium.org>,
        ALSA development <alsa-devel@alsa-project.org>
References: <20200708071117.3070707-1-yuhsuan@chromium.org>
 <f6a0ea44-3805-5901-9864-72d4a3a4562e@collabora.com>
 <CABXOdTfV_oGgZWbyP3o07obMuYGOLY87fou2h3_gowQkV7QVNw@mail.gmail.com>
 <CAGvk5Po=BcHZ8uQJAp10cYHJcvc6-x613o-0Jj00K23xpeQpaQ@mail.gmail.com>
 <CABXOdTf1+nBtau7ujnUVTfNd68D-RijZBPU8XMv=ZQ-RLbpzAg@mail.gmail.com>
 <CAGvk5Po2osJOc077x6AWOn7bDgYsWzYSfqrSp64XBgjvjMHKsQ@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <fd73832a-3e5b-7e43-c69c-1d4b9ee78d27@collabora.com>
Date:   Wed, 15 Jul 2020 19:44:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAGvk5Po2osJOc077x6AWOn7bDgYsWzYSfqrSp64XBgjvjMHKsQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu-Hsuan,

On 8/7/20 19:51, Yu-Hsuan Hsu wrote:
> Guenter Roeck <groeck@google.com> 於 2020年7月9日 週四 上午1:26寫道：
>>
>> On Wed, Jul 8, 2020 at 9:17 AM Yu-Hsuan Hsu <yuhsuan@chromium.org> wrote:
>>>
>>> Guenter Roeck <groeck@google.com> 於 2020年7月8日 週三 下午9:28寫道：
>>>>
>>>> On Wed, Jul 8, 2020 at 3:16 AM Enric Balletbo i Serra
>>>> <enric.balletbo@collabora.com> wrote:
>>>>>
>>>>> Hi Yu-Hsuan,
>>>>>
>>>>> Thank you for your patch.
>>>>>
>>>>> On 8/7/20 9:11, Yu-Hsuan Hsu wrote:
>>>>>> It is not guaranteed that I2S RX is disabled when the kernel booting.
>>>>>> For example, if the kernel crashes while it is enabled, it will keep
>>>>>> enabled until the next time EC reboots. Reset I2S RX when probing to
>>>>>> fix this issue.
>>>>>>
>>>>>> Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
>>>>>> ---
>>>>>>  include/linux/platform_data/cros_ec_commands.h | 1 +
>>>>>>  sound/soc/codecs/cros_ec_codec.c               | 7 +++++++
>>>>>>  2 files changed, 8 insertions(+)
>>>>>>
>>>>>> diff --git a/include/linux/platform_data/cros_ec_commands.h b/include/linux/platform_data/cros_ec_commands.h
>>>>>> index 69210881ebac8..11ce917ca924c 100644
>>>>>> --- a/include/linux/platform_data/cros_ec_commands.h
>>>>>> +++ b/include/linux/platform_data/cros_ec_commands.h
>>>>>> @@ -4598,6 +4598,7 @@ enum ec_codec_i2s_rx_subcmd {
>>>>>>       EC_CODEC_I2S_RX_SET_SAMPLE_DEPTH = 0x2,
>>>>>>       EC_CODEC_I2S_RX_SET_DAIFMT = 0x3,
>>>>>>       EC_CODEC_I2S_RX_SET_BCLK = 0x4,
>>>>>> +     EC_CODEC_I2S_RX_RESET = 0x5,
>>>>>
>>>>> Is this a new command not available in the firmware that is already in the field?
>>>>>
>>>>>
>>>>>>       EC_CODEC_I2S_RX_SUBCMD_COUNT,
>>>>>>  };
>>>>>>
>>>>>> diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
>>>>>> index 8d45c628e988e..5495214e73e68 100644
>>>>>> --- a/sound/soc/codecs/cros_ec_codec.c
>>>>>> +++ b/sound/soc/codecs/cros_ec_codec.c
>>>>>> @@ -1034,6 +1034,13 @@ static int cros_ec_codec_platform_probe(struct platform_device *pdev)
>>>>>>       }
>>>>>>       priv->ec_capabilities = r.capabilities;
>>>>>>
>>>>>> +     /* Reset EC codec I2S RX. */
>>>>>> +     p.cmd = EC_CODEC_I2S_RX_RESET;
>>>>>> +     ret = send_ec_host_command(priv->ec_device, EC_CMD_EC_CODEC_I2S_RX,
>>>>>> +                                (uint8_t *)&p, sizeof(p), NULL, 0);
>>>>>> +     if (ret)
>>>>>> +             dev_err(dev, "failed to EC_CODEC_I2S_RESET: %d\n", ret);
>>>>>> +

What about notify the user that he *must* update their firmware?

  dev_info(dev, "Missing reset command. Please update your EC firmware.\n")

>>>>>
>>>>> With an old firmware I suspect this message will appear on every boot, right?
>>>>> So, to solve the issue and get rid of this error you're forced to upgrade the
>>>>> firmware. Is that true?
>>>>>
>>>>
>>>> It might possibly make more sense to fail this silently and to send
>>>> EC_CODEC_I2S_RX_DISABLE as backup if it is not supported (-ENOTSUPP
>>>> can possibly be used as trigger if the call returns it).
>>>>
>>>> Also, I don't accept dev_err() if the error is ignored for patches in
>>>> my scope of responsibility.
>>>>
>>>> Guenter
>>> Thanks for the suggestion. Our plan is to upstream this patch first.
>>> And then we will merge it into the kernel after the firmware is
>>> updated. Is it feasible? (I'm not sure whether there is the better way
>>> if I want to update EC and the kernel at the same time.)
>>>
>>> I think calling EC_CODEC_I2S_RX_DISABLE does not make sense because it
>>> checks the value of i2s_rx_enabled first. If i2s_rx_enabled is false,
>>> it will skip the function. However, we don't need to reset while the
>>> i2s_rx_enabled is already false.
>>>
>> Exactly my point. If i2s_rx_enabled is false, nothing needs to be
>> done, and it doesn't hurt if the EC does nothing. If i2s_rx_enabled is
>> true, it needs to be set to false, which is accomplished by sending
>> EC_CODEC_I2S_RX_DISABLE.
> Sorry my bad. If i2s_rx_enabled is false, it will skip and return
> EC_RES_BUSY. And then we may need to handle one more error. I think it
> may become too complicated to handle those errors. Could we just merge
> this change after the firmware updates? So that we don't need to worry
> about the unsupported command.
> 

How can you ensure that assuming there is already devices in the field? The
patch should work for both cases, on devices that has the old firmware and on
devices that have the new firmware. You can't guarantee that all the devices
will update their firmware.

I'd suggest notify the user that should update the EC firmware and
fallback/continue when the EC_CODEC_I2S_RX_RESET is not implemented.

>>
>>> In addition, since it is a sub-command, it will return
>>> EC_RES_INVALID_PARAM but not ENOTSUPP if the command is not supported.
>>> And then EC_RES_INVALID_PARAM will turn into -EPROTO finally so it's
>>> difficult to do other operators basing on the return value.
>>>
>>
>> You might have to convince Enric to permit another error code to
>> translate EC_RES_INVALID_PARAM. After all, that would meet his
>> requirement that the error code must be used in the kernel to accept a
>> translation.
>>
>> Guenter
>>
>>> Thanks,
>>> Yu-Hsuan
>>>
>>>>
>>>>>>       platform_set_drvdata(pdev, priv);
>>>>>>
>>>>>>       ret = devm_snd_soc_register_component(dev, &i2s_rx_component_driver,
>>>>>>
