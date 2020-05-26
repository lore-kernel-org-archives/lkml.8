Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AADE4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:50:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7865E2070A
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 18:50:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I16pik1U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389070AbgEZSuA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 14:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388499AbgEZSuA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 14:50:00 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FCAC03E96D
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 11:50:00 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id y5so394023iob.12
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 11:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1Rp4xUS5EnFClzPQU/icIoCaObz0RQ1rswzJUiz+J1Y=;
        b=I16pik1UbGr3xSB2i671ggj6Kbtdvzlr6yyHptVNN6aJaICT/Pe2GMVrHJAO1yd75H
         B4IgdCJyLXDoxFQ28zQbJS9fiQU742HXjdeawwsU/G9h3N5h+FZDGPeFdj6uqnbLrRYl
         BwDYak/5EoP5slDNTN7Z6ATQDGUnZvC6SS4gE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1Rp4xUS5EnFClzPQU/icIoCaObz0RQ1rswzJUiz+J1Y=;
        b=B5ogFe99ioRBrS6E+4z1n0w/w05qz5s+I3bVkLCXRW4/OKp1OuaB1Ve6rq2AiWTJ/V
         onxOSw5cIEaKep4SpUcbNWUGIUM/TMaiDsIbieo0g07bd+5iu87UzkLdW3HAq/aB5anj
         ux/+RM+HIbsOW63rEQbHkHuyDTNvfs46xnqtPEWtwPc9CO8K+Aq1HfvkSpi+QjKn5U2j
         pqo2Tg5KlHX8m1D9upTgJtl5rkB8fHizdXY/u5LYYHAXnj4g0YJD6405omF5OQ4wBxjz
         wekosMfp9YBk4wk1hksc0FRlwFe/PbMNoLBD5x4jT2skM0F7203vzQmMkb9dlR8PN36s
         cFGA==
X-Gm-Message-State: AOAM530C/YGQkP4gEM1+WeS/41DwwyB+kVeQBAbVnfp3Z9qE+1NHb3Rj
        gKZ4H5Mq6P/hf5eZFWIIAULMtOInJUyXQQ5/wltlbbM/wsk=
X-Google-Smtp-Source: ABdhPJzgLm5KT3+bA098bJyOHMyTFOemRFwkmPh//ilJP3jE7KxeSp8sTWnmTOhyWTDMTzmfsfqinjgkAc2bsk3LNJw=
X-Received: by 2002:a02:6d0a:: with SMTP id m10mr2285354jac.133.1590518999430;
 Tue, 26 May 2020 11:49:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200521052832.66620-1-gwendal@chromium.org> <e83f3849-9e2d-4919-1a65-35f63eabe993@collabora.com>
In-Reply-To: <e83f3849-9e2d-4919-1a65-35f63eabe993@collabora.com>
From:   Gwendal Grignou <gwendal@chromium.org>
Date:   Tue, 26 May 2020 11:49:48 -0700
Message-ID: <CAPUE2ut37vnwT0hH+pCWVFRtMFX3v_qv+Zsq_OsM1i+SH95b6w@mail.gmail.com>
Subject: Re: [PATCH] platform: cros_ec_debugfs: control uptime information request
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Tim Wawrzynczak <twawrzynczak@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 2:21 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Gwendal,
>
> Thank you for your patch.
>
> On 21/5/20 7:28, Gwendal Grignou wrote:
> > When EC does not support uptime command (EC_CMD_GET_UPTIME_INFO),
> > return -EPROTO to read of /sys/kernel/debug/cros_ec/uptime without
> > calling the EC after the first try.
> >
> > The EC console log will not contain EC_CMD_GET_UPTIME_INFO anymore.
> >
>
> Oh, what you mean with this? Uptime is only exposed via sysfs or I am missing
> something.
I was checking the ec console log (via
/sys/kernel/debug/cros_ec/console_log) to check the EC was not
receiving and erroring on the command (pixelbook)
>
> > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > ---
> >  drivers/platform/chrome/cros_ec_debugfs.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
> > index 6ae484989d1f5..70a29afb6d9e7 100644
> > --- a/drivers/platform/chrome/cros_ec_debugfs.c
> > +++ b/drivers/platform/chrome/cros_ec_debugfs.c
> > @@ -49,6 +49,8 @@ struct cros_ec_debugfs {
> >       struct delayed_work log_poll_work;
> >       /* EC panicinfo */
> >       struct debugfs_blob_wrapper panicinfo_blob;
> > +     /* EC uptime */
> > +     bool uptime_supported;
>
> Ideally, if uptime can be supported or not we should only expose uptime when is
> supported, so the sysfs entry should only be created when is supported, similar
> to what we do with the console_log. See cros_ec_create_console_log()
>
> If doing this doesn't break userspace, I'd prefer doing in that way.
Good point, sending a v2.

Gwendal.
>
> Thanks,
>  Enric
>
>
> >  };
> >
> >  /*
> > @@ -256,12 +258,19 @@ static ssize_t cros_ec_uptime_read(struct file *file, char __user *user_buf,
> >       char read_buf[32];
> >       int ret;
> >
> > +     if (!debug_info->uptime_supported)
> > +             return -EPROTO;
> > +
> >       resp = (struct ec_response_uptime_info *)&msg.resp;
> >
> >       msg.cmd.command = EC_CMD_GET_UPTIME_INFO;
> >       msg.cmd.insize = sizeof(*resp);
> >
> >       ret = cros_ec_cmd_xfer_status(ec_dev, &msg.cmd);
> > +     if (ret == -EPROTO && msg.cmd.result == EC_RES_INVALID_COMMAND) {
> > +             debug_info->uptime_supported = false;
> > +             return ret;
> > +     }
> >       if (ret < 0)
> >               return ret;
> >
> > @@ -434,6 +443,9 @@ static int cros_ec_debugfs_probe(struct platform_device *pd)
> >       debug_info->ec = ec;
> >       debug_info->dir = debugfs_create_dir(name, NULL);
> >
> > +     /* Give uptime a chance to run. */
> > +     debug_info->uptime_supported = true;
> > +
> >       ret = cros_ec_create_panicinfo(debug_info);
> >       if (ret)
> >               goto remove_debugfs;
> >
