Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24410C3F2D0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:43:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECD27246A8
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 09:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="zGlBgJoI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726860AbgB1Jnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 04:43:37 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40034 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbgB1Jnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 04:43:35 -0500
Received: by mail-qk1-f196.google.com with SMTP id m2so2339610qka.7
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 01:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BZQpTZWkGzDGWJobzwuAfOw+XS/boYthReZIyRMS7WA=;
        b=zGlBgJoIRe/RfSDE9HfZaopWq8WV2piNpuuScoZMuTQcTFm7Rj7MXadxMl1J52m2pp
         lRBVSUEo27UOymkMXOCNeUsK5ZFmi582iShoBjR4B5kphtTxBnmjHade3IgHsIpzP4p0
         amvg1FgKhEHtAeDxH1CJK9rcz+KWWN5I+tPHeqLY9RFKOSb8/wp6Tm99onBqGNnJqlYk
         jaL7IvAscMrl0gBEGKBj8OLuP847Q2y9T5NGo8qMHI+UhUEt2niJ/Env7WBb1W0zHM+e
         KoNFYiBsHCpC/Rp8HOoYVFmxqagwOhcYMOhIa/SVH9YXQdtoa6raA5SMFkeknm77T5uw
         ykZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BZQpTZWkGzDGWJobzwuAfOw+XS/boYthReZIyRMS7WA=;
        b=rq39JvtwXAUB3OBvCRcA9UgDmJ480S7u5OofKjLiupEmu8w94YylYs8IxP/1TSTIKc
         vs8syAJa0zQa/JbrSHJcr5e7gKBkMZ+yAe7XE00vBJx6GgkL6yQGDe0uOus11bfXWc7o
         tfK8T8e0UAJfJ3A46r/BtVSDzCt/ypjU0SDZhVGd1tQ637P/CTiSmXZJrJ5k9/BvYkhY
         kizOxvSMznnMqlmg2oNOHnwszZOGH8Nqq6fI4Fah2RLK6ws/66LyieChy7CbXo7hPKA4
         s15/NiT5QZ5ZVTz1c21rHDKdduJW92cs3ubp+tCw93xWrGI5LnmUEQBAbwbOX/OjQulx
         Ly5Q==
X-Gm-Message-State: APjAAAWOntRAHF7iKA5u7R1brTP4EOJ8fpnUxJb8vyRmiE7Vu66Wu2P8
        3TUqMDONR/LGLhgaISy3f6cXY0MN6QyRQ6uoSF2/wynh
X-Google-Smtp-Source: APXvYqxUoWSKm+NYzu9ZiSLa1bUICU9tgjR/Qm+eZi+RRxEOw9s1pWhOp2Oxj4m4aVk4D87nMkpVBsKiQDQXK5Rz3ZI=
X-Received: by 2002:a05:620a:12a5:: with SMTP id x5mr3582343qki.478.1582883013336;
 Fri, 28 Feb 2020 01:43:33 -0800 (PST)
MIME-Version: 1.0
References: <2094703.CetWLLyMuz@kreacher>
In-Reply-To: <2094703.CetWLLyMuz@kreacher>
From:   Daniel Drake <drake@endlessm.com>
Date:   Fri, 28 Feb 2020 09:43:22 +0000
Message-ID: <CAD8Lp46VbG3b5NV54vmBFQH2YLY6wRngYv0oY2tiveovPRhiVw@mail.gmail.com>
Subject: Re: [PATCH 0/6] ACPI: EC: Updates related to initialization
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Jian-Hong Pan <jian-hong@endlessm.com>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2020 at 10:25 PM Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> The purpose of this series of update of the ACPI EC driver is to make its
> initialization more straightforward.
>
> They fix a couple of issues, clean up some things, remove redundant code etc.
>
> Please refer to the changelogs of individual patches for details.
>
> For easier access, the series is available in the git branch at
>
>  git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git \
>  acpi-ec-work
>
> on top of 5.6-rc3.

Jian-Hong, can you please test this on Asus UX434DA?
Check if the screen brightness hotkeys are still working after these changes.

Thanks
Daniel
