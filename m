Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEEFFC2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 14:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F3FD20A8B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 14:51:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="g2khOrPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgDJOvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 10:51:37 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:34372 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726009AbgDJOvg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 10:51:36 -0400
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03AElMPO031008;
        Fri, 10 Apr 2020 16:51:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=JG4ggwAOInAaaLwQnOLLQb7wIvHrZssGt6cM8gL6As4=;
 b=g2khOrPEW9SV32ZRwNQEVtKl9rFy53QAfsod6e1fR77Snt412upXOFgqFr1LDpfwZu8Y
 UyZZXPfBaOq7yn/ZoCInN+yyUyiCkTZT+C65Ty5kTVqa7ToVK3TM0aF6emIeMJ/m4vSZ
 ooKAlqpOtmKm4iCj/DsYnZ0byfe+2mgScnc5l20b5SFajc8wIsmm13GqBS7Z5HMSLbZS
 eLob+emRzQRVy5zXp/nCLuq2giqtPkh2ci+TKPzSbzpH0Mt9NERuM9xq1Y8N+W/ZNyFT
 xVnpmn8LgXQVfVEjdgvuVo6AvR6KbypSbhYeRhZw4CnOWEeVkTkhm1hfSVQcT6YSyY1e HA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 309vr9dumc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Apr 2020 16:51:22 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C518A10002A;
        Fri, 10 Apr 2020 16:51:17 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AC5802AE6DC;
        Fri, 10 Apr 2020 16:51:17 +0200 (CEST)
Received: from lmecxl0889.tpe.st.com (10.75.127.44) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 10 Apr
 2020 16:51:16 +0200
Subject: Re: [PATCH v2 1/2] remoteproc: Add character device interface
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <rishabhb@codeaurora.org>, Cl?ment Leger <cleger@kalrayinc.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        psodagud <psodagud@codeaurora.org>, tsoni <tsoni@codeaurora.org>,
        sidgup <sidgup@codeaurora.org>,
        <linux-remoteproc-owner@vger.kernel.org>
