Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B7B8C433F2
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E84020759
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 19:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sMHMB8VZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbgG0TrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 15:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729014AbgG0TrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 15:47:13 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753CAC061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 12:47:13 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id k18so2432400pfp.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 12:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sGQ4r67ks10a9qe3fOk8YWAIOQIxbh+oSzV4pqpcTt8=;
        b=sMHMB8VZWqlwbXWM79T30VxlVj+IefdVKIwTlDf0VEjEv0eg47NENQ/0P7cKueGUQI
         +8nCHx/Ez7jCJPiWFvLniRPedw/rfenucP/14M5GaV6t8Zn2iq3AXAhY6Mc+cF3AR3If
         tkCKJqdysJX89NANjkdlAhWQTwOG+8LgOxgJ2JlKw3YXfLyDeLItP97oJ/Uzr2hl1rMB
         ZRjX+FLOJIycW9o9c32RRniQbyQMsB3tp05irQxgp5w0I2NSrE4EJqvs7BgHp59q6LFR
         sSsaJU5PbtaQIrdsqZ8GU4BRO5vax1iCuEN5CX6vkdnYosN0wJ/x18k+S3G/oTn1SWP/
         CnKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sGQ4r67ks10a9qe3fOk8YWAIOQIxbh+oSzV4pqpcTt8=;
        b=QPzxGp4inDmhYTEKfKxo3R/PEjimGScPSsAH1xHFi16nAX93/E0Kojr5vuRRVSZN7I
         6hJmjDBpCzI7sS5Hxl2+uaPhLlTyzPNB5/KNMLt11S+HrXO8yE+jnDEh8A1QM2PBp5RZ
         a1H1YUzf0AwvJKIqoyDz5tPlsp8hIwBYP3pNOQuO4I3rqzw7oMw2ckIbieipXb9Bgjc9
         kR08hIxZl6wkE4xoJWeLT9+YZVqhi7XBbFGKqAOIOKc45asz63mSNvbeHM2Y1V0dPy1B
         CUtjrf9prystMvPmiLm26w6hb/Y7s3HXPloFS0TjgEGxFxT9YTu7WPT9ZR1rCwx3QSaZ
         xfGg==
X-Gm-Message-State: AOAM5324vIrUx+jfXj95TbAvjvjet8Jf/cYtQrZE5XgBbEmUr9xKx5Pa
        bnqcCuLqiSEjkv3+0AyeYtqdrIghozu7q3SBt94=
X-Google-Smtp-Source: ABdhPJy+//PBMIQeWkJdzakQn7hhFAyqjwSVtG1idgDdUKWtxtdXzoCU6G/qQ8c7jAKH4frEP1nSdfwatABy3IKsXas=
X-Received: by 2002:a62:758f:: with SMTP id q137mr3071458pfc.170.1595879232782;
 Mon, 27 Jul 2020 12:47:12 -0700 (PDT)
MIME-Version: 1.0
References: <18cb4d48-6571-1fdb-5902-ba64c23eee75@broadcom.com>
In-Reply-To: <18cb4d48-6571-1fdb-5902-ba64c23eee75@broadcom.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 27 Jul 2020 22:46:56 +0300
Message-ID: <CAHp75Ve1VUWsw8GdSmEbGs6v=B2=VGgcieS-voA+AqvypTpbdw@mail.gmail.com>
Subject: Re: Kernel panic - not syncing: IO-APIC + timer doesn't work!
To:     Scott Branden <scott.branden@broadcom.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 10:20 PM Scott Branden
<scott.branden@broadcom.com> wrote:
>
> Occasionally I get the following Kernel panic on boot.  This is running on the latest kernel but have seen it previously as well.
> "Kernel panic - not syncing: IO-APIC + timer doesn't work!  Boot with apic=debug and send a report."
>
> I don't know who I am support to send a report to.  But here is the log with apic=debug

Just a wild guess, do you have x2APIC in your system enabled and driver for it?

-- 
With Best Regards,
Andy Shevchenko
