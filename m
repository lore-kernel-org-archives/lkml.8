Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C87DDC4CECD
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A91472070B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 20:13:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q28RKGDL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726940AbgD0UNV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726918AbgD0UNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 16:13:18 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D04C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 13:13:18 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id b13so28593675oti.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 13:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cDA2gvlDjQF3XmddqEEMdYklKnKtW+BtZmwqaZrV2YY=;
        b=q28RKGDLUUXJvCA/waXzctMM5+urQ8/dGyUlR8ZuzfTnCZyBfn5/jcAKFB06qJ3Hx0
         sue98eW6PYIHRaiNGNYjJ6TLGjMLXKSU0MtnqzZ9qBFq+b+H/4QX9zSEwTUIn0w1aJiV
         guu6X80zsl5GyqW22FIfpwcojJOLdSM6jiVlxpEKJHooqZdUc38cjjYPsks3Lfs2CRt4
         HIN+jWCdZ9KoZCjxFT/7t79nXIPKUPrIavp/goEvQg5Ke9gabxr+QfjuKDiDgtgDFP12
         AbXiIAKyCQEJw66SmGFJoB6zcpvpUL3NsjDV4VaI7ns4I+bKjKUmmxtS+4wcKnMS3YnL
         26cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cDA2gvlDjQF3XmddqEEMdYklKnKtW+BtZmwqaZrV2YY=;
        b=fOWoMBGxZHwVocIKsO4iLA1MqIGd/0YCS3UIDc1KYsR6LB2jI5XI2r7zHQqoxSF9Jv
         1bkEaXVBGMBYBixnguZPffpXnOoOw9ejvW/AylCFDCmh78frfnamWgpl0HKMi2CoWOtp
         jqNpOUshvfYDrpzg7iTnVYri1I3YdaD3xGyN2xfk17mNknAtIVgDfyvsR2zKp+k+7RyY
         t9KAJ7MCuWJE3vucGjulc3KP3UkYpOiK/Ugg6tzBkcNM++fm5hunFO4XHtz/+XH6uz9j
         O3TEJuFIpgTlPNBM97/RIj7jVBRyjWqIYORXioY/Ss/s+7360fACECzukI1lEx6DVKR6
         jPyg==
X-Gm-Message-State: AGi0PuZrH2vpZxw5nH3eNDZ4YHlV9Y+9cGvEk9qgpYebD8ZFsh12LndI
        24es1aeDAmeR+8yRtoIRUXJs5sOb0M5YrjvX2EXLXg==
X-Google-Smtp-Source: APiQypJY3Lz/oTNH320U8S37bDEtPLjloMUGN4LeeYArglN/WH/Vzs1yv5zDS0VrwBNqlNsRjuvxvJiWjSctNWBv56s=
X-Received: by 2002:a9d:2622:: with SMTP id a31mr20989231otb.231.1588018397440;
 Mon, 27 Apr 2020 13:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <d2934f74d77c637c41d7cb98710cb5363d09e83b.1585021186.git.baolin.wang7@gmail.com>
 <CADBw62pmiguVmuq334eskLAZ5CkrjxohW_fXNjNev+O1U15=OQ@mail.gmail.com>
 <bd800f7b-05fd-b393-fba6-1965ba89e1b3@linaro.org> <CAGETcx9da-U+dXA6sreTKJQiS3brYh3Hfh_qVYt06=3UOSmT_g@mail.gmail.com>
 <429da47b-ad51-30eb-ff36-b05780c941ba@linaro.org>
In-Reply-To: <429da47b-ad51-30eb-ff36-b05780c941ba@linaro.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 27 Apr 2020 13:12:41 -0700
Message-ID: <CAGETcx9sc6oWSPK=aWJ+39i9eHAyg6iOf+Xf2oVECO+g1pFjtQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] drivers/clocksource/timer-of: Remove __init markings
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Baolin Wang <baolin.wang7@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 27, 2020 at 1:09 PM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 27/04/2020 21:04, Saravana Kannan wrote:
> > On Mon, Apr 27, 2020 at 10:13 AM Daniel Lezcano
> > <daniel.lezcano@linaro.org> wrote:
> >>
> >> On 13/04/2020 04:55, Baolin Wang wrote:
> >>> Hi Daniel,
> >>>
> >>> On Tue, Mar 24, 2020 at 1:59 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
> >>>>
> >>>> From: Saravana Kannan <saravanak@google.com>
> >>>>
> >>>> This allows timer drivers to be compiled as modules.
> >>>>
> >>>> Signed-off-by: Saravana Kannan <saravanak@google.com>
> >>>> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> >>>
> >>> Do you have any comments for this patch set? Thanks.
> >>
> >> If my understanding is correct, this patch is part of the GKI picture
> >> where hardware drivers are converted to modules.
> >>
> >> But do we really want to convert timer drivers to modules ?
> >>
> >> Is the core time framework able to support that (eg. load + unload )
> >
> > So this will mainly be used for secondary timers that the system
> > supports. Not for the main one that's set up during early boot for
> > sched timer to work. For the primary timer during boot up, we still
> > expect that to be the default ARM timer and don't want/expect that to
> > be a module (it can't be).
>
> My question is about clockevents_config_and_register() for instance, is
> there a function to unregister in the core framework ?

We can just have these modules be "permanent" modules that can't be
unloaded. They just need to not implement module_exit().

-Saravana
