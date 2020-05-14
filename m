Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0F9C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 04:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA4E5206D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 04:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589432178;
	bh=tS6PKCuuaOVh0/HHtSVgwzL/oCVDFPvX06UPgSGQWhE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MEz27BXC4p7Wqjp4/3qL/Gto81bKNDAi2/MJUBe1xxeEHDWB21Clzy5nrCqG8/8T4
	 heE4BV0SR4ADdLUiJKtFIsw39RVhCJI84XZgfnOXld7Afo36mr1exU/wZj6wy/IrnC
	 +B++TuBOYryrttDIpAeKMeZfHjPaIVLkXIVPhdkM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbgENE4R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 00:56:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:39424 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgENE4R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 00:56:17 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8420020760
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 04:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589432176;
        bh=tS6PKCuuaOVh0/HHtSVgwzL/oCVDFPvX06UPgSGQWhE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=z6yd1RCNAg146bMIZgBYghDRAwc8CNO0E9GDvv6Y22+HXx7bV9FGw1JGbbLffzfNY
         p5zT5zxdwQdwayO2C+sm7SXURaZ5Y4KAPetm7j9EjgU4lZrcGyImwlMZkC+ag3osPC
         4KTTWpE4kEmlltBfqGJE+TqKQDPgvwsKxo1KqIls=
Received: by mail-wr1-f50.google.com with SMTP id l11so2165204wru.0
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 21:56:16 -0700 (PDT)
X-Gm-Message-State: AOAM5303WMVmnGXKR753r7W4fwS758yLEY2b/lrrXOUHPvUN2EaEKktd
        iGGnIq4o31qZl4aEBptZrHZkfM5WsV/V5w5NeWAP7g==
X-Google-Smtp-Source: ABdhPJwtUZFFJakPLlCkH6LG/je1q4bEiHwcCHjYcddMslsCKpxPP5mdKFwD8PzXc3D9vYl+MjTL6h4JitBekxFSjuI=
X-Received: by 2002:adf:fe45:: with SMTP id m5mr3019712wrs.257.1589432174795;
 Wed, 13 May 2020 21:56:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134354.774943181@linutronix.de> <20200505134906.021552202@linutronix.de>
In-Reply-To: <20200505134906.021552202@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 13 May 2020 21:56:03 -0700
X-Gmail-Original-Message-ID: <CALCETrXGjAnyva+xFLjg_ceZxUqWVs9aZju=5R8bYH5iSYQvOA@mail.gmail.com>
Message-ID: <CALCETrXGjAnyva+xFLjg_ceZxUqWVs9aZju=5R8bYH5iSYQvOA@mail.gmail.com>
Subject: Re: [patch V4 part 3 28/29] x86/entry: Convert SIMD coprocessor error
 exception to IDTENTRY
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Brian Gerst <brgerst@gmail.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 7:15 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> Convert #XF to IDTENTRY_ERRORCODE:
>   - Implement the C entry point with DEFINE_IDTENTRY
>   - Emit the ASM stub with DECLARE_IDTENTRY
>   - Handle INVD_BUG in C
>   - Remove the ASM idtentry in 64bit
>   - Remove the open coded ASM entry code in 32bit
>   - Fixup the XEN/PV code
>   - Remove the old prototyoes
>   - Remove the RCU warning as the new entry macro ensures correctness
>
> No functional change.


Acked-by: Andy Lutomirski <luto@kernel.org>
