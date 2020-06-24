Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9567FC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:39:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5760720857
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 12:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gcHcQCPl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389772AbgFXMjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 08:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388132AbgFXMjj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 08:39:39 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2B6DC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 05:39:38 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id n23so2361572ljh.7
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 05:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t6dHoa2SQqWS2UVn2iygD6BVJh+DwvTd7prD5cDECPg=;
        b=gcHcQCPl+lkOrioTn9Q/LQU6Edl+FdOosES4h6JFW5+2dk6+HHFU+yUaT0TX03yfTO
         N4tvexjL0SK4N7TAH6w9gRuFhRZGHuFAPZUBPyHL52s5AAMCecvJ+R1ouHKAUKLA/G5Z
         KprxZUu8iBE8QBx4TXtLZs95yqmrbQuP785vWVuK6aef9kBbtKsYTwCSjI1jzoPH27ZF
         RmDctUJFy7IcB3R98or4l1yrU6Vgvp18Z4KitHi/h+UyHNmErwCGvBhYOFTtD4aAEN6H
         hIpSd38qrin3Ix8hxwIgIIh8GbGfsOlsPnfzZixoyGzcRFTBfxaf176jCJCqdK4s0XmE
         cDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t6dHoa2SQqWS2UVn2iygD6BVJh+DwvTd7prD5cDECPg=;
        b=C/k5zcmcgChvTCT3AFUM0nttU2w4MxxzIwQw3Q89G9HMYvP7z984VpJauhBlD6Bjlw
         QQ+r1Y2ok27/3aipkFyATdYgBR5Jw6xtGsEdyejWW6aZKFY7Ycnav/SLPEu1Nn5yky6F
         CiEXlsDRhnY3FAnUya6NPADG/1q2ABRZQakIQW+2jiaiN4QcdDwF3sQZ3JYegTJZWEhQ
         vuAUdESg+2lxWUpiMWN0We+SSdIM3dXiThgCI1xb/tDrZ01aaMX+81Vpmk8yb6Qf9brp
         DZpy3Fu2B+lWWHSAF8iAyndIk1xlUmhW6y5bDOjCpMN8VCwRWGG4abPTIza3QRNAAnPT
         ACeA==
X-Gm-Message-State: AOAM531ZtlO47Bka1ImK/R24KHX8T47ZYzNwuBTZiU2yX/Y+4Lhgps7a
        ajE5eIS2LZ758HlTYhs5HAJ3p6O31e145p5OkWIb1g==
X-Google-Smtp-Source: ABdhPJwTvHyB27Rcb5g25rtHdVlN2YTkt0oU8J4Sx2+2NIpC3Qprb6xh32YCy6zG6h+iJjbN4aTsIiEywQG61YMjNmE=
X-Received: by 2002:a2e:541e:: with SMTP id i30mr12930521ljb.156.1593002377467;
 Wed, 24 Jun 2020 05:39:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAEU1=PkNtyznCms3jjp-oZHW=UAinnNKqG144VuzO5M7MLkO3Q@mail.gmail.com>
In-Reply-To: <CAEU1=PkNtyznCms3jjp-oZHW=UAinnNKqG144VuzO5M7MLkO3Q@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 24 Jun 2020 14:39:25 +0200
Message-ID: <CAKfTPtCVF-pw0cjuivuirNpBHRXZNJLihhJtGgkuTi7VdFpWbQ@mail.gmail.com>
Subject: Re: Looping more in detach_tasks() when RT and CFS tasks are present
To:     Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, Lei Wen <leiwen@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavan,

On Wed, 24 Jun 2020 at 13:42, Pavan Kondeti <pkondeti@codeaurora.org> wrote:
>
> Hi Vincent/Peter,
>
> in load_balance(), we derive env->loop_max based on rq->nr_running.
> When the busiest rq has both RT and CFS tasks, we do more loops in
> detach_tasks(). Is there any reason for not using
> rq->cfs.h_nr_running?

Using cfs.h_nr_running seems fine for loop_max

>
> Lei Wen attempted to fix this before.
> https://lore.kernel.org/lkml/1376814322-7320-2-git-send-email-leiwen@marvell.com/

The 1st part of the patch is wrong because even if h_nr_running == 1
but nr_running > 1, we can pull the cfs thread without using active
balance

>
> Thanks,
> Pavan
>
> --
> Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
> Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a
> Linux Foundation Collaborative Project
