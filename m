Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21E4C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 17:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B55DC206BE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 17:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R10MgnbP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406548AbgFYRDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 13:03:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406536AbgFYRDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 13:03:11 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E227C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 10:03:11 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id 5so3929791oty.11
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 10:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lHuq6EogiKBbM82Ii0dKYIDH5EuifFInWULAf51Dtt8=;
        b=R10MgnbP1v4wyVm4/QHmMZdVG9DqxpMPO72tK0gXDVkiywHm0irKEx+UqGMfzqp73J
         xKFPxNUN4HTEBLkjbeo5Kn/CdFYsGCvbGEfnJgiBeIm2cPlkAJbI60H3XPCG5NOBAktH
         V2kiW36UhOmIkqFkhxrPxZEaEWZVVSYHVqjccUodku9SShsHenOyyFk0MlhGjurxfnL8
         i0Kp14hGvwj8uT+oLqYsh9UcYH5psChX9dXDm4qjbLLz36+tvm+AnllszwpMKtFwYnQ7
         HhcW/f8j2S1roSRfiNT1TsIyrDDmbgztRdk+UQClm7Iatn3kL0h+rgBRwDhW9noex7Fb
         Af4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lHuq6EogiKBbM82Ii0dKYIDH5EuifFInWULAf51Dtt8=;
        b=MjzMmKHG89MynsfN0QoRx7RWia9VghBzUqGym33fxncszkja5zryPACw+Ngp1xeeiN
         I8gzL7QPPFGM8/3GSy21+DsoBj3Coa4WEWBUxW7zKUOw6CUPbizzBEa+ZUmIY5hTXbRC
         6KeE/dS3hC+VWhS0WabJA9g8iSYyjI6JoDQ6J52K1DEjiX0KrWk+JBa62aT57rZvO3M7
         cjjXqPSZ6EQVA8clmxevAjpnbvrmGRBxJCOcRRMFI8ENAQHL7WeumemvKgJ8xHfUvs4q
         Dkd5HImMAqc8H2AjBap78fDyRGikJ/px+BUBVrW/BjFkWTEmr9lRlsk8VK7a7c0uYSyq
         RmFw==
X-Gm-Message-State: AOAM532J3s9PWjw6lIL01Y0xOZPwokPD4x22ohgpPK27sA0TUXlAx9DI
        moll6/KOgCOUzyQEdVJTWFFUO+AfFOElPEqWhdI2oA==
X-Google-Smtp-Source: ABdhPJzE23GYlnoRC3yDPliU+2Co4m7tdsZmDCRADzlN90DyT9/weTVohPePBoe23TV9oHNEbMgz1fYQjyyMa2P7zZ8=
X-Received: by 2002:a9d:6048:: with SMTP id v8mr29686218otj.231.1593104590270;
 Thu, 25 Jun 2020 10:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200625032430.152447-1-saravanak@google.com> <CAMuHMdWiAPOGPh+LCwxebfwZTxQvwEi7G3R1btdEz6xWkbFPUQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWiAPOGPh+LCwxebfwZTxQvwEi7G3R1btdEz6xWkbFPUQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 25 Jun 2020 10:02:34 -0700
Message-ID: <CAGETcx-93ps8GFSfY5eeBtxoekB5TtT+HPHV8aVoDLtXz48bVA@mail.gmail.com>
Subject: Re: [PATCH v1] driver core: Fix suspend/resume order issue with
 deferred probe
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dropping Feng and Toan due to mail bounces.

On Thu, Jun 25, 2020 at 1:58 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Saravana,
>
> Thanks for your patch!
>
> On Thu, Jun 25, 2020 at 5:24 AM Saravana Kannan <saravanak@google.com> wrote:
> > Under the following conditions:
> > - driver A is built in and can probe device-A
> > - driver B is a module and can probe device-B
>
> I think this is not correct: in my case driver B is builtin, too.

This is a correct example, it just doesn't match with your case :)

Talking about fw_devlink_pause/resume() just distracts from the real
issue that's also present in systems that don't use DT.

You have this problem even on an ACPI system -- distributions loading
all the modules in a PC. We want suspend/resume to work for those too.
So, I'm just going for a simpler example.

> > - device-A is supplier of device-B
> >
> > Without this patch:
> > 1. device-A is added.
> > 2. device-B is added.
> > 3. dpm_list is now [device-A, device-B].
> > 4. driver-A defers probe of device-A.
> > 5. deferred probe of device-A is reattempted
>
> I think this is misleading: in my case driver-A did not defer the probe
> of device-A, and driver-A never returned -EPROBE_DEFER.
> Probing was merely paused, due to fw_devlink_pause();

What I said above. fw_devlink_pause() just defers the probe for the
device -- that's how it pauses and resumes probing. For example,
device link can defer the probe for a device without ever getting to
the driver too.

> > 6. device-A is moved to end of dpm_list.
> > 6. dpm_list is now [device-B, device-A].
> > 7. driver-B is loaded and probes device-B.
> > 8. dpm_list stays as [device-B, device-A].
> >
> > Suspend (which goes in the reverse order of dpm_list) fails because
> > device-A (supplier) is suspended before device-B (consumer).
> >
> > With this patch:
> > 1. device-A is added.
> > 2. device-B is added.
> > 3. dpm_list is now [device-A, device-B].
> > 4. driver-A defers probe of device-A.
> > 5. deferred probe of device-A is reattempted later.
> > 6. dpm_list is now [device-B, device-A].
> > 7. driver-B is loaded and probes device-B.
> > 8. dpm_list is now [device-A, device-B].
> >
> > Suspend works because device-B (consumer) is suspended before device-A
> > (supplier).
> >
> > Fixes: 494fd7b7ad10 ("PM / core: fix deferred probe breaking suspend resume order")
> > Fixes: 716a7a259690 ("driver core: fw_devlink: Add support for batching fwnode parsing")
> > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>
> This fixes wake-up by GPIO key on r8a7740/armadillo and sh73a0/kzm9g.
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Thanks!

>
> > --- a/drivers/base/dd.c
> > +++ b/drivers/base/dd.c
> > @@ -109,6 +109,8 @@ static void deferred_probe_work_func(struct work_struct *work)
> >                  * probe makes that very unsafe.
> >                  */
> >                 device_pm_move_to_tail(dev);
> > +               /* Greg/Rafael: SHOULD I DELETE THIS? ^^ I think I should, but
> > +                * I'm worried if it'll have some unintended consequeneces. */
>
> Works fine for me with the call to device_pm_move_to_tail() removed, too
> (at least on the two boards that showed the issue before).

Yes, it feels right to remove this, but I just wanted to get a few
more opinions.


-Saravana
