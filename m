Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2A53C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 23:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF70A208E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 23:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jtPL3Q4G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgD2XCj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 19:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727114AbgD2XCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 19:02:37 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C01C035494
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 16:02:37 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id i68so3458939qtb.5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 16:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DDHXFao+dH7a6AcP6RfmuK8vFtcj0w+labONM9ZI/FE=;
        b=jtPL3Q4GL3DRINZX27a4KJwrnfGf/pfobWIcauTecfaGzF0ZQ1n4UEFjnrVVNqfAWe
         GcqWdT043UDjL8DBAe+y/YENFZAarqha+nTYLmZfa1V6fzUiBJxzS35/svJcBXkSfguo
         0MgDivqqXp9GPlJG1Ka86426LdUgiTUuAwlEE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DDHXFao+dH7a6AcP6RfmuK8vFtcj0w+labONM9ZI/FE=;
        b=MdX8LEBc45QDQ4cbzFC+mbWE74j6j2mmN1FMWZPkQEcxYKPPCV3vr+twOB57oBhdtI
         SVUac+Ed0KvTVJp+HJ8e2pNPwhnvitdcBrPo6vH7eC7u5EJgsi3O3MSVkv4ystkbGeZ4
         jWHRVei8akvk9gdC+oeuaJqdWfJVjiQ2K2Mk5lY2DIqurkyohDA1Jnu93OLbPSlG39oo
         VL7bkL+1HCtDY0eCX82In321RQd7Wo6QRl4mQRmRJbpRIaeVKRZkToELuRyeAi16jYYt
         wceS0ET1cXVW+0JMeZcEQy1n5G4ovK9yYDUGog9mQBrPuOFclfkVedokpYwCtV3MFLiC
         RfFA==
X-Gm-Message-State: AGi0PuZXz5+0lTTVxzIJV2FonhxuFIlNsihTxThW5mwlwqtH4k2K1Px8
        2Tuvo//43TT1m3uga0ZXjtZ0fDt7QRFjBM219ekN0/Y1
X-Google-Smtp-Source: APiQypJadZLXu2CS9GVmSkd/T7YtVd9vlz4SLC6YDlM4GFLGfq9DNs65gBsfxMDVa2DRweb6qKjJrgXZMuYET1bpYQU=
X-Received: by 2002:ac8:468b:: with SMTP id g11mr685135qto.141.1588201356174;
 Wed, 29 Apr 2020 16:02:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200422222242.241699-1-pmalani@chromium.org> <20200422222242.241699-2-pmalani@chromium.org>
 <12b56c9e-d8c7-82fa-57c8-7a33236ba188@collabora.com>
In-Reply-To: <12b56c9e-d8c7-82fa-57c8-7a33236ba188@collabora.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Wed, 29 Apr 2020 16:02:25 -0700
Message-ID: <CACeCKadOzR++ctpG52ZBZZewXFRz39crHotsTC9+MjSWBoE_Dg@mail.gmail.com>
Subject: Re: [PATCH 2/2] platform/chrome: typec: Register Type C switches
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Tim Wawrzynczak <twawrzynczak@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Guenter Roeck <groeck@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

Thanks for your review. Kindly see inline:

