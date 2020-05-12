Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC638C54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0F69206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:17:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730104AbgELNRA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 09:17:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:48918 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728085AbgELNQ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 09:16:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 12F75AC64;
        Tue, 12 May 2020 13:17:00 +0000 (UTC)
Date:   Tue, 12 May 2020 15:16:55 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Pavel Tatashin <pasha.tatashin@soleen.com>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>, jmorris@namei.org,
        sashal@kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/6] allow ramoops to collect all kmesg_dump events
Message-ID: <20200512131655.GE17734@linux-b0ei>
References: <20200506211523.15077-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200506211523.15077-1-keescook@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2020-05-06 14:15:17, Kees Cook wrote:
> Hi!
> 
> This is my stab at rearranging a few things based on Pavel's series. Most
> things remain the same; I just tweaked how defaults are arranged and
> detected and expanded the wording in a few places. Pavel, how does this
> v3 look to you?
> 
> Pavel's original cover letter:
> 
> pstore /mnt/console-ramoops-0 outputs only messages below the console
> loglevel, and our console loglevel is set to 3 due to slowness of
> serial console. Which means only errors and worse types of messages
> are recorded. There is no way to have different log levels for
> different consoles.
> 
> This patch series adds a new option to ramoops: max_reason that enables
> it to collect kmdesg dumps for other reasons beside oops and panics.

I was a bit confused by the above explanation. It talks about two
different numbering schemes:

   + console loglevels: emerg, alert, crit, err, warning, ...
   + dump reason: panic, oops, emerg, restart, halt, poweroff

This difference and also the jump from consoles to ramoops is far from
obvious.

My understanding is the following:

It is not possible to set loglevel per console. The global value must
be set by the slowest one. This prevents seeing all messages even
on fast consoles.

Alternative solution is to dump all messages using ramoops. The
problem is that it currently works only during Oops and panic
situation. This is solved by this patchset.


OK, I personally see this as two separate problems:

   1. Missing support to set loglevel per console.
   2. Missing support to dump messages for other reasons.

I would remove the paragraph about console log levels completely.
It is your reason to use ramoops. But it is not reason to modify
the logic about max_reason.


Now, the max_reason logic makes sense only when all the values
have some ordering. Is this the case?

I see it as two distinct sets:

   + panic, oops, emerg: describe how critical is an error situation
   + restart, halt, poweroff: describe behavior when the system goes down

Let's say that panic is more critical than oops. Is restart more
critical than halt?

If you want the dump during restart. Does it mean that you want it
also during emergency situation?

My fear is that this patchset is going to introduce user interface
(max_reason) with a weird logic. IMHO, max_reason is confusing even
in the code and we should not spread this to users.

Is there any reason why the existing printk.always_kmsg_dump option
is not enough for you?

Best Regards,
Petr
