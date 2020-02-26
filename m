Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4BD0C4BA1E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 757A5222C2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 17:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OPnA17Wq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgBZRcu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 12:32:50 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:47035 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgBZRcu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 12:32:50 -0500
Received: by mail-qk1-f196.google.com with SMTP id u124so150939qkh.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 09:32:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8SZWlIPAwesWEZYREUk65Wkk0q3plMvUlloIy/qq0nQ=;
        b=OPnA17WqK2a9HiEJkIFyx6Qze3oMFgWF9t88wY7OiLyYVPJnuo8gJBg/iJlOQbOTMi
         4fZIZDv9R4SAR0lVmiGA3VuigBzjdQH9HaCHZv2Bkw4odA4HA7J8qcRVfN7Gj96k60lG
         OljukKAfFvjuBNatMIVy3hWnuYibW51XaaJp8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8SZWlIPAwesWEZYREUk65Wkk0q3plMvUlloIy/qq0nQ=;
        b=Jri9r9p0rF7jVS5xY6/B+bRult1ygYXworu0KIpQMOhAOtTSspZEmJcSbt8LxbnI3b
         JHMsEmg+lrGj/ScguczQXyVqx/qb0nCBlUN1HbMY8KtY+UHSZfLYO9HGocOp2xzr8AK3
         6zzY/cReBTFtEH9u54fAwwC8KtC+sPLQ2x853NKvbjCwbEzMDYvwkkzSphLM4c7CAMZO
         pSyhlDPhTA9eb7WoQ4ngF/6twE1HPaPqJBPnmdSu6wmwRyjyjh3QWjCE6wGWORaYk4Ld
         LbZxMpt4VwMhlvmiePEBuFi0NwNKHnPKwmVQbPBcmNNMDIpiQNzH6k8qMBDBeg1QFw5D
         e33g==
X-Gm-Message-State: APjAAAXDWx6biTIb8XpnPZ/rHedGTgoUTu3PhPSu1dqSKHCFNg96j+2m
        +PwcFtiT+EOnUIP/0Scc8dgyTfo0GCnnXm5RqwTffg==
X-Google-Smtp-Source: APXvYqytAtNJV8Il3Mg/9x3pZmGB2SLFyc4DLw0hmTkKGhnqP4lPDhizBPH8ULTQzMKoYC1gn+DOMZSrOMagCoFmYfU=
X-Received: by 2002:ae9:ef06:: with SMTP id d6mr217560qkg.442.1582738367341;
 Wed, 26 Feb 2020 09:32:47 -0800 (PST)
MIME-Version: 1.0
References: <20200220155859.906647-1-enric.balletbo@collabora.com>
 <20200220155859.906647-5-enric.balletbo@collabora.com> <20200225195519.GC11971@google.com>
 <4e441ead-44f3-1787-28a3-3e71893105f9@collabora.com>
In-Reply-To: <4e441ead-44f3-1787-28a3-3e71893105f9@collabora.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Wed, 26 Feb 2020 09:32:36 -0800
Message-ID: <CACeCKac0c9e80txmyo3UZ8hU3rWj07n=pJai4mWzWae_jQ0Ueg@mail.gmail.com>
Subject: Re: [PATCH 4/8] platform/chrome: cros_ec_chardev: Use
 cros_ec_cmd_xfer_status helper
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Dmitry Torokhov <dtor@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enric,

On Wed, Feb 26, 2020 at 7:00 AM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Prashant,
>
> On 25/2/20 20:55, Prashant Malani wrote:
> > Hi Enric,
> >
> > On Thu, Feb 20, 2020 at 04:58:55PM +0100, Enric Balletbo i Serra wrote:
> >> This patch makes use of cros_ec_cmd_xfer_status() instead of
> >> cros_ec_cmd_xfer(). In this case the change is trivial and the only
> >> reason to do it is because we want to make cros_ec_cmd_xfer() a private
> >> function for the EC protocol and let people only use the
> >> cros_ec_cmd_xfer_status() to return Linux standard error codes.
> >>
> >> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >> ---
> >>
> >>  drivers/platform/chrome/cros_ec_chardev.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/platform/chrome/cros_ec_chardev.c b/drivers/platform/chrome/cros_ec_chardev.c
> >> index c65e70bc168d..b51ab24055f3 100644
> >> --- a/drivers/platform/chrome/cros_ec_chardev.c
> >> +++ b/drivers/platform/chrome/cros_ec_chardev.c
> >> @@ -301,7 +301,7 @@ static long cros_ec_chardev_ioctl_xcmd(struct cros_ec_dev *ec, void __user *arg)
> >>      }
> >>
> >>      s_cmd->command += ec->cmd_offset;
> >> -    ret = cros_ec_cmd_xfer(ec->ec_dev, s_cmd);
> >> +    ret = cros_ec_cmd_xfer_status(ec->ec_dev, s_cmd);
> >
> > One issue I see here is that if we were to later convert
> > cros_ec_cmd_xfer_status() to cros_ec_cmd(), we would lose the
> > s_cmd->result value, since I was hoping to avoid returning msg->result
> > via a pointer parameter. I don't know if userspace actually uses that, but I
> > am assuming it does.
> >
>
> I'd like to avoid returning msg->result via a pointer parameter too. I didn't
> analyze all the cases but I suspect that in most cases it is not really needed,
> so let's start by converting to the cros_ec_cmd the cases that are clear and
> let's go one by one for the ones that are not clear.
>
I think the major one I was concerned about was in user-space:
https://chromium.googlesource.com/chromiumos/platform/ec/+/refs/heads/master/util/comm-dev.c#149

The above seems to return the result (after applying an offset).
FWIU the attempt would be to not change the user-space API, so would
we need to change this user-space too?

Best regards,

> IMO cros_ec_cmd should return the same as cros_ec_cmd_xfer_status. So you should
> use cros_ec_cmd_xfer_status inside cros_ec_cmd.
>
> Regards,
>  Enric
>
> > So, should cros_ec_cmd() keep the *result pointer like so ?:
> >
> > int cros_ec_cmd(struct cros_ec_device *ec, u32 version, u32 command,
> >                void *outdata, u32 outsize, void *indata, u32 insize, u32 *result);
> >
> > This way, we can manually re-populate s_cmd->result with |*result|.
> >
> > Or, should we drop msg->result while returning s_cmd to userspace? I am
> > guessing the answer is no, but thought I'd check with you first.
> >
> > Best regards,
> >
> >
> >>      /* Only copy data to userland if data was received. */
> >>      if (ret < 0)
> >>              goto exit;
> >> --
> >> 2.25.0
> >>