References: <1585699438-14394-1-git-send-email-rishabhb@codeaurora.org>
 <5b1c8287-0077-87e7-9364-b1f5a104c9e3@st.com>
 <6261646b2e0c4d9c8a30900b2f475890@codeaurora.org>
 <730c75c9-15e2-19c5-d97a-190bf1e6ffaa@st.com>
 <634144036.14036712.1586174761552.JavaMail.zimbra@kalray.eu>
 <8379238a-a9e0-da4e-330a-18dffba5f841@st.com>
 <1331212923.14096350.1586188737626.JavaMail.zimbra@kalray.eu>
 <877ed3c91c8f140a08a743f03cafc633@codeaurora.org>
 <d1ccddc1-c97b-7573-74eb-ff0f09337cce@st.com>
 <20200410020035.GX20625@builder.lan>
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Message-ID: <9ce02bc3-0203-aa07-b29f-97f4fea718c4@st.com>
Date:   Fri, 10 Apr 2020 16:51:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200410020035.GX20625@builder.lan>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-10_05:2020-04-09,2020-04-10 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/10/20 4:00 AM, Bjorn Andersson wrote:
> On Thu 09 Apr 01:29 PDT 2020, Arnaud POULIQUEN wrote:
> 
>>
>> On 4/8/20 8:34 PM, rishabhb@codeaurora.org wrote:
>>> On 2020-04-06 08:58, Clément Leger wrote:
>>>> Hi Arnaud,
>>>>
>>>> ----- On 6 Apr, 2020, at 16:17, Arnaud Pouliquen arnaud.pouliquen@st.com wrote:
>>>>
>>>>> Hi Clément,
>>>>>
>>>>> On 4/6/20 2:06 PM, Clément Leger wrote:
>>>>>> Hi Arnaud,
>>>>>>
>>>>>> ----- On 6 Apr, 2020, at 11:01, Arnaud Pouliquen arnaud.pouliquen@st.com wrote:
>>>>>>
>>>>>>> On 4/3/20 9:13 PM, rishabhb@codeaurora.org wrote:
>>>>>>>> On 2020-04-02 10:28, Arnaud POULIQUEN wrote:
>>>>>>>>> Hi
>>>>>>>>>
>>>>>>>>> On 4/1/20 2:03 AM, Rishabh Bhatnagar wrote:
>>>>>>>>>> Add the character device interface for userspace applications.
>>>>>>>>>> This interface can be used in order to boot up and shutdown
>>>>>>>>>> remote subsystems. Currently there is only a sysfs interface
>>>>>>>>>> which the userspace clients can use. If a usersapce application
>>>>>>>>>> crashes after booting the remote processor does not get any
>>>>>>>>>> indication about the crash. It might still assume that the
>>>>>>>>>> application is running. For example modem uses remotefs service
>>>>>>>>>> to fetch data from disk/flash memory. If the remotefs service
>>>>>>>>>> crashes, modem keeps on requesting data which might lead to a
>>>>>>>>>> crash. Adding a character device interface makes the remote
>>>>>>>>>> processor tightly coupled with the user space application.
>>>>>>>>>> A crash of the application leads to a close on the file descriptors
>>>>>>>>>> therefore shutting down the remoteproc.
>>>>>>>>>
>>>>>>>>> Sorry I'm late in the discussion, I hope I've gone through the whole
>>>>>>>>> discussion so I don't reopen a closed point...
>>>>>>>>>
>>>>>>>>> Something here is not crystal clear to me so I'd rather share it...
>>>>>>>>>
>>>>>>>>> I suppose that you the automatic restart of the application is not possible to
>>>>>>>>> stop and restart the remote processor...
>>>>>>>> Yes correct, while we wait for the application to restart we might observe a
>>>>>>>> fatal crash.
>>>>>>>>>
>>>>>>>>> Why this use case can not be solved by a process monitor or a service
>>>>>>>>> in userland that detects the application crash and stop the remote
>>>>>>>>> firmware using
>>>>>>>>> the sysfs interface?
>>>>>>>>>
>>>>>>>> What happens in the case where the process monitor itself crashes? This is
>>>>>>>> actually the approach we follow in our downstream code. We have a central entity
>>>>>>>> in userspace that controls bootup/shutdown of some remote processors based on
>>>>>>>> the
>>>>>>>> votes from userspace clients. We have observed cases where this entity
>>>>>>>> itself crashes and remote processors are left hanging.
>>>>>>>
>>>>>>> Your description makes me feel like this patch is only a workaround of something
>>>>>>> that
>>>>>>> should be fixed in the userland, even if i understand that hanging is one of the
>>>>>>> most
>>>>>>> critical problem and have to be fixed.
>>>>>>> For instance, how to handle several applications that interact with the remote
>>>>>>> processor
>>>>>>> ( e.g. rpmsg service applications) how to stop and restart everything. Using the
>>>>>>> char
>>>>>>> device would probaly resolve only a part of the issue...
>>>>>>>
>>>>>>> I'm not aware about your environment and i'm not a userland expert. But what i
>>>>>>> still not
>>>>>>> understand why a parent process can not do the job...
>>>>>>> I just test a simple script on my side that treat the kill -9 of an application
>>>>>>> ("cat" in my case).
>>>>>>
>>>>>> This is not entirely true, if the parent process is killed with a SIGKILL, then
>>>>>> the process will not be able to handle anything and the remoteproc will still
>>>>>> be running.
>>>>>>
>>>>>> What I understood from Rishabh patch is a way to allow a single process handling
>>>>>> the rproc state. We have the same kind of need and currently, if the
>>>>>> user application crashes, then the rproc is still running (which happens).
>>>>>>
>>>>>>>
>>>>>>> #start the remote firmware
>>>>>>> cp  $1 /lib/firmware/
>>>>>>> echo $1> /sys/class/remoteproc/remoteproc0/firmware
>>>>>>> echo start >/sys/class/remoteproc/remoteproc0/state
>>>>>>> #your binary
>>>>>>> cat /dev/kmsg
>>>>>>> # stop the remote firmware in case of crash (and potentially some other apps)
>>>>>>> echo stop >/sys/class/remoteproc/remoteproc0/state
>>>>>>>
>>>>>>
>>>>>> This is not really "production proof" and what happens if the application is
>>>>>> responsible of setting the firmware which might be jitted ?
>>>>>> And if the script receives the SIGKILL, then we are back to the same problem.
>>>>> Yes this is just a basic example, not an implementation which would depend on
>>>>> the
>>>>> environment. i'm just trying here to  put forward a multi-process solution...and
>>>>> that I'm not an userland expert :).
>>>>>
>>>>>>
>>>>>> I really think, this is a step forward an easier and reliable use of the
>>>>>> remoteproc
>>>>>> on userland to guarantee a coherent rproc state even if host application
>>>>>> crashes.
>>> Yes what we want is simple mechanism where a single userspace process can boot/
>>> shutdown the remote processor in all scenarios. Adding more processes to monitor
>>> the already existing process might have 2 issues. One is there might be a delay
>>> between the application crash and process monitor getting to know about it and taking
>>> action. This might prove to be fatal in our case. Second, possibly the monitor can hang
>>> or get killed and is not deterministic.
>>>>>
>>>>> I can see 3 ways of handling an application crash:
>>>>> - just shutdown the firmware
>>>>> => can be done through char device
>>>>> - stop some other related processes and/or generate a remote proc crash dump for
>>>>> debug
>>>>> => /sysfs and/or debugfs
>>>>> - do nothing as you want a silence application reboot and re-attach to the
>>>>> running firmware
>>>>> => use sysfs
>>>>>
>>>>> I'm challenging the solution because splitting the API seems to me not a good
>>>>> solution.
>>>>
>>>> Completely ok with that, we have to fully understand the targeted usecase to
>>>> avoid implemented a flawed interface.
>>>>
>>>>> Now i wonder how it works for the other applications that are relying on some
>>>>> other
>>>>> kernel frameworks...
>>>>
>>>> For some other device, there is a chardev. The watchdog for intance uses a
>>>> /dev/watchdog. Regarding the gpio, it seems they are also using a chardev
>>>> and the sysfs interface is deprecated.
>>>>
>>>>> Perhaps the answer is that these frameworks don't use sysfs but char device.
>>>>> That would means that the sysfs solution is not the more adapted solution and
>>>>> perhaps we should migrate to a char device.
>>>>> But in this case, i think that it should implement the whole API and be
>>>>> exclusive with
>>>>> the syfs legacy API (so no sysfs or sysfs in read-only).
>>>>
>>>> I agree with that, if another interface must be defined, then it should
>>>> implement everything that is supported right now with the sysfs.
>>>>
>>> The other fields that sysfs exposes right now are firmware_name, name(rproc name),
>>> state. The targeted usecase was that these are configuration parameters specific
>>> to the remoteproc and should stay in the sysfs interface. Whereas char device
>>> should provide direct access to remoteproc device.
>>> It would make sense to use this interface in conjunction with sysfs
>>> interface, where you use /dev/remoteproc0 to boot/shutdown the remote processor
>>> sysfs entries to fine tune the parameters.
>>> Adding ioctls to implement all sysfs functionality seems like overkill to me. Let
>>> me know what you guys think.
>>
>> In my opinion if we open the possibility of accessing to remoteproc through a char
>> device, we should move torwards a solution that would replace the sysfs. 
>> In this case sysfs fields could be read-only, and the char devices would have to
>> support the different shutdown modes. This means that the auto shutdown should be
>> configurable (IOCTL?).
>> But I assume that the minimum could be to only disable write access on the "state" field
>> and handle the "auto shutdown" as an option of the char device.
>>
>> Anyway it only my opinion, let Bjorn an Mathieu comment and decide :)
>>
> 
> I have two concerns with migrating things to a character device:
> 
> 1) Operating an ioctl based interface requires specialized tooling. E.g.
> today whatever your installation is you can change firmware name and
> start a core with the user space tools you have. Further more allowing
> you to change firmware name before powering on the core would imply that
> both of these would have to be ioctls (we can't just boot the core on
> open) - so we would end up duplicating all parts of the sysfs interface
> in ioctls.
> 
> 2) Reducing the functionality of the sysfs interface would break
> compatibility with existing user space, which is verboten. So we would
> at best duplicate the existing features.

