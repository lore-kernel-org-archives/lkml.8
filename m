Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9955C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 20:07:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABB5C20637
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 20:07:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eJSDXtxz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgCWUHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 16:07:05 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37665 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgCWUHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 16:07:05 -0400
Received: by mail-wm1-f67.google.com with SMTP id d1so997974wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Mar 2020 13:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5WiRAMnvFissAlOT1YjcrzmBmUjG0ccc8lAc8bMs2nc=;
        b=eJSDXtxzZXqZVLJ7iLFvQKQIGT5Z5MKeRdjR2U1SDKWo/A7zLTEFqu8YUSlDUuIsWH
         ucWHXS+AgYJCXRByKz7Z4lb/oCDwD9JYbBnje4nndfo0nxly6+tUXktMmqbHlgv23l3y
         BNKGuA0NU/+S3+sPK8umJg0I1ZHQhYh9lGmbNA1ISEzXvdczBteydXKji9c3SpOGlB9t
         WoWD5gsQME4PpX1sRSLMO18TT1IuC5bSMU91otU4V5dVXFzu7hphkr2o3X+sack31rWz
         UrFxAWRaDRliZKWI0Tf3Vj7yQW6U52DdMk/UpTy/dZ35hIvC8Hf1RQTcVV6LK6iThNkp
         l+wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5WiRAMnvFissAlOT1YjcrzmBmUjG0ccc8lAc8bMs2nc=;
        b=UZixCkg6427c8fFl4qQFVviNL+4ft+MvLZ+F9iOtO7S99UxrlvG+JNp1DOiK/8xpl1
         uTc/WuYOSKrmxUqCfbRZIIo4BXeRysDiGUknKW6/nTt+WcBldYIB58FuIaFTZZbIlJaK
         RqXDXNExmbrq5ftLBo4jHlduRvPcJjGV8AQ5bYtuZJwSWXDKzpzHR+cHOo0RaVW+Y+HB
         TT1TBHm/CSniX42rwaF6g5uH1BToYG4ekGNB5FURAWr4lc3FhHUxDex1EyAgGauhWHvY
         1vajE2vwhvispzq/J7v8NJTNDC4w5e+0aEsAxheC9ZQgWIR8+PBPpHkRUdQ67MeNDBjn
         Pmaw==
X-Gm-Message-State: ANhLgQ0uXp4qa07/XSg+5MUQTetglTaEK7ZepnhZ43rVHzbvYQjv/zHs
        IXu3lDGw4Vj7wYeM1FeItYcu6mSCmxGaJQtJG09ceQ==
X-Google-Smtp-Source: ADFU+vvZ6PTvzLc7c7CtUOFxWTsDOMweZx9kr7k8Uiqz2DUl/JLub/emgkVCTrSEHEOx+RvXJddLqVDI5T23g3NLQ94=
X-Received: by 2002:a1c:a9cf:: with SMTP id s198mr1082793wme.115.1584994022457;
 Mon, 23 Mar 2020 13:07:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200313232720.22364-1-bernardo.perez.priego@intel.com> <f1635547-2c18-b9d6-0fb2-2f69dcfd124e@collabora.com>
In-Reply-To: <f1635547-2c18-b9d6-0fb2-2f69dcfd124e@collabora.com>
From:   Daniel Campello <campello@google.com>
Date:   Mon, 23 Mar 2020 14:06:26 -0600
Message-ID: <CAHcu+Vb37A+b2B6tJDYmJtH2dhUPEDy-3yZxaQYy3P3fLV2nVg@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: wilco_ec: Provide correct output format
 to 'h1_gpio' file
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Bernardo Perez Priego <bernardo.perez.priego@intel.com>,
        Benson Leung <bleung@chromium.org>,
        Nick Crews <ncrews@chromium.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Mar 17, 2020 at 1:09 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi,
>
> On 14/3/20 0:27, Bernardo Perez Priego wrote:
> > Function 'h1_gpio_get' is receiving 'val' parameter of type u64,
> > this is being passed to 'send_ec_cmd' as type u8, thus, result
> > is stored in least significant byte. Due to output format,
> > the whole 'val' value was being displayed when any of the most
> > significant bytes are different than zero.
> >
> > This fix will make sure only least significant byte is displayed
> > regardless of remaining bytes value.
> >
> > Signed-off-by: Bernardo Perez Priego <bernardo.perez.priego@intel.com>
>
> Daniel, could you give a try and give you Tested-by tag if you're fine with it?
>
> Thanks,
>  Enric
>
> > ---
> >  drivers/platform/chrome/wilco_ec/debugfs.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/platform/chrome/wilco_ec/debugfs.c b/drivers/platform/chrome/wilco_ec/debugfs.c
> > index df5a5f6c3ec6..c775b7d58c6d 100644
> > --- a/drivers/platform/chrome/wilco_ec/debugfs.c
> > +++ b/drivers/platform/chrome/wilco_ec/debugfs.c
> > @@ -211,7 +211,7 @@ static int h1_gpio_get(void *arg, u64 *val)
> >       return send_ec_cmd(arg, SUB_CMD_H1_GPIO, (u8 *)val);
> >  }
> >
> > -DEFINE_DEBUGFS_ATTRIBUTE(fops_h1_gpio, h1_gpio_get, NULL, "0x%02llx\n");
> > +DEFINE_DEBUGFS_ATTRIBUTE(fops_h1_gpio, h1_gpio_get, NULL, "0x%02hhx\n");
> >
> >  /**
> >   * test_event_set() - Sends command to EC to cause an EC test event.
> >

Done. I also found the chromium review for this on crrev.com/c/2090128

Tested-by: Daniel Campello <campello@chromium.org>
