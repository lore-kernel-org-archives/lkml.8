Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4F63C4BA26
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 19:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703AB222C4
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 19:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zd+gzvc9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgBZT7a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 14:59:30 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:44744 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727244AbgBZT7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 14:59:30 -0500
Received: by mail-vk1-f193.google.com with SMTP id x62so37191vkg.11
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 11:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RiyxAO8fOvzKXN143+bw+JynZU//eF4zHR9EjbKKDdA=;
        b=Zd+gzvc9OlxkHjdueJS9iD5Ab/3XcwVlIZ9+kZPT4Fuda9RaSkhdCV1ikvJdDLcwLs
         1RLJeIhfiH7nn4cDUuglZgibYUfCgO8OFw1xwfZLJbghSYsuMUDKO/TCgJcOnjcrieUq
         lNW1/aNGcvvP6OvJhESnVCJB0iZAf5jIYMFn4sGiAtVThp/bmnQxB5QGsmChtsAPzI14
         U/dXUh1RZgdn5BTEf4KmZh1/g7kG21kL3uygkFxCtJ/fQ4CZ0oGq02kkWFoO3wgYzymt
         nPZ2zBGA95Zt6XcuC5HnsyURcJP1sZRcuDDD/E7ksHSXBYLZmA/dgdkun/MhbholonCQ
         o6IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RiyxAO8fOvzKXN143+bw+JynZU//eF4zHR9EjbKKDdA=;
        b=juGFNMftmOjTqvKWW2yXRwwkU5JPcHdEsCi5v/mKiYa4vje8o1G2O0osUvSv8z9XEU
         CQoT3D0V7n/+RLgWgHzHITuZXFPumWI3ySz3ZAHgcwGF+nzOLOZpZ4UWUKk2Hn+bxru9
         Wm9X7nk3k1dzo5D8vy6nPfH+MkKUvB/OwZs0mRgsMQA00sCk1PdyYWxfo1Vop6YmLmyy
         d60rCyWGI1nIGVSxUewtnjMpr/EXWlUcOo4w4HIVcN3FG+fktr1QxdJSIvOV/gfpPhfo
         vpBYvGYYnf/sxeqB24juGw/w3ehSzodx00w82/jHAiPuuIA6BUXfTSMJXpBnPLccon2g
         F+Yg==
X-Gm-Message-State: APjAAAVrfWYhzLjF7U8nOf/iyoYYSHjclDxZsZFMBnpr+sPe/t0BeA3b
        dRRBhbSuZBmOtbEW7RnfBRGBieJv9rKbFrBCgQFk1ukl
X-Google-Smtp-Source: APXvYqyIqz4WY60UwINXBJ7Mi98FAqGLiEouCxoth8AP8ZPjsezsT66gZTah4xhObwuW1zWMGW/2ZrFomwEa7IZCB7Q=
X-Received: by 2002:ac5:c807:: with SMTP id y7mr550790vkl.92.1582747168397;
 Wed, 26 Feb 2020 11:59:28 -0800 (PST)
MIME-Version: 1.0
References: <20200226182517.49214-1-badhri@google.com> <20200226183157.GA16309@roeck-us.net>
In-Reply-To: <20200226183157.GA16309@roeck-us.net>
From:   Badhri Jagan Sridharan <badhri@google.com>
Date:   Wed, 26 Feb 2020 11:58:52 -0800
Message-ID: <CAPTae5KS_Gpn0SJt8mSVLtbApCTwyTH0FiYWEurg_TUCEs2Lew@mail.gmail.com>
Subject: Re: [PATCH v3] usb: typec: Add sysfs node to show cc orientation
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        USB <linux-usb@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Puma Hsu <pumahsu@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Geunter ! Sure ! Updated the patch.

