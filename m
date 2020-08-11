Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC6C2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 14:02:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 96C4B20716
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 14:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597154560;
	bh=E/QN/6nvKPj5AjGDl11DQzhq7Cj/oyWn+Iorj6tJ2ps=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=weLiQQ87GmoG2UVgXYsIgp6cNWm4xD/4xjVG0nrHYkXfF5NKGLwSoKNKWAMypQt+/
	 TCiSsqHvkKGjAlO9ch1kL/qxOoS0E9zM7NBiZGhLRlomWZ0giwlNZbza1Whg6x20k9
	 DnR3RW1gOBJTiR6R9IOTFsDcqmjhxxi68n2ZD3YM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbgHKOCj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 10:02:39 -0400
Received: from mail-oo1-f65.google.com ([209.85.161.65]:34255 "EHLO
        mail-oo1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbgHKOCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 10:02:31 -0400
Received: by mail-oo1-f65.google.com with SMTP id k63so2639546oob.1;
        Tue, 11 Aug 2020 07:02:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Y+ycr+kq0hSs2c5hcaMKETjdqn/n4h2V3uomxbdvvZA=;
        b=N5zrxUsLf26XE7GfA1bGg9SuuQ3306ZL0u+feIiCWjb6dRnAmVVNyG18W6IH+37DJN
         J/0C2RMEL4oWBjR1i+HhASFKordIHeM8Crl/v8C4z15panNEI45iePbGOLByngEjbnrU
         FOdIYpBnTSY0jNWFRNyo2r6T5Iqo9VPGqRt+ju5yX1qF9mAA8TTu2fqdg3wdUuknbYYC
         KzrU+vcUQtsnvSaXGuVEi/ga5zBOrVOG+gP4LUeN/P8XlLL82DyicmbXDyJmdJhjg49O
         q3hHkFnLnWi4Y7cKiCRMXNBF1JoGXB8fpTwgGiZReq2OUmNWCrGWo9NgjhgClE6Ymtef
         kZXA==
X-Gm-Message-State: AOAM530aXBC1ETGwV+UgfS8pgzaQYIg6IfwxGamOxWYiejlm7+sB2TAg
        GnWaQFECr6aKvcNL9OnnxILWlcz0jjOB1pCGYY4=
X-Google-Smtp-Source: ABdhPJyG3Gw6UJPnsjgckP3sTYgVzg/18zvw0XuvsEFAtYrMGDXsZUbJkq+wkVXDoCRauLRkDGMK4oK5xBK/IJPUT/U=
X-Received: by 2002:a4a:4201:: with SMTP id h1mr5242148ooj.1.1597154549897;
 Tue, 11 Aug 2020 07:02:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200616155501.psduxnisltitodme@linutronix.de>
 <871rmesqkk.fsf@gmx.net> <20200617142734.mxwfoblufmo6li5e@linutronix.de>
 <87ftatqu07.fsf@gmx.net> <20200624201156.xu6hel3drnhno6c3@linutronix.de>
 <87ftak2kxr.fsf@rub.de> <20200714134410.3odqfvjq6rndjjf6@linutronix.de>
 <CAJZ5v0hZSUkEMCszDADGWk-v0xNEiDE45B3CHLi05BX6rPfm6g@mail.gmail.com>
 <20200714141135.47adndrsdgpiqfy4@linutronix.de> <CAJZ5v0iogereapmhcFi=iXHsjnzmC26mewUSTY3+5O3ei5kfDQ@mail.gmail.com>
 <20200811102735.yifejbx62ewzpfcs@linutronix.de>
In-Reply-To: <20200811102735.yifejbx62ewzpfcs@linutronix.de>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 11 Aug 2020 16:02:17 +0200
Message-ID: <CAJZ5v0jy08XwTRUwHwjQ-UgHhi=j80q9SW2_ze1J0RiArTRKsw@mail.gmail.com>
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
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
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 12:27 PM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2020-07-14 17:53:15 [+0200], Rafael J. Wysocki wrote:
> > acpi_evaluate_integer() doesn't show up in the trace, though, AFAICS.
> >
> > > I assumed acpi_ex_opcode_2A_0T_0R() since the other
> > > candidate was acpi_ev_asynch_execute_gpe_method().
> >
> > Which probably is the case.  Specifically
> >
> > acpi_ev_asynch_execute_gpe_method: Evaluate _L66
> >
> > is likely to cause the Notify() to be dispatched.
> …
> > > Rafael, are you also interested in an ACPI dump?
> >
> > That might help a bit.
> >
> > So what probably happens is that poking at the TZ causes a GPE to
> > trigger and a Notify() to be dispatched which then goes into the
> > workqueue for execution.
> >
> > Now, I'm not sure what happens to those Notify() items, though.  They
> > each should cause a handler (in the thermal driver) to be executed,
> > but does that happen?
>
> Stephen's trace contains a few backtraces, all of them look like this:
>
> | Call Trace:
> |  acpi_ex_opcode_2A_0T_0R+0x93/0xdf
> |  acpi_ds_exec_end_op+0x10d/0x701
> |  acpi_ps_parse_loop+0x7f2/0x8c3
> |  acpi_ps_parse_aml+0x1a5/0x540
> |  acpi_ps_execute_method+0x1fe/0x2ba
> |  acpi_ns_evaluate+0x345/0x4e2
> |  acpi_evaluate_object+0x177/0x39f
> |  acpi_evaluate_integer+0x4f/0x110
> |  acpi_thermal_get_temperature.part.0+0x45/0xc4
> |  thermal_get_temp.cold+0xc/0x2e
> |  thermal_zone_get_temp+0x4c/0x70
> |  thermal_zone_device_update.part.0+0x2a/0x110
> |  acpi_thermal_notify+0xcf/0x140
> |  acpi_ev_notify_dispatch+0x45/0x5a
> |  acpi_os_execute_deferred_notify+0x34/0x60

This is Notify () processing.

The handler is acpi_thermal_notify() which calls acpi_thermal_check()
which is just a wrapper around thermal_zone_device_update() doing
update_temperature() and that calls thermal_zone_get_temp() (among
other things) which invokes the ->get_temp() callback for the target
thermal zone.

In the ACPI thermal driver the ->get_temp callback is
thermal_get_temp() which basically calls
acpi_thermal_get_temperature() and that evaluates _TMP (for the target
thermal zone).

It looks like on the machine in question the _TMP method contains
another Notify () targeting the same thermal zone which gets queued up
via the acpi_ex_opcode_2A_0T_0R() at the top.  Obviously that Notify
() (when it gets executed) will cause acpi_thermal_notify() to be
executed again and so on, ad infinitum unless the Notify () in _TMP is
conditional on something.

> |  process_one_work+0x1d2/0x3a0
> |  worker_thread+0x45/0x3c0
> |  kthread+0xf6/0x130
> |  ret_from_fork+0x35/0x40
>
> so no GPE and it comes the notify callback while parsing the ACPI table.

Right.

> Any ideas? I guess acpi_ex_opcode_2A_0T_0R() uses the workqueue because
> it may sleep and it might be invoked from non-preemptible context.

No, it uses the workqueue because it queues up a Notify () which
always goes through a workqueue (kacpi_notify_wq to be precise) and
basically in order to avoid deadlocks (it runs under locks which may
need to be acquired again to handle the notification).
