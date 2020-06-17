Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95530C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 668C820773
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:25:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kbvD0JS5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgFQOZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 10:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbgFQOZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 10:25:06 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 241BEC06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 07:25:05 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id l27so2564812ejc.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 07:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HDoWDHpkjPS6d8LBQgcIgLv8z+yGCK9DQ6/ssyT50xc=;
        b=kbvD0JS5p/ATKSjl3hmKNOhn47xO+vXH7w66YDqblxafW1UpHizYuRuC7PhgZbAZYT
         I9GWrIqicryiZCAMw8NKdkgzFRmd49HU2t4oWYTY1XJxSHugRipIUSrH0J6AwKqR5iEq
         wvum2Ecq2m1aVwZ33AtzYzsRnOlc6+wVnfnlBYAfgEv9xgXUZdVaRXmQ935HcxmkwaTH
         GOKAfg2GtQQ5F/6br4TxKHV/8tvmMQ43DtXNnsDaTrBSSwuThSfAqnJRPEJhgWCyK+6j
         EEHK63g7i/QaWYSQlCHYekjmRZWXlqq6R8/KbrpAT+zVisJ3Nji1a/sLp0Eq7vTY9yIb
         A3cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HDoWDHpkjPS6d8LBQgcIgLv8z+yGCK9DQ6/ssyT50xc=;
        b=m0yR2geShH+e13d83KOXD1/K8emtqrPHPN4UwyICwdL4nGQ/XbCCyUrZ/4OK55PMyF
         rHeO+dUZ8mutfBj8Yo3mv6a3nLA36+QKdWeyPM42J1s/IDflViHS8pDOelLEwyeNWoqg
         rya53gCUs4HVwjt5gDEdK2Mukr5zHJs9ybEhtgc6B2SfXFCXmnIdGEM81IOaQp8R2vpc
         4d9i7VkJPbUUcEviWyz5lwR5Gw6dXPLofxjUKgp2/AQWNYLR2iRA5IyjdQyDbITOmB+X
         MBbFMtnm6pzFDF++Nay60dUO6erA01gu424GkL7itLKvePDYS/J+VMEKOQdoYLWaOxXH
         2ZwA==
X-Gm-Message-State: AOAM532M0TVvevOFc5Hc7uXZcwluQOVf3Ed9sLjT3pAkv0Xz+B/ucwlC
        XCWtwDtPXA8K5G8t65qRNzcJu8UYc+f6g9eskQrcrQ==
X-Google-Smtp-Source: ABdhPJxtDFqfhqyIyfwWNre9tJ1vuIY0eX7My7z8G5vGhtOobxeDWhchL2tJJ1lcn+sA+LVEqbTIqwK2Fw9zZzwK5hg=
X-Received: by 2002:a17:906:7208:: with SMTP id m8mr8098561ejk.544.1592403903401;
 Wed, 17 Jun 2020 07:25:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200612121047.GF4282@kadam> <20200612121133.GA1139533@mwanda>
 <20200612174215.GI4282@kadam> <CAJ9a7ViP_PTiSnYnOYbH=LRXUroWT04rmdswZEdakoWjevUi4Q@mail.gmail.com>
In-Reply-To: <CAJ9a7ViP_PTiSnYnOYbH=LRXUroWT04rmdswZEdakoWjevUi4Q@mail.gmail.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 17 Jun 2020 15:24:52 +0100
Message-ID: <CAJ9a7VjxEdJV=2b6qTEyjusmOHouWd58HLwV5CeF-yT1uL-2BA@mail.gmail.com>
Subject: Re: [PATCH] coresight: cti: Fix error handling in probe
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Dan,

Looked into this some more...

