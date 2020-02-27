Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B84BC4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 11:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E763E24691
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 11:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgB0LeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 06:34:19 -0500
Received: from mx2.suse.de ([195.135.220.15]:39960 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728856AbgB0LeT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 06:34:19 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 78822AD14;
        Thu, 27 Feb 2020 11:34:16 +0000 (UTC)
Subject: Re: [PATCH] drm/bridge: analogix-anx6345: fix set of link bandwidth
To:     Icenowy Zheng <icenowy@aosc.io>, Torsten Duwe <duwe@lst.de>
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jonas Karlman <jonas@kwiboo.se>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        Vasily Khoruzhick <anarsoul@gmail.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>
References: <20200221165127.813325-1-icenowy@aosc.io>
 <20200221171328.GC6928@lst.de> <1E7BDB0F-639B-42BB-A4B4-A4C8CF94EBE0@aosc.io>
 <f4109d23-4591-1c52-2822-0a2ba358fe1f@suse.de>
 <07EED5EC-28C6-473D-B672-509F5C770479@aosc.io>
From:   Thomas Zimmermann <tzimmermann@suse.de>
Autocrypt: addr=tzimmermann@suse.de; keydata=
 mQENBFs50uABCADEHPidWt974CaxBVbrIBwqcq/WURinJ3+2WlIrKWspiP83vfZKaXhFYsdg
 XH47fDVbPPj+d6tQrw5lPQCyqjwrCPYnq3WlIBnGPJ4/jreTL6V+qfKRDlGLWFjZcsrPJGE0
 BeB5BbqP5erN1qylK9i3gPoQjXGhpBpQYwRrEyQyjuvk+Ev0K1Jc5tVDeJAuau3TGNgah4Yc
 hdHm3bkPjz9EErV85RwvImQ1dptvx6s7xzwXTgGAsaYZsL8WCwDaTuqFa1d1jjlaxg6+tZsB
 9GluwvIhSezPgnEmimZDkGnZRRSFiGP8yjqTjjWuf0bSj5rUnTGiyLyRZRNGcXmu6hjlABEB
 AAG0J1Rob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPokBVAQTAQgAPhYh
 BHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJbOdLgAhsDBQkDwmcABQsJCAcCBhUKCQgLAgQWAgMB
 Ah4BAheAAAoJEGgNwR1TC3ojR80H/jH+vYavwQ+TvO8ksXL9JQWc3IFSiGpuSVXLCdg62AmR
 irxW+qCwNncNQyb9rd30gzdectSkPWL3KSqEResBe24IbA5/jSkPweJasgXtfhuyoeCJ6PXo
 clQQGKIoFIAEv1s8l0ggPZswvCinegl1diyJXUXmdEJRTWYAtxn/atut1o6Giv6D2qmYbXN7
 mneMC5MzlLaJKUtoH7U/IjVw1sx2qtxAZGKVm4RZxPnMCp9E1MAr5t4dP5gJCIiqsdrVqI6i
 KupZstMxstPU//azmz7ZWWxT0JzgJqZSvPYx/SATeexTYBP47YFyri4jnsty2ErS91E6H8os
 Bv6pnSn7eAq5AQ0EWznS4AEIAMYmP4M/V+T5RY5at/g7rUdNsLhWv1APYrh9RQefODYHrNRH
 UE9eosYbT6XMryR9hT8XlGOYRwKWwiQBoWSDiTMo/Xi29jUnn4BXfI2px2DTXwc22LKtLAgT
 RjP+qbU63Y0xnQN29UGDbYgyyK51DW3H0If2a3JNsheAAK+Xc9baj0LGIc8T9uiEWHBnCH+R
 dhgATnWWGKdDegUR5BkDfDg5O/FISymJBHx2Dyoklv5g4BzkgqTqwmaYzsl8UxZKvbaxq0zb
 ehDda8lvhFXodNFMAgTLJlLuDYOGLK2AwbrS3Sp0AEbkpdJBb44qVlGm5bApZouHeJ/+n+7r
 12+lqdsAEQEAAYkBPAQYAQgAJhYhBHIX+6yM6c9jRKFo5WgNwR1TC3ojBQJbOdLgAhsMBQkD
 wmcAAAoJEGgNwR1TC3ojpfcIAInwP5OlcEKokTnHCiDTz4Ony4GnHRP2fXATQZCKxmu4AJY2
 h9ifw9Nf2TjCZ6AMvC3thAN0rFDj55N9l4s1CpaDo4J+0fkrHuyNacnT206CeJV1E7NYntxU
 n+LSiRrOdywn6erjxRi9EYTVLCHcDhBEjKmFZfg4AM4GZMWX1lg0+eHbd5oL1as28WvvI/uI
 aMyV8RbyXot1r/8QLlWldU3NrTF5p7TMU2y3ZH2mf5suSKHAMtbE4jKJ8ZHFOo3GhLgjVrBW
 HE9JXO08xKkgD+w6v83+nomsEuf6C6LYrqY/tsZvyEX6zN8CtirPdPWu/VXNRYAl/lat7lSI
 3H26qrE=
Message-ID: <08f290ef-7dd0-c8b9-0177-3248fb153eca@suse.de>
Date:   Thu, 27 Feb 2020 12:34:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <07EED5EC-28C6-473D-B672-509F5C770479@aosc.io>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Am 26.02.20 um 12:02 schrieb Icenowy Zheng:
> 
> 
> 于 2020年2月26日 GMT+08:00 下午6:58:43, Thomas Zimmermann <tzimmermann@suse.de> 写到:
>> Hi Iceynow,
>>
>> Torsten asked me to merge your patch via drm-misc-next. I'd add the
>> additional cc and fixes tags that Torsten listed. Are you OK with that?
> 
> I think this fixes a driver (and a board) available in 5.6.
> 
> Maybe it should enter fixes?

Pushed to drm-misc-fixes

Best regards
Thomas

> 
>>
>> Best regards
>> Thomas
>>
>> Am 22.02.20 um 03:43 schrieb Icenowy Zheng:
>>>
>>>
>>> 于 2020年2月22日 GMT+08:00 上午1:13:28, Torsten Duwe <duwe@lst.de> 写到:
>>>> On Sat, Feb 22, 2020 at 12:51:27AM +0800, Icenowy Zheng wrote:
>>>>> Current code tries to store the link rate (in bps, which is a big
>>>>> number) in a u8, which surely overflow. Then it's converted back to
>>>>> bandwidth code (which is thus 0) and written to the chip.
>>>>>
>>>>> The code sometimes works because the chip will automatically
>> fallback
>>>> to
>>>>> the lowest possible DP link rate (1.62Gbps) when get the invalid
>>>> value.
>>>>> However, on the eDP panel of Olimex TERES-I, which wants 2.7Gbps
>>>> link,
>>>>> it failed.
>>>>>
>>>>> As we had already read the link bandwidth as bandwidth code in
>>>> earlier
>>>>> code (to check whether it is supported), use it when setting
>>>> bandwidth,
>>>>> instead of converting it to link rate and then converting back.
>>>>>
>>>>> Fixes: e1cff82c1097 ("drm/bridge: fix anx6345 compilation for
>> v5.5")
>>>>> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
>>>>> ---
>>>>>  drivers/gpu/drm/bridge/analogix/analogix-anx6345.c | 3 +--
>>>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
>>>> b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
>>>>> index 56f55c53abfd..2dfa2fd2a23b 100644
>>>>> --- a/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
>>>>> +++ b/drivers/gpu/drm/bridge/analogix/analogix-anx6345.c
>>>>> @@ -210,8 +210,7 @@ static int anx6345_dp_link_training(struct
>>>> anx6345 *anx6345)
>>>>>  	if (err)
>>>>>  		return err;
>>>>>  
>>>>> -	dpcd[0] = drm_dp_max_link_rate(anx6345->dpcd);
>>>>> -	dpcd[0] = drm_dp_link_rate_to_bw_code(dpcd[0]);
>>>>> +	dpcd[0] = dp_bw;
>>>>
>>>> Why do you make this assignment and not use dp_bw directly in the
>> call?
>>>
>>> Because the dpcd array is then written as a continous array
>>> back to DPCD.
>>>
>>>>
>>>>>  	err = regmap_write(anx6345->map[I2C_IDX_DPTX],
>>>>>  			   SP_DP_MAIN_LINK_BW_SET_REG, dpcd[0]);
>>>>                                                       ^^^^^^
>>>>>  	if (err)
>>>>> -- 
>>>>> 2.24.1
>>>>
>>>> BTW, my version is only a bit more verbose:
>>>>
>>>> https://patchwork.freedesktop.org/patch/354344/
>>>>
>>>> 	Torsten
>>>
> 

-- 
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Maxfeldstr. 5, 90409 Nürnberg, Germany
(HRB 36809, AG Nürnberg)
Geschäftsführer: Felix Imendörffer
