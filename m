Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6E63C55199
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 15:35:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FED72074F
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 15:35:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Odv9VoxY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgDZPfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 11:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726146AbgDZPf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 11:35:29 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E92C061A0F
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 08:35:29 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id j14so11682314lfg.9
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 08:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=we74QiB75BtYwlX2vu1/hk6PEpVENj5opPHAohrnsck=;
        b=Odv9VoxY6497vkDTk3+CRrgpuyR/3DNV0ZX8s0CZ9GN4rNPbF0ZAWfH+KZM9MA8Mqj
         lR9kQ0/xxj0SUdi0P3ul3qdJo5Fg0sktrQoC3ayiMfbpbvhfoAV7AELpoFo0TK9CslcN
         S25kQAFoyh7iVFVHblXWMAjwsg3tdzBbYKUYPdygjdmaj5cWt6ohXnQDPgiZddm9MlZB
         g4YLk8AGHQOuQ3xDsRBB7BH7Pvb1RjSpXjTbHsWLOr20iA6s1a8jhb7+PwyTaNqSZdxg
         mypAVWAjp1ICtt7tdNQMoskBTF3XR7JWv3LDOUCyPIpJqqS1L6X6oLRnmIra8zqWztpW
         8GaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=we74QiB75BtYwlX2vu1/hk6PEpVENj5opPHAohrnsck=;
        b=Lwpb3iws+2qtrjQTEUebLiVg9CkmOo3pEZWmTrHk//N7tvqXZ8GUWWC7bydEqxq6O5
         xUVC5p+v32iSwImsc5fLbQx7ZQ8HptaKa1KJDC6iP9ekuNTQ9PifeoZ1r1kawluBlpsY
         EWpDZj62MgmPGh0IQx4hnEh4SX94Bbj3L6YMWRi1u+hjyqDzuIT4N8OwtoeUWWCJ8okK
         R7CHobCOC0i8UwykklqraYovGsWq6KZStuLyaq6wt4EjGa7pCHaXMopxmjYKEWd2xc2L
         c3rvVxo7Q4dhqGxd2hCKqsBfWCaLH3RyPhTlcUM34SrvYXQhCJlQ9bdAon53Mn5/oHEH
         jj0w==
X-Gm-Message-State: AGi0PubbkAjAVOzlg+s0j+G9dcKJ7icldcStvzZJkODOJ0bAavlq6/73
        9rv+kKq3plmR9exGfuu8eiTnTgAE/xVSvpsZK066xw==
X-Google-Smtp-Source: APiQypIQlC5Oq9kecdo1sFNy4lS8r1NT6AHD5X6gYOaNU2NmhTi6HZq5fedzF0ehDBll7oigZUvKxEholtvfWonYUMg=
X-Received: by 2002:ac2:43c6:: with SMTP id u6mr12976089lfl.170.1587915327642;
 Sun, 26 Apr 2020 08:35:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200423064808.10468-1-etienne.carriere@linaro.org> <CAL_Jsq+zNyqcQ2xWceGLz4by=3rV=46wPyj=HcFPZ9pQPF17eg@mail.gmail.com>
In-Reply-To: <CAL_Jsq+zNyqcQ2xWceGLz4by=3rV=46wPyj=HcFPZ9pQPF17eg@mail.gmail.com>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Sun, 26 Apr 2020 17:35:16 +0200
Message-ID: <CAN5uoS9qENztJcd1b4uUMW83+o57gkWE9gEpq3Qd2YV0STA1gA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/2] Add examples of secure- prefixed property in documentation
To:     Rob Herring <robh+dt@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Apr 2020 at 23:59, Rob Herring <robh+dt@kernel.org> wrote:
>
> On Thu, Apr 23, 2020 at 1:49 AM Etienne Carriere
> <etienne.carriere@linaro.org> wrote:
> >
> > Hello,
> >
> > This is a proposal for adding a bit of description in the DT bindings
> > documentation of how secure- property prefix can be used for. The
> > changes in this patch series describe that for clocks and resets properties.
> >
> > Documentation file arm/secure.txt already states that secure- prefix can be
> > used for any property hence the description proposed here are not mandated.
> > However it may be useful as explicit examples of such usage.
>
> It may say that, but any new property has to be documented and
> reviewed still. I'm not sure that anything in secure.txt has actually
> gotten used.

Looking at Linux kernel, U-Boot, Qemu, EDK II, that's right :)
I guess that applies to the so-called non-secure world.

>
> You should participate in the System DT discussions in Linaro where
> how to represent different CPUs and CPU execution environments (like
> secure world) is being worked on.

Fair, I'll get information there.
Thank you for your prompt feedback.

In the same scope, I am to post a change in the Linux DTS files.
A change to define a new attribute mostly of interest for the secure
world description.
I will still post it to the LKML to get feedback about it.
Such new bindings should still be discussed in the Linux DT ML, right?

Regards,
Etienne

>
> Rob
