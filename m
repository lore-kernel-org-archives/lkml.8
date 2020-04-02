Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40F3DC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:28:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE042072E
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 23:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585870105;
	bh=4kLBTIWSxVUy3kJv/k0JtYIs6ZqRjBooqNv7XsA+F+c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=u7HzAZAm7HRLyYmpwkgye6hSrtBV3DuMuSeVBykVnvzQMK+3k6R3uubcLwiqHk2Ux
	 5Nfvat1u5kgbFlEOomxae7D19KK3IqmHqNhis2MrJvB2Ujozf7QMW4XA2QegMHVyRF
	 asSz/LDC11aBpqvCk94AHk2PHMWifzGJ62KFzajc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390184AbgDBX2Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 19:28:24 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41038 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387919AbgDBX2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 19:28:23 -0400
Received: by mail-lj1-f193.google.com with SMTP id n17so5102251lji.8
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 16:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=27Eq33tzm0rwxrqYtQSqbizdJYHHnYSaU0MAG8gpLzU=;
        b=CfTBY7xc1tiuPYtHEJoigkNy6ECHxmqNNJtfajsajw5CbJZRZPLrGU/rk4vJo9ix26
         abrgDQ+uFBTyTnl4yYkkq16ZlRI/cZ1V7eMVlzB1WFePzfq2eXWPusgbU45dPLtmBD35
         BdRd7O/NjpQ1pgDxt+SYe8xxgLc6alEqsqeOY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=27Eq33tzm0rwxrqYtQSqbizdJYHHnYSaU0MAG8gpLzU=;
        b=fdbbhYs517f7WAC+I/jC1xwiGxLiNqJPbC2RcLRoRL3tzAy2Vq10s2mNl0eEnxetTi
         8SMRRoSXJF8a7V5OlSMM8AJfZc+L1Zy3LMam+qsvl6pQxwcYQOstZwMrpNBchJNtphlf
         u/0aEqYOSFg+Ta0RbWHEwv6xi9jomf0r787RarjvuW6YDvruLRy6x1B7aJyDU8G0jLpv
         JR4jDCU0ddMVHZbLi+G4ePpNndnnSE9bWh5xI7DmKZd3faqbYaJLqaZEcplPk0wAlljF
         ZqHl5j8dKH6p8xOKCayrLIGBhty7Q0fwieQunHH/P5Aa2SqEYVqjoxpyr2wDZJ2NsXBi
         du5Q==
X-Gm-Message-State: AGi0PuZFRbLMzw0554YgvcybtF7L8hXSD3JGr8hKBv571KEwWXu1UfXA
        lL49gL1JOO9Xm/0kwwddIqJfPN747dU=
X-Google-Smtp-Source: APiQypKsZy02Y3fCVgV2EKSS42KCzQCiYl01g7j2yPyz18kaxcR9+jpLUrT1BeButJKT9jG0BWB6Jg==
X-Received: by 2002:a2e:8ec2:: with SMTP id e2mr3218476ljl.252.1585870100775;
        Thu, 02 Apr 2020 16:28:20 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id r13sm2442569lfc.74.2020.04.02.16.28.19
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 16:28:19 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id q19so5064134ljp.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 16:28:19 -0700 (PDT)
X-Received: by 2002:a2e:b4cb:: with SMTP id r11mr3432765ljm.201.1585870099332;
 Thu, 02 Apr 2020 16:28:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200402112500.GJ72691@vkoul-mobl>
In-Reply-To: <20200402112500.GJ72691@vkoul-mobl>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Apr 2020 16:28:03 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi81+9roQMgf7n0YRxJ0rqK3W0ghB3tS3kngSikC7cOig@mail.gmail.com>
Message-ID: <CAHk-=wi81+9roQMgf7n0YRxJ0rqK3W0ghB3tS3kngSikC7cOig@mail.gmail.com>
Subject: Re: [GIT PULL]: dmaengine updates for v5.7-rc1
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dma <dmaengine@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 2, 2020 at 4:25 AM Vinod Koul <vkoul@kernel.org> wrote:
>
> Here are the changes for this cycle. SFR has told me that you might see
> a merge conflict, but I am sure you would be okay with it :)

It looked trivial enough. That said, it's in the TI_K3_UDMA driver,
which I can't build. The driver is marked as COMPILE_TEST, but it also
has

        depends on TI_SCI_PROTOCOL
        depends on TI_SCI_INTA_IRQCHIP

which means that it depends on TI_MESSAGE_MANAGER, which in turn has a

        depends on ARCH_KEYSTONE || ARCH_K3

so it may be *marked* for build testing, but it doesn't actually get
any outside of those builds.

So I did the resolution that looked trivial, but mistakes happen, and
I can't even build-test that driver..

Just a heads-up. It does look like it was _meant_ to be build-tested,
but that intent didn't work out.

Adding a COMPILE_TEST option to TI_MESSAGE_MANAGER gets things a bit
further, but even then it doesn't actually build that driver because
that TI_SCI_INTA_IRQCHIP dependency needs to be enabled too.

And that one doesn't even have a question, it's just a plain bool, and
expects to be selected. Which the arm64 platform does.

Anyway, to make a long story short: "the COMPILE_TEST marker is a lie".

So somebody should actually test my merge.

                  Linus
