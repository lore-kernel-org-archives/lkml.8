Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A83C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AE8820836
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgGCJTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 05:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgGCJTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 05:19:20 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DD91C08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 02:19:20 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id DB03F2A2D53
Subject: Re: [PATCH v2] ASoC: cros_ec_codec: Log results when EC commands fail
To:     Yu-Hsuan Hsu <yuhsuan@chromium.org>
Cc:     ALSA development <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Mark Brown <broonie@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>
References: <20200703071913.2358882-1-yuhsuan@chromium.org>
 <8d21fc0c-b43e-75a0-d5d4-ed4872ec92cb@collabora.com>
 <CAGvk5Pqx475MOsefchcgs=CnVJiwFJxa+-J6eHcp1VgscVkTeg@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <cea2bc7e-035b-2c97-73bf-25dc55ab8801@collabora.com>
Date:   Fri, 3 Jul 2020 11:19:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <CAGvk5Pqx475MOsefchcgs=CnVJiwFJxa+-J6eHcp1VgscVkTeg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yu-Hsuan,

On 3/7/20 10:48, Yu-Hsuan Hsu wrote:
> Enric Balletbo i Serra <enric.balletbo@collabora.com> 於 2020年7月3日 週五 下午4:38寫道：
>>
>> Hi Yu-Hsuan,
>>
>> Thank you for your patch
>>
>> On 3/7/20 9:19, Yu-Hsuan Hsu wrote:
>>> Log results of failed EC commands to identify a problem more easily.
>>>
>>> Replace cros_ec_cmd_xfer_status with cros_ec_cmd_xfer because the result
>>> has already been checked in this function. The wrapper is not needed.
>>>
>>
>> Nack, we did an effort to remove all public users of cros_ec_cmd_xfer() in
>> favour of cros_ec_cmd_xfer_status() and you are reintroducing again. You can do
>> the same but using cros_ec_cmd_xfer_status(). In fact, your patch will not build
>> on top of the upcoming changes.
> Thanks! But I have a question about implementing it. Does it look like
> the one below?
> ret = cros_ec_cmd_xfer_status(ec_dev, msg);
> if (ret < 0) {

In this case will already print an error.

What are you trying to achieve?

If the only reason is of this patch is print a message you should either, or
enable dynamic printk and enable dev_dbg or event better use the kernel trace
functionality. There is no need to be more verbose.

Example:
    $ echo 1 > /sys/kernel/debug/tracing/events/cros_ec/enable
    $ cat /sys/kernel/debug/tracing/trace

    369.416372: cros_ec_request_start: version: 0, command: EC_CMD_USB_PD_POWER_INFO
    369.420528: cros_ec_request_done: version: 0, command:
EC_CMD_USB_PD_POWER_INFO, ec result: EC_RES_SUCCESS, retval: 16

Cheers,
 Enric

>   if (ret == -EPROTO)
>     dev_err(..., msg->result)
>   goto error;
> }
> I'm not sure whether it makes sense to check ret == -EPROTO here.
> 
>>
>>> Signed-off-by: Yu-Hsuan Hsu <yuhsuan@chromium.org>
>>> ---
>>>  sound/soc/codecs/cros_ec_codec.c | 9 ++++++++-
>>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/sound/soc/codecs/cros_ec_codec.c b/sound/soc/codecs/cros_ec_codec.c
>>> index 8d45c628e988e..a4ab62f59efa6 100644
>>> --- a/sound/soc/codecs/cros_ec_codec.c
>>> +++ b/sound/soc/codecs/cros_ec_codec.c
>>> @@ -90,10 +90,17 @@ static int send_ec_host_command(struct cros_ec_device *ec_dev, uint32_t cmd,
>>>       if (outsize)
>>>               memcpy(msg->data, out, outsize);
>>>
>>> -     ret = cros_ec_cmd_xfer_status(ec_dev, msg);
>>> +     ret = cros_ec_cmd_xfer(ec_dev, msg);
>>>       if (ret < 0)
>>>               goto error;
>>>
>>> +     if (msg->result != EC_RES_SUCCESS) {
>>> +             dev_err(ec_dev->dev, "Command %d failed: %d\n", cmd,
>>> +                     msg->result);
>>> +             ret = -EPROTO;
>>> +             goto error;
>>> +     }
>>> +
>>>       if (insize)
>>>               memcpy(in, msg->data, insize);
>>>
>>>
