Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INVALID_DATE_TZ_ABSURD,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B14BBC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:40:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88E7D20774
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 16:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KQKJWW+3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2saZQrvE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgHLQk0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 12:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgHLQkZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 12:40:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BA8CC061383
        for <linux-kernel@vger.kernel.org>; Wed, 12 Aug 2020 09:40:25 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597250423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sr4ZjRDn7p9oSL9sB2o+Nub+YTQc03hBBT19cTGtngc=;
        b=KQKJWW+3iOj8Cd6ZX0HAC2ajV0HNZ3/WHi7eAuNNAkZ/0/1bjtWl81IZbajtQUDuaRVFLg
        uph8gMpbR8tzMcSzz9AaDoo1+F8yl5gj0msjkQqr+YW9v575BGZWVfMQMs0GlMKbhra3jG
        UjLhhIyN1LjkXkC7gLkhr7vnftECp4//TJ/V3WYm/uQs+Tk5ZzfuTzT5ZjbB/3XhTH1VIs
        xAOstHwwSCe7Ku6zhpdgFYmKooPFiRZz8FnzlSqmMt+u574yk1lds/gap6pAI41ReyOID3
        fxzxl0sR6rZOYg6jCzUCMzoh9sHJIBvwNUML+TEY9mHk5yb9zAIVaIsUc/Wd6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597250423;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sr4ZjRDn7p9oSL9sB2o+Nub+YTQc03hBBT19cTGtngc=;
        b=2saZQrvEFyRJTa7OodrC3r7g0KiaxYIMPytiqqihcIlSnea4P0c9X+98lHiqHW1wnVlYWQ
        kTpcsnx4xUf5cRDg==
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     gregkh@linuxfoundation.org, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, parri.andrea@gmail.com,
        paulmck@kernel.org, peterz@infradead.org, pmladek@suse.com,
        rostedt@goodmis.org, sergey.senozhatsky.work@gmail.com,
        sergey.senozhatsky@gmail.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, swboyd@chromium.org
Subject: Re: [PATCH v5 4/4] printk: use the lockless ringbuffer
In-Reply-To: <20200811204729.1116341-1-ndesaulniers@google.com>
References: <20200709132344.760-5-john.ogness@linutronix.de> <20200811204729.1116341-1-ndesaulniers@google.com>
Date:   Wed, 12 Aug 2020 18:46:22 +0206
Message-ID: <871rkb4y2x.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-11, Nick Desaulniers <ndesaulniers@google.com> wrote:
> From what I can tell, I think this patch ("printk: use the lockless
> ringbuffer") breaks lx-dmesg in CONFIG_GDB_SCRIPTS.
>
> (gdb) lx-dmesg
> Python Exception <class 'gdb.error'> No symbol "log_first_idx" in specified context.: 
> Error occurred in Python: No symbol "log_first_idx" in specified context.
>
> This command is used to dump the printk log buffer.
>
> It looks like the only places left in the kernel that reference are:
>
> - Documentation/admin-guide/kdump/gdbmacros.txt
> - Documentation/admin-guide/kdump/vmcoreinfo.rst
> - scripts/gdb/linux/dmesg.py
>
> I believe this commit removed log_first_idx, so all of the above
> probably need to be fixed up, too.

Thanks for pointing this out! I will get to work on a patch for this.

John Ogness