On Wed, 17 Jun 2020 at 11:53, Mike Leach <mike.leach@linaro.org> wrote:
>
> Hi Dan,
>
> On Fri, 12 Jun 2020 at 18:43, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> >
> > On Fri, Jun 12, 2020 at 03:11:33PM +0300, Dan Carpenter wrote:
> > > +static int cti_pm_setup(struct cti_drvdata *drvdata)
> > > +{
> > > +     int ret;
> > > +
> > > +     if (drvdata->ctidev.cpu == -1)
> > > +             return 0;
> > > +
> > > +     if (nr_cti_cpu)
> > > +             goto done;
> > > +
> > > +     cpus_read_lock();
> >         ^^^^^^^^^^^^^^^^
> > One thing which I do wonder is why we have locking here but not in the
> > cti_pm_release() function.  That was how the original code was so the
> > patch doesn't change anything, but I am curious.
> >
>
> Good point - the CTI PM code was modelled on the same code in the ETM
> drivers, which show the same pattern.
> Perhaps something we need to revisit in both drivers.
>

The ETMv4 code calls into the hotplug API twice - so takes the lock
and makes both calls while holding the lock - using the "_cpuslocked"
call variant to render the pair of calls atomic from the CPUHP context
point of view.
CTI only calls once so does not really need to take the locks and
could simply use the normal variant.

In both cases the cpuhp_remove_state uses the normal variant, which
takes the locks inside the api call. For the CTI there is certainly  a
case for simplification, i..e drop the "_cpuslocked" variant and
remove the explicit taking of the locks.

Something along the lines of....

...
if (nr_cti_cpu)
       goto done;

ret = cpu_pm_register_notifier(&cti_cpu_pm_nb);
if (ret)
     return ret;

ret =  cpuhp_setup_state_nocalls(......);
if (ret) {
    cpu_pm_unregister_notifier(....);
   return ret;
}

done:
....

Regards

Mike



> Regards
>
> Mike
>
> > > +     ret = cpuhp_setup_state_nocalls_cpuslocked(
> > > +                     CPUHP_AP_ARM_CORESIGHT_CTI_STARTING,
> > > +                     "arm/coresight_cti:starting",
> > > +                     cti_starting_cpu, cti_dying_cpu);
> > > +     if (ret) {
> > > +             cpus_read_unlock();
> > > +             return ret;
> > > +     }
> > > +
> > > +     ret = cpu_pm_register_notifier(&cti_cpu_pm_nb);
> > > +     cpus_read_unlock();
> > > +     if (ret) {
> > > +             cpuhp_remove_state_nocalls(CPUHP_AP_ARM_CORESIGHT_CTI_STARTING);
> > > +             return ret;
> > > +     }
> > > +
> > > +done:
> > > +     nr_cti_cpu++;
> > > +     cti_cpu_drvdata[drvdata->ctidev.cpu] = drvdata;
> > > +
> > > +     return 0;
> > > +}
> > > +
> > >  /* release PM registrations */
> > >  static void cti_pm_release(struct cti_drvdata *drvdata)
> > >  {
> > > -     if (drvdata->ctidev.cpu >= 0) {
> > > -             if (--nr_cti_cpu == 0) {
> > > -                     cpu_pm_unregister_notifier(&cti_cpu_pm_nb);
> > > +     if (drvdata->ctidev.cpu == -1)
> > > +             return;
> > >
> > > -                     cpuhp_remove_state_nocalls(
> > > -                             CPUHP_AP_ARM_CORESIGHT_CTI_STARTING);
> > > -             }
> > > -             cti_cpu_drvdata[drvdata->ctidev.cpu] = NULL;
> > > +     cti_cpu_drvdata[drvdata->ctidev.cpu] = drvdata;
> > > +     if (--nr_cti_cpu == 0) {
> > > +             cpu_pm_unregister_notifier(&cti_cpu_pm_nb);
> > > +             cpuhp_remove_state_nocalls(CPUHP_AP_ARM_CORESIGHT_CTI_STARTING);
> > >       }
> > >  }
> >
> > regards,
> > dan carpenter
> >
>
>
> --
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
