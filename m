Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1837C3F2CD
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 01:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADEC024677
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 01:49:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mirlab-org.20150623.gappssmtp.com header.i=@mirlab-org.20150623.gappssmtp.com header.b="WOqssWS1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgCCBtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 20:49:05 -0500
Received: from mail-lj1-f177.google.com ([209.85.208.177]:34233 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgCCBtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 20:49:05 -0500
Received: by mail-lj1-f177.google.com with SMTP id x7so1713138ljc.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Mar 2020 17:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mirlab-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r/4TK4RpSOsZG1KYz157/rVP7bhcgbrwMq9gvsQBpSE=;
        b=WOqssWS1QIrJEQysDIBeZnlnC3TVwM/clsfKrxa8W0mlF8iDgI38/oJxklFjEPhBjj
         yjFmIcnmIvpI6ZWY1mOXnU2uHLBOxE/dkUta7wYvUHOnjlLF9yyjEY6ZdKT07/uGftqX
         Z+be1jpr3yHB0zguCDZwbByH3OeRMMBqTR+z3yYszh16NwM8kC5zNkYDApeKRrjiGqXY
         BrVQ9xfOyXVFjP0SCr/6wL/Wrpi1EH2iNtqFg6RoEwZg6+40O4GI96r6rvbIP0kb7td4
         GgnK2BqbEtwzUuXLfFQww+/0M/bC8NEFqDhKDrRu9ZRoA/5U/0D9C32dVAthX2kKMzEq
         07vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r/4TK4RpSOsZG1KYz157/rVP7bhcgbrwMq9gvsQBpSE=;
        b=bvPygEghcOR58vL6CUXDwYvKDSFM5HNdNsTuqOGiAkvVCIfqmLEAiCCWWnMM/qxSfy
         AP3NViDCgIeat3mHdCX+KB96MO6FNSUnmjFuNEg0UaLIyNTW1faN3R1rh3xuDx6YCGX7
         hZA0qFwefQcMufZu9OokXGUsglF3aj3ca/dtv+ujYpqBwV6U0iJYQJcp79DgS0ai5tvj
         tL0sSystl7AYOW77vbkJl4/dZqoDFycUBN6UX81BE2IpHSSNI7muX3f8sDf4WIMTJR42
         /+W2E0z15NS5u7zggkdT5jOgHwdu61MSmsVPK9orNfen4a/vG1hIO3SskQ2xEm95PQ2j
         45Cw==
X-Gm-Message-State: ANhLgQ0aPvVlr53rZ6TiYp/bplCAgKONIp6lZKfyywiPfIEmar1ka3bB
        R5wJYGzkoASYpVcm0cihGInle6dsbA5O/BzV8Q8NMh1l0jc=
X-Google-Smtp-Source: ADFU+vsEiDn/HoUUhMS6Uzq8YFYaGK1WeU3lCbywAsX4x/xp9zTRrFFSVOmzBWmSwyb8aEOOykO6+y7m2/NBWC3IVAg=
X-Received: by 2002:a2e:99cc:: with SMTP id l12mr660926ljj.271.1583200142999;
 Mon, 02 Mar 2020 17:49:02 -0800 (PST)
MIME-Version: 1.0
References: <CAB3eZfv4VSj6_XBBdHK12iX_RakhvXnTCFAmQfwogR34uySo3Q@mail.gmail.com>
 <20200302103754.nsvtne2vvduug77e@yavin> <20200302104741.b5lypijqlbpq5lgz@yavin>
In-Reply-To: <20200302104741.b5lypijqlbpq5lgz@yavin>
From:   lampahome <pahome.chen@mirlab.org>
Date:   Tue, 3 Mar 2020 09:48:50 +0800
Message-ID: <CAB3eZfuAXaT4YTBSZ4sGe=NP8=71OT8wu7zXMzOjkd4NzjtXag@mail.gmail.com>
Subject: Re: why do we need utf8 normalization when compare name?
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Sorry, a better example would've been "=C3=B1" (U+00F1). You can also
> represent it as "n" (U+006E) followed by "=E2=97=8C=CC=83" (U+0303 -- "co=
mbining
> tilde"). Both forms are defined by Unicode to be canonically equivalent
> so it would be incorrect to treat the two Unicode strings differently
> (that isn't quite the case for "=C3=85").

So utf8-normalize will convert  "=C3=B1" (U+00F1) and "n" (U+006E) followed
by "=E2=97=8C=CC=83" to a utf8 code, and both are the same, right?
Then compare it byte by byte.
