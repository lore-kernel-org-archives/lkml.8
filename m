Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3267C33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:00:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C945E2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 19:00:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EpBa46mh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437200AbgAPTAl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 14:00:41 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:36968 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388663AbgAPTAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 14:00:34 -0500
Received: by mail-ot1-f54.google.com with SMTP id k14so20397691otn.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 11:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hyY7WW4dkzBjOHFiSnAhU1ifhGoPr9kB/eLuIeGz0AE=;
        b=EpBa46mhq3trk26FcvFYoKtZjmGqAVcQNC2FqB83DK2AEwcz5ZAZRcA7G2qxqCBe2v
         spthb+qWYr0doMCPKJgZNFYsI9vaoC8Cc6vnMZ8iuHDvJBEwav4YoPOwkfaSraMKqn1Q
         wZFKvwIn4SGUeVqQalUpjEV+t8ebTaC4gVyt4qT1NOQjk38K2LCLNCI9ytq8C/SaNF4d
         IPczja3VhYWvyWWQRB28Lm4Vt+YXn+G0s4fWjOzXaHehV4zOAcavIaOkWy+fq0aY84Si
         oNrR1oPx1BKc6yKRhSsOhg/Iz6CVJUFne5JoiHzq80OqL1H3x6xL8iNFzqjNEKLpd57o
         mP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hyY7WW4dkzBjOHFiSnAhU1ifhGoPr9kB/eLuIeGz0AE=;
        b=R8Lo2Zn4CRbPWWcT8nYY4DJqGCR6MjvXE1EsZ75z0NOX9cMsqVAqEV9FBuRny5v1O0
         gC+JrY7HGM1otVOul9a2H+Cj7+KXJ83fwgDBF9RVM7NQi7p1G0jhTOr7FnNjs8niG7zL
         lCKXYSJkr3NLVkCgGr6ZFyGAmGltydJTgqZ0EuMURtLg9IxYaEzk2rXwo2oi5WiKMzgV
         Z3w4bW3Ci7hzbN+fRK6iAVmljqo+IRlqCnUGFKoJmefApSxcdNQ5W91J9XXmKrf8o2Z3
         Tokmv6TJ3RPbi9Ms7JSIXAxwVcXTNpD6nW3HoW+UyLebhuC68biqmUkEsJRxzGearYiS
         vy9A==
X-Gm-Message-State: APjAAAX9dkt5BKjPSMeXBGSPt1bUJcv2czD+dAUlhZAummJ/0lh6jhy0
        4ripkNUinrtMLSoS1aU1IQf4cB6vx3iLNv/vvk0sbA==
X-Google-Smtp-Source: APXvYqzrvSvdKS//HZyQp4z4fTTVNqnffvcAgM8KAmX5p4p0X7P0vOiAdo0qA176cJ9JED9JCVoDcyalIs648b+sTEY=
X-Received: by 2002:a9d:7410:: with SMTP id n16mr3307988otk.23.1579201233339;
 Thu, 16 Jan 2020 11:00:33 -0800 (PST)
MIME-Version: 1.0
References: <20200115162512.70807-1-elver@google.com> <20200116174344.GV2935@paulmck-ThinkPad-P72>
In-Reply-To: <20200116174344.GV2935@paulmck-ThinkPad-P72>
From:   Marco Elver <elver@google.com>
Date:   Thu, 16 Jan 2020 20:00:22 +0100
Message-ID: <CANpmjNP5=ZyrnueXnYJU-ZN7VUgwnG5w4GFVLja9oN1LfHFpjg@mail.gmail.com>
Subject: Re: [PATCH -rcu v2] kcsan: Make KCSAN compatible with lockdep
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Qian Cai <cai@lca.pw>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jan 2020 at 18:43, Paul E. McKenney <paulmck@kernel.org> wrote:
>
> On Wed, Jan 15, 2020 at 05:25:12PM +0100, Marco Elver wrote:
> > We must avoid any recursion into lockdep if KCSAN is enabled on
> > utilities used by lockdep. One manifestation of this is corrupting
> > lockdep's IRQ trace state (if TRACE_IRQFLAGS). Fix this by:
> >
> > 1. Using raw_local_irq{save,restore} in kcsan_setup_watchpoint().
> > 2. Disabling lockdep in kcsan_report().
> >
> > Tested with:
> >
> >   CONFIG_LOCKDEP=y
> >   CONFIG_DEBUG_LOCKDEP=y
> >   CONFIG_TRACE_IRQFLAGS=y
> >
> > Where previously, the following warning (and variants with different
> > stack traces) was consistently generated, with the fix introduced in
> > this patch, the warning cannot be reproduced.

Qian, thank you for testing!

> I added Vlad's ack and Qian's Tested-by and queued this.  Thank you all!

Thank you, Paul!

-- Marco
