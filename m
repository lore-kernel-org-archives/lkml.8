Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E575C2D0CE
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 22:04:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6887D2071E
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 22:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgAXWEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 17:04:55 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43698 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725821AbgAXWEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 17:04:54 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iv74O-0002QG-5y; Fri, 24 Jan 2020 23:04:52 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 947D710308A; Fri, 24 Jan 2020 23:04:51 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Jules Irenge <jbi.octave@gmail.com>
Cc:     boqun.feng@gmail.com, Jules Irenge <jbi.octave@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] time: Add missing annotation to lock_hrtimer_base()
In-Reply-To: <31c31ca2d78d9368d38e1a5909bc0c9a7be5dc98.1579893447.git.jbi.octave@gmail.com>
References: <cover.1579893447.git.jbi.octave@gmail.com> <31c31ca2d78d9368d38e1a5909bc0c9a7be5dc98.1579893447.git.jbi.octave@gmail.com>
Date:   Fri, 24 Jan 2020 23:04:51 +0100
Message-ID: <87d0b8mry4.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jules,

Jules Irenge <jbi.octave@gmail.com> writes:

Please use the proper subsystem prefixes when sending patches.

git log --oneline path/to/file

gives you usally a pretty good hint.

> Sparse reports a warning at lock_hrtimer_base()
>
> |warning: context imbalance in lock_hrtimer_base() - wrong count at exit

This leading '|' is pointless

> |warning: context imbalance in hrtimer_start_range_ns() - unexpected unlock
> |warning: context imbalance in hrtimer_try_to_cancel() - unexpected unlock
> |warning: context imbalance in __hrtimer_get_remaining()
> |- unexpected unlock

How are the last 3 related to:

> Sparse reports a warning at lock_hrtimer_base()

?

> To fix this , an __acquires(timer) annotation is added.

  Add the missing __acquires(timer) annotation.

Is precise and follows the recommendations of Documentation/process/...

> Given that lock_hrtimer_base() does actually call READ_ONCE(timer->base).

Given that the above sentence uses 'Given that' it should not terminate
right after explaining the 'Given'.

> This not only fixes the warnings but also improves on readability of
> the code.

I tend to disagree. In fact the annotation disturbes the reading flow
because it's on a separate line.

Can you please stop using this boilerplate which is neither helping
review nor giving someone who looks at the commit later on any useful
information?

Here is a suggestion for a change log for this:

  Sparse reports several warnings;
   warning: context imbalance in lock_hrtimer_base() - wrong count at exit
   warning: context imbalance in hrtimer_start_range_ns() - unexpected unlock
   warning: context imbalance in hrtimer_try_to_cancel() - unexpected unlock
   warning: context imbalance in __hrtimer_get_remaining()- unexpected unlock

  The root cause is a missing annotation of lock_hrtimer_base() which
  causes also the 'unexpected unlock' warnings.
  
  Add the missing __acquires(timer) annotation.

Hmm?

The other 2 patches of this series have similar issues. The futex
changelog is also horribly formatted.

Thanks,

        tglx
