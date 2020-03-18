Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B827C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 18:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 148A4205ED
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 18:15:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WLVVjmm/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgCRSPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 14:15:17 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40159 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbgCRSPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 14:15:16 -0400
Received: by mail-io1-f68.google.com with SMTP id h18so5339113ioh.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 11:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G3ezxdprHPC/cW/uKAbsl7U/GdK+KSS74BcxSx0wptQ=;
        b=WLVVjmm/0PMM1l1p6mDIVriTyJMJ0Th4tquzPahs8W/LnzwtxpNz6jDrsqwMj83DYl
         rt1/0GMd0/IJApxkA6y+pEOMFi3PRsiD7CWqdRV3C4xQq1BtuGfPkyaFw5GY4UTpRh+t
         3pukT1OWurinsg+ucUwnnUpmNhwFxNo01T3dS/9Y1VROoU+3qlJoveEMhYdFa340GYrt
         JNWJZnHaGG3/awfsFukSXDJorBi3REn7/YvXWulIyHgrno7QTqIc8D+fJHecyIA5Rw0F
         aDuXkjrXNLfDlCm56VR7BkduHGPR7AhHAepYAK6QBJTHF1WX2FO660zP0sr33jJ5QkjY
         1oeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G3ezxdprHPC/cW/uKAbsl7U/GdK+KSS74BcxSx0wptQ=;
        b=HTzcZWlBTZzBolDP0SJtmUOS1Q4UzM6DV673PBuy32oQah0+m8zaYfIXok30hV8UtW
         32Wkvi7NeDdaYbUffbX2Y+0WLmPqatW01Hxtzx7ukcjGhc6ihFbkcntSZLbCJ/Q5ECal
         b5UvQNO+3C8Ax0P0uf5g9oqkMhNF9/ay2LQXD8eg2P3lTWWqdzL13yRO7b+5riMGXw/7
         SLzgQTYkv81TmFWSRq5Kd1S2rhNypeIL2YPDqEnKRaaRICsmB22+f2OsXwHWY/2oP5Jk
         M515M/f7WRUU6JBjsvubFPUcq0wLEtIkhChqUCfa0WOXNp5FMTS/QQX/nRpEDfU4Ml5L
         WR7A==
X-Gm-Message-State: ANhLgQ17ckx5NozkpWWVCC5UN//XOrpY1+Ks1C3gGqGbWZB8ngv+DQOb
        fDa1gXlIpyMK4UD+Q3lzIylH2hvoFNlrsTcquKdPug==
X-Google-Smtp-Source: ADFU+vsy1Xcz73+8WOjXa+8SolKRUHeZY/s0KA74nqezOvrFq97BgP/0qG96ERIthIjEQ+53e3HMW0S91FCfhZMyXik=
X-Received: by 2002:a05:6638:f01:: with SMTP id h1mr5469337jas.36.1584555315208;
 Wed, 18 Mar 2020 11:15:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200309161748.31975-1-mathieu.poirier@linaro.org>
 <20200309161748.31975-2-mathieu.poirier@linaro.org> <20200318132241.GB2789508@kroah.com>
 <20200318181226.GA18359@xps15>
In-Reply-To: <20200318181226.GA18359@xps15>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Wed, 18 Mar 2020 12:15:04 -0600
Message-ID: <CANLsYkxxUuaAZEy8fHm1aWDocdaRg1rUKan6tQQh6+T4afTxFg@mail.gmail.com>
Subject: Re: [PATCH 01/13] coresight: cti: Initial CoreSight CTI Driver
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Mike Leach <mike.leach@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Mar 2020 at 12:12, Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
>
> On Wed, Mar 18, 2020 at 02:22:41PM +0100, Greg KH wrote:
> > On Mon, Mar 09, 2020 at 10:17:36AM -0600, Mathieu Poirier wrote:
> > > From: Mike Leach <mike.leach@linaro.org>
> > >
> > > This introduces a baseline CTI driver and associated configuration files.
> > >
> > > Uses the platform agnostic naming standard for CoreSight devices, along
> > > with a generic platform probing method that currently supports device
> > > tree descriptions, but allows for the ACPI bindings to be added once these
> > > have been defined for the CTI devices.
> > >
> > > Driver will probe for the device on the AMBA bus, and load the CTI driver
> > > on CoreSight ID match to CTI IDs in tables.
> > >
> > > Initial sysfs support for enable / disable provided.
> > >
> > > Default CTI interconnection data is generated based on hardware
> > > register signal counts, with no additional connection information.
> > >
> > > Signed-off-by: Mike Leach <mike.leach@linaro.org>
> > > Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> >
> > You didn't cc: all of them to get review comments?  I've added it
> > above...
>
> Thanks
>
> >
> > And signed-off-by implies reviewed-by.
>
> This set has been refined over several iterations.  I added my R-b to patches
> that I had reviewed and did not need attentions anymore.  Since this is supposed
> to be a chain of custody I decided to keep my R-b and append my S-b before
> queueing in my tree.  I have seen this done many times before but will remove if
> you think it is better.
>
> >
> > > +/* basic attributes */
> > > +static ssize_t enable_show(struct device *dev,
> > > +                      struct device_attribute *attr,
> > > +                      char *buf)
> > > +{
> > > +   int enable_req;
> > > +   bool enabled, powered;
> > > +   struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);
> > > +   ssize_t size = 0;
> > > +
> > > +   enable_req = atomic_read(&drvdata->config.enable_req_count);
> > > +   spin_lock(&drvdata->spinlock);
> > > +   powered = drvdata->config.hw_powered;
> > > +   enabled = drvdata->config.hw_enabled;
> > > +   spin_unlock(&drvdata->spinlock);
> > > +
> > > +   if (powered) {
> > > +           size = scnprintf(buf, PAGE_SIZE, "cti %s; powered;\n",
> > > +                            enabled ? "enabled" : "disabled");
> > > +   } else {
> > > +           size = scnprintf(buf, PAGE_SIZE, "cti %s; unpowered;\n",
> > > +                            enable_req ? "enable req" : "disabled");
> >
> > sysfs files should never need scnprintf() as you "know" a single value
> > will fit into a PAGE_SIZE.
>
> I've seen many patches using scnprintf() that were merged.  We can change this
> to sprintf().
>
> >
> > And shouldn't this just be a single value, this looks like it is 2
> > values in one line, that then needs to be parsed, is that to be
> > expected?
>
> There is no shortage of files under /sys/device/ with output that needs parsing,
> but this can be split in two entries.
>
> >
> > Where is the documentation for this new sysfs file?
>
> All the documentation for sysfs files are lumped together in a single patch [1]
> that is also part of this set.
>
> [1]. https://lkml.org/lkml/2020/3/9/643

Correction - this link should be:

https://lkml.org/lkml/2020/3/9/642

>
> >
> > > +const struct attribute_group *coresight_cti_groups[] = {
> > > +   &coresight_cti_group,
> > > +   NULL,
> > > +};
> >
> > ATTRIBUTE_GROUPS()?
>
> As with all the other coresight devices, groups are communicated to
> coresight_register() and added to the csdev->dev in that function.
>
> >
> > > +static struct amba_driver cti_driver = {
> > > +   .drv = {
> > > +           .name   = "coresight-cti",
> > > +           .owner = THIS_MODULE,
> >
> > Aren't amba drivers smart enough to set this properly on their own?
> > {sigh}
>
> Would you mind indicating where?  builtin_amba_driver() calls
> amba_driver_register() and  that doesn't set the owner field.
>
> Thanks,
> Mathieu
>
> >
> > greg k-h
