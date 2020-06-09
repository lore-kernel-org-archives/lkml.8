Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5F2C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 21:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B441F20737
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 21:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="WyzmLb5S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgFIVtL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 17:49:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728193AbgFIVtE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 17:49:04 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBA4C08C5C2
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 14:49:04 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id m32so12390340ede.8
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 14:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dF+RQ0AQoP42Ff+qtYJONpy5p7iRkssBS+Qb7xcQPb4=;
        b=WyzmLb5SHrusklbUivTJLgHqRqnRqMxkpynwwTr3vbBJiY6c7PmcAEIIIvP2jlHn6B
         mZwe2OOpQoB3n3VcfW5KVnwFuOM1x+srCuMxz5iJjpGg4WKloGOQp9oFUSx04T8ZmSKR
         +4GJ7DTuahDB9EhglmBziGz/xDhPcnwhLos0OryPrLEwh9QgwtvC3gKB8wZ3SOADGhFM
         KWszOiOj/3MgGRj8POFzDeNzXiDjnC5qI56jh12gAEuVwMzsAgIx3nZhLKEJo9WZXfEA
         OJSYTUELmgqymgcl8RsPJmsaUdTb+H7K9spydxz6F8uCXlX5GkKk/K7xTley7ISL2JWu
         E1Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dF+RQ0AQoP42Ff+qtYJONpy5p7iRkssBS+Qb7xcQPb4=;
        b=rh8ZOfTEkolDvgDLhjujV89EBGQzngAVpXqfrHNUfKEbpMBpNFVPFfdiH2pjAvX4WK
         ZM07eY4xCqFi+g/oBnE1uT3N4a9RiJ+Qkycq3A96QzKLGAQombKuE7TCzoEZ7Cgsl55t
         1GnzcmEqC6725lWRJYPuZ52PYdilsXgDe+z3fWZPbuxPmoCzsHUKCX4sy2JZ8246CM8B
         TDg9+X8ar1jFATq+fe52DFAcsX3mhSIckNI92AsamPx1elwHI2dwePjnZqPIC1gEBdDb
         I4JDqu6FcJ+VZHjRhfnf9zaWQ47uTYvYvebH6/SN64m+V6nv3QvquDcLHPAPKf2dEyII
         Z0BQ==
X-Gm-Message-State: AOAM531qb8ujREUvKxXKfpxl72mUnfvCBtsOZelTdfi0pQotznP+g4O8
        AiOyI6BT6FiH6MQwQktE/DLsi4Bd92RIUDlUl932YA==
X-Google-Smtp-Source: ABdhPJzbVOtjVZ79aGfP2Lwa/ckHUcZ4Mr+zJirQEkN0p/xLAj8D/4/tCBcmX7Ur2OZQfbfkbGZpgqEbiStWTsnkvUA=
X-Received: by 2002:aa7:c944:: with SMTP id h4mr28309011edt.383.1591739342882;
 Tue, 09 Jun 2020 14:49:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200609101935.5716b3bd@hermes.lan> <20200609.113633.1866761141966326637.davem@davemloft.net>
 <4d664ff641dbf3aeab1ecd5eacda220dab9d7d17.camel@intel.com> <20200609.123858.466960203090925019.davem@davemloft.net>
In-Reply-To: <20200609.123858.466960203090925019.davem@davemloft.net>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 9 Jun 2020 14:48:51 -0700
Message-ID: <CAPcyv4jr9F_0q4S-LSvHzJK7mamLW-m1Skgw7cXvkZYNtStyxA@mail.gmail.com>
Subject: Re: [PATCH ethtool v1] netlink: add master/slave configuration support
To:     David Miller <davem@davemloft.net>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew@lunn.ch>,
        amitc@mellanox.com, david@protonic.nl, linville@tuxdriver.com,
        marex@denx.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        petrm@mellanox.com, hkallweit1@gmail.com, kernel@pengutronix.de,
        christian.herber@nxp.com, mkubecek@suse.cz, kuba@kernel.org,
        o.rempel@pengutronix.de, Netdev <netdev@vger.kernel.org>,
        mkl@pengutronix.de, f.fainelli@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 9, 2020 at 12:57 PM David Miller <davem@davemloft.net> wrote:
>
> From: "Williams, Dan J" <dan.j.williams@intel.com>
> Date: Tue, 9 Jun 2020 19:30:50 +0000
>
> > On Tue, 2020-06-09 at 11:36 -0700, David Miller wrote:
> >> From: Stephen Hemminger <stephen@networkplumber.org>
> >> Date: Tue, 9 Jun 2020 10:19:35 -0700
> >>
> >> > Yes, words do matter and convey a lot of implied connotation and
> >> > meaning.
> >>
> >> What is your long term plan?  Will you change all of the UAPI for
> >> bonding for example?
> >
> > The long term plan in my view includes talking with standards bodies to
> > move new content to, for example, master/subordinate. In other words,
> > practical forward steps, not retroactively changing interfaces.
>
> When that knowledge is established legitimately in standards and
> transferred into common knowledge of these technologies, yes then
> please come present your proposals.

Our hands are not completely tied by the specifications, as a
community we have a non-zero level of influence over standards bodies,
even direct participation in some. So we could do something stronger
than passively wait for standards to catch up. For example, deprecate
our consideration of future specifications that include this language
and set a cut off date.

I understand the confusion that arises from using terminology
differently from the specification, but at the same time when
specification language actively hurts kernel code maintainability we
change it. For example, when I did the first iteration of what
eventually became libnvdimm Ingo rightly reacted to the naming being
too ACPI specification centric and wanting more kernel-centric naming.

If the common kernel name for what was formerly called a "slave"
device is a "subordinate" device then the confusion is lessened, only
one common kernel translation to consider.

> But right now using different words will create confusion.
>
> I also find master/subordinate an interesting proposal, what if master
> is a triggering term?  Why only slave?

"slave" has a direct connection to human suffering deployed at global scale.

One way I think about this is consider we have our first ever Linux
Plumbers on the African continent, and you had a choice about giving a
talk about how the git master branch operates, or a talk about slave
devices which one would you feel more immediately comfortable leading?
Any hesitation you would feel freely using the word slave with a
predominantly black audience is a similar speed bump a contributor
might feel needing to consume that term to get their job done.

Explaining "no, not that connotation of slave" does not scale as much
as transitioning to another term.

> I know people feel something needs to change, but do that moving
> forward for the technologies themselves.

This is the start of a process that the kernel community can take an
active role to lead, we have it within our control to not wait for the
lowest common denominator to catch up.

> Not how we implement support
> for a technology which is established already.
>
> Plant the seed, don't chop the tree down.

I appreciate the engagement.
