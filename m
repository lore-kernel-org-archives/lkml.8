Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB918C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4B8D2145D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 23:09:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eHu1cIr7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgGPXJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 19:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727925AbgGPXJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 19:09:18 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A776C08C5DB
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 15:16:41 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id k71so5507213pje.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jul 2020 15:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uyJjNcCyaCd1x5/819IrrY1FHu5p7NCmrwELbf92SAw=;
        b=eHu1cIr74RawyPqX0Cqg3kfkYi/drr3HXHWhaWKTivMGMKCMf3e0XRoQ2En4jdjC4o
         l0QXBXm6ndcTw0e1BnIhRnI9fmTiAZsUsu0D17CFOrD4RGcofnUAKaBCktK0WZ3HIVfj
         xabBG2ZxSqmkP5rHOF+BNiSMHYS5PaLoIfFLIMpffgQpnHBG0JhA3lwQzxqpQJRN1Igr
         Ol5E/Gp0zFDAv77oilMTq1A6jnLxF8MKYnrfILiWK6THw1VBn9dDuu8Xz+SeXubQM64h
         RRBKDl3Y3FuU2gfHgGMY94DzYfV9XveiQNE1WNtju12Jzz60Joi1KZzd8kS0V40voa54
         cnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uyJjNcCyaCd1x5/819IrrY1FHu5p7NCmrwELbf92SAw=;
        b=tfOYJj1mDfN4DbrVI9ZZhCQ/KyrCJtc0V6DzJagAxEeyFIUWWClHIhLzLJxdL03abL
         2+A2aEuKAj7nUJLi1DcDbrGz76grn5VFYcnDbJzykZEPXwJ5H2bcgIe80VVkH8kp5CfC
         YRci13YjjiL9ajrICTjIvLCKpYc0jzIBIxTEzsC+D/CzrgKmB5p2kgUr3SmQ6xy5FgT9
         Vuy2Hv4AmXZfTaMQikm61quuCS2kFHe0Sz592plmCCKtzaZJ0JOugnFEr0ShIu9Lrq2c
         axqkMx85IJmEC8CaD5flR8AtAtnt8UMa/KDwESg57Ems1Uxl6tWIu7WMs0BwMb5kflVM
         RYrg==
X-Gm-Message-State: AOAM532+9zTAf868v7Vay8YXkGnsK8bwEFLPWX0aqCnuRoT7Y7wa66Gs
        4ohK1yg0BA8k/HPVKZu/hFSBOHd9yLnhQgEIhdUnoQ==
X-Google-Smtp-Source: ABdhPJzd3SJxIS4HsCUds4zwHzaxq83M1tXUciur4bETKG0e7fh8+z+LpQ32CtOhhi4oDDmKD7oe/79nInT7mEGSln8=
X-Received: by 2002:a17:90a:cc03:: with SMTP id b3mr6368860pju.80.1594937800591;
 Thu, 16 Jul 2020 15:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200716215242.GA19193@embeddedor>
In-Reply-To: <20200716215242.GA19193@embeddedor>
From:   Brendan Higgins <brendanhiggins@google.com>
Date:   Thu, 16 Jul 2020 15:16:29 -0700
Message-ID: <CAFd5g44yqds4xUp=xVbXTpFZydLobfpyLrVdwZOjrRa4=TOj5Q@mail.gmail.com>
Subject: Re: [PATCH][next] i2c: aspeed: Use fallthrough pseudo-keyword
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-i2c@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 2:47 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:
>
> Replace the existing /* fall through */ comments and its variants with
> the new pseudo-keyword macro fallthrough[1].
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
