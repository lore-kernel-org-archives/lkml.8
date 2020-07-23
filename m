Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E4FC433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:04:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 349E5207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgGWIEV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 04:04:21 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44620 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgGWIEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 04:04:20 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id F394928D80B
Subject: Re: [PATCH 2/2] platform/chrome: cros_ec_proto: check for missing
 EC_CMD_HOST_EVENT_GET_WAKE_MASK
To:     Brian Norris <briannorris@chromium.org>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
References: <20200722015732.1720840-1-briannorris@chromium.org>
 <20200722015732.1720840-2-briannorris@chromium.org>
 <5ebf1534-8045-9894-9c1c-b92b9c6d8479@collabora.com>
 <CA+ASDXMk7Tg7Lwqt8Pv5BQT0J40dpJtqrL9TAn8y5Nj3TCkj6Q@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <59657973-cdef-eaf2-47f2-368205015750@collabora.com>
Date:   Thu, 23 Jul 2020 10:04:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+ASDXMk7Tg7Lwqt8Pv5BQT0J40dpJtqrL9TAn8y5Nj3TCkj6Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,

On 22/7/20 22:50, Brian Norris wrote:
> On Wed, Jul 22, 2020 at 3:19 AM Enric Balletbo i Serra
> <enric.balletbo@collabora.com> wrote:
>>
>> Hi Brian,
>>
>> Thank you for your patch, I'll take a look soon but I'd like to ask if you can
>> join the discussion with this patchset [1], specially this one [2]. We're trying
>> to match EC errors with standard linux kernel errors because we think can be
>> helpful.
>>
>> [1] https://lore.kernel.org/patchwork/cover/1276734/
>> [2] https://lore.kernel.org/patchwork/patch/1276738/
> 
> Hi Enric,
> 
> Thanks, I'll do that. I do wonder sometimes how non-maintainers should
> best support "community" around these things, for subsystems that
> don't have a dedicated mailing list and are therefore sent only to
> maintainers + LKML-fire-hose. I could probably subscribe to LKML and
> filter it, but something tells me my mailbox will still manage to
> explode somehow... Anyway, I digress.
> 

We talked sometimes on having a dedicated ML, but for one reason or the other,
and as we don't have a lot of volume, we didn't set up (could be an option).

Another thing that we can do (although this is specific for you and doesn't
solve the problem with people like you that are interested on this), is add you
as a reviewer in the MAINTAINERS file. The CrOS EC has a lot of subtleties, and
having more ChromeOS people involved in the reviewing upstream is more than welcome.

Regards,
Enric

> Other than perhaps taking a lesson not to propagate -ENOTSUPP, I don't
> think this series should block on that, as this is a bugfix IMO.
> 
> Regards,
> Brian
> 
