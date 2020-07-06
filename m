Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6014BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 20:07:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32ADA206B6
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 20:07:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cuPtkJba"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbgGFUHz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 16:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgGFUHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 16:07:55 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E64DC061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 13:07:55 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id u8so17807085qvj.12
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 13:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WxzYL3dtx1zZhE+eRZlLjbwpIDVIPj8EL53YBYdx0TI=;
        b=cuPtkJbaS39CURKAqpISO45og9V35Wm8LvNFovTPQXECcB/wRJKfWkj8laPXGy6twl
         zp8M7LibaxgtspVjZB7kR0moa5dlodTBbW069rxuX3ng7a7XtVE0kjKDvPIGW8FvHNHI
         yBbIuhNeMAq40Yj/j1LKFwPWfLW6eDYPwJBWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WxzYL3dtx1zZhE+eRZlLjbwpIDVIPj8EL53YBYdx0TI=;
        b=A8AjvM68OFjqcYJ0QyUNDTkShBkoJFqdIBnUtY9+5j8rwJYPx6bakNFuwUiTZFbkCr
         KuTepolGaeiqmhRLnJ6Zo7M3hNxfK7i7JS0vCSSMhKw7CfteIgiF+lFx7BQ/Ubmkgnmu
         vSd5Os5PF40xohg5Qit/x4iVF+bgQLfVfyrV9XbOQbHbQ7UPspnTRhbfe16muPbJbI0H
         geL8ELul7+9OwZbo4d9rDZKAGnQEpkgW5TwplhBqDI6Ion+7eT7rVr/tFedurncfBOiD
         bqlwlZY6ZqGk2K4FcSneLG2WoD7C2cuPb5Vr6hOfqIdMsWqGNB+xs6eT8GQHi6OJH5VL
         A8Rg==
X-Gm-Message-State: AOAM531abJez6Hjeg2lDZmAV03IRejk6k/az0mtvyQZAXeDZ1ftd29PD
        DzM1PtbU4+M/rkoX/2fXYavq38oGjOPbfgGdxGQUgg==
X-Google-Smtp-Source: ABdhPJx+GkC86LHajgKBMCmAEAcQ4s60gsju8Yj9ox3fC0QHxw7eLh8UqWqA3W6xZom/ImNXa6fymbnHkRWAIhwfjwY=
X-Received: by 2002:a0c:a8e6:: with SMTP id h38mr42900484qvc.15.1594066074183;
 Mon, 06 Jul 2020 13:07:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200704142607.171400-1-linux@roeck-us.net> <20200706185230.GA792857@google.com>
 <20200706194120.GB180826@roeck-us.net>
