Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34954C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 18:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2E102465A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 18:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Z0ShGgYB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgBESWM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 13:22:12 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:42861 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728076AbgBESWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 13:22:07 -0500
Received: by mail-lf1-f67.google.com with SMTP id y19so2179930lfl.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 10:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jYSq2gM0rxvbmer1jk84xhZ3+qMB/quMixgOKAh7Q9E=;
        b=Z0ShGgYBzv9MqLGK+lDZ3hvGS5qTENbW1JXO05EKWQZuZetpcDYVGGVN7l+G4akJO8
         5e7m6Du4pK1vyp8UKVSQRLOHxisKBQGV+mtKzKCAKh1UAPKL78ueLGukubKe7K1nSwav
         9WR1ZoHQtd6YZlovje7nP9OxYEqpJ9EzHrwbo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jYSq2gM0rxvbmer1jk84xhZ3+qMB/quMixgOKAh7Q9E=;
        b=aVXqvzafsKRex286XnX6EwCUsuMLynGNGblFn5HScT7GGOdnKUIBqCVn6DhCEvI7ho
         OBLrXVrpDaX0GM5lxXxjq5q9PCopnfCXn6zZhLe1MD7pMItmQmwokFl+2Z49LLiIDO1P
         3CAPalj/JDQrCTZKOS6OqplgORQ9F61H1Jw3ITahi6Gj0IxzJQzchpJR1PpGZ8sZOSVX
         8YViQKJ3oKlw9I16wmnNrtlEcA9Zszpv53DBO/L/s/MIbhZcvHomR3WxHxriGN46QkQU
         v+n7pweVINsuQbrThSMFiMio3S1K14BKHUtJupiTg/p4BLh8Pa9JEez3ZLqHf6NqLMvt
         L4oQ==
X-Gm-Message-State: APjAAAVEQ4fbLmuSEkE+HQ6mhYoTfUHqIF4LuYY1zlW/2oqNsB8EUcbU
        4GfNuBO2Yx8BQJYQhQM7oQkEQUGzySg=
X-Google-Smtp-Source: APXvYqxl+sY6OARGCeqzoO4Xmp/wXIlSASXur1Vv8S2Sgb21zEIpb49ty4XBY9Vhy/0IheLCW4S8Xw==
X-Received: by 2002:ac2:4a89:: with SMTP id l9mr18290427lfp.121.1580926923307;
        Wed, 05 Feb 2020 10:22:03 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id 126sm130819lfm.38.2020.02.05.10.22.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 10:22:02 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id b15so2190919lfc.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 10:22:02 -0800 (PST)
X-Received: by 2002:a19:c205:: with SMTP id l5mr18227021lfc.159.1580926921198;
 Wed, 05 Feb 2020 10:22:01 -0800 (PST)
MIME-Version: 1.0
References: <1580796831-18996-1-git-send-email-mkshah@codeaurora.org>
 <1580796831-18996-3-git-send-email-mkshah@codeaurora.org> <CAE=gft7gPS+hhnDP+uTn3is6s9=Nspbb4PL0bZ025Tq1Zpth8Q@mail.gmail.com>
 <7db81eed-d46d-8131-f471-6f57c0335ace@codeaurora.org>
In-Reply-To: <7db81eed-d46d-8131-f471-6f57c0335ace@codeaurora.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Wed, 5 Feb 2020 10:21:24 -0800
X-Gmail-Original-Message-ID: <CAE=gft6zEKYoMabmRbO55BSAt-4oOuwRRZZD6BcSbe7Xp15Vnw@mail.gmail.com>
Message-ID: <CAE=gft6zEKYoMabmRbO55BSAt-4oOuwRRZZD6BcSbe7Xp15Vnw@mail.gmail.com>
Subject: Re: [PATCH 2/3] soc: qcom: rpmh: Update rpm_msgs offset address and
 add list_del
