Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4450C3F68F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 08:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B96214DB
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 08:17:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbgBJIRu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 03:17:50 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:47226 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbgBJIRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 03:17:50 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tomeu)
        with ESMTPSA id B7231283D5B
Subject: Re: [PATCH v4 0/7] Add dts for mt8183 GPU (and misc panfrost patches)
To:     Nicolas Boichat <drinkcat@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
References: <20200207052627.130118-1-drinkcat@chromium.org>
 <5237381b-c232-7087-a3d6-78d6358d80bf@collabora.com>
 <CANMq1KCD1U7iym_fFWAd-Xa6ipxHmF_FAYxDL5WqGzDnA0KKLw@mail.gmail.com>
 <93aec9ae-00fc-bf55-1d6c-9bd715b78344@collabora.com>
 <CANMq1KC_nN4MQ8LKPCCNGPPeHRP18n3USXg6DRPousivn_J3aw@mail.gmail.com>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Message-ID: <7e1ffa57-20c7-02cc-47f6-bfaebb772956@collabora.com>
Date:   Mon, 10 Feb 2020 09:17:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CANMq1KC_nN4MQ8LKPCCNGPPeHRP18n3USXg6DRPousivn_J3aw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/20 4:39 AM, Nicolas Boichat wrote:
> On Fri, Feb 7, 2020 at 4:13 PM Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
>>
>> On 2/7/20 8:42 AM, Nicolas Boichat wrote:
>>> On Fri, Feb 7, 2020 at 2:18 PM Tomeu Vizoso <tomeu.vizoso@collabora.com> wrote:
>>>>
>>>>> Some more changes are still required to get devfreq working, and of course
>>>>> I do not have a userspace driver to test this with.
>>>>
>>>> Have you tried the Panfrost tests in IGT? They are atm quite basic, but
>>>> could be interesting to check that the different HW units are correctly
>>>> powered on.
>>>
>>> I haven't, you mean this right?
>>> https://gitlab.freedesktop.org/tomeu/igt-gpu-tools/tree/panfrost
>>
>> Yes, though may be better to use the upstream repo:
>>
>> https://gitlab.freedesktop.org/drm/igt-gpu-tools
>>
>>> Any specific test you have in mind?
>>
>> All the panfrost ones, but looks like panfrost_prime:gem-prime-import is
>> failing atm:
>>
>> https://lava.collabora.co.uk/scheduler/job/2214987
> 
> (I first removed opp table from device tree to avoid constant spew
> about devfreq not supporting 2 regulators, I should get around to fix
> that...)
> 
> # /usr/libexec/igt-gpu-tools/panfrost_gem_new
> IGT-Version: 1.24-gd4d574a4 (arm) (Linux: 4.19.99 aarch64)
> Starting subtest: gem-new-4096
> Subtest gem-new-4096: SUCCESS (0.000s)
> Starting subtest: gem-new-0
> Subtest gem-new-0: SUCCESS (0.000s)
> Starting subtest: gem-new-zeroed
> Subtest gem-new-zeroed: SUCCESS (0.001s)
> # /usr/libexec/igt-gpu-tools/panfrost_get_param
> IGT-Version: 1.24-gd4d574a4 (arm) (Linux: 4.19.99 aarch64)
> Starting subtest: base-params
> Subtest base-params: SUCCESS (0.000s)
> Starting subtest: get-bad-param
> Subtest get-bad-param: SUCCESS (0.000s)
> Starting subtest: get-bad-padding
> Subtest get-bad-padding: SUCCESS (0.000s)
> # /usr/libexec/igt-gpu-tools/panfrost_prime
> IGT-Version: 1.24-gd4d574a4 (arm) (Linux: 4.19.99 aarch64)
> Starting subtest: gem-prime-import
> (panfrost_prime:1527) ioctl_wrappers-CRITICAL: Test assertion failure
> function prime_fd_to_handle, file
> ../igt-gpu-tools-9999/lib/ioctl_wrappers.c:1336:
> (panfrost_prime:1527) ioctl_wrappers-CRITICAL: Failed assertion:
> igt_ioctl((fd), ((((2U|1U) << (((0+8)+8)+14)) | ((('d')) << (0+8)) |
> (((0x2e)) << 0) | ((((sizeof(struct drm_prime_handle)))) <<
> ((0+8)+8)))), (&args)) == 0
> (panfrost_prime:1527) ioctl_wrappers-CRITICAL: Last errno: 95,
> Operation not supported
> (panfrost_prime:1527) ioctl_wrappers-CRITICAL: error: -1 != 0
> Stack trace:
> Subtest gem-prime-import failed.
> Subtest gem-prime-import: FAIL (0.004s)
> (but that looks expected?)

Yep, haven't gotten to investigate yet.

> Now the trickier ones, I guess we're either missing something, or my
> dirty 4.19 backport is very broken:

Damn, looks like the simple job we use to test submits doesn't work as-is 
on your GPU.

But things seem to work otherwise, so probably the kernel driver is fully 
functional with your changes.

Cheers,

Tomeu

