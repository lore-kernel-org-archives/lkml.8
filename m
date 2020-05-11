Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B810C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 05:43:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6C08F206D9
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 05:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbgEKFnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 01:43:52 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:45572 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgEKFnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 01:43:52 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tomeu)
        with ESMTPSA id 682772A02BF
Subject: Re: [PATCH 00/15][RFC] Add regulator devfreq support to Panfrost
To:     =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Steven Price <steven.price@arm.com>,
        Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20200510165538.19720-1-peron.clem@gmail.com>
From:   Tomeu Vizoso <tomeu.vizoso@collabora.com>
Message-ID: <20af7963-1d5a-d274-a46e-ca9a287d745a@collabora.com>
Date:   Mon, 11 May 2020 07:43:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200510165538.19720-1-peron.clem@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/20 6:55 PM, Clément Péron wrote:
> Hi,
> 
> This serie cleans and adds regulator support to Panfrost devfreq.
> This is mostly based on comment for the freshly introduced lima
> devfreq.
> 
> We need to add regulator support because on Allwinner the GPU OPP
> table defines both frequencies and voltages.
> 
> First patches [01-08] should not change the actual behavior
> and introduce a proper panfrost_devfreq struct.
> 
> Fatches after are WIP and add regulator support.
> 
> However I got several issues first we need to avoid getting regulator
> if devfreq get by itself the regulator, but as of today the OPP
> framework only get and don't enable the regulator...
> An HACK for now is to add regulator-always-on in the device-tree.
> 
> Then when I enable devfreq I got several faults like.
> I'm totally noob on GPU sched/fault and couldn't be helpfull with this.

Do you know at which frequencies do the faults happen? From what I can 
see, it's just the GPU behaving erratically, and the CPU reading random 
values from the GPU registers. Given the subject of this series, I guess 
the GPU isn't getting enough power.

There could be a problem with the OPP table, might be a good idea to see 
what levels are problematic and try with a more conservative table.

Besides that, there could be a problem with clock frequency changes, or 
voltage changes. It may take some time for the final state to be stable, 
depending how the regulation happens.

Thanks,

Tomeu




> I got this running glmark2 on T720 (Allwinner H6) with Mesa 20.0.5.
> # glmark2-es2-drm
> =======================================================
>      glmark2 2017.07
> =======================================================
>      OpenGL Information
>      GL_VENDOR:     Panfrost
>      GL_RENDERER:   Mali T720 (Panfrost)
>      GL_VERSION:    OpenGL ES 2.0 Mesa 20.0.5
> =======================================================
> 
> [   93.550063] panfrost 1800000.gpu: GPU Fault 0x00000088 (UNKNOWN) at 0x0000000080117100
> [   94.045401] panfrost 1800000.gpu: gpu sched timeout, js=0, config=0x3700, status=0x8, head=0x21d6c00, tail=0x21d6c00, sched_job=00000000e3c2132f
> 
> [  328.871070] panfrost 1800000.gpu: Unhandled Page fault in AS0 at VA 0x0000000000000000
> [  328.871070] Reason: TODO
> [  328.871070] raw fault status: 0xAA0003C2
> [  328.871070] decoded fault status: SLAVE FAULT
> [  328.871070] exception type 0xC2: TRANSLATION_FAULT_LEVEL2
> [  328.871070] access type 0x3: WRITE
> [  328.871070] source id 0xAA00
> [  329.373327] panfrost 1800000.gpu: gpu sched timeout, js=1, config=0x3700, status=0x8, head=0xa1a4900, tail=0xa1a4900, sched_job=000000007ac31097
> [  329.386527] panfrost 1800000.gpu: js fault, js=0, status=DATA_INVALID_FAULT, head=0xa1a4c00, tail=0xa1a4c00
> [  329.396293] panfrost 1800000.gpu: gpu sched timeout, js=0, config=0x3700, status=0x58, head=0xa1a4c00, tail=0xa1a4c00, sched_job=0000000004c90381
> [  329.411521] panfrost 1800000.gpu: Unhandled Page fault in AS0 at VA 0x0000000000000000
> [  329.411521] Reason: TODO
> [  329.411521] raw fault status: 0xAA0003C2
> [  329.411521] decoded fault status: SLAVE FAULT
> [  329.411521] exception type 0xC2: TRANSLATION_FAULT_LEVEL2
> [  329.411521] access type 0x3: WRITE
> [  329.411521] source id 0xAA00
> 
> Thanks for your reviews, help on this serie,
> Clement
> 
> Clément Péron (15):
>    drm/panfrost: avoid static declaration
>    drm/panfrost: clean headers in devfreq
>    drm/panfrost: don't use pfdevfreq.busy_count to know if hw is idle
>    drm/panfrost: introduce panfrost_devfreq struct
>    drm/panfrost: use spinlock instead of atomic
>    drm/panfrost: properly handle error in probe
>    drm/panfrost: use device_property_present to check for OPP
>    drm/panfrost: move devfreq_init()/fini() in device
>    drm/panfrost: dynamically alloc regulators
>    drm/panfrost: add regulators to devfreq
>    drm/panfrost: set devfreq clock name
>    arm64: defconfig: Enable devfreq cooling device
>    arm64: dts: allwinner: h6: Add cooling map for GPU
>    [DO NOT MERGE] arm64: dts: allwinner: h6: Add GPU OPP table
>    [DO NOT MERGE] arm64: dts: allwinner: force GPU regulator to be always
> 
>   .../dts/allwinner/sun50i-h6-beelink-gs1.dts   |   1 +
>   arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  | 102 ++++++++++
>   arch/arm64/configs/defconfig                  |   1 +
>   drivers/gpu/drm/panfrost/panfrost_devfreq.c   | 190 ++++++++++++------
>   drivers/gpu/drm/panfrost/panfrost_devfreq.h   |  32 ++-
>   drivers/gpu/drm/panfrost/panfrost_device.c    |  56 ++++--
>   drivers/gpu/drm/panfrost/panfrost_device.h    |  14 +-
>   drivers/gpu/drm/panfrost/panfrost_drv.c       |  15 +-
>   drivers/gpu/drm/panfrost/panfrost_job.c       |  10 +-
>   9 files changed, 310 insertions(+), 111 deletions(-)
> 
