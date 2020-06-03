Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74353C433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 18:42:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C4852074B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 18:42:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dd1HIESh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgFCSmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 14:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgFCSmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 14:42:31 -0400
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6922CC08C5C0;
        Wed,  3 Jun 2020 11:42:30 -0700 (PDT)
Received: by mail-io1-xd2d.google.com with SMTP id p20so3412504iop.11;
        Wed, 03 Jun 2020 11:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/ayQQstOIIDAVAm7DUEsy/1EwnXM4OCks6yx7VXAtz0=;
        b=dd1HIESh9wjeMB2DRzWc+TNFLWLCSZ/CoiLCmo3JmBscQFak1Qq5oY08YE2L90GXH1
         2fDZoyLmCNOpFaJGmPaoWBRHdh7x9KNy3zcr7le7XloQTpGztHhmv6uvU8itraWKN2MM
         zFXSdBavffxBrwb7rSWk4WU80egnSDepHzFonmWiqFp+6CB4gF4hvWDsnCpDni7YsiCw
         g5VmI3XerxuTnhVsTh+Za3GihjwXClmwwcfwgIVSKSzqg123q/6ldP+D22L7yDa3WzIM
         Yr/0CEv4pFOfO7aUjaWiaOzh/TyMoreWW9BovBBi6SrhGREC/mRHvAImkkKlRkMJRAJ2
         eQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/ayQQstOIIDAVAm7DUEsy/1EwnXM4OCks6yx7VXAtz0=;
        b=iUK0fTYMVvj/6tmA/J3RrrS7mOBM+gNmPztdBgWfBzjGI7eygD49tmSDv3zAa6BBqD
         WlqyV8Mb4ejPSQzRkwVduuGbHb0e8ewYDLqk1nEC3li0vjNd/ueAxnXGLOzYBC4Co6bA
         lbwuADwnpmP603sCWdfnX9PAaJLfB8qAhmdVSaeGeL0f+O9Af4SIw47vUQrwiZVMDbIG
         1Z3G8sYYrO+CJZU4BNygh2LPA/klb6vYk6JnMs2jYYSWwAHB8fQDlwLxgCVxT1ZZHSeI
         zNePoGPkqdhT8qRD5JdC7fuZoYBaurcw7D4iP/Zvu/WJFYi6E2ITwwRmPV9XzzqH5Vlm
         EWcg==
X-Gm-Message-State: AOAM530ev5ilENOUrZEcMg0DrKw0LzwxwcgwB+ZgyoBu/6IzTysuKI5r
        DKqri79I6Nl9F9oVWN0AQJXK9IND6LMVkyg4PnA=
X-Google-Smtp-Source: ABdhPJy9yjqCeCXKJJyrSLwf3jOll6RD3VKatdzC9kRnS4OaxQByAamVPr9nSXVqOHcrBwK1GfHmQzHWsfk9kuBkRSk=
X-Received: by 2002:a5d:8958:: with SMTP id b24mr999661iot.53.1591209749811;
 Wed, 03 Jun 2020 11:42:29 -0700 (PDT)
MIME-Version: 1.0
References: <0a50f0cf5593baeb628dc8606c523665e5e2ae6c.1589519600.git.viresh.kumar@linaro.org>
 <20200519012927.GT2165@builder.lan> <20200519034055.hfvifqz442yfduhg@vireshk-i7>
 <CABb+yY30nmbBUzYG62xGEbrr7107h_Edyq3jKPheZAQ0Cvr9Yg@mail.gmail.com> <20200603183120.GE23722@bogus>
In-Reply-To: <20200603183120.GE23722@bogus>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Wed, 3 Jun 2020 13:42:18 -0500
Message-ID: <CABb+yY2KXqRnxqHC-Hs8NsosEPtyTYO4v_b1cCGs9Lphpz_X+A@mail.gmail.com>
Subject: Re: [RFC] dt-bindings: mailbox: add doorbell support to ARM MHU
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 3, 2020 at 1:31 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> > >
> > H/W is actually fine :)   Its just that the driver is written to
> > _also_ support a platform (my original) that doesn't have shmem and
> > need to pass data via 32bit registers.
> > Frankly, I am not against the doorbell mode, I am against implementing
> > two modes in a driver. If it really helped (note the past tense) the
> > SCMI, we could implement the driver only in doorbell mode but
> > unfortunately SCMI would still be _broken_ for non-doorbell
> > controllers.
>
> Should be fine as the specification is designed to work with only shmem
> for any data transfer and mailbox is just a signal mechanism. I won't
> be too worried about that.
>
Please clarify how it will work on, say again, rockchip platform with shmem.

thanks.