In-Reply-To: <20200706194120.GB180826@roeck-us.net>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Mon, 6 Jul 2020 13:07:43 -0700
Message-ID: <CACeCKadx5vmqT9dnTTr49T3s-ZG1h3YnKZRvFVB4vrUhnD2faw@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec_proto: Convert EC error codes to
 Linux error codes
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Yu-Hsuan Hsu <yuhsuan@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 6, 2020 at 12:41 PM Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Mon, Jul 06, 2020 at 11:52:30AM -0700, Prashant Malani wrote:
> > Hi Guenter,
> >
> > On Sat, Jul 04, 2020 at 07:26:07AM -0700, Guenter Roeck wrote:
> > > The EC reports a variety of error codes. Most of those, with the exception
> > > of EC_RES_INVALID_VERSION, are converted to -EPROTO. As result, the actual
> > > error code gets lost. Convert all EC errors to Linux error codes to report
> > > a more meaningful error to the caller to aid debugging.
> > >
> > > Cc: Yu-Hsuan Hsu <yuhsuan@chromium.org>
> > > Cc: Prashant Malani <pmalani@chromium.org>
> > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > ---
> > >  drivers/platform/chrome/cros_ec_proto.c | 37 +++++++++++++++++++------
> > >  1 file changed, 29 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> > > index 3e745e0fe092..10aa9e483d35 100644
> > > --- a/drivers/platform/chrome/cros_ec_proto.c
> > > +++ b/drivers/platform/chrome/cros_ec_proto.c
> > > @@ -543,6 +543,29 @@ int cros_ec_cmd_xfer(struct cros_ec_device *ec_dev,
> > >  }
> > >  EXPORT_SYMBOL(cros_ec_cmd_xfer);
> > >
> > > +static const int cros_ec_error_map[] = {
> > > +   [EC_RES_INVALID_COMMAND] = -EOPNOTSUPP,
> > > +   [EC_RES_ERROR] = -EIO,
> > > +   [EC_RES_INVALID_PARAM] = -EINVAL,
> > > +   [EC_RES_ACCESS_DENIED] = -EACCES,
> > > +   [EC_RES_INVALID_RESPONSE] = -EPROTO,
> > > +   [EC_RES_INVALID_VERSION] = -ENOTSUPP,
> > > +   [EC_RES_INVALID_CHECKSUM] = -EBADMSG,
> > > +   [EC_RES_IN_PROGRESS] = -EINPROGRESS,
> > > +   [EC_RES_UNAVAILABLE] = -ENODATA,
> > > +   [EC_RES_TIMEOUT] = -ETIMEDOUT,
> > > +   [EC_RES_OVERFLOW] = -EOVERFLOW,
> > > +   [EC_RES_INVALID_HEADER] = -EBADR,
> > > +   [EC_RES_REQUEST_TRUNCATED] = -EBADR,
> > > +   [EC_RES_RESPONSE_TOO_BIG] = -EFBIG,
> > > +   [EC_RES_BUS_ERROR] = -EFAULT,
> > > +   [EC_RES_BUSY] = -EBUSY,
> > > +   [EC_RES_INVALID_HEADER_VERSION] = -EBADMSG,
> > > +   [EC_RES_INVALID_HEADER_CRC] = -EBADMSG,
> > > +   [EC_RES_INVALID_DATA_CRC] = -EBADMSG,
> > > +   [EC_RES_DUP_UNAVAILABLE] = -ENODATA,
> > > +};
> > > +
> > >  /**
> > >   * cros_ec_cmd_xfer_status() - Send a command to the ChromeOS EC.
> > >   * @ec_dev: EC device.
> > > @@ -555,8 +578,7 @@ EXPORT_SYMBOL(cros_ec_cmd_xfer);
> > >   *
> > >   * Return:
> > >   * >=0 - The number of bytes transferred
> > > - * -ENOTSUPP - Operation not supported
> > > - * -EPROTO - Protocol error
> > > + * <0 - Linux error code
> > >   */
> > >  int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
> > >                         struct cros_ec_command *msg)
> > > @@ -566,13 +588,12 @@ int cros_ec_cmd_xfer_status(struct cros_ec_device *ec_dev,
> > >     ret = cros_ec_cmd_xfer(ec_dev, msg);
> > >     if (ret < 0) {
> > >             dev_err(ec_dev->dev, "Command xfer error (err:%d)\n", ret);
> > > -   } else if (msg->result == EC_RES_INVALID_VERSION) {
> > > -           dev_dbg(ec_dev->dev, "Command invalid version (err:%d)\n",
> > > -                   msg->result);
> > > -           return -ENOTSUPP;
> > >     } else if (msg->result != EC_RES_SUCCESS) {
> > > -           dev_dbg(ec_dev->dev, "Command result (err: %d)\n", msg->result);
> > > -           return -EPROTO;
> > > +           if (msg->result < ARRAY_SIZE(cros_ec_error_map) && cros_ec_error_map[msg->result])
> >
> > Do we expect a case where cros_ec_error_map[msg->result] == 0?
> >
>
> It seemed to be prudent to assume that this code is not going to be
> updated whenever a new EC error code is added. Doing nothing would
> risk returning 0, and addding WARN_ON or dev_warn seemed excessive.
> Having said that, I don't really have a strong opinion one way
> or another, and I'll be happy to change the code to whatever people
> think is appropriate.

Thanks for providing the rationale. I think if a new EC error code is
added (and this array isn't updated),
msg->result < ARRAY_SIZE(cros_ec_error_map) would return false, and
the code block would return -EPROTO.

I'll defer to the maintainer's opinion(s), but I think we can remove
the condition after '&&'.

Best regards,

>
> Thanks,
> Guenter
