Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD58C47247
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 18:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3717B214D8
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 18:47:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNin6+nW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgEISrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 14:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727993AbgEISrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 14:47:13 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E98C061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 11:47:13 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id x73so4074148lfa.2
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 11:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=r2VqzdQ3t3l9GLlfIblPu8fIc2SHZonPe2y2Y9yrzwA=;
        b=GNin6+nWM1QP0m2z2hzY8zsRxqDBXtplG9wjFmOI1ojkUNRLK/92I4+Q7OAX+WzfxJ
         jeP6kJWDxAzjEZPTJifP7QYUSRiOgFJ0ke4eAeXHoWxJc0jOMZjK1g5wF0zWOpZxTuhv
         sv0T/R7VPmB2U+RjECSIWuLjjX+Gx2KuWI36/teOaZZHLHYxC3t51ccoY/x9Hv9XdvK6
         jV09Kal555yn4AtGCKL0piKHqimwgL45NBm2bp5fgO9slMCOhh0JzQ+CHBC4lhDoLPvp
         i4ihRv9OUGLBDyKhHPev4lxHDLhsTsxQ34cMV7CmmZYgwfYd/TG5gdUR7BY59qve9I0v
         uyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=r2VqzdQ3t3l9GLlfIblPu8fIc2SHZonPe2y2Y9yrzwA=;
        b=Mn0JRafyelVOK220VApp6vjC/VMyUqeOI68kdynX7XFYCAaeGrpFTOeibbnqDDjn2P
         rxlB7MzPY8ZU9S5bCTR54DIx81vJy5aQDtxfO847zopiFYYY/JNE4v7GOzsrLYzgKb5v
         Qs7Y0xJdcZWAaC7xLKBo2GX6Y1SiIskdoQbP6fi+1brA3c40W5qoJzUXomZvqWGe4k99
         zIDq8XWLWUsQS3leJq9mfsQHip7EvpbuaBwZCfJLvZgUht4vBuBye/bW90nKr/f9003J
         XeG20V1R3hgx+Rdg8zV9E4ooyWPBsEfV7+VjbOo5YK0uDsEQLvVGX+PlPhTwIJLi8/qf
         r+YQ==
X-Gm-Message-State: AOAM533c07+/QDosc9qLweWugbXSAmmzO9czZxyklvtxRnWvHH+Arfi3
        lY4yl+S6otp+N27tDut55Cus6GuoATtA1UiBzb8=
X-Google-Smtp-Source: ABdhPJy9gyB1ktrqC1Zd3HyibZp0l6obehCp4vpCDO0qkgRUMj3Vjub/ykfUERbE41LdjhQm/0RhnA0bO0Yeti7gp9Q=
X-Received: by 2002:ac2:4945:: with SMTP id o5mr5705467lfi.21.1589050031766;
 Sat, 09 May 2020 11:47:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200509130714.10586-1-john.oldman@polehill.co.uk> <20200509171131.GA2495033@kroah.com>
In-Reply-To: <20200509171131.GA2495033@kroah.com>
Reply-To: john.oldman@polehill.co.uk
From:   John Oldman <john.oldman60@gmail.com>
Date:   Sat, 9 May 2020 19:47:00 +0100
Message-ID: <CAMJX__Skgr+1ZO5JxwnwRt6A1C5rBc50cUDSN+6BM4pmYGPY4w@mail.gmail.com>
Subject: Re: [PATCH] staging: vc04_services: interface: vchiq_arm:
 vchiq_connected.c: Block comments should align the * on each line
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     John Oldman <john.oldman@polehill.co.uk>, nsaenzjulienne@suse.de,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg

Yea, thanks for the feedback.

Will fix and resend...

John


On Sat, 9 May 2020 at 18:11, Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Sat, May 09, 2020 at 02:07:14PM +0100, John Oldman wrote:
> > Coding style issue
>
> Your subject line needs to be much shorter, don't you think?
>
> Please fix up and resend.
>
> greg k-h
