Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837EBC33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 22:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548A921739
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 22:23:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Xj9ZG1jT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgA1WXK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 17:23:10 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36075 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgA1WXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 17:23:10 -0500
Received: by mail-lj1-f195.google.com with SMTP id r19so16404129ljg.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 14:23:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NfyHDiKgXC7RpXltToUGOptSkL+aCPz1A7fOlH9JHEY=;
        b=Xj9ZG1jTO2QFr1VtHGKe2y30MbfZ6YphF2ryb3xKZugcVMQ81TG126+ww3RkQjBa1V
         I+RBfB32X69iOlpqpJsZCbtDRPqpj1+qB6fmnov21l4ebqMPfAVkxfcV4CYOGIVyWiK1
         xCytSOo9GiPprrw9TGD5eSBiqEeBdeTrsvaFY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NfyHDiKgXC7RpXltToUGOptSkL+aCPz1A7fOlH9JHEY=;
        b=b2Xy3M7bmjbvclew70a/38MDY1Lz+80aBboiuSe+kdEIlUvNUUzWegcXIZlnPcEMxU
         6EhdE9X3ycdAKY1UzHbANzeAswtT8QdnB9Yc5VkWCiIljvQiBoPlWt5GoOJiDW8TedDg
         gDAH07rw752ACqo/pIF1Kdh6DYGW+i669hgej8h4/7OHnYbS9WjchKUn1+oNs7V/UxRy
         KcnKw4gSjrO2b5XXGGOvaZu5pnD0dHvgexLka5jiyUHa/AWananZpBuRGAXRj3HFJUkn
         Ho0RW5d8YSI938X4FUgPb1ckqfgKlL2w+w8SbnGSTJurruVRHwNgYhaOdc3nHFVwREov
         vlWw==
X-Gm-Message-State: APjAAAXfZFXMiqHvzgrgkEepAeB8rgzfgK3rZdRI27Gz2TTcgJ+btAy4
        Aon1AgchGenBGHOQ+SQfKrII4x5BE0E=
X-Google-Smtp-Source: APXvYqzQcoPjv6NHQ0IfoXAGY0iUWlp3u7yLtgPqslqOGSbHNcVBfFyPdw6bbbPEO3NdaakATXMtNg==
X-Received: by 2002:a2e:990d:: with SMTP id v13mr8465422lji.47.1580250187516;
        Tue, 28 Jan 2020 14:23:07 -0800 (PST)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id w19sm31427lfl.55.2020.01.28.14.23.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 14:23:06 -0800 (PST)
Received: by mail-lj1-f177.google.com with SMTP id y4so16371429ljj.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 14:23:06 -0800 (PST)
X-Received: by 2002:a2e:3e10:: with SMTP id l16mr9445599lja.286.1580250185446;
 Tue, 28 Jan 2020 14:23:05 -0800 (PST)
MIME-Version: 1.0
References: <20200117162444.v2.1.I9c7e72144ef639cc135ea33ef332852a6b33730f@changeid>
 <CACK8Z6Ft95qj4e_fsA32r_bcz2SsHOW1xxqZJt3_DBAJw=NMGA@mail.gmail.com>
 <CAE=gft6fKQWExW-=xjZGzXs30XohfpA5SKggvL2WtYXAHmzMew@mail.gmail.com>
 <87y2tytv5i.fsf@nanos.tec.linutronix.de> <87eevqkpgn.fsf@nanos.tec.linutronix.de>
 <CAE=gft6YiM5S1A7iJYJTd5zmaAa8=nhLE3B94JtWa+XW-qVSqQ@mail.gmail.com>
 <CAE=gft5xta4XCJtctWe=R3w=kVr598JCbk9VSRue04nzKAk3CQ@mail.gmail.com>
 <CAE=gft7MqQ3Mej5oCT=gw6ZLMSTHoSyMGOFz=-hae-eRZvXLxA@mail.gmail.com>
 <87d0b82a9o.fsf@nanos.tec.linutronix.de> <CAE=gft7C5HTmcTLsXqXbCtcYDeKG6bCJ0gmgwVNc0PDHLJ5y_A@mail.gmail.com>
 <878slwmpu9.fsf@nanos.tec.linutronix.de> <87imkv63yf.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87imkv63yf.fsf@nanos.tec.linutronix.de>
