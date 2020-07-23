Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A18C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 01:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E1BCD2080D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 01:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s8JVwLed"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387521AbgGWBIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728607AbgGWBIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 21:08:18 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC19C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 18:08:18 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id w17so1798400ply.11
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 18:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7BNQLQ9xYSO5Mk/qX3aSybUJ4uhC8hWopwOjSfKz/AY=;
        b=s8JVwLedb44KpLKEpJGBdaH2HwLlSViCcbaEndk2FLmmnY8NxziuIPK5ZJTb5qd0T0
         2PEnrT3mJZhns0ncUlW/6mLXkbKnQNFyeVfBwgdT3nuj0k1Qm1C+HjK/mBjq6kdEaBhQ
         TFeOttB3kQJZE+Wzv1w+oak3y/SsuP15iTdpxNUamy3xsWgu6kFtmckK3iMMw+rp0xNZ
         Y46oEFVJS61DHWcxMwFPvtE5hUVLtxs5+At2xfsopm7Shqj9vQsUdP5UZLgIYqL7KWHy
         z3MaO5ZJSal9MI0pN8SBatue4N3cECvIN99/fbJkq1Ig76FlW0C0F5CSn7IQ43vTLILc
         4HHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7BNQLQ9xYSO5Mk/qX3aSybUJ4uhC8hWopwOjSfKz/AY=;
        b=iL5Kv6ArYaIFgUx/i7+VtHqLv7dMhEAysFRBe3ltzLDpfcIBvxUaeWgO5T7wI7KVmA
         8nHoDqroRUAQhB5vBfOPXb1jrWaI22Yo8IfsXP/H0zTkkwQdzD3eTOqMZiO1T+Armhy0
         GIc5rZWMgHguohOpE0cRNcURxGneihhdIk1tEQoZ3hBTh8gBrrVIPCGiwSNYsuWEJAuP
         Qv/F8KplHoqg+5pOqGE12H7sHHH7nZeBp1KvDC1wITphrE6HOYbhQ5RRvrr6ETjQC7Kf
         yEndJouAJitab5fdttL7AB8OckDzU7II8zegEV3pigdnoHlsPrLwtfg0Vsty1uXdF9gI
         Hdlw==
X-Gm-Message-State: AOAM533tBZwWKIRrsxw2WzwLkFFFJmgNqoS45gitXy7PEuSNuJeqBBkG
        1MKxnQ2HVRmRp2BD9qSfNDUSBU2O78xAYm46v881jg==
X-Google-Smtp-Source: ABdhPJyEOsGWXSqvQ8/0Vu5HwDfJ1zjjpfbswuwK2/vrArcK+pe99mQ+HuJpwjMM/NO3sn276+hfoK22X8Gh0KBaAsU=
X-Received: by 2002:a17:90b:3683:: with SMTP id mj3mr1879835pjb.91.1595466497424;
 Wed, 22 Jul 2020 18:08:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200722201313.754671-1-saravanak@google.com> <20200722201313.754671-2-saravanak@google.com>
 <CAL_JsqJvhpghE=LR=ng-gL5ek-7LOC1CGfOx6Vr-iACu-TX_fQ@mail.gmail.com>
In-Reply-To: <CAL_JsqJvhpghE=LR=ng-gL5ek-7LOC1CGfOx6Vr-iACu-TX_fQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 22 Jul 2020 18:07:41 -0700
Message-ID: <CAGETcx9eRQPTH8YVtqtDdLkwHYbTw=DhWfryY98ZQ4_NOvALxw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] of: property: Add device link support for
 pinctrl-0 through pinctrl-8
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 2:09 PM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Wed, Jul 22, 2020 at 2:13 PM Saravana Kannan <saravanak@google.com> wrote:
> >
> > Add support for pinctrl-0 through pinctrl-8 explicitly instead of trying
> > to add support for pinctrl-%d properties.
> >
> > Of all the pinctrl-* properties in dts files (20322), only 47% (9531)
> > are pinctrl-%d properties. Of all the pinctrl-%d properties, 99.5%
> > (9486) are made up of pinctrl-[0-2].
> >
> > Trying to parse all pinctrl-* properties and checking for pinctrl-%d is
> > unnecessarily complicated. So, just add support for pinctrl-[0-8] for
> > now. In the unlikely event we ever exceed pinctrl-8, we can come back
> > and improve this.
>
> It wasn't immediately clear from this that pinctrl-8 is the current
> max you found vs. a should be enough for a while.

Hmmm... I tried. Looks like I failed. Open to copy-pasting any commit
text that you think will make it clearer.

> Pinctrl is also a bit special in that we have 100s of child nodes and
> only 1 to a few actual dependencies (the pinctrl node). I assume in
> the end here, it's just the pin controller node that's the dependency
> rather than creating lot's of dependencies?

Correct. In the end, it just links to the one (or few) pin controller
devices. Is there a requirement that all pinctrl-N properties point to
the child state nodes of the same pin-controller node? Or can
pinctrl-0 point to one and pinctrl-1 point to another pin controller
node? If the former, all I'd need to do is parse pinctrl-0.

-Saravana
