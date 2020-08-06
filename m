Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA75C388F8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:05:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 102B522DD6
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:05:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="huIdmLYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728735AbgHFHsj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 03:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbgHFHrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 03:47:43 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D73CC061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 00:47:32 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f1so42476450wro.2
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 00:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=HHOPpgbgSKjDTGkpjqLc9R9y62AcGcDlV5geHTzbj4k=;
        b=huIdmLYimIV/KSis/VRrs/h7gvLArHfqG/ltX0I5AeF1iCTLGBqMHip1CC1N+4mHTY
         EEfMhXqOT4Cvy6kSAlvZLnuHOQY4IRpZ2MX9koV7VnA7avsWXz6yypW4cTpVhZ29tE22
         MwxXWdZM1LO0bonUk30Tw9sk6/b9Yi+RAShi/FA5zW1/VuySaCdULkCLhzTQQ2bwkHMB
         +MhJ5/QvsrDCImQvySWulvxTqLlQzJwh2Nzx6jqZ7sw29ZSMZUNKTvtEW7bhxqs8nuiI
         PWzWj2zoKSmygmQkpLciPPKy6l9moly/qwFssdGb8/3P5TFa6BS2GtwOE3kIzO1vN2or
         7NBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=HHOPpgbgSKjDTGkpjqLc9R9y62AcGcDlV5geHTzbj4k=;
        b=K1GoMVNXy7i/f6LwdT2CNxD3pJne4uAj2ns1QVuYe4IolDzIZzgR2NRx1gLvPlcXTL
         RU0rMJUee4jHB+wEyNvBbun+PTpIP4r5b5IFOzPO1pp2zTp6QUs2XXV94jDPcShNYy79
         Zmck2k1JxJIRvy0dax4L/VQvU801UnfjFdrlfBbnQwi71hPWNtAgoO9rCsHeV9QzQj1O
         qD32yhZNxvHjwRMkmwsbMCVCEFBSnMjmZ45yZAQqMD9YGdY2ovl+kvRzyBjmqq1oAdTU
         NJhZhcJMSPMZ4N4HtZihp0z5d/vvdfp8Pyt+rGiCf+S+rXGLEgTE3TsUsMWyIE8yj025
         Pn8A==
X-Gm-Message-State: AOAM531YhPrW6tDlQ4Po0CLrQkBoeEJG7BOprh3dkcuX+uZwJxedzHHz
        8i5ADA5C48ZUjQe88glXuSpIyw==
X-Google-Smtp-Source: ABdhPJw+4NVYCnu2GbhFtnNRtemtzn42yTacU2OokEGm5X69leVrkhBEzTunKFaJrBI+wZmBlt4Vig==
X-Received: by 2002:adf:e7c3:: with SMTP id e3mr6237105wrn.356.1596700050497;
        Thu, 06 Aug 2020 00:47:30 -0700 (PDT)
Received: from elver.google.com ([100.105.32.75])
        by smtp.gmail.com with ESMTPSA id p14sm5943332wrx.90.2020.08.06.00.47.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 00:47:28 -0700 (PDT)
Date:   Thu, 6 Aug 2020 09:47:23 +0200
From:   Marco Elver <elver@google.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        fenghua.yu@intel.com, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Luck, Tony" <tony.luck@intel.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        yu-cheng.yu@intel.com, jgross@suse.com, sdeep@vmware.com,
        virtualization@lists.linux-foundation.org,
        kasan-dev <kasan-dev@googlegroups.com>,
        syzbot <syzbot+8db9e1ecde74e590a657@syzkaller.appspotmail.com>
Subject: Re: [PATCH] x86/paravirt: Add missing noinstr to arch_local*()
 helpers
Message-ID: <20200806074723.GA2364872@elver.google.com>
References: <0000000000007d3b2d05ac1c303e@google.com>
 <20200805132629.GA87338@elver.google.com>
 <20200805134232.GR2674@hirez.programming.kicks-ass.net>
 <20200805135940.GA156343@elver.google.com>
 <20200805141237.GS2674@hirez.programming.kicks-ass.net>
 <20200805141709.GD35926@hirez.programming.kicks-ass.net>
 <CANpmjNN6FWZ+MsAn3Pj+WEez97diHzqF8hjONtHG15C2gSpSgw@mail.gmail.com>
 <CANpmjNNy3XKQqgrjGPPKKvXhAoF=mae7dk8hmoS4k4oNnnB=KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNy3XKQqgrjGPPKKvXhAoF=mae7dk8hmoS4k4oNnnB=KA@mail.gmail.com>
User-Agent: Mutt/1.14.4 (2020-06-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 07:31PM +0200, Marco Elver wrote:
...
> Oh well, it seems that KCSAN on syzbot still crashes even with this
> "fix". It's harder to reproduce though, and I don't have a clear
> reproducer other than "fuzz the kernel" right now. I think the new IRQ
> state tracking code is still not compatible with KCSAN, even though we
> thought it would be. Most likely there are still ways to get recursion
> lockdep->KCSAN. An alternative would be to deal with the recursion
> like we did before, instead of trying to squash all of it. I'll try to
> investigate -- Peter, if you have ideas, help is appreciated.

Testing my hypothesis that raw then nested non-raw
local_irq_save/restore() breaks IRQ state tracking -- see the reproducer
below. This is at least 1 case I can think of that we're bound to hit.

Thanks,
-- Marco

------ >8 ------

diff --git a/init/main.c b/init/main.c
index 15bd0efff3df..0873319dcff4 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1041,6 +1041,22 @@ asmlinkage __visible void __init start_kernel(void)
 	sfi_init_late();
 	kcsan_init();
 
+	/* DEBUG CODE */
+	lockdep_assert_irqs_enabled(); /* Pass. */
+	{
+		unsigned long flags1;
+		raw_local_irq_save(flags1);
+		{
+			unsigned long flags2;
+			lockdep_assert_irqs_enabled(); /* Pass - expectedly blind. */
+			local_irq_save(flags2);
+			lockdep_assert_irqs_disabled(); /* Pass. */
+			local_irq_restore(flags2);
+		}
+		raw_local_irq_restore(flags1);
+	}
+	lockdep_assert_irqs_enabled(); /* FAIL! */
+
 	/* Do the rest non-__init'ed, we're now alive */
 	arch_call_rest_init();
 
