Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EABAC433FB
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54DF0224D4
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 13:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594734913;
	bh=fwD6LcwQF8G40pCs6Q6A08kZrf75rGZdt5X3qjY2QI0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tSSLOEItSfN5EIEXwDjR1vwrIWVNDfT0w7CytStpJjT4n4pOO9VjvKo0JJAJ8OnJ9
	 tkkcDjrye/BRoC7pUdveG+JLWf7Gbutss7P5hfhI86+d4ys4cQktQOz+WID5PEXqqE
	 SEfLjnAey2ZX8mKXQTGG44obGaWMsLpFdCo4AuQQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgGNNzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 09:55:12 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:45397 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726450AbgGNNzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 09:55:10 -0400
Received: by mail-ot1-f48.google.com with SMTP id h1so13035607otq.12;
        Tue, 14 Jul 2020 06:55:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2DHbXEMPR9kKKspzgGqTKK3b3d08bDvPNu5F8TGYfWU=;
        b=E09eUJT8EsVGGUwo/ZSc655wRNnDXfgHeMJN6z8IhbfmVuVWIjt3TeXELKjg06+qSs
         r5upzkEQFSmPj/mUqqFUGIuiZVq0exIxKLbzb/oUYzjgqPT5WOgKcobo//s+6Ms4C80U
         vSTNdOosNfLKZ56Wy6v+iAw2aRvyhVKOybvvvELexy99R/ZY7ptAlObz5I0Vh9SA2LO5
         FklScOYfqYG5TxMHa+XoiQv+oMxGQbJpb4BlKfOJqUOKzu7S3f8aLcYUoNeWjDkCwW9s
         Qo5ikfWZazwEFF2zRKuRCxWwTmfG3BuCEi6rsVxsPSZkg9zTWebgPvlXVRIaJNhcsex4
         WBwg==
X-Gm-Message-State: AOAM533Jny9WAgAFA6PIYPM0at+QF6R4YGEz0s/p5FfuzeEZ8cNyUqYK
        aKMqmWcPgTJc0s99ns91WwH6q16RZ83QapA0O+w=
X-Google-Smtp-Source: ABdhPJxwEm4PTUOI0UF+niRi3EZCrOpeSa0d4wfKvfZGhADzLG6hbvLCLsM2/amZ+VypzLrCVW+fSTq5yBHWYfZZe20=
X-Received: by 2002:a05:6830:30ba:: with SMTP id g26mr4048682ots.118.1594734908915;
 Tue, 14 Jul 2020 06:55:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200615145130.bcdidqkp6w23xb6c@linutronix.de>
 <87tuzbh482.fsf@gmx.net> <20200616073827.vysntufld3ves666@linutronix.de>
 <87o8pjh1i0.fsf@gmx.net> <20200616155501.psduxnisltitodme@linutronix.de>
 <871rmesqkk.fsf@gmx.net> <20200617142734.mxwfoblufmo6li5e@linutronix.de>
 <87ftatqu07.fsf@gmx.net> <20200624201156.xu6hel3drnhno6c3@linutronix.de>
 <87ftak2kxr.fsf@rub.de> <20200714134410.3odqfvjq6rndjjf6@linutronix.de>
In-Reply-To: <20200714134410.3odqfvjq6rndjjf6@linutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 14 Jul 2020 15:54:57 +0200
Message-ID: <CAJZ5v0hZSUkEMCszDADGWk-v0xNEiDE45B3CHLi05BX6rPfm6g@mail.gmail.com>
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Stephen Berman <stephen.berman@gmx.net>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 3:44 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:>
> On 2020-06-24 23:49:52 [+0200], Stephen Berman wrote:
>
> Let me summarize the thread here:
>
> On Stephen's system, ACPI informs the thermal zone driver to poll the
> temperature every second and the driver does so.
> The driver queries the temperature by invoking acpi_evaluate_integer()
> which invokes (at some point) acpi_ev_queue_notify_request().

Well, I don't quite see how acpi_ev_queue_notify_request() can be
invoked from the acpi_evaluate_integer() code path.

Do you have a call trace showing that?

> This then invokes acpi_os_execute_deferred() via
>     queue_work_on(, kacpi_notify_wq, )
>
> acpi_os_execute_deferred() invokes acpi_ev_notify_dispatch() and this is
> no longer synchronised with the initial acpi_evaluate_integer() request.

That indeed would be the case, but I first need to understand what's
going on with the acpi_evaluate_integer() causing a Notify () to be
queued up.

Cheers!
