Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1399C2BA18
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 05:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84A9206C0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 05:43:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586151800;
	bh=E7m3idB9KXQ4U9/pMSnS8tOhmB0bGpuaLtvA6Uj7S0U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=gTAyubDrqjffr2CZYBnW9Mffy23y5Rivd/M1TvY0faM3TqjRZoH/i6042Du4HBAIa
	 MN3KI969In5KAOJMWijNZBJGnOEXV95QSyCt7V3G4P3XBAoK2cqrXrhgg1y0XGF9NL
	 I3e4N1NjslHmbe2/QA5s8nVytbXmlKFjxRInO+Dg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbgDFFlQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 01:41:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:46222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgDFFlQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 01:41:16 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83B76206C0;
        Mon,  6 Apr 2020 05:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586151675;
        bh=E7m3idB9KXQ4U9/pMSnS8tOhmB0bGpuaLtvA6Uj7S0U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=axjXnE+e6XYsAiXQGUeWRnSa/TxzV0HMIzPibIuJ5rWD2abEbm2E3UMGa9vb6Ilwq
         0y3zNH0rv9WEA1bcRliXuWkHrsHuwSGZL2R8A0qaFCMqVXjjpG9dp2iN6I3jcL0Ub0
         Ut3ijmH8L3/ovmmM1Fdo9a5LN/nl1SN+HbrUvCV4=
Date:   Mon, 6 Apr 2020 07:41:10 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Fei Zhang <zhangfeionline@gmail.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com
Subject: Re: [PATCH] driver core: Fix possible use after free on name
Message-ID: <20200406054110.GA1638548@kroah.com>
References: <1586102749-3364-1-git-send-email-zhangfeionline@gmail.com>
 <20200405164006.GA1582475@kroah.com>
 <CAC_binJNLLxfOm0W2TuVTJZxJRTZTvPPocSDNQMU=21XO37oZg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_binJNLLxfOm0W2TuVTJZxJRTZTvPPocSDNQMU=21XO37oZg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 06, 2020 at 01:33:03PM +0800, Fei Zhang wrote:
> Dear Greg,
> 
> Please refer to below for the crash. If you are fine with it, I will
> submit another patch with correcting the error mentioned.
> 
> When writing a kernel driver module, we may use it like this:
> 
> static int frv_init(int index)
> {
> ...
> 	char name [128]={0};
> 	sprintf(name,"test_%d",index);
> 	mount_dev_p->pci_class =class_create(THIS_MODULE,name);
> 	classdev = device_create(mount_dev_p->pci_class, NULL, devno,
> 	NULL, "PCIE_%x",index);
> ...
> }
> 
> static void frv_exit(void)
> {
> ...
> 	device_destroy(mount_dev_p->pci_class,mount_dev_p->devno);
> 	class_destroy(mount_dev_p->pci_class );
> ...
> }
> 
> But when we remove the module, a crash occurres when calling
> device_destroy.
> 
> Call Trace:
>  vsnprintf+0x2b2/0x4e0
>  add_uevent_var+0x7d/0x110
>  kobject_uevent_env+0x23f/0x770
>  kobject_uevent+0xb/0x10
>  device_del+0x23b/0x360
>  device_unregister+0x1a/0x60
>  device_destroy+0x3c/0x50
> 
> I traced the code and found that an invalid local variable was called
> in "kobject_uevent_env()", and triggered further crash as followed:
> 
> kobject_uevent_env(...)
> {
> ...
> struct kset_uevent_ops *uevent_ops;
> uevent_ops = kset->uevent_ops;
> subsystem = uevent_ops->name(kset, kobj);
> add_uevent_var(env, "SUBSYSTEM=%s", subsystem);
> ...
> }
> 
> What is the "subsystem" value, continue to track.
> 
> static const struct kset_uevent_ops device_uevent_ops = {
> 	.name =		dev_uevent_name,
> };
> 
> static const char *dev_uevent_name(struct kset *kset, struct kobject *kobj)
> {
> 	struct device *dev = kobj_to_dev(kobj);
> 	if (dev->class)
> 		return dev->class->name;
> 	return NULL;
> }
> 
> Everything becomes clear: "class->name" and "subsystem" value is local
> variable array address of start module function inside "char name [128]".
> Used released local variable in device_destroy's kobject_uevent_env, an
> error occurred.

Please do not top-post.

Anyway, yes, that does seem to be a semi-valid way of creating a class,
does anyone currently do that in the kernel tree today?  Typically
creating classes is rare, and do not have a "dynamic name" like your
example above, because that is not what a class is for.

So while the idea is good to solve this, I would like to go back to your
example to find out why you are doing this in the first place, as that
does not seem to be the way to use the driver model correctly.

thanks,

greg k-h
