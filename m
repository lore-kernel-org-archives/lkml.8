Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEBDC2BB54
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 08:29:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD05520A8B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 08:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="Jzg2acb2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgDII3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 04:29:21 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:7906 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725828AbgDII3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 04:29:20 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0398RSwZ011921;
        Thu, 9 Apr 2020 10:29:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : subject : to : cc
 : references : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=STMicroelectronics;
 bh=pvNYoGRSyo2rWLVdnJAB2Trt54SboMRVt0DDFJhq3Mw=;
 b=Jzg2acb2ZP3x9oX+elMVEs5zz5IKYAn3m/ubELT6JLpSwpJGd9jKm8oPZ8ytNS+KKbzV
 iOPfQeG7d/LB0PBhazkAoXG+zs5IwZj4ROYMBxtp6JKjrvnFJdhVvs/0DmhaIkp1PwwP
 3KdZQtZpggXnoIpKyNadyOD4ShSoNJel88GgU2rZ87m46/VZZXglrimxHi061t1BtkCA
 NS04kdqmBUzX8xHRmsAUejYUpEq09qVb+ZtixpICbEWPeWSRoSfHlK9PuqhH1nyZPvdM
 bKkCR7JyLvWcCFVSIY/9KV5tpj1U4/Ep8hI00qxxvpSVbSm3cotCK+IIcLNU8b3BlSLr yg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 3091qk8pkg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 09 Apr 2020 10:29:09 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 55243100044;
        Thu,  9 Apr 2020 10:29:08 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag3node1.st.com [10.75.127.7])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2F30121F67C;
        Thu,  9 Apr 2020 10:29:08 +0200 (CEST)
Received: from lmecxl0889.tpe.st.com (10.75.127.45) by SFHDAG3NODE1.st.com
 (10.75.127.7) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 9 Apr
 2020 10:29:06 +0200
From:   Arnaud POULIQUEN <arnaud.pouliquen@st.com>
Subject: Re: [PATCH v2 1/2] remoteproc: Add character device interface
To:     <rishabhb@codeaurora.org>,
        =?UTF-8?Q?Cl=c3=a9ment_Leger?= <cleger@kalrayinc.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-remoteproc <linux-remoteproc@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
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
Message-ID: <d1ccddc1-c97b-7573-74eb-ff0f09337cce@st.com>
Date:   Thu, 9 Apr 2020 10:29:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <877ed3c91c8f140a08a743f03cafc633@codeaurora.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG3NODE1.st.com
 (10.75.127.7)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-09_03:2020-04-07,2020-04-09 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 4/8/20 8:34 PM, rishabhb@codeaurora.org wrote:
