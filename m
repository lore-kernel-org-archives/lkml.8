Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2845DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F233F20787
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 08:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="kKdUUmpy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387856AbgE0Ia1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 04:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387707AbgE0Ia0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 04:30:26 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F766C061A0F;
        Wed, 27 May 2020 01:30:26 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id k8so3601504edq.4;
        Wed, 27 May 2020 01:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SywmEh99ZiSZvvICfd9xcBs2ww3bg/rbWeS9Bx7NHo4=;
        b=kKdUUmpyEMI1liiT7BKaxwaKB7ITFoRBD6XjMZtYP5yEu0Sg2lSDGmVc9bgK0/oMJ9
         UVjrIjP9Zl5+zOsYEn58tDnLrS/TkX9b0pD1thO1oRQO4cgqxPxpYfd8xBaj1NFut8J6
         a5UcHqrKM58int5Z1nczfhnIgbXUWwVe4xU2g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SywmEh99ZiSZvvICfd9xcBs2ww3bg/rbWeS9Bx7NHo4=;
        b=VmbHVV5Q5A96XXmZsNCbrGGy/gMfmJtNQhnXL1pXYMgxmZvYt1xM78YLxvckYi/5zI
         waCvhrH7sm3ifaMsrIs7xk1O/PSdbkTfeOCA6dpE8xalFpa45lnzJk42KwOj0TTaN5gz
         mx+WQcu8lXsSyYbwY1qJavGDxzcgHlNOhJcBBbSweEJ1idbbm7AQZoffFmM5X1rswyG1
         GTisaWedkmq9tNS+QIJuZNTFS6as2ZX1Pltow1EvfiTX7Opnhyx29vFHPda/IWCxLVz7
         m27aHQrKVbhnFoLrkozSAEPdxRHrrw0s/VIhYLmVGQGwNt+iM8Et1YtynIR7qTxpGvfi
         k/AQ==
X-Gm-Message-State: AOAM531v2nh69kmGoIHK04E2Q9NqdrSBtvOzQT3wy+wb9uYki6GVHfKa
        rGP/oT4Uhyo6vK/MrNbseMJt4d9WXinVnhOER1O0Z4gB
X-Google-Smtp-Source: ABdhPJxN4wHJ/b/dfhahM4kiOD5BBlupG8Kp/judkuSegesYIMxpAUWv2vBj7UuqBV1XwT5sCxZFEh2G0dOjlwZXnpU=
X-Received: by 2002:aa7:c944:: with SMTP id h4mr22510152edt.383.1590568225149;
 Wed, 27 May 2020 01:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200408203616.4031-1-eajames@linux.ibm.com> <159056731319.88029.1548166710007070918@swboyd.mtv.corp.google.com>
In-Reply-To: <159056731319.88029.1548166710007070918@swboyd.mtv.corp.google.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 27 May 2020 08:30:12 +0000
Message-ID: <CACPK8XcQ3FXePSQ_2TnJZ6E_RsQb2LhMsPVt1d+CbjHmNoOOnQ@mail.gmail.com>
Subject: Re: [PATCH] clk: ast2600: Fix AHB clock divider for A1
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Eddie James <eajames@linux.ibm.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 May 2020 at 08:15, Stephen Boyd <sboyd@kernel.org> wrote:
>
> Quoting Eddie James (2020-04-08 13:36:16)
> > The latest specs for the AST2600 A1 chip include some different bit
> > definitions for calculating the AHB clock divider. Implement these in
> > order to get the correct AHB clock value in Linux.
> >
> > Signed-off-by: Eddie James <eajames@linux.ibm.com>
>
> Any Fixes tag for this patch? Seems like it is fixing something.

It fixes the driver to work on the new hardware that didn't exist
until now. I guess you could say:

Fixes: d3d04f6c330a ("clk: Add support for AST2600 SoC")

Cheers,

Joel
