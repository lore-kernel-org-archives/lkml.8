Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E19DC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06A7A206F6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 13:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgCXNy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 09:54:58 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:49892 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727382AbgCXNy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 09:54:58 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id C87382969BD
Subject: Re: [PATCH] platform/chrome: wilco_ec: Provide correct output format
 to 'h1_gpio' file
To:     Daniel Campello <campello@google.com>
Cc:     Bernardo Perez Priego <bernardo.perez.priego@intel.com>,
        Benson Leung <bleung@chromium.org>,
        Nick Crews <ncrews@chromium.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org
References: <20200313232720.22364-1-bernardo.perez.priego@intel.com>
 <f1635547-2c18-b9d6-0fb2-2f69dcfd124e@collabora.com>
 <CAHcu+Vb37A+b2B6tJDYmJtH2dhUPEDy-3yZxaQYy3P3fLV2nVg@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <334c8fff-db38-1b99-01d9-b251435ddec1@collabora.com>
Date:   Tue, 24 Mar 2020 14:54:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAHcu+Vb37A+b2B6tJDYmJtH2dhUPEDy-3yZxaQYy3P3fLV2nVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23/3/20 21:06, Daniel Campello wrote:
> Hello,
> 
> On Tue, Mar 17, 2020 at 1:09 AM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
>>
>> Hi,
>>
>> On 14/3/20 0:27, Bernardo Perez Priego wrote:
>>> Function 'h1_gpio_get' is receiving 'val' parameter of type u64,
>>> this is being passed to 'send_ec_cmd' as type u8, thus, result
>>> is stored in least significant byte. Due to output format,
>>> the whole 'val' value was being displayed when any of the most
>>> significant bytes are different than zero.
>>>
>>> This fix will make sure only least significant byte is displayed
>>> regardless of remaining bytes value.
>>>
>>> Signed-off-by: Bernardo Perez Priego <bernardo.perez.priego@intel.com>
>>
>> Daniel, could you give a try and give you Tested-by tag if you're fine with it?
>>
>> Thanks,
>>  Enric
>>
>>> ---
>>>  drivers/platform/chrome/wilco_ec/debugfs.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/platform/chrome/wilco_ec/debugfs.c b/drivers/platform/chrome/wilco_ec/debugfs.c
>>> index df5a5f6c3ec6..c775b7d58c6d 100644
>>> --- a/drivers/platform/chrome/wilco_ec/debugfs.c
>>> +++ b/drivers/platform/chrome/wilco_ec/debugfs.c
>>> @@ -211,7 +211,7 @@ static int h1_gpio_get(void *arg, u64 *val)
>>>       return send_ec_cmd(arg, SUB_CMD_H1_GPIO, (u8 *)val);
>>>  }
>>>
>>> -DEFINE_DEBUGFS_ATTRIBUTE(fops_h1_gpio, h1_gpio_get, NULL, "0x%02llx\n");
>>> +DEFINE_DEBUGFS_ATTRIBUTE(fops_h1_gpio, h1_gpio_get, NULL, "0x%02hhx\n");
>>>
>>>  /**
>>>   * test_event_set() - Sends command to EC to cause an EC test event.
>>>
> 
> Done. I also found the chromium review for this on crrev.com/c/2090128
> 
> Tested-by: Daniel Campello <campello@chromium.org>
> 

Queued for 5.7. Thanks.

~ Enric
