Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D6CC2BA1B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12C4C24942
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 16:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="mf7A4+m6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbgDFQMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 12:12:15 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:2088 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729460AbgDFQMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 12:12:13 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e8b54770000>; Mon, 06 Apr 2020 09:10:31 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 06 Apr 2020 09:12:13 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 06 Apr 2020 09:12:13 -0700
Received: from DRHQMAIL107.nvidia.com (10.27.9.16) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 Apr
 2020 16:12:12 +0000
Received: from [10.2.164.193] (172.20.13.39) by DRHQMAIL107.nvidia.com
 (10.27.9.16) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 6 Apr 2020
 16:12:11 +0000
Subject: Re: [RFC PATCH v6 6/9] media: tegra: Add Tegra210 Video input driver
To:     Dmitry Osipenko <digetx@gmail.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <frankc@nvidia.com>, <hverkuil@xs4all.nl>,
        <sakari.ailus@iki.fi>, <helen.koike@collabora.com>
CC:     <sboyd@kernel.org>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1585963507-12610-1-git-send-email-skomatineni@nvidia.com>
 <1585963507-12610-7-git-send-email-skomatineni@nvidia.com>
 <38d921a7-5cdf-8d0a-2772-4399dd1a96a0@gmail.com>
 <9b8cf37b-d2ad-9df2-aad8-216c2c954e69@nvidia.com>
 <1a12974a-7cc7-2c3a-3995-076b9956714d@gmail.com>
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
Message-ID: <66cc8646-43d3-3fc8-c31d-d0d2efac505f@nvidia.com>
Date:   Mon, 6 Apr 2020 09:12:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1a12974a-7cc7-2c3a-3995-076b9956714d@gmail.com>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 DRHQMAIL107.nvidia.com (10.27.9.16)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586189431; bh=jI/z5fkue2SxsL7yu3bnv36ATfwkh0MST94p9u6WwKU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Transfer-Encoding:
         Content-Language;
        b=mf7A4+m64PV04pY7UpB5hc/QwEHXn7Q+NQoWtWtxU3YoMDPLNE+2yc0m3su4lkpGv
         1naXWNkkUGSNQOooBWfweCCHKPb4thKUUqT1RqOX/b+wn1KP7hXhI9d3sNbzkRkeHb
         +nHyzyat3GSGdWYoioJ4cCtHHXa1ijpUoXgJmfYXBUTzCIXQXA7+HHkBKGzGOuoosO
         72kbgK+q65Qnvb9b9zlEEm+sLlYbix7vqCgJ+lcqNk4uWk4NUI7MqRJJeA1hiNRhiP
         yeEaa7fKyG3pUhBmwyJVa1M6lHmNN/7GqK31RTDpPUP3I+97siB2cgrlsTtPZSUiS0
         Vy9pdNe6GRbzw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/6/20 9:05 AM, Dmitry Osipenko wrote:
> External email: Use caution opening links or attachments
>
>
> 06.04.2020 18:35, Sowjanya Komatineni =D0=BF=D0=B8=D1=88=D0=B5=D1=82:
> ...
>>>> +     /* wait for syncpt counter to reach frame start event threshold =
*/
>>>> +     err =3D host1x_syncpt_wait(chan->frame_start_sp, thresh,
>>>> +                              TEGRA_VI_SYNCPT_WAIT_TIMEOUT, &value);
>>>> +     if (err) {
>>>> +             dev_err(&chan->video.dev,
>>>> +                     "frame start syncpt timeout: %d\n", err);
>>>> +             /* increment syncpoint counter for timedout events */
>>>> +             host1x_syncpt_incr(chan->frame_start_sp);
>>> Why incrementing is done while hardware is still active?
>>>
>>> The sync point's state needs to be completely reset after resetting
>>> hardware. But I don't think that the current upstream host1x driver
>>> supports doing that, it's one of the known-long-standing problems of th=
e
>>> host1x driver.
>>>
>>> At least the sp->max_val incrementing should be done based on the actua=
l
>>> syncpoint value and this should be done after resetting hardware.
>> upstream host1x driver don't have API to reset or to equalize max value
>> with min/load value.
>>
>> So to synchronize missed event, incrementing HW syncpt counter.
>>
>> This should not impact as we increment this in case of missed events onl=
y.
> It's wrong to touch sync point while hardware is active and it's active
> until being reset.
>
> You should re-check the timeout after hw resetting and manually put the
> syncpoint counter back into sync only if needed.

There is possibility of timeout to happen any time even during the=20
capture also and is not related to hw reset.

Manual synchronization is needed when timeout of any frame events happen=20
otherwise all subsequence frames will timeout due to mismatch in event=20
counters.


