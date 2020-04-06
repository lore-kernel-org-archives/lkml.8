Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94CAAC2BA18
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 05:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57B5A206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 05:33:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WLeI6KcQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbgDFFdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 01:33:09 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41417 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725768AbgDFFdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 01:33:08 -0400
Received: by mail-lj1-f193.google.com with SMTP id n17so13230733lji.8
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 22:33:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Vy4sPe40TgmNn9QaQzfa5wOoqy2O7KW0J1Zr/o5gzHw=;
        b=WLeI6KcQCXZxgYY9fnWxwa+NEvHn/rkhh3atkX/ys6V5VKLXvICyOsUg1wMv36mGHy
         wPMJRzQ6kP1rj/Q3yPZpTK8Za4vTlbH6dZz0BFbA4e2WBNsBrTl++QIllh6WELEbaxua
         dmS2ArM+zomG12E00pc/td/7g8NFXrhlq/D2T3s+Kh/UyEbKDuKKUI4drr7hzqR9p0fA
         ALvi2atQ0DxvruLBNGrcGWLhEoU6ID3RtQOn2PjxC4Snx19wdxq/zxvSc1aAItaVwhic
         ayw3WBuQ5w3RGs8ylznPUow9wXGpNjKq4pSQhl/iodbdLHs2H1eqVyDdf7P6HBNkdCK1
         oqDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Vy4sPe40TgmNn9QaQzfa5wOoqy2O7KW0J1Zr/o5gzHw=;
        b=rl3cYcika/+3MolZ/GlHW+yfST+fQFGF19yZmRJl4+V+dXAk19l04M4qaAx4gaU3oG
         KXeAHbpXlqPHahfUOGKMYjGfmj4VndXW/aMRBNY8vB538m4qf5Jc7sDrta1aQea2cr7X
         O2g2ymk9TNG9m2NualoX547qVThK40MXiI40Xl/Qk9pOzkFsw39GrWPvQ5qw4xhfQD+F
         9vYbwPDSi6ELtXMBO55dh47eTfqUOS3Nt2FKEFMCijFyjPMiqkBOii9oY6v/S5KoTzyc
         CX2SRuO1S+qdFRK4T+nlUhKE0aWdTm6tGxsksM4AcflPZ47cPTPvpouBT7Mhs1JFHVZN
         nhyA==
X-Gm-Message-State: AGi0PuYsbAWX8NQmchynOWtihRyDSwsjTr3xyX5kKiLvIm0jOhYu6h4t
        /nT/ordBtEbiDflUvKFeCwhkeHUMQTH73Igird4=
X-Google-Smtp-Source: APiQypIZ08IdPbNWdhQyjbv8MazVODb/SRGCa8fRPaoAsI3S3eHysg89+WYymxTviToAWG2k8Y13c6qqS9FK2Nz8Cmk=
X-Received: by 2002:a2e:8105:: with SMTP id d5mr11035910ljg.196.1586151184392;
 Sun, 05 Apr 2020 22:33:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac2:4a77:0:0:0:0:0 with HTTP; Sun, 5 Apr 2020 22:33:03 -0700 (PDT)
In-Reply-To: <20200405164006.GA1582475@kroah.com>
References: <1586102749-3364-1-git-send-email-zhangfeionline@gmail.com> <20200405164006.GA1582475@kroah.com>
From:   Fei Zhang <zhangfeionline@gmail.com>
Date:   Mon, 6 Apr 2020 13:33:03 +0800
Message-ID: <CAC_binJNLLxfOm0W2TuVTJZxJRTZTvPPocSDNQMU=21XO37oZg@mail.gmail.com>
Subject: Re: [PATCH] driver core: Fix possible use after free on name
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Greg,

Please refer to below for the crash. If you are fine with it, I will
submit another patch with correcting the error mentioned.

When writing a kernel driver module, we may use it like this:

static int frv_init(int index)
{
...
	char name [128]={0};
	sprintf(name,"test_%d",index);
	mount_dev_p->pci_class =class_create(THIS_MODULE,name);
	classdev = device_create(mount_dev_p->pci_class, NULL, devno,
	NULL, "PCIE_%x",index);
...
}

static void frv_exit(void)
{
...
	device_destroy(mount_dev_p->pci_class,mount_dev_p->devno);
	class_destroy(mount_dev_p->pci_class );
...
}

