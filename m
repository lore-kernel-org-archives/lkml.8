Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92BCCC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53CFD20675
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="cVxKtbDW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgCINn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 09:43:28 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:40590 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726427AbgCINn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 09:43:27 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 029Dgg95022146;
        Mon, 9 Mar 2020 14:43:17 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=9FQAytpLsI/D123EtIRSfLaD/E+V6TsKcGwBzl4+Ckw=;
 b=cVxKtbDWotu1GthfQjjNe49LEu1MJBvdx7jOBKUt5b1xoYtqR32OakLCRRsREUqfa3Ey
 7sh3Vuq6ynF93SrD3H4zeizXq9OkGfnjf/suMhbS9hkKNyEoPtTyQb2C4ELjhVX00lI+
 Al9+5lJhO8l5YMaat8ryIwi+2bd6yaMPcKPocsghob2ko/LvgqEVk4OVyv/eVZtJkqFW
 Rq/BXL9BIQCAVHPnLkuo7LEtuqK9Ek/lIr7ne7LZ/l5YKYMvS7AMCh1xebRDcUHVshmT
 yIK9EGHZm86PqVlPzdllV4s/MU6O7qr0fOWrGN8hN7BgvCPCSjUnu6diVcnkXnsfufYc AA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2ym1y6cjun-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Mar 2020 14:43:17 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EAB9B100034;
        Mon,  9 Mar 2020 14:43:12 +0100 (CET)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D08C92A5429;
        Mon,  9 Mar 2020 14:43:12 +0100 (CET)
Received: from lmecxl0889.lme.st.com (10.75.127.46) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 9 Mar
 2020 14:43:11 +0100
Subject: Re: [PATCH v5 1/3] remoteproc: add support for co-processor loaded
 and booted before kernel
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        <devicetree@vger.kernel.org>, Ohad Ben-Cohen <ohad@wizery.com>,
        Loic PALLARDY <loic.pallardy@st.com>,
        Suman Anna <s-anna@ti.com>,
        Fabien DESSENNE <fabien.dessenne@st.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20200211174205.22247-1-arnaud.pouliquen@st.com>
 <20200211174205.22247-2-arnaud.pouliquen@st.com>
 <20200213200813.GA14415@xps15> <24947b31-bef6-cfb3-686e-80bef6f974e3@st.com>
 <CANLsYkxhWWgVFVe3=5WOYkYGQgV7g+3FvDKRDKi7y9kuk4_G8w@mail.gmail.com>
 <d6e09b93-f287-78a0-a6d9-3d9ea0a5f3d7@st.com>
 <CANLsYkzQz5yyu+KViEL8GwWtp7cfBotS8Fuvs1MJzvYq4LxOig@mail.gmail.com>
 <07d5bea4-1585-db55-4ca0-ae28dcf81d41@st.com>
 <CANLsYkwPHZQ776AtSmzLO=m7Uxa4Dmw+aVrWL+tB5-ZUNy=N3g@mail.gmail.com>
 <CANLsYkwAyY86+85nWuP67wB+h8ycSNkbPmjmGz1-s=xVU5qs=w@mail.gmail.com>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <c15bddd7-0542-d1a7-97c5-d1e68c2a0048@st.com>
