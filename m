Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6302C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C07C206C3
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 21:55:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R6IL3IE0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729120AbgGGVy7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 17:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgGGVy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 17:54:58 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B157AC061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 14:54:58 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id a21so12191263otq.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 14:54:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bw1dsLPtsusoVZu5E92gBzxhDS3/mcoDt6/t2gCfNAw=;
        b=R6IL3IE0whMxdwVJgmRKb7J49Wo826feGf4RpzU1UHp84nRW1/S5Lj0OdlRyg1MbCS
         2mLbnvCvod5/RFb3VQW8dsPx3E1KvzX4mG3AuGgKyGgpNMlSiCHZ98aaHHT3bCePa6EF
         1kuRSDyzS53RkWDuEqpBJnpbLzD/TAofByHpeHaUNQOxi51ms4oDmmrWU/rP0NQNRgJA
         QBTmBp8301EM4b5mxJoOOtLvwf1Ra53UU4lUMHXUgeGnezgejRHstAuz0shGVbiAsqUQ
         6FVHzVQMwCzwtdCBkCR5GoAmvyW7s+4J0W8QZMMEXTjte+DvsT7YAFSRt7g71FX+afsu
         pufA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bw1dsLPtsusoVZu5E92gBzxhDS3/mcoDt6/t2gCfNAw=;
        b=ndwb12nKyGGI68ftLSgxKcD2FIuEQvE1uwYQ/goewngmgASLBO5xX5GSFKoh/IccD6
         Rw1vXzaUz+jzDI3kNUOVOs+0XxDEXs9lp3tGSc+L4iTSSduh5/3+cP6XBZxiBGuhQ9CE
         tmQVU+dPZy1JEaZuMJMPbPbG7AMZzrZEB8noymtMetvH7b+4hCT9dOjuepKJjZNL69E1
         asBCmAKBIRLHqjLPJmKtat/eU1n03eEGEkxVf0K26FE+PYlC9qLKFyUvBjBGthFImgzA
         z++1ONffEUh2HfnO3TBn8X3FMYR7lczBEwAHOiw4lD96yK6SZL/CgA4gQu6hoNH2gO4f
         imMA==
X-Gm-Message-State: AOAM531IQ4RZxFL2034YeqG2jjZUf9U4jw0rO5grvYl79IcmS3heAiA+
        ZseSVXcjoUtzyw4ek/YXY9/Vq07nMzE5ixgoZWZjNQ==
X-Google-Smtp-Source: ABdhPJyNjogkJvtUW5ZTV4oBpDMTql1EepeodMfihZi8Qf5Y9zgz8p05zgBxRYsuMJyffoBMVnrJmhsjZGMQiXFfzsA=
X-Received: by 2002:a05:6830:1d43:: with SMTP id p3mr27738361oth.369.1594158897817;
 Tue, 07 Jul 2020 14:54:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200701194259.3337652-1-saravanak@google.com>
 <20200701194259.3337652-2-saravanak@google.com> <CAJZ5v0jS39EPgsiNrGzCGeSpMpccu2tUQZ_zn9PABMMmtD-PBA@mail.gmail.com>
In-Reply-To: <CAJZ5v0jS39EPgsiNrGzCGeSpMpccu2tUQZ_zn9PABMMmtD-PBA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 7 Jul 2020 14:54:21 -0700
Message-ID: <CAGETcx_mPeO_KRoA6s_kRDPSrr+jkssVP8uoWg5_YVyMmYXe8Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] driver core: Don't do deferred probe in parallel
 with kernel_init thread
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Cc: Android Kernel" <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 7, 2020 at 8:59 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Wed, Jul 1, 2020 at 9:43 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > The current deferred probe implementation can mess up suspend/resume
> > ordering if deferred probe thread is kicked off in parallel with the
> > main initcall thread (kernel_init thread) [1].
> >
> > For example:
> >
> > Say device-B is a consumer of device-A.
> >
> > Initcall thread                                 Deferred probe thread
> > ===============                                 =====================
> > 1. device-A is added.
> > 2. device-B is added.
> > 3. dpm_list is now [device-A, device-B].
> > 4. driver-A defers probe of device-A.
> >                                                 5. device-A is moved to
> >                                                    end of dpm_list
> >                                                 6. dpm_list is now
> >                                                    [device-B, device-A]
> > 7. driver-B is registereed and probes device-B.
> > 8. dpm_list stays as [device-B, device-A].
> >
> > The reverse order of dpm_list is used for suspend. So in this case
> > device-A would incorrectly get suspended before device-B.
> >
> > Commit 716a7a259690 ("driver core: fw_devlink: Add support for batching
> > fwnode parsing") kicked off the deferred probe thread early during boot
> > to run in parallel with the initcall thread and caused suspend/resume
> > regressions.  This patch removes the parallel run of the deferred probe
> > thread to avoid the suspend/resume regressions.
> >
> > [1] - https://lore.kernel.org/lkml/CAGETcx8W96KAw-d_siTX4qHB_-7ddk0miYRDQeHE6E0_8qx-6Q@mail.gmail.com/
> >
> > Fixes: 716a7a259690 ("driver core: fw_devlink: Add support for batching fwnode parsing")
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/base/base.h | 1 -
> >  drivers/base/core.c | 1 -
> >  drivers/base/dd.c   | 5 -----
> >  3 files changed, 7 deletions(-)
> >
> > diff --git a/drivers/base/base.h b/drivers/base/base.h
> > index 95c22c0f9036..40fb069a8a7e 100644
> > --- a/drivers/base/base.h
> > +++ b/drivers/base/base.h
> > @@ -153,7 +153,6 @@ extern char *make_class_name(const char *name, struct kobject *kobj);
> >  extern int devres_release_all(struct device *dev);
> >  extern void device_block_probing(void);
> >  extern void device_unblock_probing(void);
> > -extern void driver_deferred_probe_force_trigger(void);
> >
> >  /* /sys/devices directory */
> >  extern struct kset *devices_kset;
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index 67d39a90b45c..35cc9896eb9e 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -1323,7 +1323,6 @@ void fw_devlink_resume(void)
> >                 goto out;
> >
> >         device_link_add_missing_supplier_links();
> > -       driver_deferred_probe_force_trigger();
>
> So it looks like this was not needed after all.
>
> What was the role of it then?

It's needed to avoid delaying all probe till late_initcall. Patch 3/3
has more details.

-Saravana