On Wed, Feb 26, 2020 at 10:32 AM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Wed, Feb 26, 2020 at 10:25:17AM -0800, Badhri Jagan Sridharan wrote:
> > Export Type-C orientation information when available.
> > - "normal": CC1 orientation
> > - "reverse": CC2 orientation
> > - "unknown": Orientation cannot be determined.
> >
> > Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
> > ---
> > Version history:
> > V3:
> > - Heikki's suggestion to us .is_visible callback.
> >   unsigned int orientation_aware:1 has been introduced to
> >   make support of this attribute optional for drivers such
> >   as UCSI
> > - Guenter's suggestion to rename to "orientation".
> > - Heikki's suggestion to stick with string values instead
> >   of exposing it as integer values.
> > ---
> >  Documentation/ABI/testing/sysfs-class-typec |  9 +++++++
> >  drivers/usb/typec/class.c                   | 27 +++++++++++++++++++++
> >  drivers/usb/typec/tcpm/tcpm.c               |  1 +
> >  include/linux/usb/typec.h                   |  1 +
> >  4 files changed, 38 insertions(+)
> >
> > diff --git a/Documentation/ABI/testing/sysfs-class-typec b/Documentation/ABI/testing/sysfs-class-typec
> > index 0c2eb26fdc06b..b834671522d6f 100644
> > --- a/Documentation/ABI/testing/sysfs-class-typec
> > +++ b/Documentation/ABI/testing/sysfs-class-typec
> > @@ -108,6 +108,15 @@ Contact: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> >  Description:
> >               Revision number of the supported USB Type-C specification.
> >
> > +What:                /sys/class/typec/<port>/orientation
> > +Date:                February 2020
> > +Contact:     Badhri Jagan Sridharan <badhri@google.com>
> > +Description:
> > +             Indicates the active orientation of the Type-C connector.
> > +             Valid values:
> > +             - "normal": CC1 orientation
> > +             - "reverse": CC2 orientation
> > +             - "unknown": Orientation cannot be determined.
> >
> >  USB Type-C partner devices (eg. /sys/class/typec/port0-partner/)
> >
> > diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
> > index 12be5bb6d32ca..2524f1571e425 100644
> > --- a/drivers/usb/typec/class.c
> > +++ b/drivers/usb/typec/class.c
> > @@ -1244,6 +1244,26 @@ static ssize_t usb_power_delivery_revision_show(struct device *dev,
> >  }
> >  static DEVICE_ATTR_RO(usb_power_delivery_revision);
> >
> > +static ssize_t orientation_show(struct device *dev,
> > +                                struct device_attribute *attr,
> > +                                char *buf)
> > +{
> > +     struct typec_port *p = to_typec_port(dev);
> > +     enum typec_orientation orientation = typec_get_orientation(p);
> > +
> > +     switch (orientation) {
> > +     case TYPEC_ORIENTATION_NONE:
> > +             return sprintf(buf, "%s\n", "unknown");
> > +     case TYPEC_ORIENTATION_NORMAL:
> > +             return sprintf(buf, "%s\n", "normal");
> > +     case TYPEC_ORIENTATION_REVERSE:
> > +             return sprintf(buf, "%s\n", "reverse");
> > +     default:
> > +             return sprintf(buf, "%s\n", "unknown");
>
> TYPEC_ORIENTATION_NONE and default can be handled in a single case statement.
>
> > +     }
> > +}
> > +static DEVICE_ATTR_RO(orientation);
> > +
> >  static struct attribute *typec_attrs[] = {
> >       &dev_attr_data_role.attr,
> >       &dev_attr_power_operation_mode.attr,
> > @@ -1254,6 +1274,7 @@ static struct attribute *typec_attrs[] = {
> >       &dev_attr_usb_typec_revision.attr,
> >       &dev_attr_vconn_source.attr,
> >       &dev_attr_port_type.attr,
> > +     &dev_attr_orientation.attr,
> >       NULL,
> >  };
> >
> > @@ -1283,6 +1304,10 @@ static umode_t typec_attr_is_visible(struct kobject *kobj,
> >                       return 0;
> >               if (port->cap->type != TYPEC_PORT_DRP)
> >                       return 0444;
> > +     } else if (attr == &dev_attr_orientation.attr) {
> > +             if (port->cap->orientation_aware)
> > +                     return 0444;
> > +             return 0;
> >       }
> >
> >       return attr->mode;
> > @@ -1493,6 +1518,8 @@ int typec_set_orientation(struct typec_port *port,
> >       }
> >
> >       port->orientation = orientation;
> > +     sysfs_notify(&port->dev.kobj, NULL, "orientation");
> > +     kobject_uevent(&port->dev.kobj, KOBJ_CHANGE);
> >
> >       return 0;
> >  }
> > diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
> > index 78077c234ef27..bc0032a6b9a14 100644
> > --- a/drivers/usb/typec/tcpm/tcpm.c
> > +++ b/drivers/usb/typec/tcpm/tcpm.c
> > @@ -4742,6 +4742,7 @@ struct tcpm_port *tcpm_register_port(struct device *dev, struct tcpc_dev *tcpc)
> >       port->typec_caps.pd_revision = 0x0300;  /* USB-PD spec release 3.0 */
> >       port->typec_caps.driver_data = port;
> >       port->typec_caps.ops = &tcpm_ops;
> > +     port->typec_caps.orientation_aware = 1;
> >
> >       port->partner_desc.identity = &port->partner_ident;
> >       port->port_type = port->typec_caps.type;
> > diff --git a/include/linux/usb/typec.h b/include/linux/usb/typec.h
> > index 44d28387ced48..b00a2642a9cd6 100644
> > --- a/include/linux/usb/typec.h
> > +++ b/include/linux/usb/typec.h
> > @@ -211,6 +211,7 @@ struct typec_capability {
> >       u16                     pd_revision; /* 0300H = "3.0" */
> >       int                     prefer_role;
> >       enum typec_accessory    accessory[TYPEC_MAX_ACCESSORY];
> > +     unsigned int            orientation_aware:1;
> >
> >       struct fwnode_handle    *fwnode;
> >       void                    *driver_data;
> > --
> > 2.25.0.265.gbab2e86ba0-goog
> >
