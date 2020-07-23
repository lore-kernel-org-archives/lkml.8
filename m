Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1E3C433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 070D92086A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 08:08:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgGWII1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 04:08:27 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:44684 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgGWII0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 04:08:26 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 64C40296B62
Subject: Re: [PATCH 2/2] platform/chrome: cros_ec_proto: check for missing
 EC_CMD_HOST_EVENT_GET_WAKE_MASK
To:     Brian Norris <briannorris@chromium.org>,
        Guenter Roeck <groeck@google.com>
Cc:     Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
References: <20200722015732.1720840-1-briannorris@chromium.org>
 <20200722015732.1720840-2-briannorris@chromium.org>
 <5ebf1534-8045-9894-9c1c-b92b9c6d8479@collabora.com>
 <CA+ASDXMk7Tg7Lwqt8Pv5BQT0J40dpJtqrL9TAn8y5Nj3TCkj6Q@mail.gmail.com>
 <CABXOdTfvNBuaEx-vTU2MqNF_EmULJu=506oUtd29kN=FAPswBQ@mail.gmail.com>
 <CA+ASDXNeTp0z7M6rR62rJEa3tF52BYjXdodFTQvuR4b43o0e-Q@mail.gmail.com>
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Message-ID: <c03a678c-e288-c541-0fee-59b3585f2b43@collabora.com>
Date:   Thu, 23 Jul 2020 10:08:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CA+ASDXNeTp0z7M6rR62rJEa3tF52BYjXdodFTQvuR4b43o0e-Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brian,

On 23/7/20 2:43, Brian Norris wrote:
> On Wed, Jul 22, 2020 at 2:13 PM Guenter Roeck <groeck@google.com> wrote:
>> On Wed, Jul 22, 2020 at 1:50 PM Brian Norris <briannorris@chromium.org> wrote:
>>> Other than perhaps taking a lesson not to propagate -ENOTSUPP, I don't
>>> think this series should block on that, as this is a bugfix IMO.
>>
>> My patch will return -EOPNOTSUPP for EC_RES_INVALID_COMMAND, so maybe
>> you could do the same. In my latest version (not yet submitted) I
>> extracted the conversion into a separate function, so if your patch is
>> accepted now I can just add another patch on top of it to start using
>> that function.
> 
> Sure, I can use EOPNOTSUPP in v2.
> 

Yes, please, can you send a v2 using EOPNOTSUPP

> BTW, the error code is completely internal to cros_ec_proto.c in my
> patch, so it seems even less-related to your series, unless I got
> refactor cros_ec_get_host_event_wake_mask() to use
> cros_ec_cmd_xfer_status() instead of send_command(). I'm actually not
> sure why we don't do that, now that I think about it...
> 
> So WDYT? Should I rebase on your eventual v3 and refactor to
> cros_ec_cmd_xfer_status()? Or (re)submit this first, and add one more
> cros_ec_cmd_xfer_status() usage for you to tweak in your series?
> 

No need to rebase on top of Guenter patches, as I plan to pick your patches first.

Regards,
Enric

> I don't mind a lot either way, except that I would like to port this
> to older kernels soon.
> 
> Brian
> 