To:     Maulik Shah <mkshah@codeaurora.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, lsrao@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 4, 2020 at 9:12 PM Maulik Shah <mkshah@codeaurora.org> wrote:
>
>
> On 2/5/2020 6:01 AM, Evan Green wrote:
> > On Mon, Feb 3, 2020 at 10:14 PM Maulik Shah <mkshah@codeaurora.org> wrote:
> >> rpm_msgs are copied in continuously allocated memory during write_batch.
> >> Update request pointer to correctly point to designated area for rpm_msgs.
> >>
> >> While at this also add missing list_del before freeing rpm_msgs.
> >>
> >> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
> >> ---
> >>   drivers/soc/qcom/rpmh.c | 9 ++++++---
> >>   1 file changed, 6 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
> >> index c3d6f00..04c7805 100644
> >> --- a/drivers/soc/qcom/rpmh.c
> >> +++ b/drivers/soc/qcom/rpmh.c
> >> @@ -65,7 +65,7 @@ struct cache_req {
> >>   struct batch_cache_req {
> >>          struct list_head list;
> >>          int count;
> >> -       struct rpmh_request rpm_msgs[];
> >> +       struct rpmh_request *rpm_msgs;
> >>   };
> >>
> >>   static struct rpmh_ctrlr *get_rpmh_ctrlr(const struct device *dev)
> >> @@ -327,8 +327,10 @@ static void invalidate_batch(struct rpmh_ctrlr *ctrlr)
> >>          unsigned long flags;
> >>
> >>          spin_lock_irqsave(&ctrlr->cache_lock, flags);
> >> -       list_for_each_entry_safe(req, tmp, &ctrlr->batch_cache, list)
> >> +       list_for_each_entry_safe(req, tmp, &ctrlr->batch_cache, list) {
> >> +               list_del(&req->list);
> >>                  kfree(req);
> >> +       }
> >>          INIT_LIST_HEAD(&ctrlr->batch_cache);
> > Hm, I don't get it. list_for_each_entry_safe ensures you can traverse
> > the list while freeing it behind you. ctrlr->batch_cache is now a
> > bogus list, but is re-inited with the lock held. From my reading,
> > there doesn't seem to be anything wrong with the current code. Can you
> > elaborate on the bug you found?
>
> Hi Evan,
>
> when we don't do list_del, there might be access to already freed memory.
> Even after current item free via kfree(req), without list_del, the next
> and prev item's pointer are still pointing to this freed region.
> it seem best to call list_del to ensure that before freeing this area,
> no other item in list refer to this.

I don't think that's true. the "_safe" part of
list_for_each_entry_safe ensures that we don't touch the ->next member
of any node after freeing it. So I don't think there's any case where
we could touch freed memory. The list_del still seems like needless
code to me.

>
> >
> >>          spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
> >>   }
> >> @@ -377,10 +379,11 @@ int rpmh_write_batch(const struct device *dev, enum rpmh_state state,
> >>                  return -ENOMEM;
> >>
> >>          req = ptr;
> >> +       rpm_msgs = ptr + sizeof(*req);
> >>          compls = ptr + sizeof(*req) + count * sizeof(*rpm_msgs);
> >>
> >>          req->count = count;
> >> -       rpm_msgs = req->rpm_msgs;
> >> +       req->rpm_msgs = rpm_msgs;
> > I don't really understand what this is fixing either, can you explain?
> the continous memory allocated via below is for 3 items,
>
> ptr = kzalloc(sizeof(*req) + count * (sizeof(req->rpm_msgs[0]) +
> sizeof(*compls)), GFP_ATOMIC);
>
> 1. batch_cache_req,  followed by
> 2. total count of rpmh_request,  followed by
> 3. total count of compls
>
> current code starts using (3) compls from proper offset in memory
>          compls = ptr + sizeof(*req) + count * sizeof(*rpm_msgs);
>
> however for (2) rpmh_request it does
>
>          rpm_msgs = req->rpm_msgs;
>
> because of this it starts 8 byte before its designated area and overlaps
> with (1) batch_cache_req struct's last entry.
> this patch corrects it via below to ensure rpmh_request uses correct
> start address in memory.
>
>          rpm_msgs = ptr + sizeof(*req);

I don't follow that either. The empty array declaration (or the
GCC-specific version of it would be  "struct rpmh_request
rpm_msgs[0];") is a flexible array member, meaning the member itself
doesn't take up any space in the struct. So, for instance, it holds
true that &(req->rpm_msgs[0]) == (req + 1). By my reading the existing
code is correct, and your patch just adds a needless pointer
indirection. Check out this wikipedia entry:

https://en.wikipedia.org/wiki/Flexible_array_member
