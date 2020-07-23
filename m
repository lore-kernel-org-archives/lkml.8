Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5305EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C08220714
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 07:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cloud.ionos.com header.i=@cloud.ionos.com header.b="YTspYUzC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbgGWHCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 03:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725774AbgGWHCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 03:02:48 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADBCC0619DC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 00:02:48 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id by13so3684243edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jul 2020 00:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SfS8nf99hq7DuEx/kHoPEqmrbwoIsST4mSyABQnVZSQ=;
        b=YTspYUzCTPwfyoE5AgUNWSWm/7lHjJgCkRwdVPwjww4zm9w3luUg460JDLNEVmx1x4
         S8BzLS4eHF/AiT2KSekme/fJuTc299z1dMIieW3HNDHKNesyG4kuklzMgMc0mXC9i6Ri
         7exLlox951kHvcQ1jcaafBTZtD4ViRjp7LpkEijd+1SORDeMiJJ26Rk7dQpZb1Kmh/II
         N7eNo+2K9D/uEjEVKD2sm7L6rJhX3kWVqJHrWdN5ne+KS0ej7Wrr+44ARtQjBBj/xVEP
         vP0yRnG9nSBKsMs0yYa2LAP6r9iDmyaropf9IRUsYvOxdKphMs7SIGx3OUQIAYcAZyQC
         +ijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SfS8nf99hq7DuEx/kHoPEqmrbwoIsST4mSyABQnVZSQ=;
        b=WU6btYm6AXjG8WoDabVpDjWOZLPHYnNA8q5gfm03/8KAeIGjmiU2FMDadipfCATtpO
         pGVYpAxcgsBdKL9AmY9Zw69z86AHiPdYQvOz3RnT0/rmi7cmWai2yif0y4lsbXedXNPi
         1I0wuP5xq2WCZbSfRT+zRSch4K8JefyXswUDJWU6ZdwkIMRlIq51wcv5lqgsPoMzKTmD
         JX+PZKrETGY9vCYKEIvbFdnAywOHYz1buBPOYBFINygOIuiMfRXiSENYhzvIQ7cf/Dzk
         fcltxWb0OgxAchfKqY0ZQ9gd1d+I7wmAzp5m+o2dUh33XHIIrlXnr/MFfl16K027bFVp
         4NkQ==
X-Gm-Message-State: AOAM531NXQ+uoaXbqTNjm8pYW/RPW/Eordzi47fxNmGk/zdfU7WvEETs
        0pFcvkUjfR/KxuPyl1hbHATy9v1IXF+X2+n9LPafHr5RgBx30M+8
X-Google-Smtp-Source: ABdhPJxTduRJ5al4/frVVD9fDofIlJ7ztuk37FWYsBSe0cNzQyQ+mBrOBScQo6owEDNSjYITuNkfVSMC62ellntxR68=
X-Received: by 2002:a05:6402:559:: with SMTP id i25mr2816567edx.35.1595487767298;
 Thu, 23 Jul 2020 00:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200720133427.454400-1-vaibhavgupta40@gmail.com> <20200720133427.454400-11-vaibhavgupta40@gmail.com>
In-Reply-To: <20200720133427.454400-11-vaibhavgupta40@gmail.com>
From:   Jinpu Wang <jinpu.wang@cloud.ionos.com>
Date:   Thu, 23 Jul 2020 09:02:36 +0200
Message-ID: <CAMGffE=K4Tx6oduwS1=_1pgOCpXPnrOF9XZghOvR2taTwnhn3A@mail.gmail.com>
Subject: Re: [PATCH v2 10/15] scsi: pm_8001: use generic power management
To:     Vaibhav Gupta <vaibhavgupta40@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        Vaibhav Gupta <vaibhav.varodek@gmail.com>,
        Adam Radford <aradford@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        Hannes Reinecke <hare@suse.com>,
        Bradley Grove <linuxdrivers@attotech.com>,
        John Garry <john.garry@huawei.com>,
        Don Brace <don.brace@microsemi.com>,
        James Smart <james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Shivasharan S <shivasharan.srikanteshwara@broadcom.com>,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Linux SCSI Mailinglist <linux-scsi@vger.kernel.org>,
        esc.storagedev@microsemi.com, megaraidlinux.pdl@broadcom.com,
        MPT-FusionLinux.pdl@broadcom.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 3:38 PM Vaibhav Gupta <vaibhavgupta40@gmail.com> wrote:
>
> With legacy PM, drivers themselves were responsible for managing the
> device's power states and takes care of register states.
>
> After upgrading to the generic structure, PCI core will take care of
> required tasks and drivers should do only device-specific operations.
>
> The driver was calling pci_save/restore_state(), pci_choose_state(),
> pci_enable/disable_device() and pci_set_power_state() which is no more
> needed.
>
> Compile-tested only.
>
> Signed-off-by: Vaibhav Gupta <vaibhavgupta40@gmail.com>
nit: subject should be pm8001
Thanks!
Acked-by: Jack Wang <jinpu.wang@cloud.ionos.com>
