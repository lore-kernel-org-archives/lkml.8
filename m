Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6277CC4332B
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 16:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33C742070A
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 16:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DVI33oBA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbgCSQm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 12:42:28 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:48608 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727772AbgCSQm1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 12:42:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584636147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zOA+IMIU8Q7WJF49pLVV19IvK2l47KrbLmH0N3YKQfA=;
        b=DVI33oBA6X7Dve+e3IGq9Utate+xN+IxH4Stn0ykxLr8SsnCXnuKhiIkivxh80dQqLQdZu
        FHIe3X45Dkw0i95ubNuh4nWdM4skelJrTdxKFQLHN89JBdRFtV/pGh9Eks0DUaQ0F6HYlE
        ZQcddNcNO9/GDFdh/BtYF7oELiWjnXs=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-359-DMRBizbhPuSOXVrcctoT5w-1; Thu, 19 Mar 2020 12:42:25 -0400
X-MC-Unique: DMRBizbhPuSOXVrcctoT5w-1
Received: by mail-il1-f200.google.com with SMTP id 75so2491217ilv.16
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 09:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zOA+IMIU8Q7WJF49pLVV19IvK2l47KrbLmH0N3YKQfA=;
        b=EagODj40er2C6haAQ0UVymj/AimDoKvt5oLbV4/OVS1zA5zTnqTl+EWNA/FzAcJJ/M
         xuq6CEs1dntr9/T0j6OdTUCT7a9VTbkj5ut9SYsp2nyxED+IknLfYxRdKKDRbqIzlhNv
         psQZjxJljkIAVhWemX6CQzDye+vfjDY2GqOOZdW5xSApeosfaZzrAB+KMFzVp8NLV9A4
         a6ETywvqyUPBhtFH44VrHl/txT8bTyquHIGRb00z7LJkCjZZ6oJ9DAiyE9o/Nu1XPgCD
         SXZGF1NmnV33vnYcnMMhFXCAbRNyl/lWI3F4H5jjJ9BfgTq2z/QFKxnqIRxwtSL7roWk
         rv/Q==
X-Gm-Message-State: ANhLgQ2Bd6yje/FXUm9t51MJekqNPNGO2IvZ6W/CKsDxPmeMQFTrCCek
        qwqTyr+JksIkKghwRGTf/9z48IJwOeC/0vriEkZ5vlGiogWom5npwUz7gBOkKKlYD3AwbLlGkyL
        6LeNN3vzJMDtA0Y3huZztaipyP+6VvlcwM6Z9Ys7G
X-Received: by 2002:a6b:be02:: with SMTP id o2mr3477758iof.39.1584636144620;
        Thu, 19 Mar 2020 09:42:24 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vs8iofIYJ+iNpo9+omXOEAEZcpDGFzEXydxLKvQtkjHH4wpvAEyj5/8Q2KiQ1Qpj4eSOH80FA0MxKZjmfU4MgQ=
X-Received: by 2002:a6b:be02:: with SMTP id o2mr3477735iof.39.1584636144322;
 Thu, 19 Mar 2020 09:42:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200318140605.45273-1-jarod@redhat.com> <8a88d1c8-c6b1-ad85-7971-e6ae8c6fa0e4@gmail.com>
 <CAKfmpSc0yea5-OfE1rnVdErDTeOza=owbL00QQEaH-M-A6Za7g@mail.gmail.com> <25629.1584564113@famine>
In-Reply-To: <25629.1584564113@famine>
From:   Jarod Wilson <jarod@redhat.com>
Date:   Thu, 19 Mar 2020 12:42:14 -0400
Message-ID: <CAKfmpScbzEZAEw=zOEwguQJvr6L2fQiGmAY60SqSBQ_g-+B4tw@mail.gmail.com>
Subject: Re: [PATCH net] ipv6: don't auto-add link-local address to lag ports
To:     Jay Vosburgh <jay.vosburgh@canonical.com>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Moshe Levi <moshele@mellanox.com>,
        Marcelo Ricardo Leitner <mleitner@redhat.com>,
        Netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 18, 2020 at 4:42 PM Jay Vosburgh <jay.vosburgh@canonical.com> wrote:
>
> Jarod Wilson <jarod@redhat.com> wrote:
>
> >On Wed, Mar 18, 2020 at 2:02 PM Eric Dumazet <eric.dumazet@gmail.com> wrote:
> >>
> >> On 3/18/20 7:06 AM, Jarod Wilson wrote:
> >> > Bonding slave and team port devices should not have link-local addresses
> >> > automatically added to them, as it can interfere with openvswitch being
> >> > able to properly add tc ingress.
> >> >
> >> > Reported-by: Moshe Levi <moshele@mellanox.com>
> >> > CC: Marcelo Ricardo Leitner <mleitner@redhat.com>
> >> > CC: netdev@vger.kernel.org
> >> > Signed-off-by: Jarod Wilson <jarod@redhat.com>
> >>
> >>
> >> This does not look a net candidate to me, unless the bug has been added recently ?
> >>
> >> The absence of Fixes: tag is a red flag for a net submission.
> >>
> >> By adding a Fixes: tag, you are doing us a favor, please.
> >
> >Yeah, wasn't entirely sure on this one. It fixes a problem, but it's
> >not exactly a new one. A quick look at git history suggests this might
> >actually be something that technically pre-dates the move to git in
> >2005, but only really became a problem with some additional far more
> >recent infrastructure (tc and friends). I can resubmit it as net-next
> >if that's preferred.
>
>         Commit
>
> c2edacf80e15 bonding / ipv6: no addrconf for slaves separately from master
>
>         should (in theory) already prevent ipv6 link-local addrconf, at
> least for bonding slaves, and dates from 2007.  If something has changed
> to break the logic in this commit, then (a) you might need to do some
> research to find a candidate for your Fixes tag, and (b) I'd suggest
> also investigating whether or not the change added by c2edacf80e15 to
> addrconf_notify() no longer serves any purpose, and should be removed if
> that is the case.
>
>         Note also that the hyperv netvsc driver, in netvsc_vf_join(),
> sets IFF_SLAVE in order to trigger the addrconf prevention logic from
> c2edacf80e15; I'm not sure if your patch would affect its expectations
> (if c2edacf80e15 were removed).

Interesting. We'll keep digging over here, but that's definitely not
working for this particular use case with OVS for whatever reason.

-- 
Jarod Wilson
jarod@redhat.com