> On 2020-04-06 08:58, Clément Leger wrote:
>> Hi Arnaud,
>>
>> ----- On 6 Apr, 2020, at 16:17, Arnaud Pouliquen arnaud.pouliquen@st.com wrote:
>>
>>> Hi Clément,
>>>
>>> On 4/6/20 2:06 PM, Clément Leger wrote:
>>>> Hi Arnaud,
>>>>
>>>> ----- On 6 Apr, 2020, at 11:01, Arnaud Pouliquen arnaud.pouliquen@st.com wrote:
>>>>
>>>>> On 4/3/20 9:13 PM, rishabhb@codeaurora.org wrote:
>>>>>> On 2020-04-02 10:28, Arnaud POULIQUEN wrote:
>>>>>>> Hi
>>>>>>>
>>>>>>> On 4/1/20 2:03 AM, Rishabh Bhatnagar wrote:
>>>>>>>> Add the character device interface for userspace applications.
>>>>>>>> This interface can be used in order to boot up and shutdown
>>>>>>>> remote subsystems. Currently there is only a sysfs interface
>>>>>>>> which the userspace clients can use. If a usersapce application
>>>>>>>> crashes after booting the remote processor does not get any
>>>>>>>> indication about the crash. It might still assume that the
>>>>>>>> application is running. For example modem uses remotefs service
>>>>>>>> to fetch data from disk/flash memory. If the remotefs service
>>>>>>>> crashes, modem keeps on requesting data which might lead to a
>>>>>>>> crash. Adding a character device interface makes the remote
>>>>>>>> processor tightly coupled with the user space application.
>>>>>>>> A crash of the application leads to a close on the file descriptors
>>>>>>>> therefore shutting down the remoteproc.
>>>>>>>
>>>>>>> Sorry I'm late in the discussion, I hope I've gone through the whole
>>>>>>> discussion so I don't reopen a closed point...
>>>>>>>
>>>>>>> Something here is not crystal clear to me so I'd rather share it...
>>>>>>>
>>>>>>> I suppose that you the automatic restart of the application is not possible to
>>>>>>> stop and restart the remote processor...
>>>>>> Yes correct, while we wait for the application to restart we might observe a
>>>>>> fatal crash.
>>>>>>>
>>>>>>> Why this use case can not be solved by a process monitor or a service
>>>>>>> in userland that detects the application crash and stop the remote
>>>>>>> firmware using
>>>>>>> the sysfs interface?
>>>>>>>
>>>>>> What happens in the case where the process monitor itself crashes? This is
>>>>>> actually the approach we follow in our downstream code. We have a central entity
>>>>>> in userspace that controls bootup/shutdown of some remote processors based on
>>>>>> the
>>>>>> votes from userspace clients. We have observed cases where this entity
>>>>>> itself crashes and remote processors are left hanging.
>>>>>
>>>>> Your description makes me feel like this patch is only a workaround of something
>>>>> that
>>>>> should be fixed in the userland, even if i understand that hanging is one of the
>>>>> most
>>>>> critical problem and have to be fixed.
>>>>> For instance, how to handle several applications that interact with the remote
>>>>> processor
>>>>> ( e.g. rpmsg service applications) how to stop and restart everything. Using the
>>>>> char
>>>>> device would probaly resolve only a part of the issue...
>>>>>
>>>>> I'm not aware about your environment and i'm not a userland expert. But what i
>>>>> still not
>>>>> understand why a parent process can not do the job...
>>>>> I just test a simple script on my side that treat the kill -9 of an application
>>>>> ("cat" in my case).
>>>>
>>>> This is not entirely true, if the parent process is killed with a SIGKILL, then
>>>> the process will not be able to handle anything and the remoteproc will still
>>>> be running.
>>>>
>>>> What I understood from Rishabh patch is a way to allow a single process handling
>>>> the rproc state. We have the same kind of need and currently, if the
>>>> user application crashes, then the rproc is still running (which happens).
>>>>
>>>>>
>>>>> #start the remote firmware
>>>>> cp  $1 /lib/firmware/
>>>>> echo $1> /sys/class/remoteproc/remoteproc0/firmware
>>>>> echo start >/sys/class/remoteproc/remoteproc0/state
>>>>> #your binary
>>>>> cat /dev/kmsg
>>>>> # stop the remote firmware in case of crash (and potentially some other apps)
>>>>> echo stop >/sys/class/remoteproc/remoteproc0/state
>>>>>
>>>>
>>>> This is not really "production proof" and what happens if the application is
>>>> responsible of setting the firmware which might be jitted ?
>>>> And if the script receives the SIGKILL, then we are back to the same problem.
>>> Yes this is just a basic example, not an implementation which would depend on
>>> the
>>> environment. i'm just trying here to  put forward a multi-process solution...and
>>> that I'm not an userland expert :).
>>>
>>>>
>>>> I really think, this is a step forward an easier and reliable use of the
>>>> remoteproc
>>>> on userland to guarantee a coherent rproc state even if host application
>>>> crashes.
> Yes what we want is simple mechanism where a single userspace process can boot/
> shutdown the remote processor in all scenarios. Adding more processes to monitor
> the already existing process might have 2 issues. One is there might be a delay
> between the application crash and process monitor getting to know about it and taking
> action. This might prove to be fatal in our case. Second, possibly the monitor can hang
> or get killed and is not deterministic.
>>>
>>> I can see 3 ways of handling an application crash:
>>> - just shutdown the firmware
>>> => can be done through char device
>>> - stop some other related processes and/or generate a remote proc crash dump for
>>> debug
>>> => /sysfs and/or debugfs
>>> - do nothing as you want a silence application reboot and re-attach to the
>>> running firmware
>>> => use sysfs
>>>
>>> I'm challenging the solution because splitting the API seems to me not a good
>>> solution.
>>
>> Completely ok with that, we have to fully understand the targeted usecase to
>> avoid implemented a flawed interface.
>>
>>> Now i wonder how it works for the other applications that are relying on some
>>> other
>>> kernel frameworks...
>>
>> For some other device, there is a chardev. The watchdog for intance uses a
>> /dev/watchdog. Regarding the gpio, it seems they are also using a chardev
>> and the sysfs interface is deprecated.
>>
>>> Perhaps the answer is that these frameworks don't use sysfs but char device.
>>> That would means that the sysfs solution is not the more adapted solution and
>>> perhaps we should migrate to a char device.
>>> But in this case, i think that it should implement the whole API and be
>>> exclusive with
>>> the syfs legacy API (so no sysfs or sysfs in read-only).
>>
>> I agree with that, if another interface must be defined, then it should
>> implement everything that is supported right now with the sysfs.
>>
> The other fields that sysfs exposes right now are firmware_name, name(rproc name),
> state. The targeted usecase was that these are configuration parameters specific
> to the remoteproc and should stay in the sysfs interface. Whereas char device
> should provide direct access to remoteproc device.
> It would make sense to use this interface in conjunction with sysfs
> interface, where you use /dev/remoteproc0 to boot/shutdown the remote processor
> sysfs entries to fine tune the parameters.
> Adding ioctls to implement all sysfs functionality seems like overkill to me. Let
> me know what you guys think.

