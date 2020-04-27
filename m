Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 610FCC4CECC
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:05:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CEC920B1F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 19:05:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c08JIixJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726463AbgD0TFP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 15:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbgD0TFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 15:05:15 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2DCEC0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 12:05:13 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id z25so28116650otq.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 12:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nYjwD1cgAWi1h+FC9EQC7XuePn+s5PWM+1lGoIZAVCc=;
        b=c08JIixJpwm3AnUT4Q9UksVmigA3X3foOTQBV6lbJRWOn5Z3K81IaclNk9s814fOuq
         AshvqmDnrLSI2OXna8H/Jg0rEGzqWqR3nMJjjp0KeP0ZeDEe5+YIhIYrNY6QXZNSoJZX
         56q8SFCinQ5mlQ465vQ3UMXSrG/wyIWcDFYrKGivbJ9T9fXvROOkvouGfRWEcF9D/oIQ
         kKeUv/zOARkRlYNSQXxV+atfykVqURXgfoBqgM9W90IIerOpDlYZnffCLtM6TJtHcLIN
         ggGeLNmCDUOuKgEX80BY2Yu0RB8aSOWaqP51g4Jemc/d+inCU68Iw1/lZNLv+YuQL5lR
         KP0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nYjwD1cgAWi1h+FC9EQC7XuePn+s5PWM+1lGoIZAVCc=;
        b=J8iVaMmrQU5i5lILf51uzJVj/1he+hECpHrb3CfUn5p+tY0RMLtLqEUrtnC6NYC+Nu
         552eDbfaqDfinYP9O+yIjDZ7CegEpLoiYm4y9djl6dZ1hpHf8LMwuybKlMO57xODr3LV
         rMXNK9TZXcJ9RGwR/NR0DFie83MkgrKSVLJYbqsiAi7pLV4JCFCvFBargB85w79N6K98
         NPdFq2+kcjSAqGyTnX3BFRmmqh4KSLbF01S3KN+PvpPaR6dPWR8VuI5gZO2cZZjEq9JI
         mK+nkioomKVAu5TWEzOaIpaQiVj+VvV9FR74EZG/AZtpnWFOt+npnxF+YYTIfKy7aMpy
         U3+Q==
X-Gm-Message-State: AGi0PuZuW4BBl8t5DSDopVkXN/I9B7T7/VK9hSaZnVVp1DGPPW2jVdld
        VHqlpB0T1g/oKI8t0I6/Ja0jVDOVg+okST4QpC3ozA==
X-Google-Smtp-Source: APiQypKRsDULSiHYguXY/SspKgeNcy0w4pMmN9hPoGc7kJJm4stawBrL4awYMuu//cDz3DiM2/YDhdKwJFHPeuGlt04=
X-Received: by 2002:a9d:2622:: with SMTP id a31mr20759634otb.231.1588014312538;
 Mon, 27 Apr 2020 12:05:12 -0700 (PDT)
MIME-Version: 1.0
References: <d2934f74d77c637c41d7cb98710cb5363d09e83b.1585021186.git.baolin.wang7@gmail.com>
 <CADBw62pmiguVmuq334eskLAZ5CkrjxohW_fXNjNev+O1U15=OQ@mail.gmail.com> <bd800f7b-05fd-b393-fba6-1965ba89e1b3@linaro.org>
In-Reply-To: <bd800f7b-05fd-b393-fba6-1965ba89e1b3@linaro.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 27 Apr 2020 12:04:36 -0700
Message-ID: <CAGETcx9da-U+dXA6sreTKJQiS3brYh3Hfh_qVYt06=3UOSmT_g@mail.gmail.com>
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

On Mon, Apr 27, 2020 at 10:13 AM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 13/04/2020 04:55, Baolin Wang wrote:
> > Hi Daniel,
> >
> > On Tue, Mar 24, 2020 at 1:59 PM Baolin Wang <baolin.wang7@gmail.com> wrote:
> >>
> >> From: Saravana Kannan <saravanak@google.com>
> >>
> >> This allows timer drivers to be compiled as modules.
> >>
> >> Signed-off-by: Saravana Kannan <saravanak@google.com>
> >> Signed-off-by: Baolin Wang <baolin.wang7@gmail.com>
> >
> > Do you have any comments for this patch set? Thanks.
>
> If my understanding is correct, this patch is part of the GKI picture
> where hardware drivers are converted to modules.
>
> But do we really want to convert timer drivers to modules ?
>
> Is the core time framework able to support that (eg. load + unload )

So this will mainly be used for secondary timers that the system
supports. Not for the main one that's set up during early boot for
sched timer to work. For the primary timer during boot up, we still
expect that to be the default ARM timer and don't want/expect that to
be a module (it can't be).

-Saravana
