Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0237DC352A3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 21:56:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3AF24680
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 21:56:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=scoopta.email header.i=@scoopta.email header.b="HWzannKX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbgBMVz7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 16:55:59 -0500
Received: from scoopta.email ([198.58.106.30]:36964 "EHLO scoopta.email"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728055AbgBMVz7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 16:55:59 -0500
DKIM-Signature: a=rsa-sha256; b=HWzannKX/lNL9+XrJD8pGhjb5zTU/GCSJt/P3SgtyLSmHCNNzv0Xb/4FEMQLkCjEd/PlDom6JLOeP+aA/yXvLQz0NZHNxLwXyJ3SnzLHOSxlJ4R6Y1ZDaeGZ3oeHFHdaR2wPuPNAAWeu0tj3fcO/CiFAMPxZ/dWibbKhVhFsHclw4/NbDHz9MEjn1FmhOG0iho64FArtHKZfZUoFygPCwLAnrdObeG3UfdrFYenc+MK2hs0B+O/BPA+z0edzyafM8cFaWNcizFoqy/NeF2Kdl4prUTJ2q4sbsnhKcVJr0jooXHRQ9gFUf49BMW64/9xXWDwn0oQw6P6jZyuSN3Wy71pNhpodoV+yV1QpHwweg8JVAR5sMkXYRL0jecXfjSdE3OoGOgjGQTeW9kjwuNG3P3A2JI8E8pVrbiXJjTgbKtzr1CJPDQN+P8AoBS9UZhRt5i7FN8LxMebc17IzEQ/DdIQZKabTKEnIHPxcQdsECygmj93JbLhpugcerrnr4CU2At5V1jFwFg+2KA0SPydb2Xd3cGE9RO1r3IwWbtskpO2SP8YW18u/PN7swrziKYtVG9i4mAVuaFAolSi0rT7YZeWHrEkcmPw/174SZNoB54t2ZYgrNCOubZKLgX9nfeFD+OzTNMUPlp/Wl7fPgH3kjjat1XPiAa7w1Apwq3HmZZe/HonA/IaH6Glsd22/f0uYnmj1HbtTb9b2k4nU3Q8Gyl+FZkrR7cvXY6tIk1DHvQWnrERZfwK2wZqCkt/WfR3Pffy/j3jS1WH3Zdx34GCrpPdeGIVdAapunSgUY443otuOHpz1nOlWpBch6M2+EVbVdOuUN/NTIE3makiyP8I2+9ZW1vxLc0McL7giPkcEjbFKsfs3BhlvfILfaVMMH0MVUDZeVdDHWYz7Ed0KVB/WS6SYMYTKVATjT13GmamFssZXcGRXpWcNfNvR/JXyrsbch5sjiN
 MCrtz2zVJi014rONkKjN9DUnAbMLOhCoEFz5jWE9TrZ3388U0LSD3GQAUVpMlFwjeP0wvy4sHnDNuj+JcBNFhTV26dwwJsRX8QOC4oHaLYYt7NeMVWyw66FlvGbTIys98bgm4FN1Q77ZvXo7hB/4py5HzKN+DflyVXTxMb5ZAevHT0mtDToBJH0CS6wIneA+t080oxINyRRnai4bpEY43IMNUL02AAjxnGR7f3+TbiYGPFSGf6p4z+BYiY/8oXEJalENhO6/CiSKWfnpmbVvCzxjxo9nlQxn9p7pz6Ggte1gd767J3BHkEjaFWvJrC2nmk5idWGmSYdWMmHFi5KZLWkCTiDpn6fgPK1jyCu2VZbP/qqFqpGjv3JhV8yCYu46f4sNjKYwwRom+o4g==; s=20190906; c=relaxed/relaxed; d=scoopta.email; v=1; bh=NWIzN1D0PkBfXyoPl6HGIphhT6OjbDAKi1Q4VdD9UMA=; h=Message-ID:Date:Subject:From:To:MIME-Version:Content-Type;
MIME-Version: 1.0
X-UserIsAuth: true
Received: from 75-128-38-74.static.mtpk.ca.charter.com (EHLO [192.168.0.102]) ([75.128.38.74])
          by scoopta.email (JAMES SMTP Server ) with ESMTPA ID -140762169
          for <linux-kernel@vger.kernel.org>;
          Thu, 13 Feb 2020 13:55:58 -0800 (PST)
Subject: Re: RX 5700 XT Issues
From:   Scoopta <mlist@scoopta.email>
To:     linux-kernel@vger.kernel.org
References: <8e09f86e-b241-971a-ea8c-8948b9e06d20@scoopta.email>
 <3b2eff03-35b0-36f4-21a7-6a117733d4ad@scoopta.email>
 <2f5a756d-64d3-800c-499c-8531a6571e3a@scoopta.email>
Message-ID: <e63e075c-949b-84ea-d4c2-94510ee4704d@scoopta.email>
Date:   Thu, 13 Feb 2020 13:55:57 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
In-Reply-To: <2f5a756d-64d3-800c-499c-8531a6571e3a@scoopta.email>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've opened a bug report here 
https://gitlab.freedesktop.org/drm/amd/issues/1047 about this issue

On 2/12/20 1:34 AM, Scoopta wrote:
> I've attached the dmesg output after the error happens.
>
> On 2/11/20 9:45 PM, Scoopta wrote:
>> My previous statement doesn't appear to be correct syslog just wasn't
>> being flushed despite doing an REISUB. I'm getting a powerplay error.
>> Specifically it seems related to
>> https://gitlab.freedesktop.org/drm/amd/issues/900
>>
>> On 2/11/20 7:13 PM, Scoopta wrote:
>>> When playing demanding games my RX 5700 XT will sometimes just stop. All
>>> my displays turn off but the system stays responsive. Audio keeps
>>> working and I can REISUB no problem, the card just stops. Fans turn off
>>> lm-sensors reports N/A as all information on the sensors and my monitors
>>> go into power save. syslog is also completely quiet. amdgpu doesn't seem
>>> to error or anything so I have no idea how to troubleshoot if this is a
>>> hardware issue or if it's a driver issue. I couldn't find a drm or GPU
>>> specific list so I'm sending it here. I want to be sure it's not a
>>> driver issue or other kernel issue before doing an RMA.
>>>
