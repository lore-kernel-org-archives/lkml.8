Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D925EC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 11:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C14CC20772
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 11:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726829AbgGILFS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 07:05:18 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57316 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726923AbgGILFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 07:05:15 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: gtucker)
        with ESMTPSA id E33BC2A63B1
Subject: Re: chrome-platform/for-kernelci bisection:
 baseline.bootrr.rockchip-dp-probed on rk3399-gru-kevin
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <linux@roeck-us.net>, kernelci-results@groups.io
Cc:     linux-kernel@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>
References: <5f06177f.1c69fb81.ed8e4.1a92@mx.google.com>
 <a79f116f-2c6d-570d-8e06-95082d26d42d@roeck-us.net>
 <55cb5ce6-4ecb-1203-807f-c24648c0e989@collabora.com>
From:   Guillaume Tucker <guillaume.tucker@collabora.com>
Message-ID: <6ee59022-ca64-92ab-6ed6-e04115698780@collabora.com>
Date:   Thu, 9 Jul 2020 12:05:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <55cb5ce6-4ecb-1203-807f-c24648c0e989@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/2020 10:17, Enric Balletbo i Serra wrote:
> Hi,
> 
> On 8/7/20 22:32, Guenter Roeck wrote:
>> On 7/8/20 11:59 AM, kernelci.org bot wrote:
>>> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>>> * This automated bisection report was sent to you on the basis  *
>>> * that you may be involved with the breaking commit it has      *
>>> * found.  No manual investigation has been done to verify it,   *
>>> * and the root cause of the problem may be somewhere else.      *
>>> *                                                               *
>>> * If you do send a fix, please include this trailer:            *
>>> *   Reported-by: "kernelci.org bot" <bot@kernelci.org>          *
>>> *                                                               *
>>> * Hope this helps!                                              *
>>> * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * *
>>>
>>> chrome-platform/for-kernelci bisection: baseline.bootrr.rockchip-dp-probed on rk3399-gru-kevin
>>>
>>> Summary:
>>>   Start:      154353417996 KERNELCI: x86_64_defconfig: Enable support for Chromebooks devices
>>>   Plain log:  https://storage.kernelci.org/chrome-platform/for-kernelci/v5.8-rc1-20-g154353417996/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.txt
>>>   HTML log:   https://storage.kernelci.org/chrome-platform/for-kernelci/v5.8-rc1-20-g154353417996/arm64/defconfig/gcc-8/lab-collabora/baseline-rk3399-gru-kevin.html
>>>   Result:     8c9a6ef40bf4 platform/chrome: cros_ec_proto: Convert EC error codes to Linux error codes
>>>
>>> Checks:
>>>   revert:     PASS
>>>   verify:     PASS
>>>
>>> Parameters:
>>>   Tree:       chrome-platform
>>>   URL:        https://git.kernel.org/pub/scm/linux/kernel/git/chrome-platform/linux.git
>>>   Branch:     for-kernelci
>>>   Target:     rk3399-gru-kevin
>>>   CPU arch:   arm64
>>>   Lab:        lab-collabora
>>>   Compiler:   gcc-8
>>>   Config:     defconfig
>>>   Test case:  baseline.bootrr.rockchip-dp-probed
>>>
>>> Breaking commit found:
>>>
>>> -------------------------------------------------------------------------------
>>> commit 8c9a6ef40bf400c64c9907031bd32b59f9d4aea2
>>> Author: Guenter Roeck <linux@roeck-us.net>
>>> Date:   Sat Jul 4 07:26:07 2020 -0700
>>>
>>>     platform/chrome: cros_ec_proto: Convert EC error codes to Linux error codes
>>>     
>>>     The EC reports a variety of error codes. Most of those, with the exception
>>>     of EC_RES_INVALID_VERSION, are converted to -EPROTO. As result, the actual
>>>     error code gets lost. Convert all EC errors to Linux error codes to report
>>>     a more meaningful error to the caller to aid debugging.
>>>     
>>>     Cc: Yu-Hsuan Hsu <yuhsuan@chromium.org>
>>>     Cc: Prashant Malani <pmalani@chromium.org>
>>>     Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>>>     Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
>>>
> 
> So, as Guenter pointed I dropped this patch now.
> 
>>
>> So, just FTR, turns out that there are callers which specifically check for
>> -EPROTO and examine the EC error code if it is returned, or just accept
>> -EPROTO as generic failure (but nothing else). Example is drivers/pwm/pwm-cros-ec.c:
>> cros_ec_num_pwms(). Such commands now fail, in this case because
>> EC_RES_INVALID_PARAM is now returned as -EINVAL and cros_ec_num_pwms()
>> doesn't expect that.
>>
> 
> Right, that's interesting, and I'll take in consideration for future reworks of
> the above patch and also take a deeper look at those specific cases reported.

This bisection is probably one of the most interesting ones
indeed.  I should mention it when I finally get round to making
a "KernelCI bisections hall of fame" blog post.

> BTW, Guillaume, I queued that patch to give a try and test 3 days ago. Is the
> bisection job expected to take that time to run? In this case I think it also
> took some time to receive the build test, so probably is just a matter of having
> lot of jobs in the queue?
> 
> I am not complaining at all, just curious, and just want to know to improve my
> maintainer workflow.

I think what you're doing is perfectly fine, there were some
issues with Jenkins and one build server that caused some
KernelCI builds to not be run this week.  Also there is an
intermittent bug in LAVA that causes tests to not run, so I think
the delay was due to an unfortunate combination of infrastructure
issues.

We now have a rather fast build server dedicated to bisections,
so for a maintainer branch like yours where it just takes a
handful of iterations I would expect this kind of report to be
sent at most 6h after a git push.  Bisecting linux-next can take
a few extra hours with typically 10~15 iterations.

Best wishes,
Guillaume

>> drivers/iio/common/cros_ec_sensors/cros_ec_sensors.c has a similar problem;
>> it only accepts -EPROTO as "valid" error, but nothing else. I didn't check
>> for others.
>>
>> Guenter
>>

