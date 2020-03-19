Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 098A0C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3E8820663
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 14:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dgnqc9To"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727586AbgCSOka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 10:40:30 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:32914 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgCSOka (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:40:30 -0400
Received: by mail-il1-f195.google.com with SMTP id k29so2469608ilg.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 07:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jjHet+d6PgTVVQzngVDu0DWyN0tpKckAYla4JKs7W40=;
        b=dgnqc9TorOD+T7DJjFZzT7XMOPM1Uql4eYR/gS5bo9ceo7hLhVWlnB54uKbeWs8glD
         W0GqzPTosEGlGB2FD4wkXNwzYZe1nOu0nYaC/hIo2N0bT8j+uZ/S4yEUI2ICrA31I84p
         Bb/+Nm31Se85+XJ81U/2TkVgpWOuFMRxwpI2Kt9SP//ToZtVsaN9s7Lb4s9RJX5ktYfS
         V9srf5U7C3MlP4rJEsNCwqTpMjNie8Mc07Dv81W7d1pNkAZ/cj+/WKOZEY1O6Cqnbhnv
         y/GJRrcFHuQ1nRXCu66Eew+tnit/uhgJXJLi4MM9daknEEsDIvsge+5QMBVuDDWhwi58
         umvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jjHet+d6PgTVVQzngVDu0DWyN0tpKckAYla4JKs7W40=;
        b=DNCT/LZQfltHDKh1aP+hZJVfHuUdcuwifWOQKoJojA0oLRONwfM33KyQUENTnoGTZF
         cYJudiJHGvgUzCMaewEKkdVMgF1y6GD+0LqQChBPh4b4l2Wmlmav+tdwlVMhd21w87hb
         PrCc7BW3ODM1p4GTmP8Nj42QgNajYKbzxBTNOPJwezfiss/vGy1I8sK6CY64cPs/FgnL
         w4lbOYPWrphK4gZM/vQoOp1M26FcmZ38yL8ryJMH7tI+HOudteVv3NbNUpYv4q5Mrx1R
         97sWwPm7fA02OQrxaOg3Z1vv4zjiyviht2pQs8hGZChE1u9dBlY3lkNhgH4olu5TeM5O
         gQmA==
X-Gm-Message-State: ANhLgQ0XW9StBc520kzzxXKsEL5oMxTNy+CcwDXOhWbDo+rgQEMl9kfc
        /BT3IfeUEiggjJ8mGXjnB/kRmWstPfBkpnVVssRQ1LJT
X-Google-Smtp-Source: ADFU+vsnPog9qFORvypj6xgLmeNjTJ3qbUUNUhTdvHi8BkTFesTjFNHuDKSwwaQaDPgWVZwvifE+xVBtSq04YCVh2eA=
X-Received: by 2002:a92:9f1a:: with SMTP id u26mr3577794ili.72.1584628828813;
 Thu, 19 Mar 2020 07:40:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200309161748.31975-1-mathieu.poirier@linaro.org>
 <20200309161748.31975-3-mathieu.poirier@linaro.org> <20200318131821.GA2789508@kroah.com>
 <20200318181604.GB18359@xps15> <20200318182201.GA3235688@kroah.com>
 <CANLsYkxkg1bCCN=iuSQBF_oG-wWwrSvEC2pLNVkP64EgTfVAvg@mail.gmail.com> <20200319075414.GA3445010@kroah.com>
