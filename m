Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02600C433E8
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 01:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEC8020888
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 01:02:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gv5J7slR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733219AbgGWBCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729423AbgGWBCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 21:02:34 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCCBC0619E1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 18:02:34 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id a23so2143185pfk.13
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 18:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nUCwRjT2pU2Gmv3Op2+ljHBnuLbX/BdWuYfwk3p2dPU=;
        b=Gv5J7slRS2adw592HJRD5Dk1x0nICM0czHuAtw+Bea1LUJWvVeWd0EXViOfOPO1aIz
         lZRq1TTWDGIpJFyqeXnKCiX4h5lGMCqz+sDdJoYXUjk2nk0smYwqWnSg3ia+ENWx3JL6
         J3P2+rh7riPtr1zCP0JTRttUOoJt8xjmKnixeV5qmaJMSe8T1E39p3iyzDBlQ/bMcJgG
         CgUONWqmmby9jG30sRUM7Kw4PSnEj4qGFFW1pVFZrnjJzniW8fYV5srexWGwLHMe67Tb
         Xoo/sWsbkcjREY3TQbYqcS+/AG9DB2VIYxYjlkTctj6thbZspvKB0TG84njjduRKwvae
         rdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nUCwRjT2pU2Gmv3Op2+ljHBnuLbX/BdWuYfwk3p2dPU=;
        b=t2bK1tRa/jp960AqDOWVVbU7P8jfbiml1z9BC2SA8DJ/anxPLDb4pi0bDemI/xVLtY
         Qx+V59M2RQ20WozbItG8K5ykn4huXiPfcCaKULnf0F7DzcfFRbwep1UhXh7NXtbuElx9
         pGzBOkbsS4ltcPH5Obr/IOFkpXORVKERUSGV6WCpAp5uiW5lvhmuGgq90qyrOvTX+/SC
         nXg7RTbZitKguVxgu/e1rn+DQ+ebjFs0BC6puHAw5892gPEhGts7dh+eh7r1o6lCAmFl
         lvH9wc5Muz1OJlYfEUHwk6iNHLexpI4B1mP0lBa7cr0qD5wYrLvZujz5Oeby10dRyn/a
         tBMA==
X-Gm-Message-State: AOAM5313jp57vLy3tJgHkFE4NGtD7J4IFYqPXKhRfzQKpRlFs1XmI5MF
        kPltDZsm5+yZwtrcfMntHqBeuENYr4UwUfJq52ebCg==
X-Google-Smtp-Source: ABdhPJy3F0JIAPnQcvEuqhIjvTmhlNc50e2Fao3jv3xBkWy1mCNh+m6SvHBS7aYoHWIqwjhyNEQp/34XrbengBxtQHU=
X-Received: by 2002:a63:495c:: with SMTP id y28mr2164282pgk.30.1595466153346;
 Wed, 22 Jul 2020 18:02:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200722201313.754671-1-saravanak@google.com> <20200722201313.754671-2-saravanak@google.com>
 <084158b7-f6dc-167f-b06d-db617fb2df29@gmail.com>
In-Reply-To: <084158b7-f6dc-167f-b06d-db617fb2df29@gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 22 Jul 2020 18:01:57 -0700
Message-ID: <CAGETcx-CajYnh=ZOkGBxrSUHe0uTAwJ_gZ8EJV1jrq-jNmaBVw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] of: property: Add device link support for
 pinctrl-0 through pinctrl-8
To:     Frank Rowand <frowand.list@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 22, 2020 at 1:56 PM Frank Rowand <frowand.list@gmail.com> wrote:
>
> On 2020-07-22 15:13, Saravana Kannan wrote:
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
> If you were to implement the more general pinctrl-* case, roughly what would
> it look like (pseudo-code or english description is fine).

So when I say "unnecessarily complicated", it's in terms of
readability. I can't use these macros -- which are succinct 1 line
entries that are super easy to understand.

Pseudo code:
parse_pinctrl(np, prop_name, index)
{
    if (doens't start with "pinctrl-")
        return NULL;
    ret = kstrtouint(propname + strlen("pinctrl"), 10, &val);

    check that it's not something line "pinctrl-2nd-val" that'll still
set val to 2.

    parse phandle with args and return phandle node.
}

All this when effectively 99.5% of the DT just use pinctrl-0,
pinctrl-1 and pinctrl-2. There are a few that use pinctrl-3. And
literally 6 DT files in the entire kernel source tree use pinctrl-4 or
greater.

And for those 6 files, pinctrl-[0-8] really point to the same pinctrl
node. So even if I didn't parse pinctrl-[4-8], all the device
dependencies would be tracked properly.

-Saravana
