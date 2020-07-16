Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE555C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86B1A207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 14:45:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GEjIqLiP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbgGPOpL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726963AbgGPOpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 10:45:08 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B47DC061755
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 07:45:08 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id s9so7412194ljm.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 07:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KEqbgXg5bolFCkaEREfRLUaB6wjIdNl0kMgYuxyNxpI=;
        b=GEjIqLiPxGWf30Xto3dr/VRzc+jve2MqdPGTM9sUQj6SX8bHj0uzqXyVE5K8msut3n
         LcgTNQNJqtw7IemIFS+OMy8vmAQJCY2yQD7IgTshitTlPFcWnVmsuYJ0Z2hDwfzIKbUJ
         cKheZtsoJichKATZ899iNX3ePelWfAebfy3ARo5wiIs/R4Ud+5wEUK8+rmEAaUYXT4EQ
         dVl7m668gegN7uHOzqeusAgXDr24DBP48h/z5g7LjaM5rNfYR1pD6vD7nw/+P7k2Db7a
         4tu57r9py1rEFDd2fujZs9B4aNhKOTlR4jVM85AT7LS+H2TzMmskAYFNea1MPtilOpHP
         uxxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KEqbgXg5bolFCkaEREfRLUaB6wjIdNl0kMgYuxyNxpI=;
        b=VQcYYnWstCY56BCYEVylgwXBuTrlSh4mPR7kM/+jvlGw2mrdH1ormllGgtX/6BN9YV
         vme7ztFPh4Is3t+Yhv88mXhGgddFhnNBhDuepmTMgXyMrCO1zm/vor1H1Lj9b8/YefGn
         ko+B/gyJslsvXr8+nNV45Yon7p0FI3cN1TaOqTpq9JUy8S6UC1at3PpDZQQmTDWyTWpN
         o1INHK6eHS/ZTsHxaJb+20txb10Tc011gnAzOzC/zDvJxip1ORj8nUzx9znOLoq/+sAX
         vcXxkgC0yr/re83zjAcFn1Uy2xNNGt2jVIZXpXkgHETS0ds5COA+1clMFxTF8Ei7p+be
         2J9Q==
X-Gm-Message-State: AOAM530RDsDKDWQLsNkkY111hgr9piwrW75f/meIFVhWTTP5kmTitsCy
        IGaxf65zampNciMtLiY/4lrH0ePS0yslj5BfShiUTRJwfse7Sw==
X-Google-Smtp-Source: ABdhPJwJEhKsmRxsAvPniebMSKL4vf5R0zcd380KCBeBrDwpEZAgDNUsbbYigJ6CStV4ZzKU0+7UrLBBBKm2jdUPO50=
X-Received: by 2002:a2e:b054:: with SMTP id d20mr2073091ljl.55.1594910706505;
 Thu, 16 Jul 2020 07:45:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200712131003.23271-1-madhuparnabhowmik10@gmail.com>
 <20200712131003.23271-2-madhuparnabhowmik10@gmail.com> <20200712160856.GW9247@paulmck-ThinkPad-P72>
In-Reply-To: <20200712160856.GW9247@paulmck-ThinkPad-P72>
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Thu, 16 Jul 2020 20:14:54 +0530
Message-ID: <CA+G9fYuVmTcttBpVtegwPbKxufupPOtk_WqEtOdS+HDQi7WS9Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] kvm: mmu: page_track: Fix RCU list API usage
To:     madhuparnabhowmik10@gmail.com,
        "Paul E. McKenney" <paulmck@kernel.org>
Cc:     josh@joshtriplett.org, Joel Fernandes <joel@joelfernandes.org>,
        Paolo Bonzini <pbonzini@redhat.com>, rcu@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, kvm list <kvm@vger.kernel.org>,
        frextrite@gmail.com, lkft-triage@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jul 2020 at 21:39, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Sun, Jul 12, 2020 at 06:40:03PM +0530, madhuparnabhowmik10@gmail.com wrote:
> > From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> >
> > Use hlist_for_each_entry_srcu() instead of hlist_for_each_entry_rcu()
> > as it also checkes if the right lock is held.
> > Using hlist_for_each_entry_rcu() with a condition argument will not
> > report the cases where a SRCU protected list is traversed using
> > rcu_read_lock(). Hence, use hlist_for_each_entry_srcu().
> >
> > Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
>
> I queued both for testing and review, thank you!
>
> In particular, this one needs an ack by the maintainer.
>
>                                                         Thanx, Paul
>
> >  arch/x86/kvm/mmu/page_track.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/kvm/mmu/page_track.c b/arch/x86/kvm/mmu/page_track.c
> > index a7bcde34d1f2..a9cd17625950 100644
> > --- a/arch/x86/kvm/mmu/page_track.c
> > +++ b/arch/x86/kvm/mmu/page_track.c
> > @@ -229,7 +229,8 @@ void kvm_page_track_write(struct kvm_vcpu *vcpu, gpa_t gpa, const u8 *new,
> >               return;
> >
> >       idx = srcu_read_lock(&head->track_srcu);
> > -     hlist_for_each_entry_rcu(n, &head->track_notifier_list, node)
> > +     hlist_for_each_entry_srcu(n, &head->track_notifier_list, node,
> > +                             srcu_read_lock_held(&head->track_srcu))

x86 build failed on linux -next 20200716.

arch/x86/kvm/mmu/page_track.c: In function 'kvm_page_track_write':
include/linux/rculist.h:727:30: error: left-hand operand of comma
expression has no effect [-Werror=unused-value]
  for (__list_check_srcu(cond),     \
                              ^
arch/x86/kvm/mmu/page_track.c:232:2: note: in expansion of macro
'hlist_for_each_entry_srcu'
  hlist_for_each_entry_srcu(n, &head->track_notifier_list, node,
  ^~~~~~~~~~~~~~~~~~~~~~~~~
arch/x86/kvm/mmu/page_track.c: In function 'kvm_page_track_flush_slot':
include/linux/rculist.h:727:30: error: left-hand operand of comma
expression has no effect [-Werror=unused-value]
  for (__list_check_srcu(cond),     \
                              ^
arch/x86/kvm/mmu/page_track.c:258:2: note: in expansion of macro
'hlist_for_each_entry_srcu'
  hlist_for_each_entry_srcu(n, &head->track_notifier_list, node,
  ^~~~~~~~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[3]: *** [arch/x86/kvm/mmu/page_track.o] Error 1

build link,
https://ci.linaro.org/view/lkft/job/openembedded-lkft-linux-next/DISTRO=lkft,MACHINE=intel-corei7-64,label=docker-lkft/815/consoleText

-- 
Linaro LKFT
https://lkft.linaro.org