> # /usr/libexec/igt-gpu-tools/panfrost_submit
> IGT-Version: 1.24-gd4d574a4 (arm) (Linux: 4.19.99 aarch64)
> Starting subtest: pan-submit
> (panfrost_submit:1643) CRITICAL: Test assertion failure function
> __real_main86, file ../igt-gpu-tools-9999/tests/panfrost_submit.c:103:
> (panfrost_submit:1643) CRITICAL: Failed assertion: syncobj_wait(fd,
> &submit->args->out_sync, 1, abs_timeout(SHORT_TIME_NSEC), 0, NULL)
> Stack trace:
> Subtest pan-submit failed.
> **** DEBUG ****
> (panfrost_submit:1643) CRITICAL: Test assertion failure function
> __real_main86, file ../igt-gpu-tools-9999/tests/panfrost_submit.c:103:
> (panfrost_submit:1643) CRITICAL: Failed assertion: syncobj_wait(fd,
> &submit->args->out_sync, 1, abs_timeout(SHORT_TIME_NSEC), 0, NULL)
> (panfrost_submit:1643) igt_core-INFO: Stack trace:
> ****  END  ****
> Subtest pan-submit: FAIL (0.119s)
> Starting subtest: pan-submit-error-no-jc
> Subtest pan-submit-error-no-jc: SUCCESS (0.000s)
> Starting subtest: pan-submit-error-bad-in-syncs
> Subtest pan-submit-error-bad-in-syncs: SUCCESS (0.012s)
> Starting subtest: pan-submit-error-bad-bo-handles
> Subtest pan-submit-error-bad-bo-handles: SUCCESS (0.012s)
> Starting subtest: pan-submit-error-bad-requirements
> Subtest pan-submit-error-bad-requirements: SUCCESS (0.012s)
> Starting subtest: pan-submit-error-bad-out-sync
> Subtest pan-submit-error-bad-out-sync: SUCCESS (0.012s)
> Starting subtest: pan-reset
> (panfrost_submit:1643) CRITICAL: Test assertion failure function
> __real_main86, file ../igt-gpu-tools-9999/tests/panfrost_submit.c:173:
> (panfrost_submit:1643) CRITICAL: Failed assertion: syncobj_wait(fd,
> &submit->args->out_sync, 1, abs_timeout(BAD_JOB_TIME_NSEC), 0, NULL)
> Stack trace:
> Subtest pan-reset failed.
> **** DEBUG ****
> (panfrost_submit:1643) CRITICAL: Test assertion failure function
> __real_main86, file ../igt-gpu-tools-9999/tests/panfrost_submit.c:173:
> (panfrost_submit:1643) CRITICAL: Failed assertion: syncobj_wait(fd,
> &submit->args->out_sync, 1, abs_timeout(BAD_JOB_TIME_NSEC), 0, NULL)
> (panfrost_submit:1643) igt_core-INFO: Stack trace:
> ****  END  ****
> Subtest pan-reset: FAIL (0.840s)
> 
> The pan-submit case causes an MMU fault:
> (full log: https://gist.github.com/drinkcat/1ae36cb1b1b71f30cc4fc29759612d76)
> 
> [ 1215.234937] [IGT] panfrost_submit: executing
> [ 1215.318446] [IGT] panfrost_submit: starting subtest pan-submit
> ...
> [ 1215.338644] panfrost 13040000.gpu: Unhandled Page fault in AS0 at
> VA 0x000000FF00000000
>                 Reason: TODO
>                 raw fault status: 0xA002C0
>                 decoded fault status: SLAVE FAULT
>                 exception type 0xC0: UNKNOWN
>                 access type 0x2: READ
>                 source id 0xA0
> [ 1215.444504] [IGT] panfrost_submit: exiting, ret=98
> ...
> [ 1215.446902] panfrost 13040000.gpu: js fault, js=0,
> status=JOB_BUS_FAULT, head=0x300b000, tail=0x300b000
> [ 1215.446935] panfrost 13040000.gpu: Unhandled Page fault in AS0 at
> VA 0x000000FF00000000
> Reason: TODO
> raw fault status: 0xA002C0
> decoded fault status: SLAVE FAULT
> exception type 0xC0: UNKNOWN
> access type 0x2: READ
> source id 0xA0
> 
> pan-reset failure looks similar:
> https://gist.github.com/drinkcat/2d336d57e6b95262d83e7a28a409bc5b
> 
> Thanks,
> 
>> Cheers,
>>
>> Tomeu
>>
>>> Thanks,
>>>
>>>> Regards,
>>>>
>>>> Tomeu
>>>>
>>>>> I believe at least patches 1, 2, and 3 can be merged. 4 and 5 are mostly
>>>>> useful in conjunction with 6 and 7 (which are not ready yet), so I'll let
>>>>> maintainers decide.
>>>>>
>>>>> Thanks!
>>>>>
>>>>> Nicolas Boichat (7):
>>>>>      dt-bindings: gpu: mali-bifrost: Add Mediatek MT8183
>>>>>      arm64: dts: mt8183: Add node for the Mali GPU
>>>>>      drm/panfrost: Improve error reporting in panfrost_gpu_power_on
>>>>>      drm/panfrost: Add support for multiple regulators
>>>>>      drm/panfrost: Add support for multiple power domains
>>>>>      RFC: drm/panfrost: Add mt8183-mali compatible string
>>>>>      RFC: drm/panfrost: devfreq: Add support for 2 regulators
>>>>>
>>>>>     .../bindings/gpu/arm,mali-bifrost.yaml        |  25 ++++
>>>>>     arch/arm64/boot/dts/mediatek/mt8183-evb.dts   |   7 +
>>>>>     arch/arm64/boot/dts/mediatek/mt8183.dtsi      | 105 +++++++++++++++
>>>>>     drivers/gpu/drm/panfrost/panfrost_devfreq.c   |  17 +++
>>>>>     drivers/gpu/drm/panfrost/panfrost_device.c    | 123 +++++++++++++++---
>>>>>     drivers/gpu/drm/panfrost/panfrost_device.h    |  27 +++-
>>>>>     drivers/gpu/drm/panfrost/panfrost_drv.c       |  41 ++++--
>>>>>     drivers/gpu/drm/panfrost/panfrost_gpu.c       |  11 +-
>>>>>     8 files changed, 326 insertions(+), 30 deletions(-)
>>>>>
