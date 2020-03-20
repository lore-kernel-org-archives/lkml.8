Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AB90C4332E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 20:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A5B720409
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 20:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tkGRj8xZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726979AbgCTUqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 16:46:19 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41523 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbgCTUqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 16:46:18 -0400
Received: by mail-ed1-f66.google.com with SMTP id v6so8704458edw.8
        for <linux-kernel@vger.kernel.org>; Fri, 20 Mar 2020 13:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/PDiCfVzJR6fbRiqtmPfVAOBY9XV5yzFUyxAY7cQmzw=;
        b=tkGRj8xZJfs2RvgR+4qOK2ziAbf0K6kdOl8ufOPd6164iOO08RbnkY7zFwFfC3DsgM
         ldbMShmk4xhjfhZ8hFfbAKecG+uVtemC5hiXQEC2CVKkOG5y/ad8GOsZnvREFECLGHvX
         smJ1VwBSRYmRXtodlcQNTHsGW9K7BVYEV3f5tZY7Ra5pBpzwfl8BF8s21cztiSBlqRlW
         Fl8uqP9x9Bc+Pdcs6PeZNoqCIkVbSXtmJuJcX4cCJ+4I6Jofbr/X5Iq0lyKwy0ctFq6F
         cd3a+m89Xx+8tIWMhwlTBJ+q1Kwc4mvgC0uInHJKdIAHFSgzBSSoMJoD4hAXMbUbA10R
         bT7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/PDiCfVzJR6fbRiqtmPfVAOBY9XV5yzFUyxAY7cQmzw=;
        b=kbWIkGerIi/RKtp1Z/2NQaea/Th1F/EB5LHvfLdi4EkrJ0FsK9AP1HT/B3NYbURoHu
         Bjss2a2iHjxztoofCtfjSzfGcx9q7LgswsjFEWDxkvtXZwZy91XEa19g+1ee2rQSCmso
         4vH7e+UeaEOfhmmRkPpxbknZeHxwmkqUwpcfStN4t9J5fQOYQCGaIXPCePsO+qNgxawI
         Fes46QpCC9vfmzL4ybqLBD+kTb1gx7UJSbZvawo6yI0cDiK+FJ0UPZJfCLFcZyHWegpn
         HpdKct+jDLHIQb2W897sL4nF0oVpQynx8xyZB4wmieU6OlBFtlx0yryijcAvKcw/Sqg4
         QmSA==
X-Gm-Message-State: ANhLgQ2BR4U9VRHysAyZk9aEKPsWYMZeTurFqRdq+TGspSR3VHwTTyZY
        kaAD6i5tmyFoogN9NCLTAG80NH5az9j7YUkNlsgswA==
X-Google-Smtp-Source: ADFU+vtNahf1ktCk9uXI6lwbWpCy1CyBcl/mn73xmDSWeKU/+hJQIqGxgwfvUbpvn3jz2flPR1KB+RMwMge5xFhjAxk=
X-Received: by 2002:a17:906:7e51:: with SMTP id z17mr9972500ejr.373.1584737175024;
 Fri, 20 Mar 2020 13:46:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200320175910.180266-1-yonghyun@google.com> <20200320123425.49c6568e@w520.home>
In-Reply-To: <20200320123425.49c6568e@w520.home>
From:   Yonghyun Hwang <yonghyun@google.com>
Date:   Fri, 20 Mar 2020 13:46:04 -0700
Message-ID: <CAEauFbx1Su7Lg5kdxXnvUwfwLCH67qaGB6EZ7g3OOH-tbRfBBA@mail.gmail.com>
Subject: Re: [PATCH] vfio-mdev: support mediated device creation in kernel
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     Kirti Wankhede <kwankhede@nvidia.com>,
        Cornelia Huck <cohuck@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Havard Skinnemoen <hskinnemoen@google.com>,
        Moritz Fischer <mdf@kernel.org>,
        Joshua Lang <joshualang@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 20, 2020 at 11:34 AM Alex Williamson
