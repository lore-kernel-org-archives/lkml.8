Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B04A8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 06:40:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8712A207BB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 06:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595400031;
	bh=55rpauAhzVgR6FwpmFAWLHbR2LAKN1/g2HefQPBweag=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Xi6rufM6IORTvwqOes6O9NCjMLEwrAjOTBso4vgE046VTjEYYFdsBQhYhKhTFqgry
	 IaqhGHE5gpEywORCS8x42QKFaTjJIDo71RTmAhLvIO88x7y+WWizohBrER2EnmdfDt
	 CCnNbUV0gIxqQPOirxxjl2JLzfTxIzwpF34yafw0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729320AbgGVGka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 02:40:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:41104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbgGVGka (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 02:40:30 -0400
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 434DF207BB;
        Wed, 22 Jul 2020 06:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595400029;
        bh=55rpauAhzVgR6FwpmFAWLHbR2LAKN1/g2HefQPBweag=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=bfCFlN4c7KDwRBdE39U7N1CQ4rkmxW6dLv3QRIJBm7tysVXNSYXrrADHWkQVTdGY5
         udhKexSMH67kL4chrrmere0bkLniTVuatZddM8P7l5dJRxWVbiO2b5DBr6B4dJmL8P
         BDydbKc5GQE1ZiWqILnZZ/HW+t3muU4Xf8RvRrSI=
Received: by mail-lj1-f173.google.com with SMTP id j11so1263308ljo.7;
        Tue, 21 Jul 2020 23:40:29 -0700 (PDT)
X-Gm-Message-State: AOAM5309RuYCj94vcl+dy3wTmFOuqsu9BrCikyMJvOQTyLhU/sJg6pf2
        7bCJunMVKeYWEKPbBFUIuVIJxsR6ALRXogg6zq0=
X-Google-Smtp-Source: ABdhPJwMMcOo7FU02TM1OwIIdL8VE4cdJEzaCOKzNEjZFPauU6B2EXZ+ELowyqn0yrKndRqfybodVWL6D3Qp21g6LE8=
X-Received: by 2002:a2e:9996:: with SMTP id w22mr15651735lji.446.1595400027569;
 Tue, 21 Jul 2020 23:40:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200720155530.1173732-1-a.darwish@linutronix.de> <20200720155530.1173732-20-a.darwish@linutronix.de>
In-Reply-To: <20200720155530.1173732-20-a.darwish@linutronix.de>
From:   Song Liu <song@kernel.org>
Date:   Tue, 21 Jul 2020 23:40:16 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7Cd1FyV7SgH5AtCEYHREOeG75nFqeZKNObPt3bA12Ygg@mail.gmail.com>
Message-ID: <CAPhsuW7Cd1FyV7SgH5AtCEYHREOeG75nFqeZKNObPt3bA12Ygg@mail.gmail.com>
Subject: Re: [PATCH v4 19/24] raid5: Use sequence counter with associated spinlock
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-raid <linux-raid@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 20, 2020 at 8:57 AM Ahmed S. Darwish
<a.darwish@linutronix.de> wrote:
>
> A sequence counter write side critical section must be protected by some
> form of locking to serialize writers. A plain seqcount_t does not
> contain the information of which lock must be held when entering a write
> side critical section.
>
> Use the new seqcount_spinlock_t data type, which allows to associate a
> spinlock with the sequence counter. This enables lockdep to verify that
> the spinlock used for writer serialization is held when the write side
> critical section is entered.
>
> If lockdep is disabled this lock association is compiled out and has
> neither storage size nor runtime overhead.
>
> Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>

Acked-by: Song Liu <song@kernel.org>