From:   Evan Green <evgreen@chromium.org>
Date:   Tue, 28 Jan 2020 14:22:28 -0800
X-Gmail-Original-Message-ID: <CAE=gft7Gu0ah4qcbsEB1X+kUMagCzPR+cdCfn2caofcGV+tBjA@mail.gmail.com>
Message-ID: <CAE=gft7Gu0ah4qcbsEB1X+kUMagCzPR+cdCfn2caofcGV+tBjA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI/MSI: Avoid torn updates to MSI pairs
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Rajat Jain <rajatja@google.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        x86@kernel.org, Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 6:38 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Evan,
>
> Thomas Gleixner <tglx@linutronix.de> writes:
> > It's worthwhile, but that needs some deep thoughts about locking and
> > ordering plus the inevitable race conditions this creates. If it would
> > be trivial, I surely wouldn't have hacked up the retrigger mess.
>
> So after staring at it for a while, I came up with the patch below.
>
> Your idea of going through some well defined transition vector is just
> not feasible due to locking and life-time issues.
>
> I'm taking a similar but easier to handle approach.
>
>     1) Move the interrupt to the new vector on the old (local) CPU
>
>     2) Move it to the new CPU
>
>     3) Check if the new vector is pending on the local CPU. If yes
>        retrigger it on the new CPU.
>
> That might give a spurious interrupt if the new vector on the local CPU
> is in use. But as I said before this is nothing to worry about. If the
> affected device driver fails to handle that spurious interrupt then it
> is broken anyway.
>
> In theory we could teach the vector allocation logic to search for an
> unused pair of vectors on both CPUs, but the required code for that is
> hardly worth the trouble. In the end the situation that no pair is found
> has to be handled anyway. So rather than making this the corner case
> which is never tested and then leads to hard to debug issues, I prefer
> to make it more likely to happen.
>
> The patch is only lightly tested, but so far it survived.
>

Hi Thomas,
Thanks for the patch, I gave it a try. I get the following splat, then a hang:

[   62.173778] ============================================
[   62.179723] WARNING: possible recursive locking detected
[   62.185657] 4.19.96 #2 Not tainted
[   62.189453] --------------------------------------------
[   62.195388] migration/1/17 is trying to acquire lock:
[   62.201031] 000000006885da2d (vector_lock){-.-.}, at:
apic_retrigger_irq+0x31/0x63
[   62.209508]
[   62.209508] but task is already holding lock:
[   62.216026] 000000006885da2d (vector_lock){-.-.}, at:
msi_set_affinity+0x13c/0x27b
[   62.224498]
[   62.224498] other info that might help us debug this:
[   62.231791]  Possible unsafe locking scenario:
[   62.231791]
[   62.238406]        CPU0
[   62.241135]        ----
[   62.243863]   lock(vector_lock);
[   62.247467]   lock(vector_lock);
[   62.251071]
[   62.251071]  *** DEADLOCK ***
[   62.251071]
[   62.257687]  May be due to missing lock nesting notation
[   62.257687]
[   62.265274] 2 locks held by migration/1/17:
[   62.269946]  #0: 00000000cfa9d8c3 (&irq_desc_lock_class){-.-.}, at:
irq_migrate_all_off_this_cpu+0x44/0x28f
[   62.280846]  #1: 000000006885da2d (vector_lock){-.-.}, at:
msi_set_affinity+0x13c/0x27b
[   62.289801]
[   62.289801] stack backtrace:
[   62.294669] CPU: 1 PID: 17 Comm: migration/1 Not tainted 4.19.96 #2
[   62.310713] Call Trace:
[   62.313446]  dump_stack+0xac/0x11e
[   62.317255]  __lock_acquire+0x64f/0x19bc
[   62.321646]  ? find_held_lock+0x3d/0xb8
[   62.325936]  ? pci_conf1_write+0x4f/0xdf
[   62.330320]  lock_acquire+0x1b2/0x1fa
[   62.334413]  ? apic_retrigger_irq+0x31/0x63
[   62.339097]  _raw_spin_lock_irqsave+0x51/0x7d
[   62.343972]  ? apic_retrigger_irq+0x31/0x63
[   62.348646]  apic_retrigger_irq+0x31/0x63
[   62.353124]  msi_set_affinity+0x25a/0x27b
[   62.357606]  irq_do_set_affinity+0x37/0xaa
[   62.362191]  irq_migrate_all_off_this_cpu+0x1c1/0x28f
[   62.367841]  fixup_irqs+0x15/0xd2
[   62.371544]  cpu_disable_common+0x20a/0x217
[   62.376217]  native_cpu_disable+0x1f/0x24
[   62.380696]  take_cpu_down+0x41/0x95
[   62.384691]  multi_cpu_stop+0xbd/0x14b
[   62.388878]  ? _raw_spin_unlock_irq+0x2c/0x40
[   62.393746]  ? stop_two_cpus+0x2c5/0x2c5
[   62.398127]  cpu_stopper_thread+0x84/0x100
[   62.402705]  smpboot_thread_fn+0x1a9/0x25f
[   62.407281]  ? cpu_report_death+0x81/0x81
[   62.411760]  kthread+0x146/0x14e
[   62.415364]  ? cpu_report_death+0x81/0x81
[   62.419846]  ? kthread_blkcg+0x31/0x31
[   62.424042]  ret_from_fork+0x24/0x50

-Evan
