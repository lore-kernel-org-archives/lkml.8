Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D9FC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 23:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF55D207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 23:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z7YPQvc6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388817AbgFXXWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 19:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388735AbgFXXWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 19:22:24 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4700CC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 16:22:24 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id 5so1583220oty.11
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 16:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ixR4kIucjZXiRtwMzxKSRPAHfL+FLubXnd+GvW1h77s=;
        b=Z7YPQvc6norraPne8OACkSUlKBVmLzg0FP9LZ7gduh3U4fiXJckSxRV8Rw/M6ozRWJ
         CjO2/AkaXd9R+o9hVzdrRw1hQuKb2mCZ1GENwhRmQMvXPb4YogDL9Anl/z4vNHibhS7O
         NK3IrFNQK8cYxuy21niT7Scw64KVhXT99fgZQNoQLHaS4zd3qSpDwRBNF69Va9CI3Su1
         XOZeXBH0cz4qgxb4LruxmpvoG9P53uUpxNMeGz+7XTSEjo/48iNu+ULMKQcpWyfIRnzG
         WGAjrfnyEm3aD+QzMcQW7ICI5L5cy+GzJeuU+I+SuwLYvFoAuMEzV69tL1xuT3vPCjHY
         qcNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ixR4kIucjZXiRtwMzxKSRPAHfL+FLubXnd+GvW1h77s=;
        b=gN2l+J4g1qeDN8TtYBjNG7Tmj3C+R4fCbLiOnsHUOOgFwW8i8tv8c/19MGUKJYji+D
         ODaD62HhmxqoFEsooB77otmjH7T2ns0/3WdwTJktasEUhybv3gyM2r4deaDKRzXZPpP8
         sL4aUfpSwQBCZpCgegQpi5iY0HFsnDCgKfEtHPb6BW0mDpRMjD5G75atJksOUmB0pEuw
         5uLBziPLzJBzxTKFSsPolDqFU1fKExe1XPGu9OlU/j4HYDe5BuEhaK1xO/atqHQKAoCq
         +1r9DQ/asmfUh7kj6eUvrcbAsnGJL0NTXlMg1tX2sDfBeUiZLJKob0Vrf+MBrMzHKnYc
         mEkA==
X-Gm-Message-State: AOAM531mtnI3n7rfImlUckEwlt7TteHd+oSabmOvRGlWIG4r7sJWOZc8
        aML/PuIakpiZOIyI1G9y7V0fRAFC7m26FabtvRDRyA==
X-Google-Smtp-Source: ABdhPJyDeT0KDPGBY+XrtAn4IpWyHShWZgknfbRvrpyv5ICBQ0JbfIvQE3n6cpvnMFZ4tsBYi4nHf3OPeZeTeb/2RbY=
X-Received: by 2002:a05:6830:1e13:: with SMTP id s19mr9494408otr.102.1593040943632;
 Wed, 24 Jun 2020 16:22:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200616061338.109499-1-john.stultz@linaro.org>
 <20200616061338.109499-5-john.stultz@linaro.org> <20200621060055.GA2421@builder.lan>
In-Reply-To: <20200621060055.GA2421@builder.lan>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 24 Jun 2020 16:22:12 -0700
Message-ID: <CALAqxLUhi4qQpz5b+6hc8T5mA2E6ugg6UD44WA+Dc2+=Hjm=DQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 4/5] pinctrl: qcom: Allow pinctrl-msm code to be
 loadable as a module
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Andy Gross <agross@kernel.org>, Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Saravana Kannan <saravanak@google.com>,
        Todd Kjos <tkjos@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        iommu@lists.linux-foundation.org, linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 20, 2020 at 11:03 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Mon 15 Jun 23:13 PDT 2020, John Stultz wrote:
>
> > Tweaks to allow pinctrl-msm code to be loadable as a module.
> > This is needed in order to support having the qcom-scm driver,
> > which pinctrl-msm calls into, configured as a module.
> >
>
> This means that we need a "depends on QCOM_SCM || QCOM_SCM=n" on all
> entries in the Kconfig that selects PINCTRL_MSM, or switch PINCTRL_MSM
> to be user selectable and make all the others depend on it.

Oh, good point! I already had to fix that in a different tree, but
forgot to move the fix over to my upstreaming tree.


> >
> > +MODULE_DESCRIPTION("Qualcomm Technologies, Inc. pinctrl-msm driver");
>
> It's the "Qualcomm Technologies, Inc. TLMM driver"
>
> > +MODULE_LICENSE("GPL v2");
> > +
>
> Please don't retain my empty line at the end of this file :)

Done and done. Thanks so much for the review!
-john
