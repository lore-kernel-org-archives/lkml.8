Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9FE8C54FD0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:53:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6DAA20767
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 18:53:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sDAFKvHz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbgDWSxH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 14:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgDWSxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 14:53:07 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1654DC09B042
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 11:53:07 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id j4so7933071otr.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 11:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HMPPKtadtl0cEjroea7mXsdefqmGAHEHdtPRIbCzW0Q=;
        b=sDAFKvHzrkB3rjxkW4EUPUKW6zSesgCna5+ROQwp/oYmsYtaTWVt1MIlYXTYGxPTWW
         Tb3UU+oi6w9YnvWvcnEs/ySG3JTllE/Q9rQsfpZk5R495gXnyNX2e5hwEzBIBSz8NkCp
         dlUIP3JpnufeBhRb8pRgTmEKHbIuvHMERZ3XAL0Jv4F4NZbLVjN4wACcSCgvKMxuWcJj
         VUA165wRwkpcOZOoED3pirf3HiOKcWY2jOKeBckzPSP1jVdDcWjcvnERVZv0oi7JIr8/
         dUIk2J1Pv8yzdKYstU5GisQwWxklfPB6oXVvuUhYbhWY7o1KvseYaSvafgmY/ZmD0EFp
         hcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HMPPKtadtl0cEjroea7mXsdefqmGAHEHdtPRIbCzW0Q=;
        b=eEQWoLFtNom0VBfzXQQnBppLmbHgofMSEkOqxcHDzRU0blgBiitH1k+6Z6cNFssYkh
         0BjUvdlYt1LIq44UrXT15yGYqz8lBW24WW/EO9/5wKEzcZJeiX5EA4hlfKu5VaIMAtJA
         VQXFU6YBvibZiSsCZwmLAiVmexGiq7kScTdE+4ZuJ0BNm1hPUyFYxlcZ+juf0joj5uuT
         U/yAFw4W4//D90yvpZz27CqqK/kQaj49a45DMHOno7JCXdSrJ1vgIGat7tqKc7xNFQc2
         PbXIfrR/+YuWXyX1psYmP02eFqpipW9zn62LsD2T1quASIvyfjdG+AyaAIl5dM7I3X5a
         FuSg==
X-Gm-Message-State: AGi0PuZrIDegRBbVl/v1WJ9qJUq/UlTEh0LlUfAhqKOFZPavcHybekW4
        g/NWqEwxVOsyzgtiW0DWzkyHi3VEhvkli4dxJVQlwQ==
X-Google-Smtp-Source: APiQypKp/CKEoiUXBB9NIOWJDTRO/kEDOqevd9xQIVVjzftkBl9I/Wp5OMfDbp0fksX1vycP85f3Tdi+yNFwSLlA7Nw=
X-Received: by 2002:aca:db08:: with SMTP id s8mr4239090oig.97.1587667986328;
 Thu, 23 Apr 2020 11:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <CALAqxLURuJ-tMxMY6Z2BvLmyd6X+w7SiSB5otoH6vx+NxJm-NA@mail.gmail.com>
 <20200423171029.GS17661@paulmck-ThinkPad-P72> <20200423184955.c7yij2hg7a2ftsfa@linutronix.de>
In-Reply-To: <20200423184955.c7yij2hg7a2ftsfa@linutronix.de>
From:   John Stultz <john.stultz@linaro.org>
Date:   Thu, 23 Apr 2020 11:52:54 -0700
Message-ID: <CALAqxLXGik84wE9bW+1vEDKnv3O3iynPtgX3FG=d-Jma0qrb8Q@mail.gmail.com>
Subject: Re: BUG: Invalid wait context with 5.7-rc2?
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        lkml <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 11:49 AM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2020-04-23 10:10:29 [-0700], Paul E. McKenney wrote:
> > > Curious if this was already on anyone's radar?
> >
> > Looks like __queue_work() is attempting to acquire a normal spinlock_t
> > with interrupts disabled, which -rt doesn't like much.  And I believe
> > that lockdep has been upgraded to check for this.
> >
> > Adding Sebastian for his thoughts.
>
> This is known. There is more than just workqueue in this regard. Please
> disable CONFIG_PROVE_RAW_LOCK_NESTING until this is fixed (see Kconfig
> help). Except for workqueue, there is also printk which triggers the
> same warning and isn't as easy to fix as workqueue.

Ok. Appreciate it! Thanks so much for the context! I'll stop worrying
about that one and keep digging on my own issue.
-john
