Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01EF6C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 16:25:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8270206D5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 16:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B3BPjaGW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbgA3QZH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 11:25:07 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46007 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbgA3QZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 11:25:06 -0500
Received: by mail-lf1-f67.google.com with SMTP id 203so2657566lfa.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 08:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3tJQxQn36anxbwALkCaLbBJq4eUAmsOs9pq3YyQsRhk=;
        b=B3BPjaGWPoAABc9xnyRAFTWgCw9wrB1ZeT2myJ4j3qNZfjdLGQbtA6ppzfO89/TBay
         ttvDuo9U7iCYnbMNOzUfe+B57ZqaO72i2wXXLcvITDPrdYX21Z3GMK0GscSqPhB96zjn
         iwMR8iz22LA7x1mU+AKtUlodr9TxWhoVUWP2jAV5Ej3ICcabhMyoMktRvb3ijfcIU47D
         vpPtwqeJAbEt69pvag9vYsry1ggY1srP0u4R/I9XmMy3jwvhumtpJvGN5uyEiBcnkWsY
         Ui+JAv/BVlEkHI2seHJqjJtqtIz+OLFYZw3BB4kTFzlLgNqV66SfpQ3w28AuUgQs8vzt
         wD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3tJQxQn36anxbwALkCaLbBJq4eUAmsOs9pq3YyQsRhk=;
        b=Xki/q7oZa7Ph+xMn6yzghC0nUYG/TZQLDua55Cd6FpmgnVKjdHRwvir+90TqzoWPd8
         IsOk1fvXbAxQ4EtwUl7MOFRjjC12IO5MFEmSnFYjquKlfFRIDsUhr/vqKXaejHB+T4ZD
         Bc6mqGaPaYdMWVzOamQYm/u/eAqFJCkiZZTIQzOH84mSMACGniP43JUWWITt94QJaHUn
         5lQJKNPjlHjCm+KmQ2irN2Scr0mpWuT2Usuh4NQNWNEXgvR+4zG8ZWMr4HYUvDAcGZLH
         TgXTmeHlqhbqKafPOIF5KqjU4xcW7qDx3wnrlcNC7aOmtTtRBLa2Hdpy2/ny3B4/6mtH
         6k7w==
X-Gm-Message-State: APjAAAU2R36N71VWzzcL370cWAbd6eLCvWBCyafrH14c+FZPGNXBwtwb
        cjr6s6Lmn5loG+kKRydry6s3kD2cNsBlQM0tkTh7zYOpRs9igw==
X-Google-Smtp-Source: APXvYqydvKInvstXGIHTwegzHLQJT5RJWEFSHufspFXlOKO38V4tozDLJgTX+szwedAKTTDxyaiFV51NI9c674cbgWI=
X-Received: by 2002:ac2:5e29:: with SMTP id o9mr2996848lfg.81.1580401502991;
 Thu, 30 Jan 2020 08:25:02 -0800 (PST)
MIME-Version: 1.0
References: <CAN5uoS_A9TYU2aWf3WVq3KGna6oVswfut+hC7sJWvhfYggMwTA@mail.gmail.com>
 <20200130094103.mrz7ween6ukfa4fk@vireshk-i7>
In-Reply-To: <20200130094103.mrz7ween6ukfa4fk@vireshk-i7>
From:   Etienne Carriere <etienne.carriere@linaro.org>
Date:   Thu, 30 Jan 2020 17:24:51 +0100
Message-ID: <CAN5uoS8o96sZfgx2qU0Mw-3Phud4kjOcVvxz8HXpqo6-WnUK=A@mail.gmail.com>
Subject: Re: [PATCH V5] firmware: arm_scmi: Make scmi core independent of the
 transport type
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Jan 2020 at 10:41, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 30-01-20, 10:25, Etienne Carriere wrote:
> > I've made a first port (draft) for adding new transport channels, next
> > to existing mailbox channel, on top of your change.
> > You can find it here: https://github.com/etienne-lms/linux/pull/1.
> >
> > I don't have specific comments on your change but the one below.
> > I think SMT header should move out of mailbox.c, but that may be a bit
> > out of the scope of your change.
>
> If it is guaranteed that someone will end up using those routines
> apart from mailbox.c, then surely it can be done.
>
> > I would prefer an optional mak_txdone callback:
> >
> >     if (info->desc->ops->mark_txdone)
> >        info->desc->ops->mark_txdone(cinfo, ret);
>
> So you are sure that mark_txdone won't be required in your case? I can
> make it optional then.

I think there is nothing to be done from mark_txdone() in my setup.
Making it optional is more flexible. But transport can also register
an empty function if needed.


etienne

>
> --
> viresh
