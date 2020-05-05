Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A98C47258
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 04:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E87412087E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 04:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="D6pOHAQq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725915AbgEEEWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 00:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725298AbgEEEWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 00:22:36 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70664C061A10
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 21:22:36 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id k22so663586eds.6
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 21:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uJ0y6FcFB9jMQW7+VyYkys9OyOfLGv891tBYXbKQ6Lo=;
        b=D6pOHAQqV6oRTxL2e0a/me5SShTY0XO/9NZf1dqbqzyQwZgQF3OarvhBJyqYJN0vjO
         R5Ixk0dgTp9/EoOjz0rEcr0mPHhkEKxtTWV8FnJgtUhE/0w7hyYhPO/U7mbGI0Lj4LCf
         typkORdm614GhaxIgrXewRMy0s/Rm7s7+FiKYI9aKY50ys18ZWYJhcAQA5DEU9sc+eoL
         S0NjlXGpbt/FrqTmZrrQ3r3CjSYwmjVrUJunR0lNJUWKY42njsJqi9vwBhqDFVqWHE6q
         HrD3+KbbvTIG+t+7wE1NPXVG7sUeofXBAV9ZWVqZldNFKRWqHbYonZvPwyVm1HhyM/oR
         1W+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uJ0y6FcFB9jMQW7+VyYkys9OyOfLGv891tBYXbKQ6Lo=;
        b=UVtagEGqu0wY6nEH7DLFGZ9obeJ6nBcgo59SQtQE1/7VTUReJhDos35KU3QGgjihsa
         tGEXAyVA+ElYYBI5WcInlB+8zRQSd6ISBFAsFSLpP4pwu++KH2y+pdYHZ+VwPpCoM8br
         mQvxkAeiF1RqZhlOeT+LDitAtBjRBZAwR+l0F3ZSHgNCO79Xsw7lFTcMwiPwF1Hso0yP
         Vj2EjdukL1ZLwXfGK4MQKMmixp0ugovStGVcY/qBF5ESjIikoCT/VXF4M0NN7thYIKDQ
         gpJsadN1INyhi3XhZulRmPqdYyUsvTri7fMYCiOACafZ6IwjNmO4Tirxd8/niL5/edgy
         hpiw==
X-Gm-Message-State: AGi0PuZfXICf2ZqDbt8wlIRyU2lBSGGf4jV9bfn9syurU605Ns/pB0z4
        8EJw1nxbfslC4wBIOqVriFr0yRu59kol/uwZQ2uzhA==
X-Google-Smtp-Source: APiQypKrSlYwMkQPNUw8t3+Xw52t8PsrOt2V3d2FTdJ37MpHOu8qVhpo1pFWdq/+9CH/1SCr+fYJEYbsTqkYq0TiiB8=
X-Received: by 2002:aa7:c492:: with SMTP id m18mr960081edq.346.1588652554919;
 Mon, 04 May 2020 21:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200502143555.543636-1-pasha.tatashin@soleen.com>
 <20200502143555.543636-2-pasha.tatashin@soleen.com> <20200505010219.GA2282345@jagdpanzerIV.localdomain>
 <CA+CK2bASiWe=w07gsc-_fFZxPY0SSECSYh6femUCA8yugEpuRg@mail.gmail.com> <CA+CK2bAZAAzAK7G3bJ5dOHR__5+a8LgWPVBzwM+TnbHdVKDUgQ@mail.gmail.com>
In-Reply-To: <CA+CK2bAZAAzAK7G3bJ5dOHR__5+a8LgWPVBzwM+TnbHdVKDUgQ@mail.gmail.com>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 5 May 2020 00:21:59 -0400
Message-ID: <CA+CK2bAPhXL_p2WkDaLshw2U13KbdU5NMH6qJsy8YTq3rwZwBg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] printk: honor the max_reason field in kmsg_dumper
To:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     James Morris <jmorris@namei.org>, Sasha Levin <sashal@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>, anton@enomsg.org,
        ccross@android.com, Tony Luck <tony.luck@intel.com>,
        robh+dt@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > I changed it to make code cleaner:  for such basic operation there are
> > too many conditions if we will keep it inside the kmsg_dump().
> > However, if being able to set always_kmsg_dump dynamically during
> > runtime is deemed important, I can change it back to be checked in
> > kmsg_dump.
>
> If you agree that we do not have to modify this variable dynamically,
> I will also change the permission here:
> module_param_named(always_kmsg_dump, always_kmsg_dump, bool, S_IRUGO | S_IWUSR);

Hi Sergey,

After thinking about this. I will move this logic back to kmsg_dump(),
to keep the current behavior where kmsg_dump can be modified during
runtime.

Thank you,
Pasha
