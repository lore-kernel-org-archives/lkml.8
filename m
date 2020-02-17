Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8C85C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 10:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC0E2206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 10:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iCWesEqn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgBQKtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 05:49:49 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:41085 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727503AbgBQKtt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 05:49:49 -0500
Received: by mail-ot1-f67.google.com with SMTP id r27so15612668otc.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 02:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6MkNl3Abs/Zhpl/WspSWXMtoc/Dld+RTVCvPuIDTGmM=;
        b=iCWesEqn79wrDAMoUjzzwp5x2orkx7XfePkUaMJEDylcZXa07OlgSTfCTS2Eh6NYMk
         t1zVkR74buksJ0bBuxqUtoUD6gPtTRit7gaFecJS2S9t89HchGipLixE/uFoodO3Dx1M
         Sl2dYVF9uzU3/BuLNrIhhWSNa3BFBwxdx6wSLJMlk6Pgo65Tiu/W4CybO6PMdkbXuNZV
         eageRQ6zuP+stzxhdP9j4dioXOEWu8dIQgkjlDYh3FXsLBFIRyJSV1e67srb4SBuSXie
         QP/ngLCfq7AY+zDDICCivuIhUG8C/Xa2yAlONZWqg/Og+kFZBFeMkNVvibxHvLvI+oUP
         0OWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6MkNl3Abs/Zhpl/WspSWXMtoc/Dld+RTVCvPuIDTGmM=;
        b=MmeeLDEe/iGih45LFInyXsgP4z+ueuQZcZ8q2dei6MbWy7GdGH1niZpd2+OQaYkdJO
         2A+E/UAsUkzC5QI0ldy1uXUy89ItTJNkiX5hx5SAmRJogmS1Ptsyd9xPDKGSi3P2rd8M
         He9iVkza9GJeM/xyonitCiEon1PYiuqC+AZXeQt4qXjDNoNrqwdDo6a3D6DAyFToNO4Y
         laksZ67HlGx6t9TJCZyH3u+IGMDy2c7LWbzd3Jhh8C/UcRLJEDMp7E/63mPc8G3xJUD8
         PW2LO9SvWe5oJAVJywZ40o7VsGsWKlmuAOzi3JK8uc4ngF1Nv3/kRskgtGZuTF16mWuO
         FAvA==
X-Gm-Message-State: APjAAAWtBbqKzU4hgRUuvYzpxTJXVvlZFsgz6Q7x8l3VW/HPQq8ImOUP
        507auE4hebV8/AkWHrNJLtmhRk5OhN7y83a7Gqm02FJT
X-Google-Smtp-Source: APXvYqxiY98U5GsKZwWm2SB0qiQjRLVZ82wrOV/Wdh3mKbpLXSJsEM+gtxb9OnxaRmas4wY8IzMGqiRmhQ+9di/zWM8=
X-Received: by 2002:a9d:4c8c:: with SMTP id m12mr12055496otf.312.1581936588572;
 Mon, 17 Feb 2020 02:49:48 -0800 (PST)
MIME-Version: 1.0
References: <20200214153535.32046-1-cristian.marussi@arm.com> <20200214153535.32046-4-cristian.marussi@arm.com>
In-Reply-To: <20200214153535.32046-4-cristian.marussi@arm.com>
From:   Viresh Kumar <viresh.kumar@linaro.org>
Date:   Mon, 17 Feb 2020 16:19:37 +0530
Message-ID: <CAOh2x==CEWNCQ8YT9nyBDjmWx=jLGEADKm400SafkitEO6OCfA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 03/13] firmware: arm_scmi: Add notifications
 support in transport layer
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Sudeep Holla <sudeep.holla@arm.com>, lukasz.luba@arm.com,
        james.quinlan@broadcom.com, Jonathan.Cameron@huawei.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 9:07 PM Cristian Marussi
<cristian.marussi@arm.com> wrote:
>
> Add common transport-layer methods to:
>  - fetch a notification instead of a response
>  - clear a pending notification
>
> Add also all the needed support in mailbox/shmem transports.
>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---
>  drivers/firmware/arm_scmi/common.h  |  8 ++++++++
>  drivers/firmware/arm_scmi/mailbox.c | 17 +++++++++++++++++
>  drivers/firmware/arm_scmi/shmem.c   | 15 +++++++++++++++
>  3 files changed, 40 insertions(+)

Reviewed-by: Viresh Kumar <viresh.kumar@linaro.org>