Date:   Mon, 9 Mar 2020 14:43:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CANLsYkwAyY86+85nWuP67wB+h8ycSNkbPmjmGz1-s=xVU5qs=w@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG7NODE3.st.com (10.75.127.21) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-03-09_04:2020-03-09,2020-03-09 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 2/27/20 1:56 AM, Mathieu Poirier wrote:
> On Thu, 20 Feb 2020 at 14:40, Mathieu Poirier
> <mathieu.poirier@linaro.org> wrote:
>>
>> On Thu, 20 Feb 2020 at 02:35, Arnaud POULIQUEN <arnaud.pouliquen@st.com> wrote:
>>>
>>>
>>>
>>> On 2/19/20 9:56 PM, Mathieu Poirier wrote:
>>>> Hey Arnaud,
>>>>
>>>> On Tue, 18 Feb 2020 at 10:31, Arnaud POULIQUEN <arnaud.pouliquen@st.com> wrote:
>>>>>
>>>>> Hi Mathieu, Bjorn,
>>>>>
>>>>> On 2/17/20 7:40 PM, Mathieu Poirier wrote:
>>>>>> On Fri, 14 Feb 2020 at 09:33, Arnaud POULIQUEN <arnaud.pouliquen@st.com> wrote:
>>>>>>>
>>>>>>> Hi Mathieu,
>>>>>>>
>>>>>>> On 2/13/20 9:08 PM, Mathieu Poirier wrote:
>>>>>>>> Good day,
>>>>>>>>
>>>>>>>> On Tue, Feb 11, 2020 at 06:42:03PM +0100, Arnaud Pouliquen wrote:
>>>>>>>>> From: Loic Pallardy <loic.pallardy@st.com>
>>>>>>>>>
>>>>>>>>> Remote processor could boot independently or be loaded/started before
>>>>>>>>> Linux kernel by bootloader or any firmware.
>>>>>>>>> This patch introduces a new property in rproc core, named skip_fw_load,
>>>>>>>>> to be able to allocate resources and sub-devices like vdev and to
>>>>>>>>> synchronize with current state without loading firmware from file system.
>>>>>>>>> It is platform driver responsibility to implement the right firmware
>>>>>>>>> load ops according to HW specificities.
>>>>>>>>>
>>>>>>>>> Signed-off-by: Loic Pallardy <loic.pallardy@st.com>
>>>>>>>>> Acked-by: Mathieu Poirier <mathieu.poirier@linaro.org>
>>>>>>>>> Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
>>>>>>>>> ---
>>>>>>>>>  drivers/remoteproc/remoteproc_core.c | 67 ++++++++++++++++++++++------
>>>>>>>>>  include/linux/remoteproc.h           |  2 +
>>>>>>>>>  2 files changed, 55 insertions(+), 14 deletions(-)
>>>>>>>>>
>>>>>>>>> diff --git a/drivers/remoteproc/remoteproc_core.c b/drivers/remoteproc/remoteproc_core.c
>>>>>>>>> index 097f33e4f1f3..876b5420a32b 100644
>>>>>>>>> --- a/drivers/remoteproc/remoteproc_core.c
>>>>>>>>> +++ b/drivers/remoteproc/remoteproc_core.c
>>>>>>>>> @@ -1358,8 +1358,19 @@ static int rproc_start(struct rproc *rproc, const struct firmware *fw)
>>>>>>>>>      return ret;
>>>>>>>>>  }
>>>>>>>>>
>>>>>>>>> -/*
>>>>>>>>> - * take a firmware and boot a remote processor with it.
>>>>>>>>> +/**
>>>>>>>>> + * rproc_fw_boot() - boot specified remote processor according to specified
>>>>>>>>> + * firmware
>>>>>>>>> + * @rproc: handle of a remote processor
>>>>>>>>> + * @fw: pointer on firmware to handle
>>>>>>>>> + *
>>>>>>>>> + * Handle resources defined in resource table, load firmware and
>>>>>>>>> + * start remote processor.
>>>>>>>>> + *
>>>>>>>>> + * If firmware pointer fw is NULL, firmware is not handled by remoteproc
>>>>>>>>> + * core, but under the responsibility of platform driver.
>>>>>>>>> + *
>>>>>>>>> + * Returns 0 on success, and an appropriate error value otherwise.
>>>>>>>>>   */
>>>>>>>>>  static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
>>>>>>>>>  {
>>>>>>>>> @@ -1371,7 +1382,11 @@ static int rproc_fw_boot(struct rproc *rproc, const struct firmware *fw)
>>>>>>>>>      if (ret)
>>>>>>>>>              return ret;
>>>>>>>>>
>>>>>>>>> -    dev_info(dev, "Booting fw image %s, size %zd\n", name, fw->size);
>>>>>>>>> +    if (fw)
>>>>>>>>> +            dev_info(dev, "Booting fw image %s, size %zd\n", name,
>>>>>>>>> +                     fw->size);
>>>>>>>>> +    else
>>>>>>>>> +            dev_info(dev, "Synchronizing with preloaded co-processor\n");
>>>>>>>>>
>>>>>>>>>      /*
>>>>>>>>>       * if enabling an IOMMU isn't relevant for this rproc, this is
>>>>>>>>> @@ -1718,16 +1733,22 @@ static void rproc_crash_handler_work(struct work_struct *work)
>>>>>>>>>   * rproc_boot() - boot a remote processor
>>>>>>>>>   * @rproc: handle of a remote processor
>>>>>>>>>   *
>>>>>>>>> - * Boot a remote processor (i.e. load its firmware, power it on, ...).
>>>>>>>>> + * Boot a remote processor (i.e. load its firmware, power it on, ...) from
>>>>>>>>> + * different contexts:
>>>>>>>>> + * - power off
>>>>>>>>> + * - preloaded firmware
>>>>>>>>> + * - started before kernel execution
>>>>>>>>> + * The different operations are selected thanks to properties defined by
>>>>>>>>> + * platform driver.
>>>>>>>>>   *
>>>>>>>>> - * If the remote processor is already powered on, this function immediately
>>>>>>>>> - * returns (successfully).
>>>>>>>>> + * If the remote processor is already powered on at rproc level, this function
>>>>>>>>> + * immediately returns (successfully).
>>>>>>>>>   *
>>>>>>>>>   * Returns 0 on success, and an appropriate error value otherwise.
>>>>>>>>>   */
>>>>>>>>>  int rproc_boot(struct rproc *rproc)
>>>>>>>>>  {
>>>>>>>>> -    const struct firmware *firmware_p;
>>>>>>>>> +    const struct firmware *firmware_p = NULL;
>>>>>>>>>      struct device *dev;
>>>>>>>>>      int ret;
>>>>>>>>>
>>>>>>>>> @@ -1758,11 +1779,20 @@ int rproc_boot(struct rproc *rproc)
>>>>>>>>>
>>>>>>>>>      dev_info(dev, "powering up %s\n", rproc->name);
>>>>>>>>>
>>>>>>>>> -    /* load firmware */
>>>>>>>>> -    ret = request_firmware(&firmware_p, rproc->firmware, dev);
>>>>>>>>> -    if (ret < 0) {
>>>>>>>>> -            dev_err(dev, "request_firmware failed: %d\n", ret);
>>>>>>>>> -            goto downref_rproc;
>>>>>>>>> +    if (!rproc->skip_fw_load) {
>>>>>>>>> +            /* load firmware */
>>>>>>>>> +            ret = request_firmware(&firmware_p, rproc->firmware, dev);
>>>>>>>>> +            if (ret < 0) {
>>>>>>>>> +                    dev_err(dev, "request_firmware failed: %d\n", ret);
>>>>>>>>> +                    goto downref_rproc;
>>>>>>>>> +            }
>>>>>>>>> +    } else {
>>>>>>>>> +            /*
>>>>>>>>> +             * Set firmware name pointer to null as remoteproc core is not
>>>>>>>>> +             * in charge of firmware loading
>>>>>>>>> +             */
>>>>>>>>> +            kfree(rproc->firmware);
>>>>>>>>> +            rproc->firmware = NULL;
>>>>>>>>
>>>>>>>> If the MCU with pre-loaded FW crashes request_firmware() in
>>>>>>>> rproc_trigger_recovery() will return an error and rproc_start()
>>>>>>>> never called.
>>>>>>>
>>>>>>> Right, something is missing in the recovery function to prevent request_firmware call if skip_fw_load is set
>>>>>>>
>>>>>>> We also identify an issue if recovery fails:
>>>>>>> In case of recovery issue the rproc state is RPROC_CRASHED, so that it is no more possible to load a new firmware from
>>>>>>> user space.
>>>>>>> This issue is not linked to this patchset. We have patches on our shelves for this.
>>>>>>>
>>>>>>>>>      }
>>>>>>>>>
>>>>>>>>>      ret = rproc_fw_boot(rproc, firmware_p);
>>>>>>>>> @@ -1916,8 +1946,17 @@ int rproc_add(struct rproc *rproc)
>>>>>>>>>      /* create debugfs entries */
>>>>>>>>>      rproc_create_debug_dir(rproc);
>>>>>>>>>
>>>>>>>>> -    /* if rproc is marked always-on, request it to boot */
>>>>>>>>> -    if (rproc->auto_boot) {
>>>>>>>>> +    if (rproc->skip_fw_load) {
>>>>>>>>> +            /*
>>>>>>>>> +             * If rproc is marked already booted, no need to wait
>>>>>>>>> +             * for firmware.
>>>>>>>>> +             * Just handle associated resources and start sub devices
>>>>>>>>> +             */
>>>>>>>>> +            ret = rproc_boot(rproc);
>>>>>>>>> +            if (ret < 0)
>>>>>>>>> +                    return ret;
>>>>>>>>> +    } else if (rproc->auto_boot) {
>>>>>>>>> +            /* if rproc is marked always-on, request it to boot */
>>>>>>>>
>>>>>>>> I spent way too much time staring at this modification...  I can't decide if a
>>>>>>>> system where the FW has been pre-loaded should be considered "auto_boot".
>>>>>>>> Indeed the result is the same, i.e the MCU is started at boot time without user
>>>>>>>> intervention.
>>>>>>>
>>>>>>> The main difference is that the firmware is loaded by the Linux remote proc in case of auto-boot.
>>>>>>> In auto-boot mode the remoteproc loads a firmware, on probe, with a specified name without any request from user space.
>>>>>>> One constraint of this mode is that the file system has to be accessible before the rproc probe.
>>>>>>
>>>>>> Indeed, but in both cases the MCU is booted automatically.  In one
>>>>>> case the FW is loaded by the framework and in the other it is not.  As
>>>>>> such both scenarios are "auto_boot", they simply have different
>>>>>> flavours.
>>>>> Regarding your concerns i would like to propose an alternative that will answer to following use cases:
>>>>>
>>>>> In term of use cases we can start the remote proc firmware in following modes:
>>>>> - auto boot with FW loading, resource table parsing and FW start/stop
>>>>> - auto boot without FW loading, with FW resource table parsing and FW start/stop
>>>>> - auto boot with FW attachment and  resource table parsing
>>>>> - boot on userspace request with FW loading, resource table parsing and FW start/stop
>>>>> - boot on userspace request without FW loading, with FW resource table parsing and FW start/stop
>>>>> - boot on userspace request with FW attachment and  resource table parsing
>>>>>
>>>>> I considered the recovery covered by these use cases...
>>>>>
>>>>> I tried to concatenate all use case to determine the behavior of the core and platform driver:
>>>>> - "auto-boot" used to decide if boot is from driver or user space request (independently from fw loading and live cycle management)
>>>>> - "skip_fw_load" allows to determine if a firmware has to be loaded or not.
>>>>> - remote Firmware live cycle (start,stop,...) are managed by the platform driver, it would have to determine the manage the remote proc depending on the mode detected.
>>>>>
>>>>> If i apply this for stm32mp1 driver:
>>>>> normal boot( FW started on user space request):
>>>>>   - auto-boot = 0
>>>>>   - skip_fw_load = 0
>>>>> FW loaded and started by the bootloader
>>>>>   - auto-boot = 1
>>>>>   - skip_firmware = 1;
>>>>>
>>>>> => on a stop: the "auto-boot" and "skip_firmware flag will be reset by the stm32rproc driver, to allow user space to load a new firmware or reste the system.
>>>>> this is considered as a ack by Bjorn today, if you have an alternative please share.
>>>>
>>>> I wonder if we can achieve the same results without needing
>>>> rproc::skip_fw_load...  For cases where the FW would have been loaded
>>>> and the MCU started by another entity we could simply set rproc->state
>>>> = RPROC_RUNNING in the platform driver.  That way when the MCU is
>>>> stopped or crashes, there is no flag to reset, rproc->state is simply
>>>> set correctly by the current code.
>>>>
>>>> I would also set auto_boot =1 in order to start the AP synchronisation
>>>> as quickly as possible and add a check in rproc_trigger_auto_boot() to
>>>> see if rproc->state == RPROC_RUNNING.  If so simply call rproc_boot()
>>>> where platform specific rproc_ops would be tailored to handle a
>>>> running processor.
>>>
>>> Your proposal is interesting, what concerns me is that seems to work only
>>> for a first start.
>>
>> Correct, my proposal will skip loading the MCU firmware only when
>> Linux boots and MCU probed.  I thought this was what your patchset is
>> doing.
>>
>>> And calling rproc_boot, while state is RPROC_RUNNING seems
>>> pretty strange for me.
>>
>> After sending my email I thought about spinning off a new function,
>> something like rproc_sync() and call it instead of rproc_boot().  But
>> none of that matters now that Peng has highlighted the need to handle
>> late attach scenarios where the FW is never loaded by the remoteproc
>> core.
>>
>>> Also, as Peng mentions in https://patchwork.kernel.org/patch/11390485/,
>>> the need also exists to skip the load of the firmware on recovery.
>>> How to manage ROM/XIP Firmwares, no handling of the FW code only management
>>> of the live cycle (using sysfs, crash management ....)?
>>>
>>
>> A very good question, and something I need to think about after
>> reviewing Peng's patchset.  I will get back to you.
> 
> After reviewing Peng's patches it became clear to me using if/else
> statements will quickly become unmanageable - we need something
> flexible that can scale.  After spending a long time looking at what
> TI, NXP and ST have done to address their specific needs I think a
> solution is starting to take shape in my head.  From here I think the
> best way to proceed is for me to write a patchset that enacts those
> ideas and sent it out for review, something that should take me around
> 2 weeks.
Ok, so i'm putting this thread on hold, pending your proposal.

Regards,
Arnaud
> 
>>
>>>>
>>>> In my opinion the above would represent the state of the MCU rather
>>>> than the state of the FW used by the MCU.  It would also provide an
>>>> opening for supporting systems where the MCU is not the life cycle
>>>> manager.
>>> Not sure to catch your point here. By "above" you mention your proposal or mine?
>>
>> I was talking about the lines I wrote.
>>
>>> In my opinion, rproc->state already represents the MCU state
>>> what seems missing is the FW state
>>> Could you clarify what you mean by "systems where the MCU is not the life cycle
>>> manager" MCU = rproc framework?
>>
>> Arrgghh... That's a brain bug on my side.  It should have been AP, not MCU.
>>
>>>
>>> Regards
>>> Arnaud
>>>
>>>>
>>>> Let me know what you think...
>>>>
>>>>>
>>>>> I need to rework the patchset in consequence but i would appreciate your feedback on this proposal before, to be sure that i well interpreted your concerns...
>>>>>
>>>>> Regards,
>>>>> Arnaud
>>>>>
>>>>>>
>>>>>>> This is not necessary the case, even if EPROBE_DEFER is used. In this case the driver has to be build as kernel module.
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Arnaud
>>>>>>>>
>>>>>>>> I'd welcome other people's opinion on this.
>>>>>>>>
>>>>>>>>>              ret = rproc_trigger_auto_boot(rproc);
>>>>>>>>>              if (ret < 0)
>>>>>>>>>                      return ret;
>>>>>>>>> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>>>>>>>>> index 16ad66683ad0..4fd5bedab4fa 100644
>>>>>>>>> --- a/include/linux/remoteproc.h
>>>>>>>>> +++ b/include/linux/remoteproc.h
>>>>>>>>> @@ -479,6 +479,7 @@ struct rproc_dump_segment {
>>>>>>>>>   * @table_sz: size of @cached_table
>>>>>>>>>   * @has_iommu: flag to indicate if remote processor is behind an MMU
>>>>>>>>>   * @auto_boot: flag to indicate if remote processor should be auto-started
>>>>>>>>> + * @skip_fw_load: remote processor has been preloaded before start sequence
>>>>>>>>>   * @dump_segments: list of segments in the firmware
>>>>>>>>>   * @nb_vdev: number of vdev currently handled by rproc
>>>>>>>>>   */
>>>>>>>>> @@ -512,6 +513,7 @@ struct rproc {
>>>>>>>>>      size_t table_sz;
>>>>>>>>>      bool has_iommu;
>>>>>>>>>      bool auto_boot;
>>>>>>>>> +    bool skip_fw_load;
>>>>>>>>>      struct list_head dump_segments;
>>>>>>>>>      int nb_vdev;
>>>>>>>>>  };
>>>>>>>>> --
>>>>>>>>> 2.17.1
>>>>>>>>>