In my opinion if we open the possibility of accessing to remoteproc through a char
device, we should move torwards a solution that would replace the sysfs. 
In this case sysfs fields could be read-only, and the char devices would have to
support the different shutdown modes. This means that the auto shutdown should be
configurable (IOCTL?).
But I assume that the minimum could be to only disable write access on the "state" field
and handle the "auto shutdown" as an option of the char device.

Anyway it only my opinion, let Bjorn an Mathieu comment and decide :)

Regards,
Arnaud

>>
>> Clément
>>
>>>
>>> Regards,
>>> Arnaud
>>>
>>>>
>>>> Regards,
>>>>
>>>> Clément
>>>>
>>>>> Anyway, it's just my feeling, let other people give their feedback.
>>>>>
>>>>>>> I just want to be sure that there is no alternative to this, because
>>>>>>> having two ways
>>>>>>> for application to shutdown the firmware seems to me confusing...
>>>>>> Does making this interface optional/configurable helps?
>>>>>>>
>>>>>>> What about the opposite service, mean inform the application that the remote
>>>>>>> processor is crashed?
>>>>>>> Do you identify such need? or the "auto" crash recovery is sufficient?
>>>>>> Auto recovery works perfectly for us. Although there is a mechanism in
>>>>>> place using QMI(Qualcomm MSM interface) that can notify clients about remote
>>>>>> processor crash.
>>>>>
>>>>> Thanks for the information.
>>>>>
>>>>> Regards
>>>>> Arnaud
>>>>>
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Arnaud
>>>>>>>>
>>>>>>>> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
>>>>>>>> ---
>>>>>>>>  drivers/remoteproc/Kconfig               |   9 +++
>>>>>>>>  drivers/remoteproc/Makefile              |   1 +
>>>>>>>>  drivers/remoteproc/remoteproc_cdev.c     | 100 +++++++++++++++++++++++++++++++
>>>>>>>>  drivers/remoteproc/remoteproc_internal.h |  22 +++++++
>>>>>>>>  include/linux/remoteproc.h               |   2 +
>>>>>>>>  5 files changed, 134 insertions(+)
>>>>>>>>  create mode 100644 drivers/remoteproc/remoteproc_cdev.c
>>>>>>>>
>>>>>>>> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
>>>>>>>> index de3862c..6374b79 100644
>>>>>>>> --- a/drivers/remoteproc/Kconfig
>>>>>>>> +++ b/drivers/remoteproc/Kconfig
>>>>>>>> @@ -14,6 +14,15 @@ config REMOTEPROC
>>>>>>>>
>>>>>>>>  if REMOTEPROC
>>>>>>>>
>>>>>>>> +config REMOTEPROC_CDEV
>>>>>>>> +    bool "Remoteproc character device interface"
>>>>>>>> +    help
>>>>>>>> +      Say y here to have a character device interface for Remoteproc
>>>>>>>> +      framework. Userspace can boot/shutdown remote processors through
>>>>>>>> +      this interface.
>>>>>>>> +
>>>>>>>> +      It's safe to say N if you don't want to use this interface.
>>>>>>>> +
>>>>>>>>  config IMX_REMOTEPROC
>>>>>>>>      tristate "IMX6/7 remoteproc support"
>>>>>>>>      depends on ARCH_MXC
>>>>>>>> diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
>>>>>>>> index e30a1b1..b7d4f77 100644
>>>>>>>> --- a/drivers/remoteproc/Makefile
>>>>>>>> +++ b/drivers/remoteproc/Makefile
>>>>>>>> @@ -9,6 +9,7 @@ remoteproc-y                += remoteproc_debugfs.o
>>>>>>>>  remoteproc-y                += remoteproc_sysfs.o
>>>>>>>>  remoteproc-y                += remoteproc_virtio.o
>>>>>>>>  remoteproc-y                += remoteproc_elf_loader.o
>>>>>>>> +obj-$(CONFIG_REMOTEPROC_CDEV)        += remoteproc_cdev.o
>>>>>>>>  obj-$(CONFIG_IMX_REMOTEPROC)        += imx_rproc.o
>>>>>>>>  obj-$(CONFIG_MTK_SCP)            += mtk_scp.o mtk_scp_ipi.o
>>>>>>>>  obj-$(CONFIG_OMAP_REMOTEPROC)        += omap_remoteproc.o
>>>>>>>> diff --git a/drivers/remoteproc/remoteproc_cdev.c
>>>>>>>> b/drivers/remoteproc/remoteproc_cdev.c
>>>>>>>> new file mode 100644
>>>>>>>> index 0000000..8182bd1
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/drivers/remoteproc/remoteproc_cdev.c
>>>>>>>> @@ -0,0 +1,100 @@
>>>>>>>> +// SPDX-License-Identifier: GPL-2.0-only
>>>>>>>> +/*
>>>>>>>> + * Character device interface driver for Remoteproc framework.
>>>>>>>> + *
>>>>>>>> + * Copyright (c) 2020, The Linux Foundation. All rights reserved.
>>>>>>>> + */
>>>>>>>> +
>>>>>>>> +#include <linux/cdev.h>
>>>>>>>> +#include <linux/fs.h>
>>>>>>>> +#include <linux/module.h>
>>>>>>>> +#include <linux/mutex.h>
>>>>>>>> +#include <linux/remoteproc.h>
>>>>>>>> +
>>>>>>>> +#include "remoteproc_internal.h"
>>>>>>>> +
>>>>>>>> +#define NUM_RPROC_DEVICES    64
>>>>>>>> +static dev_t rproc_cdev;
>>>>>>>> +static DEFINE_IDA(cdev_minor_ida);
>>>>>>>> +
>>>>>>>> +static int rproc_cdev_open(struct inode *inode, struct file *file)
>>>>>>>> +{
>>>>>>>> +    struct rproc *rproc;
>>>>>>>> +
>>>>>>>> +    rproc = container_of(inode->i_cdev, struct rproc, char_dev);
>>>>>>>> +
>>>>>>>> +    if (!rproc)
>>>>>>>> +        return -EINVAL;
>>>>>>>> +
>>>>>>>> +    if (rproc->state == RPROC_RUNNING)
>>>>>>>> +        return -EBUSY;
>>>>>>>> +
>>>>>>>> +    return rproc_boot(rproc);
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static int rproc_cdev_release(struct inode *inode, struct file *file)
>>>>>>>> +{
>>>>>>>> +    struct rproc *rproc;
>>>>>>>> +
>>>>>>>> +    rproc = container_of(inode->i_cdev, struct rproc, char_dev);
>>>>>>>> +
>>>>>>>> +    if (!rproc || rproc->state != RPROC_RUNNING)
>>>>>>>> +        return -EINVAL;
>>>>>>>> +
>>>>>>>> +    rproc_shutdown(rproc);
>>>>>>>> +
>>>>>>>> +    return 0;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +static const struct file_operations rproc_fops = {
>>>>>>>> +    .open = rproc_cdev_open,
>>>>>>>> +    .release = rproc_cdev_release,
>>>>>>>> +};
>>>>>>>> +
>>>>>>>> +int rproc_char_device_add(struct rproc *rproc)
>>>>>>>> +{
>>>>>>>> +    int ret, minor;
>>>>>>>> +    dev_t cdevt;
>>>>>>>> +
>>>>>>>> +    minor = ida_simple_get(&cdev_minor_ida, 0, NUM_RPROC_DEVICES,
>>>>>>>> +                   GFP_KERNEL);
>>>>>>>> +    if (minor < 0) {
>>>>>>>> +        dev_err(&rproc->dev, "%s: No more minor numbers left! rc:%d\n",
>>>>>>>> +            __func__, minor);
>>>>>>>> +        return -ENODEV;
>>>>>>>> +    }
>>>>>>>> +
>>>>>>>> +    cdev_init(&rproc->char_dev, &rproc_fops);
>>>>>>>> +    rproc->char_dev.owner = THIS_MODULE;
>>>>>>>> +
>>>>>>>> +    cdevt = MKDEV(MAJOR(rproc_cdev), minor);
>>>>>>>> +    ret = cdev_add(&rproc->char_dev, cdevt, 1);
>>>>>>>> +    if (ret < 0)
>>>>>>>> +        ida_simple_remove(&cdev_minor_ida, minor);
>>>>>>>> +
>>>>>>>> +    rproc->dev.devt = cdevt;
>>>>>>>> +    return ret;
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +void rproc_char_device_remove(struct rproc *rproc)
>>>>>>>> +{
>>>>>>>> +    __unregister_chrdev(MAJOR(rproc->dev.devt), MINOR(rproc->dev.devt), 1,
>>>>>>>> +                "rproc");
>>>>>>>> +    ida_simple_remove(&cdev_minor_ida, MINOR(rproc->dev.devt));
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +void __init rproc_init_cdev(void)
>>>>>>>> +{
>>>>>>>> +    int ret;
>>>>>>>> +
>>>>>>>> +    ret = alloc_chrdev_region(&rproc_cdev, 0, NUM_RPROC_DEVICES, "rproc");
>>>>>>>> +    if (ret < 0) {
>>>>>>>> +        pr_err("Failed to alloc rproc_cdev region, err %d\n", ret);
>>>>>>>> +        return;
>>>>>>>> +    }
>>>>>>>> +}
>>>>>>>> +
>>>>>>>> +void __exit rproc_exit_cdev(void)
>>>>>>>> +{
>>>>>>>> +    __unregister_chrdev(MAJOR(rproc_cdev), 0, NUM_RPROC_DEVICES, "rproc");
>>>>>>>> +}
>>>>>>>> diff --git a/drivers/remoteproc/remoteproc_internal.h
>>>>>>>> b/drivers/remoteproc/remoteproc_internal.h
>>>>>>>> index 493ef92..28d61a1 100644
>>>>>>>> --- a/drivers/remoteproc/remoteproc_internal.h
>>>>>>>> +++ b/drivers/remoteproc/remoteproc_internal.h
>>>>>>>> @@ -47,6 +47,27 @@ struct dentry *rproc_create_trace_file(const char *name,
>>>>>>>> struct rproc *rproc,
>>>>>>>>  int rproc_init_sysfs(void);
>>>>>>>>  void rproc_exit_sysfs(void);
>>>>>>>>
>>>>>>>> +#ifdef CONFIG_REMOTEPROC_CDEV
>>>>>>>> +void rproc_init_cdev(void);
>>>>>>>> +void rproc_exit_cdev(void);
>>>>>>>> +int rproc_char_device_add(struct rproc *rproc);
>>>>>>>> +void rproc_char_device_remove(struct rproc *rproc);
>>>>>>>> +#else
>>>>>>>> +static inline void rproc_init_cdev(void)
>>>>>>>> +{
>>>>>>>> +}
>>>>>>>> +static inline void rproc_exit_cdev(void)
>>>>>>>> +{
>>>>>>>> +}
>>>>>>>> +static inline int rproc_char_device_add(struct rproc *rproc)
>>>>>>>> +{
>>>>>>>> +    return 0;
>>>>>>>> +}
>>>>>>>> +static inline void  rproc_char_device_remove(struct rproc *rproc)
>>>>>>>> +{
>>>>>>>> +}
>>>>>>>> +#endif
>>>>>>>> +
>>>>>>>>  void rproc_free_vring(struct rproc_vring *rvring);
>>>>>>>>  int rproc_alloc_vring(struct rproc_vdev *rvdev, int i);
>>>>>>>>
>>>>>>>> @@ -63,6 +84,7 @@ struct resource_table *rproc_elf_find_loaded_rsc_table(struct
>>>>>>>> rproc *rproc,
>>>>>>>>  struct rproc_mem_entry *
>>>>>>>>  rproc_find_carveout_by_name(struct rproc *rproc, const char *name, ...);
>>>>>>>>
>>>>>>>> +
>>>>>>>>  static inline
>>>>>>>>  int rproc_fw_sanity_check(struct rproc *rproc, const struct firmware *fw)
>>>>>>>>  {
>>>>>>>> diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
>>>>>>>> index 16ad666..c4ca796 100644
>>>>>>>> --- a/include/linux/remoteproc.h
>>>>>>>> +++ b/include/linux/remoteproc.h
>>>>>>>> @@ -37,6 +37,7 @@
>>>>>>>>
>>>>>>>>  #include <linux/types.h>
>>>>>>>>  #include <linux/mutex.h>
>>>>>>>> +#include <linux/cdev.h>
>>>>>>>>  #include <linux/virtio.h>
>>>>>>>>  #include <linux/completion.h>
>>>>>>>>  #include <linux/idr.h>
>>>>>>>> @@ -514,6 +515,7 @@ struct rproc {
>>>>>>>>      bool auto_boot;
>>>>>>>>      struct list_head dump_segments;
>>>>>>>>      int nb_vdev;
>>>>>>>> +    struct cdev char_dev;
>>>>>>>>  };
>>>>>>>>
>>> >>>>>  /**
