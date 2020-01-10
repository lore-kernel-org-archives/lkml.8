Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6356C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 10:46:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B11342072E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 10:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727588AbgAJKqN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 05:46:13 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:51748 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727345AbgAJKqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 05:46:13 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 18972293A50
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: Re: [PATCH] platform/chrome: wilco_ec: Fix keyboard backlight probing
To:     Daniel Campello <campello@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Nick Crews <ncrews@chromium.org>,
        Benson Leung <bleung@chromium.org>
References: <20200107112400.1.Iedcdbae5a7ed79291b557882130e967f72168a9f@changeid>
 <ab377eeb-f1bc-13c2-8bbc-ccc53ecb7c4d@collabora.com>
 <20200108155948.GA47901@chromium.org>
Message-ID: <b6cfdfee-7e1f-117d-cb42-2d067ebd3807@collabora.com>
Date:   Fri, 10 Jan 2020 11:46:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200108155948.GA47901@chromium.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,
On 8/1/20 16:59, Daniel Campello wrote:
> Hi Enric,
> 
> On Wed, Jan 08, 2020 at 11:38:58AM +0100, Enric Balletbo i Serra wrote:
>> Hi Daniel,
>>
>> Many thanks for sending the patch upstream.
>>
>> On 7/1/20 19:24, Daniel Campello wrote:
>>> The EC on the Wilco platform responds with 0xFF to commands related to
>>> the keyboard backlight on the absence of a keyboard backlight module.
>>> This change allows the EC driver to continue loading even if the
>>> backlight module is not present.
>>>
>>
>> Could you explain a bit more which is the problem you're trying to solve? I am
>> not sure I understand it, isn't the kbbl_exist call for that purpose? (in
>> absence of the keyboard backligh module just don't init the device?)
> 
> kbbl_exists is intended to return a bool based on response.status !=
> 0xFF. Without this patch kbbl_exists will fail and return an -EIO
> error on any value of response.status
> 

Thanks for the explanation I understand now what is happening. I added the Fixed
tag and queued as a fix for chrome-platform-5.5

Thanks,
 Enric

>>
>> Thanks,
>>  Enric
>>