Agree with your concerns.
But could we consider that an application using this char dev, is no more
compatible with existing interface? 
And it would make sense that it requests exclusivity on
the remote firmware lice cycle. In this case the sysfs state should be
read only to protect from an unexpected shutdown.

> 
> 
> That said, per the same argument I don't really like duplicating the
> state controls in a character device (i.e. Rishabh's patch), but this
> really does provide something that we can't do with the current
> interface.

Yes, that why it could be nice to make it scalable to integrate
future extension that can not be implemented using sysfs.

One of my main concern is that forcing the boot on open and shutdown on
close limits the usage of this device for some other future purposes. 
Coming back in the future to a generic solution will be not possible
as case of impact on the open close behaviour.
Using ioctls would avoid this limitation...
Ioctl could be used to enable the boot/shutdown on open/close

Then this char device could be also used to generate an event for application
on crash.
In this case the char device could be used only for the event, and sysfs
state would be used to manage the remoteproc firmware. So sysfs state should
be in read write access...

Concerning the firmware name, today sysfs interface imposes only one firmware
what's happen if more that one firmware loading is requested (for instance 
a core firmware with of some processing or rpc modules...).
In this case the sysfs firmware field could not be used.

These examples make me think that sysfs could be to manage through
remoteproc_cdev instead of directly calling core function.
This would help to define dynamic rules for the sysfs access. 

To sum up, nothing against opening interface with the char device.
I'm just wondering if this device should not be designed to allow some future
extensions of the API, and not only for this use case.  

Regards
Arnaud

> 
> Regards,
> Bjorn
> 