But when we remove the module, a crash occurres when calling
device_destroy.

Call Trace:
 vsnprintf+0x2b2/0x4e0
 add_uevent_var+0x7d/0x110
 kobject_uevent_env+0x23f/0x770
 kobject_uevent+0xb/0x10
 device_del+0x23b/0x360
 device_unregister+0x1a/0x60
 device_destroy+0x3c/0x50

I traced the code and found that an invalid local variable was called
in "kobject_uevent_env()", and triggered further crash as followed:

kobject_uevent_env(...)
{
...
struct kset_uevent_ops *uevent_ops;
uevent_ops = kset->uevent_ops;
subsystem = uevent_ops->name(kset, kobj);
add_uevent_var(env, "SUBSYSTEM=%s", subsystem);
...
}

What is the "subsystem" value, continue to track.

static const struct kset_uevent_ops device_uevent_ops = {
	.name =		dev_uevent_name,
};

static const char *dev_uevent_name(struct kset *kset, struct kobject *kobj)
{
	struct device *dev = kobj_to_dev(kobj);
	if (dev->class)
		return dev->class->name;
	return NULL;
}

Everything becomes clear: "class->name" and "subsystem" value is local
variable array address of start module function inside "char name [128]".
Used released local variable in device_destroy's kobject_uevent_env, an
error occurred.

Thanks,
Fei

2020-04-06 0:40 GMT+08:00, Greg KH <gregkh@linuxfoundation.org>:
> On Sun, Apr 05, 2020 at 09:05:49AM -0700, zhangfeionline@gmail.com wrote:
>> From: PengfeiZhang <zhangfeionline@gmail.com>
>>
>> __class_create() copies the pointer to the name passed as an
>> argument only to be used later. But there's a chance the caller
>> could immediately free the passed string(e.g., local variable).
>> This could trigger a use after free when we use class name(e.g.,
>> dev_uevent_name()called by device_destroy(),class_create_release()).
>>
>> To be on the safe side: duplicate the string with kstrdup_const()
>> so that if an unaware user passes an address to a stack-allocated
>> buffer, we won't get the arbitrary name and crash.
>
> Where are you seeing this happen?
>
>>
>> Signed-off-by: PengfeiZhang <zhangfeionline@gmail.com>
>> ---
>>  drivers/base/class.c | 17 +++++++++++++++--
>>  1 file changed, 15 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/base/class.c b/drivers/base/class.c
>> index bcd410e..770b3b3 100644
>> --- a/drivers/base/class.c
>> +++ b/drivers/base/class.c
>> @@ -206,6 +206,7 @@ void class_unregister(struct class *cls)
>>  static void class_create_release(struct class *cls)
>>  {
>>  	pr_debug("%s called for %s\n", __func__, cls->name);
>> +	kfree_const(cls->name);
>>  	kfree(cls);
>>  }
>>
>> @@ -227,7 +228,10 @@ struct class *__class_create(struct module *owner,
>> const char *name,
>>  			     struct lock_class_key *key)
>>  {
>>  	struct class *cls;
>> -	int retval;
>> +	int retval = -EINVAL;
>> +
>> +	if (!name)
>> +		goto done;
>
> This is a new change, who calls this function with name not being set?
>
>
>>
>>  	cls = kzalloc(sizeof(*cls), GFP_KERNEL);
>>  	if (!cls) {
>> @@ -235,18 +239,27 @@ struct class *__class_create(struct module *owner,
>> const char *name,
>>  		goto error;
>>  	}
>>
>> +	name = kstrdup_const(name, GFP_KERNEL);
>> +	if (!name) {
>> +		retval = -ENOMEM;
>> +		goto error;
>> +	}
>
> and overwriting the pointer like that is bad-form, try doing something
> else here instead.
>
>> +
>>  	cls->name = name;
>>  	cls->owner = owner;
>>  	cls->class_release = class_create_release;
>>
>>  	retval = __class_register(cls, key);
>>  	if (retval)
>> -		goto error;
>> +		goto error_class_register;
>>
>>  	return cls;
>>
>> +error_class_register:
>> +	kfree(cls->name);
>
> kfree_const()?
>
> thanks,
>
> greg k-h
>
