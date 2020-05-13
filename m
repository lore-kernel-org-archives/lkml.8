Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7E0C2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 07:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9ED5920673
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 07:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731463AbgEMHe5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 03:34:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:42674 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728988AbgEMHe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 03:34:56 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D99B8AFA9;
        Wed, 13 May 2020 07:34:55 +0000 (UTC)
Date:   Wed, 13 May 2020 09:34:49 +0200
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
        Steven Rostedt <rostedt@goodmis.org>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/6] allow ramoops to collect all kmesg_dump events
Message-ID: <20200513073448.GG7340@linux-b0ei>
References: <20200506211523.15077-1-keescook@chromium.org>
 <20200512131655.GE17734@linux-b0ei>
 <CA+CK2bBMUxxuTBicQ7ihKpN3jK94mMjcNCXhnAXUaODce09Wmw@mail.gmail.com>
 <20200512155207.GF17734@linux-b0ei>
 <202005121111.6BECC45@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005121111.6BECC45@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2020-05-12 11:45:54, Kees Cook wrote:
> Here are the problems I see being solved by this:
> 
> - lifting kmsg dump reason filtering out of the individual pstore
>   backends and making it part of the "infrastructure", so that
>   there is a central place to set expectations. Right now there
>   is a mix of explicit and implicit kmsg dump handling:
> 
>   - arch/powerpc/kernel/nvram_64.c has a hard-coded list

It handles restart, halt, poweroff the same way.  I wonder if anyone
would want to distinguish them.

>   - drivers/firmware/efi/efi-pstore.c doesn't expect anything but
>     OOPS and PANIC.
>   - drivers/mtd/mtdoops.c tries to filter using its own dump_oops
>     and doesn't expect anything but OOPS and PANIC.
>   - fs/pstore/ram.c: has a hard-coded list and uses its own
>     dump_oops.
>   - drivers/mtd/mtdpstore.c (under development[3]) expected only
>     OOPS and PANIC and had its own dump_oops.

The others handle only panic or oops.

What about splitting the reason into two variables? One for severity
and other for shutdown behavior. I mean:

  + reason: panic, oops, emergency, shutdown    (ordered by severity)
  + handling: restart, halt, poweroff

Or we might just replace KMSG_DUMP_RESTART, KMSG_DUMP_HALT,
KMSG_DUMP_POWEROFF with a single KMSG_DUMP_SHUTDOWN.

Then the max reason variable would make sense.

Best Regards,
Petr
