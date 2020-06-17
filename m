Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73B18C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 10:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5027621527
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 10:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N6FV9zn0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgFQKx4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 06:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgFQKxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 06:53:52 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CA9C061573
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 03:53:51 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id o15so1783352ejm.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 03:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lCVEonbpFZmz0/ZeZBC256oe8W32YGcEqtUscl42Jjk=;
        b=N6FV9zn0+vHCrQgrVC1C0J/mPAwm539PdN5uB7k0b9RkMCTH5U+h4TNko9RWYTFJS0
         aycV7lZQuWVgH8fVnSepk8Xz4VRR0fWiURSOHJK9kMY/TeSTYqHhqujymcLZK8nILAq8
         YRnZdRC+EuIeN9ZsLl8ItTHgnLXHEd4/8J1RICT4DwDfOwhleGOwVqvM5R9dnz8aZtuO
         BJrqqCIPEirrFFQ+oaDBvgOulTo2An6MX+DdR6/Q8wn/r+pwJkOrMtEF6QcvlqVKRjrt
         Q3wuXeWMZBbTXMuBU1zwm5ArFFPkRslx4tiWzIl5cKnTCZggSehVm90BWCG6qsbLOv9E
         86nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lCVEonbpFZmz0/ZeZBC256oe8W32YGcEqtUscl42Jjk=;
        b=SRQa/S22RFef2R1CpND0YNN5McsSqYztP1RXko/xegd/pHTiUb1lzFuBD32Ul1h7yW
         XTGHHVEvhU8uL3j16W7pk0jdKrXEcuA/XwpzkXa3JIt7dh/o7DhukJD9ygxfC0B4fgj9
         SUp4617JHbtEl0HgR0Eo//SWSlz3cb82ZR0OAtWqr1+4twldPsXodN4QAwgcy74V6Z1o
         6RsguyEHghEptCh/zJbPNpDlGvXwYQaTtdPnTI216dxBYt43M5nv2P/WV3gGiRLjJ9Mm
         RYjXe5wY4l79VB696Rkc/DuEoXuqfP5xBnG3+2TCnjsVix+Vc5UVkRHVXWptAPU+0gBj
         ZmKw==
X-Gm-Message-State: AOAM531stz6VVVQf9qiB8IJonm3vXAUrqOVe6RgAepe5a5UKRJ77aVmS
        +BxkfSRQibvL8K1PiDtHSOyXzj74gRiJnA+aMb45bg==
X-Google-Smtp-Source: ABdhPJzM/QMiOA2pfu6giruDymL/vgxx992VCpmzw/lfID1zaGXgd0e96O1FEVsGBiSkriQxR1i1J10b+Xiy3GtvffU=
X-Received: by 2002:a17:906:118b:: with SMTP id n11mr7055515eja.328.1592391230007;
 Wed, 17 Jun 2020 03:53:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200612121047.GF4282@kadam> <20200612121133.GA1139533@mwanda> <20200612174215.GI4282@kadam>
In-Reply-To: <20200612174215.GI4282@kadam>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 17 Jun 2020 11:53:39 +0100
Message-ID: <CAJ9a7ViP_PTiSnYnOYbH=LRXUroWT04rmdswZEdakoWjevUi4Q@mail.gmail.com>
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

Hi Dan,

On Fri, 12 Jun 2020 at 18:43, Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Fri, Jun 12, 2020 at 03:11:33PM +0300, Dan Carpenter wrote:
> > +static int cti_pm_setup(struct cti_drvdata *drvdata)
> > +{
> > +     int ret;
> > +
> > +     if (drvdata->ctidev.cpu == -1)
> > +             return 0;
> > +
> > +     if (nr_cti_cpu)
> > +             goto done;
> > +
> > +     cpus_read_lock();
>         ^^^^^^^^^^^^^^^^
> One thing which I do wonder is why we have locking here but not in the
> cti_pm_release() function.  That was how the original code was so the
> patch doesn't change anything, but I am curious.
>

Good point - the CTI PM code was modelled on the same code in the ETM
drivers, which show the same pattern.
Perhaps something we need to revisit in both drivers.

Regards

Mike

> > +     ret = cpuhp_setup_state_nocalls_cpuslocked(
> > +                     CPUHP_AP_ARM_CORESIGHT_CTI_STARTING,
> > +                     "arm/coresight_cti:starting",
> > +                     cti_starting_cpu, cti_dying_cpu);
> > +     if (ret) {
> > +             cpus_read_unlock();
> > +             return ret;
> > +     }
> > +
> > +     ret = cpu_pm_register_notifier(&cti_cpu_pm_nb);
> > +     cpus_read_unlock();
> > +     if (ret) {
> > +             cpuhp_remove_state_nocalls(CPUHP_AP_ARM_CORESIGHT_CTI_STARTING);
> > +             return ret;
> > +     }
> > +
> > +done:
> > +     nr_cti_cpu++;
> > +     cti_cpu_drvdata[drvdata->ctidev.cpu] = drvdata;
> > +
> > +     return 0;
> > +}
> > +
> >  /* release PM registrations */
> >  static void cti_pm_release(struct cti_drvdata *drvdata)
> >  {
> > -     if (drvdata->ctidev.cpu >= 0) {
> > -             if (--nr_cti_cpu == 0) {
> > -                     cpu_pm_unregister_notifier(&cti_cpu_pm_nb);
> > +     if (drvdata->ctidev.cpu == -1)
> > +             return;
> >
> > -                     cpuhp_remove_state_nocalls(
> > -                             CPUHP_AP_ARM_CORESIGHT_CTI_STARTING);
> > -             }
> > -             cti_cpu_drvdata[drvdata->ctidev.cpu] = NULL;
> > +     cti_cpu_drvdata[drvdata->ctidev.cpu] = drvdata;
> > +     if (--nr_cti_cpu == 0) {
> > +             cpu_pm_unregister_notifier(&cti_cpu_pm_nb);
> > +             cpuhp_remove_state_nocalls(CPUHP_AP_ARM_CORESIGHT_CTI_STARTING);
> >       }
> >  }
>
> regards,
> dan carpenter
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