In-Reply-To: <20200319075414.GA3445010@kroah.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 19 Mar 2020 08:40:18 -0600
Message-ID: <CANLsYkwVDi1RoAOoQ8fKf5GuOnD=YFM6Bo308j7KJ5eg0fAR=w@mail.gmail.com>
Subject: Re: [PATCH 02/13] coresight: cti: Add sysfs coresight mgmt register access
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Mar 2020 at 01:54, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Mar 18, 2020 at 01:28:05PM -0600, Mathieu Poirier wrote:
> > On Wed, 18 Mar 2020 at 12:22, Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Wed, Mar 18, 2020 at 12:16:04PM -0600, Mathieu Poirier wrote:
> > > > On Wed, Mar 18, 2020 at 02:18:21PM +0100, Greg KH wrote:
> > > > > On Mon, Mar 09, 2020 at 10:17:37AM -0600, Mathieu Poirier wrote:
> > > > > > From: Mike Leach <mike.leach@linaro.org>
> > > > > >
> > > > > > Adds sysfs access to the coresight management registers.
> > > > > >
> > > > > > Signed-off-by: Mike Leach <mike.leach@linaro.org>
> > > > > > Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > > > > Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
> > > > > > [Fixed abbreviation in title]
> > > > > > Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
> > > > > > ---
> > > > > >  .../hwtracing/coresight/coresight-cti-sysfs.c | 53 +++++++++++++++++++
> > > > > >  drivers/hwtracing/coresight/coresight-priv.h  |  1 +
> > > > > >  2 files changed, 54 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/hwtracing/coresight/coresight-cti-sysfs.c b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> > > > > > index a832b8c6b866..507f8eb487fe 100644
> > > > > > --- a/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> > > > > > +++ b/drivers/hwtracing/coresight/coresight-cti-sysfs.c
> > > > > > @@ -62,11 +62,64 @@ static struct attribute *coresight_cti_attrs[] = {
> > > > > >   NULL,
> > > > > >  };
> > > > > >
> > > > > > +/* register based attributes */
> > > > > > +
> > > > > > +/* macro to access RO registers with power check only (no enable check). */
> > > > > > +#define coresight_cti_reg(name, offset)                  \
> > > > > > +static ssize_t name##_show(struct device *dev,                           \
> > > > > > +                    struct device_attribute *attr, char *buf)    \
> > > > > > +{                                                                        \
> > > > > > + struct cti_drvdata *drvdata = dev_get_drvdata(dev->parent);     \
> > > > > > + u32 val = 0;                                                    \
> > > > > > + pm_runtime_get_sync(dev->parent);                               \
> > > > > > + spin_lock(&drvdata->spinlock);                                  \
> > > > > > + if (drvdata->config.hw_powered)                                 \
> > > > > > +         val = readl_relaxed(drvdata->base + offset);            \
> > > > > > + spin_unlock(&drvdata->spinlock);                                \
> > > > > > + pm_runtime_put_sync(dev->parent);                               \
> > > > > > + return scnprintf(buf, PAGE_SIZE, "0x%x\n", val);                \
> > > > > > +}                                                                        \
> > > > > > +static DEVICE_ATTR_RO(name)
> > > > > > +
> > > > > > +/* coresight management registers */
> > > > > > +coresight_cti_reg(devaff0, CTIDEVAFF0);
> > > > > > +coresight_cti_reg(devaff1, CTIDEVAFF1);
> > > > > > +coresight_cti_reg(authstatus, CORESIGHT_AUTHSTATUS);
> > > > > > +coresight_cti_reg(devarch, CORESIGHT_DEVARCH);
> > > > > > +coresight_cti_reg(devid, CORESIGHT_DEVID);
> > > > > > +coresight_cti_reg(devtype, CORESIGHT_DEVTYPE);
> > > > > > +coresight_cti_reg(pidr0, CORESIGHT_PERIPHIDR0);
> > > > > > +coresight_cti_reg(pidr1, CORESIGHT_PERIPHIDR1);
> > > > > > +coresight_cti_reg(pidr2, CORESIGHT_PERIPHIDR2);
> > > > > > +coresight_cti_reg(pidr3, CORESIGHT_PERIPHIDR3);
> > > > > > +coresight_cti_reg(pidr4, CORESIGHT_PERIPHIDR4);
> > > > > > +
> > > > > > +static struct attribute *coresight_cti_mgmt_attrs[] = {
> > > > > > + &dev_attr_devaff0.attr,
> > > > > > + &dev_attr_devaff1.attr,
> > > > > > + &dev_attr_authstatus.attr,
> > > > > > + &dev_attr_devarch.attr,
> > > > > > + &dev_attr_devid.attr,
> > > > > > + &dev_attr_devtype.attr,
> > > > > > + &dev_attr_pidr0.attr,
> > > > > > + &dev_attr_pidr1.attr,
> > > > > > + &dev_attr_pidr2.attr,
> > > > > > + &dev_attr_pidr3.attr,
> > > > > > + &dev_attr_pidr4.attr,
> > > > > > + NULL,
> > > > > > +};
> > > > > > +
> > > > > >  static const struct attribute_group coresight_cti_group = {
> > > > > >   .attrs = coresight_cti_attrs,
> > > > > >  };
> > > > > >
> > > > > > +static const struct attribute_group coresight_cti_mgmt_group = {
> > > > > > + .attrs = coresight_cti_mgmt_attrs,
> > > > > > + .name = "mgmt",
> > > > > > +};
> > > > > > +
> > > > > >  const struct attribute_group *coresight_cti_groups[] = {
> > > > > >   &coresight_cti_group,
> > > > > > + &coresight_cti_mgmt_group,
> > > > > >   NULL,
> > > > > >  };
> > > > > > diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> > > > > > index 82e563cdc879..aba6b789c969 100644
> > > > > > --- a/drivers/hwtracing/coresight/coresight-priv.h
> > > > > > +++ b/drivers/hwtracing/coresight/coresight-priv.h
> > > > > > @@ -22,6 +22,7 @@
> > > > > >  #define CORESIGHT_CLAIMCLR       0xfa4
> > > > > >  #define CORESIGHT_LAR            0xfb0
> > > > > >  #define CORESIGHT_LSR            0xfb4
> > > > > > +#define CORESIGHT_DEVARCH        0xfbc
> > > > > >  #define CORESIGHT_AUTHSTATUS     0xfb8
> > > > > >  #define CORESIGHT_DEVID          0xfc8
> > > > > >  #define CORESIGHT_DEVTYPE        0xfcc
> > > > > > --
> > > > > > 2.20.1
> > > > > >
> > > > >
> > > > > I do not see any Documentation/ABI/ entries for these new sysfs files,
> > > > > did I miss it somehow?  I can't take new sysfs code without
> > > > > documentation.
> > > >
> > > > All the ABI is documented in this patch, which is part of this set.
> > > >
> > > > [1]. https://lkml.org/lkml/2020/3/9/642
> > >
> > > That is not in the required Documentation/ABI/ form that all sysfs files
> > > should have.  If they don't, it's a bug.
> >
> > Now I'm very confused...  As far as I can tell Mike has followed the
> > (very loose) guidelines set out in the ABI documentation [1].  I have
> > also taken a look at the patches that were merged in the v5.5 cycle -
> > nothing is very different than what Mike has put together.  It is also
> > based on the work I did a while back [2] that you merged.
>
> {sigh}
>
> I churned through 1200+ patches yesterday to get caught up and I think I
> totally missed this, sorry.  Yes, that is the correct format, I was
> looking at the .rst files you added to this series and missed this API
> file instead.

That's understandable - I review patches for only 2 subsystems and I
get overwhelmed.

>
> Ugh, my fault.
>
> Can you just resend this whole series and I'll go through it again?

I'll address the issues we agree on over in the other thread and will respin.

Thanks,
Mathieu

>
> thanks,
>
> greg k-h
