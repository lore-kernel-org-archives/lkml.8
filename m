Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53888C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 07:40:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2840320801
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 07:40:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z/znBnX8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgDFHkq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 03:40:46 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40849 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgDFHkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 03:40:43 -0400
Received: by mail-lj1-f194.google.com with SMTP id 19so13501553ljj.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 00:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=SU8aAOCODFY6+GxOBeWofzHrHiCCqA1sLaMZiLXSXUw=;
        b=Z/znBnX85OoIuiesmN8HokMcq3qYWhChOGsf8zivoV9S4x2ftkfKdDiFsgTTvL6C+9
         b19SaGxk45gATh915vOfRtccsRQ1LbJJXrh/XfLRypE5s4AuhF/irZWilLIt7h2XLZ32
         Pi+Dm/YNfmoNbFnj4KhycGTr7mmtxl/Crod5KNqBvdxOgUzDpDjXOqlmbcH5AXro1m5O
         Bhv38Y4WOQgnhf16bbbR1qH1dTRFe6lc/qdwAsO50hP46PE1E5lhMOy+qOud8TmLSZHJ
         vJ81nWZ71T0I1SlRs9WxxzpKvCUkH1G2EcrUiLpNB7UF4rxXzvJ+U+vTm0TnBNPq9RhI
         EhVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=SU8aAOCODFY6+GxOBeWofzHrHiCCqA1sLaMZiLXSXUw=;
        b=UijtoaZJrSj54R/+4b+haZx5P7VHKas56ukfXIF2EOFC3YlQfOvK6DUmQuFD3R7vHc
         aLxmqZWewKye5u2iLVbUZswFAPdq5bEtA9ZMKsi+ABCvKg/MsqznLMtBmEjBzD8OwGGb
         qLnsTVf8bj4gazEZqLhl9I18s+B/y8DB/kQ2CEGYv7qlajARGB0M1O9TdF3I2iOGWtzp
         S2/tWVeotkTP/cwTfy35bsJLfTH/ChqVYKtO5EwH4qCclUvR1iN3PaOp7M0DdD0VkeAS
         Oj88glgbcux76mB6T6oeEyVvcieFCGrkuGrdlLE4n2/Lvu04coiarJ7isGSCh9vWWAxg
         wHTQ==
X-Gm-Message-State: AGi0PuaM6MmCkeinjCJT3cGb4MgVa5SK8aliLCFmhgARl/Y3vc+7B0oB
        xs3AQMZ0Z7K3PJ5bdPVbPMjMPaFJJkXvn2kWcIU=
X-Google-Smtp-Source: APiQypId0afPZ4x8PvGkxbbjbbAzonmu1ZV2X/K1TsKNsXag6xthEU0nB4oLKp01uDFmixo3ZKhSX6FLJ2a8Uu8qL8E=
X-Received: by 2002:a2e:9ccd:: with SMTP id g13mr11324753ljj.147.1586158842043;
 Mon, 06 Apr 2020 00:40:42 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac2:4a77:0:0:0:0:0 with HTTP; Mon, 6 Apr 2020 00:40:41 -0700 (PDT)
In-Reply-To: <20200406054110.GA1638548@kroah.com>
References: <1586102749-3364-1-git-send-email-zhangfeionline@gmail.com>
 <20200405164006.GA1582475@kroah.com> <CAC_binJNLLxfOm0W2TuVTJZxJRTZTvPPocSDNQMU=21XO37oZg@mail.gmail.com>
 <20200406054110.GA1638548@kroah.com>
From:   Fei Zhang <zhangfeionline@gmail.com>
Date:   Mon, 6 Apr 2020 15:40:41 +0800
Message-ID: <CAC_binJMn-uRNy1dwp=2fhF54R8DpaTZYskwEz3GNE-U0pShDQ@mail.gmail.com>
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

Mostly, "class_creat" is used in kernel driver module, basically
read-only strings,
but it is easier to use a local variable string. When writing drive module,
it fails to judge the local variable string which cannot be passed in
only via interface.
I found that someone else may also face the same problem.

If we have 2 identical hardwares with different internal logic(fpga),
it may be more
appropriate to create dynamic classes according to the logical functions.

Thanks,
Fei

2020-04-06 13:41 GMT+08:00, Greg KH <gregkh@linuxfoundation.org>:
> On Mon, Apr 06, 2020 at 01:33:03PM +0800, Fei Zhang wrote:
>> Dear Greg,
>>
>> Please refer to below for the crash. If you are fine with it, I will
>> submit another patch with correcting the error mentioned.
>>
>> When writing a kernel driver module, we may use it like this:
>>
>> static int frv_init(int index)
>> {
>> ...
>> 	char name [128]={0};
>> 	sprintf(name,"test_%d",index);
>> 	mount_dev_p->pci_class =class_create(THIS_MODULE,name);
>> 	classdev = device_create(mount_dev_p->pci_class, NULL, devno,
>> 	NULL, "PCIE_%x",index);
>> ...
>> }
>>
>> static void frv_exit(void)
>> {
>> ...
>> 	device_destroy(mount_dev_p->pci_class,mount_dev_p->devno);
>> 	class_destroy(mount_dev_p->pci_class );
>> ...
>> }
>>
>> But when we remove the module, a crash occurres when calling
>> device_destroy.
>>
>> Call Trace:
>>  vsnprintf+0x2b2/0x4e0
>>  add_uevent_var+0x7d/0x110
>>  kobject_uevent_env+0x23f/0x770
>>  kobject_uevent+0xb/0x10
>>  device_del+0x23b/0x360
>>  device_unregister+0x1a/0x60
>>  device_destroy+0x3c/0x50
>>
>> I traced the code and found that an invalid local variable was called
>> in "kobject_uevent_env()", and triggered further crash as followed:
>>
>> kobject_uevent_env(...)
>> {
>> ...
>> struct kset_uevent_ops *uevent_ops;
>> uevent_ops = kset->uevent_ops;
>> subsystem = uevent_ops->name(kset, kobj);
>> add_uevent_var(env, "SUBSYSTEM=%s", subsystem);
>> ...
>> }
>>
>> What is the "subsystem" value, continue to track.
>>
>> static const struct kset_uevent_ops device_uevent_ops = {
>> 	.name =		dev_uevent_name,
>> };
>>
>> static const char *dev_uevent_name(struct kset *kset, struct kobject
>> *kobj)
>> {
>> 	struct device *dev = kobj_to_dev(kobj);
>> 	if (dev->class)
>> 		return dev->class->name;
>> 	return NULL;
>> }
>>
>> Everything becomes clear: "class->name" and "subsystem" value is local
>> variable array address of start module function inside "char name [128]".
>> Used released local variable in device_destroy's kobject_uevent_env, an
>> error occurred.
>
> Please do not top-post.
>
> Anyway, yes, that does seem to be a semi-valid way of creating a class,
> does anyone currently do that in the kernel tree today?  Typically
> creating classes is rare, and do not have a "dynamic name" like your
> example above, because that is not what a class is for.
>
> So while the idea is good to solve this, I would like to go back to your
> example to find out why you are doing this in the first place, as that
> does not seem to be the way to use the driver model correctly.
>
> thanks,
>
> greg k-h
>
