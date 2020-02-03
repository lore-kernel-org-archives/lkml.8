Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0429AC35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:24:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A532082E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 18:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Fmx475x4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729007AbgBCSYg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 13:24:36 -0500
Received: from mail-qv1-f65.google.com ([209.85.219.65]:43375 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727924AbgBCSYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 13:24:35 -0500
Received: by mail-qv1-f65.google.com with SMTP id p2so7242111qvo.10
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 10:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i3R4djKifwhxC8DKPa9MV9umaXkZvBl9B/6d7cIsXfo=;
        b=Fmx475x4gQ78/b+g8gvjFVtwdEZuWDf6c0spl6RhZMLQfUNwZPi3sn0Zg96IQjKrhy
         fjCqd/jYBg+63WK0pwkxid3NIkL7w8JLctBn0dzPdTu5ZNrhPnuvCWsOHfjNQmSAGsjq
         6/BZgczP5mmxdijQvfvgQnV3j39ztjPMRmmag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i3R4djKifwhxC8DKPa9MV9umaXkZvBl9B/6d7cIsXfo=;
        b=qlATnn11/eWPKR/N615kMoW5DrcW2QGzYpGdtBiH7wiXf7PoIj7VJF49SLBO6xFu15
         TEbjiBTQhoUh3gOGqHfmfuQK/USK31gDp4fDK7H7wM3tl0iVS0/uSV057Sue1MorOEwW
         YBzLzQ7iEWK/PmujysNyfjA4F/zThRdcfN/XGEsdjwkWC47q/3rY3h0o0eAfEIVjVYnB
         JnPlM/UZCFIXsoc3VAmJfMUvdvwxuy5CVocfHry83OyM0je17BVvsFmou6+1pDB1xatX
         10l23atO6A2f+VpS/c2vig87+v+BLXtNYjIWQgZPEyfqvCaJ7l15nESJbBzykHwnIlF7
         oi0w==
X-Gm-Message-State: APjAAAVOwOEe8zt7ADvcsfX/H8VkfHvZEr7yJhHGq8Q/crhVw2WmXPHt
        SFy8p4VCi9tbw60V278ly4MjEh2S5xZGZKCVVwoD1Q==
X-Google-Smtp-Source: APXvYqzA+HmdJRGigKaT/mdLyTKVklJRmaM6/8LF7N61E4A9BrgtiqYIlhJSJbOh2fqynLXUD6UEbVRst2r7wg6ITq4=
X-Received: by 2002:ad4:4e73:: with SMTP id ec19mr23183160qvb.78.1580754274234;
 Mon, 03 Feb 2020 10:24:34 -0800 (PST)
MIME-Version: 1.0
References: <20200130203106.201894-1-pmalani@chromium.org> <20200130203106.201894-2-pmalani@chromium.org>
 <86fb1f07-7677-52e6-024e-48528d5093b2@collabora.com>
In-Reply-To: <86fb1f07-7677-52e6-024e-48528d5093b2@collabora.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Mon, 3 Feb 2020 10:24:23 -0800
Message-ID: <CACeCKafy_4jDWgOH9B6nuc1LCrOT0VVJWAmPTgwYaKV59UMhuA@mail.gmail.com>
Subject: Re: [PATCH 01/17] platform/chrome: Add EC command msg wrapper
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Evan Green <evgreen@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 3, 2020 at 7:27 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Prashant,
>
> Many thanks to work on this. Some comments below ...

> >  #include <linux/platform_data/cros_ec_commands.h>
> >  #include <linux/platform_data/cros_ec_proto.h>
> > @@ -570,6 +571,62 @@ int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
> >  }
> >  EXPORT_SYMBOL(cros_ec_cmd_xfer_status);
> >
> > +/**
> > + * cros_ec_send_cmd_msg() - Utility function to send commands to ChromeOS EC.
>
> I'm wondering if just cros_ec_cmd() shouldn't be a better name. If it's a
> replacement of current user usage of cros_ec_cmd_xfer and
> cros_ec_cmd_xfer_status, this will be used a lot, and have a short name and
> clear will help the users of this helper.
Sounds good. I think in another patch (13/17) there is a point about
how it's tough to get rid of cros_ec_cmd_xfer() without non-trivial
rework to a few drivers, but cros_ec_cmd() is certainly more concise.

>
> > + * @ec: EC device struct.
> > + * @version: Command version number (often 0).
> > + * @command: Command ID including offset.
> > + * @outdata: Data to be sent to the EC.
> > + * @outsize: Size of the &outdata buffer.
> > + * @indata: Data to be received from the EC.
> > + * @insize: Size of the &indata buffer.
> > + *
> > + * This function is a wrapper around &cros_ec_cmd_xfer_status, and performs
>
> You say that is a wrapper around cros_ec_cmd_xfer_status but then you remove
> that function, and rewrite the doc here. Just explain for what is this helper
> without referencing cros_ec_cmd_xfer_status and cros_ec_cmd_xfer.
My apologies, I should have edited it to say cros_ec_cmd_xfer()
instead of _status().
I'll update the documentation to just avoid the two altogether.

>
> > + * some of the common work involved with sending a command to the EC. This
> > + * includes allocating and filling up a &struct cros_ec_command message buffer,
> > + * and copying the received data to another buffer.
> > + *
> > + * Return: The number of bytes transferred on success or negative error code.
> > + */
> > +int cros_ec_send_cmd_msg(struct cros_ec_device *ec, unsigned int version,
> > +                      unsigned int command, void *outdata,
> > +                      unsigned int outsize, void *indata,
> > +                      unsigned int insize)
>
> Should we change the parameter types from "unsigned int" to "u32" to match both
> ec hardware and the storage type in struct cros_ec_command?
Sounds good. I will make the change.
>
> > +{
> > +     struct cros_ec_command *msg;
> > +     int ret;
> > +
> > +     msg = kzalloc(sizeof(*msg) + max(outsize, insize), GFP_KERNEL);
> > +     if (!msg)
> > +             return -ENOMEM;
> > +
> > +     msg->version = version;
> > +     msg->command = command;
> > +     msg->outsize = outsize;
> > +     msg->insize = insize;
> > +
> > +     if (outdata && outsize > 0)
> > +             memcpy(msg->data, outdata, outsize);
> > +
> > +     ret = cros_ec_cmd_xfer(ec, msg);
> > +     if (ret < 0) {
> > +             dev_err(ec->dev, "Command xfer error (err:%d)\n", ret);
> > +             goto cleanup;
> > +     } else if (msg->result != EC_RES_SUCCESS) {
> > +             dev_dbg(ec->dev, "Command result (err: %d)\n", msg->result);
> > +             ret = -EPROTO;
> > +             goto cleanup;
> > +     }
> > +
> > +     if (insize)
> > +             memcpy(indata, msg->data, insize);
> > +
> > +cleanup:
> > +     kfree(msg);
> > +     return ret;
> > +}
> > +EXPORT_SYMBOL(cros_ec_send_cmd_msg);
> > +
> >  static int get_next_event_xfer(struct cros_ec_device *ec_dev,
> >                              struct cros_ec_command *msg,
> >                              struct ec_response_get_next_event_v1 *event,
> > diff --git a/include/linux/platform_data/cros_ec_proto.h b/include/linux/platform_data/cros_ec_proto.h
> > index 30098a5515231d..166ce26bdd79eb 100644
> > --- a/include/linux/platform_data/cros_ec_proto.h
> > +++ b/include/linux/platform_data/cros_ec_proto.h
> > @@ -201,6 +201,11 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
> >  int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
> >                           struct cros_ec_command *msg);
> >
> > +int cros_ec_send_cmd_msg(struct cros_ec_device *ec_dev, unsigned int version,
> > +                      unsigned int command, void *outdata,
> > +                      unsigned int outsize, void *indata,
> > +                      unsigned int insize);
> > +
> >  int cros_ec_register(struct cros_ec_device *ec_dev);
> >
> >  int cros_ec_unregister(struct cros_ec_device *ec_dev);
> >