On Wed, Apr 29, 2020 at 3:22 PM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Prashant,
>
> Thank you for your patch.
>
> On 23/4/20 0:22, Prashant Malani wrote:
> > Register Type C mux and switch handles, when provided via firmware
> > bindings. These will allow the cros-ec-typec driver, and also alternate
> > mode drivers to configure connected Muxes correctly, according to PD
> > information retrieved from the Chrome OS EC.
> >
> > Signed-off-by: Prashant Malani <pmalani@chromium.org>
> > ---
> >  drivers/platform/chrome/cros_ec_typec.c | 47 +++++++++++++++++++++++++
> >  1 file changed, 47 insertions(+)
> >
> > diff --git a/drivers/platform/chrome/cros_ec_typec.c b/drivers/platform/chrome/cros_ec_typec.c
> > index eda57db26f8d..324ead297c4d 100644
> > --- a/drivers/platform/chrome/cros_ec_typec.c
> > +++ b/drivers/platform/chrome/cros_ec_typec.c
> > @@ -14,6 +14,8 @@
> >  #include <linux/platform_data/cros_usbpd_notify.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/usb/typec.h>
> > +#include <linux/usb/typec_mux.h>
> > +#include <linux/usb/role.h>
> >
> >  #define DRV_NAME "cros-ec-typec"
> >
> > @@ -25,6 +27,9 @@ struct cros_typec_port {
> >       struct typec_partner *partner;
> >       /* Port partner PD identity info. */
> >       struct usb_pd_identity p_identity;
> > +     struct typec_switch *ori_sw;
> > +     struct typec_mux *mux;
> > +     struct usb_role_switch *role_sw;
> >  };
> >
> >  /* Platform-specific data for the Chrome OS EC Type C controller. */
> > @@ -84,6 +89,40 @@ static int cros_typec_parse_port_props(struct typec_capability *cap,
> >       return 0;
> >  }
> >
> > +static int cros_typec_get_switch_handles(struct cros_typec_port *port,
> > +                                      struct fwnode_handle *fwnode,
> > +                                      struct device *dev)
> > +{
> > +     port->mux = fwnode_typec_mux_get(fwnode, NULL);
> > +     if (IS_ERR(port->mux)) {
>
> Should you return an error if NULL is returned (IS_ERR_OR_NULL) ? I think that
> fwnode_typec_mux_get can return NULL too.
I think returning NULL can be considered "not an error" for devices
that don't have kernel-controlled muxes (which won't have this
property defined).
So this check should be fine as is.
>
>
> > +             dev_info(dev, "Mux handle not found.\n");
> > +             goto mux_err;
> > +     }
> > +
> > +     port->ori_sw = fwnode_typec_switch_get(fwnode);
> > +     if (IS_ERR(port->ori_sw)) {
>
> ditto
>
> > +             dev_info(dev, "Orientation switch handle not found.\n");
> > +             goto ori_sw_err;
> > +     }
> > +
> > +     port->role_sw = fwnode_usb_role_switch_get(fwnode);
> > +     if (IS_ERR(port->role_sw)) {
>
> ditto
>
> > +             dev_info(dev, "USB role switch handle not found.\n");
> > +             goto role_sw_err;
> > +     }
> > +
> > +     return 0;
> > +
> > +role_sw_err:
> > +     usb_role_switch_put(port->role_sw);
> > +ori_sw_err:
> > +     typec_switch_put(port->ori_sw);
> > +mux_err:
> > +     typec_mux_put(port->mux);
> > +
> > +     return -ENODEV;
> > +}
> > +
> >  static void cros_unregister_ports(struct cros_typec_data *typec)
> >  {
> >       int i;
> > @@ -91,6 +130,9 @@ static void cros_unregister_ports(struct cros_typec_data *typec)
> >       for (i = 0; i < typec->num_ports; i++) {
> >               if (!typec->ports[i])
> >                       continue;
> > +             usb_role_switch_put(typec->ports[i]->role_sw);
> > +             typec_switch_put(typec->ports[i]->ori_sw);
> > +             typec_mux_put(typec->ports[i]->mux);
> >               typec_unregister_port(typec->ports[i]->port);
> >       }
> >  }
> > @@ -153,6 +195,11 @@ static int cros_typec_init_ports(struct cros_typec_data *typec)
> >                       ret = PTR_ERR(cros_port->port);
> >                       goto unregister_ports;
> >               }
> > +
> > +             ret = cros_typec_get_switch_handles(cros_port, fwnode, dev);
> > +             if (ret)
> > +                     dev_info(dev, "No switch control for port %d\n",
> > +                              port_num);
>
> When drivers are working, they should not spit out any messages, make
> this dev_dbg() at the most. Be quiet, please.
Ack. Will update this in the next version.
>
>
> >       }
> >
> >       return 0;
> >
