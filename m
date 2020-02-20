Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DFADC761A6
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74D5224654
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 06:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kS8sPzcC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgBTGp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 01:45:28 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:33186 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbgBTGp1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 01:45:27 -0500
Received: by mail-il1-f193.google.com with SMTP id s18so22766337iln.0;
        Wed, 19 Feb 2020 22:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Im+z9BpxgrtGOkJ+iJIGy2bwVRagdiXEKkPgtWVmzAI=;
        b=kS8sPzcCHKfCH0EjHnhVB2wAIDK2IWKTgeJLse8OO4CcMISN9LlCicg5zSDWghpdKQ
         xg5Tw8/EqXuKsLDMyTSWJvBbbwHklHhcDsoZNUpG6rllz2wzcV4quTN1IJMdQ95xSEIJ
         VZWcJFGa0+yV7z3Ev3p7PcHZqKbPSrcrpfgmoItb1LAvrwQ6Ugy8iSrkCqGyDPyGHMsX
         wjEwvzF8vQKMjbc/Ak5Y3alZSEf1KfK+WpOv3yVQ5BYxDtDwD2iZaifIhlDXhAEwq9SD
         TTPybypiRM7NNYxVOB7xyr+q6wZ9YSFWCZl1Ut9ZGjKt4wKVq02SNzsHEZxxFvSIyAK/
         Spyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Im+z9BpxgrtGOkJ+iJIGy2bwVRagdiXEKkPgtWVmzAI=;
        b=GKkh4I4lMnt++HIVTSnYNjdbY4s+toS7MHYMcm9nteiDWFyxuVCSdhElfW/6uXzBfs
         6MIzF95KlQI2zVS5Ggij8qcmJ+vP6BmzNliod44Iajklc7UnoE43dt9Lz0+KMxHN+ii6
         OiaS5GuKQvW6+uTGHa2wqrKDgi4hCf2Ig1UwZy8aNwdMabXybxUTqRBujHq2gXax40Gq
         1FYYNrZhbRRjfQKyk0stN2QHAy/A2nZ3GQz+H5YDE8+ET/RhOsFln6fC2ouNPu66jmvF
         dO3ltvm0m9D5J8lkSDs4qPJaPJztANq2OMDOyRZGxgbhnbHC3Cd0xdPZiylbw5IFqLKN
         nx4A==
X-Gm-Message-State: APjAAAUDgc0aGaxSO4u1+E4oBSZ6fwbBf76EE6p1E8TxtKvDWiAPDUWY
        8SKb8F2Jhb7rb0obSgN1KQeaxGo6iYoDTGZud/gAvU70zmo=
X-Google-Smtp-Source: APXvYqyd+49YVrH/RNEem9De5EU7pIuYMV/dKpioMc6ldrO+SbEDSr38Vy/jYjP+bok8uBMJI7+8zG1TRby1mRRUOQE=
X-Received: by 2002:a92:cd52:: with SMTP id v18mr28468412ilq.134.1582181127140;
 Wed, 19 Feb 2020 22:45:27 -0800 (PST)
MIME-Version: 1.0
References: <20200219191730.1277800-1-paulburton@kernel.org>
 <20200219191730.1277800-3-paulburton@kernel.org> <cfeab22c0f332418d25e56fa86f5420f5470e4ee.camel@perches.com>
In-Reply-To: <cfeab22c0f332418d25e56fa86f5420f5470e4ee.camel@perches.com>
From:   Huacai Chen <chenhuacai@gmail.com>
Date:   Thu, 20 Feb 2020 14:44:03 +0800
Message-ID: <CAAhV-H62BKFeh3h7xE3LQLYwLRukG5dE3gu4F7RGZdJcdoNCjg@mail.gmail.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: Set MIPS status to Odd Fixes
To:     Joe Perches <joe@perches.com>
Cc:     Paul Burton <paulburton@kernel.org>,
        "open list:MIPS" <linux-mips@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all,

I suggest Jiaxun Yang to be the new Linux/MIPS maintainer because of
the following reasons:

1. He is familiar with Linux kernel & MIPS architecture.
2. He is active and has already contributed many patches.
3. He is not an employee of any corporation, so people can expect him
to be neutral.
4. He is young and has enough free time to follow the mainstream
development closely.
5. His English is good and is willing to maintain a good level of
communication with other contributors.

Jiaxun, what's your opinion?

Regards,
Huacai Chen

On Thu, Feb 20, 2020 at 11:16 AM Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2020-02-19 at 11:17 -0800, Paul Burton wrote:
> > My time with MIPS the company has reached its end, and so at best I'll
> > have little time spend on maintaining arch/mips/. Reflect that in
> > MAINTAINERS by changing status to Odd Fixes. Hopefully this might spur
> > the involvement of someone with more time, but even if not it should
> > help serve to avoid unrealistic expectations.
> []
> > diff --git a/MAINTAINERS b/MAINTAINERS
> []
> > @@ -11120,7 +11120,7 @@ W:    http://www.linux-mips.org/
> >  T:   git git://git.linux-mips.org/pub/scm/ralf/linux.git
>
> Maybe Ralf's T: entry should be removed too.
>
>