<alex.williamson@redhat.com> wrote:
>
> On Fri, 20 Mar 2020 10:59:10 -0700
> Yonghyun Hwang <yonghyun@google.com> wrote:
>
> > To enable a mediated device, a device driver registers its device to VFIO
> > MDev framework. Once the mediated device gets enabled, UUID gets fed onto
> > the sysfs attribute, "create", to create the mediated device. This
> > additional step happens after boot-up gets complete. If the driver knows
> > how many mediated devices need to be created during probing time, the
> > additional step becomes cumbersome. This commit implements a new function
> > to allow the driver to create a mediated device in kernel.
>
> But pre-creating mdev devices seems like a policy decision.  Why can't
> userspace make such a policy decision, and do so with persistent uuids,
> via something like mdevctl?  Thanks,
>
> Alex

Yep, it can be viewed as the policy decision and userspace can make
the decision. However, it would be handy and plausible, if a device
driver can pre-create "fixed or default" # of mdev devices, while
allowing the device policy to come into play after bootup gets
complete. Without this patch, a device driver should release the
policy and the policy should be aligned with the driver, which would
be cumbersome (sometimes painful) in a cloud environment. My use case
with mdev is to enable a subset of vfio-pci features without losing my
device driver.

Thank you,
Yonghyun


>
>
> > Signed-off-by: Yonghyun Hwang <yonghyun@google.com>
> > ---
> >  drivers/vfio/mdev/mdev_core.c | 45 +++++++++++++++++++++++++++++++++++
> >  include/linux/mdev.h          |  3 +++
> >  2 files changed, 48 insertions(+)
> >
> > diff --git a/drivers/vfio/mdev/mdev_core.c b/drivers/vfio/mdev/mdev_core.c
> > index b558d4cfd082..a6d32516de42 100644
> > --- a/drivers/vfio/mdev/mdev_core.c
> > +++ b/drivers/vfio/mdev/mdev_core.c
> > @@ -350,6 +350,51 @@ int mdev_device_create(struct kobject *kobj,
> >       return ret;
> >  }
> >
> > +/*
> > + * mdev_create_device : Create a mdev device
> > + * @dev: device structure representing parent device.
> > + * @uuid: uuid char string for a mdev device.
> > + * @group: index to supported type groups for a mdev device.
> > + *
> > + * Create a mdev device in kernel.
> > + * Returns a negative value on error, otherwise 0.
> > + */
> > +int mdev_create_device(struct device *dev,
> > +                     const char *uuid, int group)
> > +{
> > +     struct mdev_parent *parent = NULL;
> > +     struct mdev_type *type = NULL;
> > +     guid_t guid;
> > +     int i = 1;
> > +     int ret;
> > +
> > +     ret = guid_parse(uuid, &guid);
> > +     if (ret) {
> > +             dev_err(dev, "Failed to parse UUID");
> > +             return ret;
> > +     }
> > +
> > +     parent = __find_parent_device(dev);
> > +     if (!parent) {
> > +             dev_err(dev, "Failed to find parent mdev device");
> > +             return -ENODEV;
> > +     }
> > +
> > +     list_for_each_entry(type, &parent->type_list, next) {
> > +             if (i == group)
> > +                     break;
> > +             i++;
> > +     }
> > +
> > +     if (!type || i != group) {
> > +             dev_err(dev, "Failed to find mdev device");
> > +             return -ENODEV;
> > +     }
> > +
> > +     return mdev_device_create(&type->kobj, parent->dev, &guid);
> > +}
> > +EXPORT_SYMBOL(mdev_create_device);
> > +
> >  int mdev_device_remove(struct device *dev)
> >  {
> >       struct mdev_device *mdev, *tmp;
> > diff --git a/include/linux/mdev.h b/include/linux/mdev.h
> > index 0ce30ca78db0..b66f67998916 100644
> > --- a/include/linux/mdev.h
> > +++ b/include/linux/mdev.h
> > @@ -145,4 +145,7 @@ struct device *mdev_parent_dev(struct mdev_device *mdev);
> >  struct device *mdev_dev(struct mdev_device *mdev);
> >  struct mdev_device *mdev_from_dev(struct device *dev);
> >
> > +extern int mdev_create_device(struct device *dev,
> > +                     const char *uuid, int group_idx);
> > +
> >  #endif /* MDEV_H */
>
