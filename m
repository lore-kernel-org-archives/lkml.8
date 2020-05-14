Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF81C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 167F2206D4
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 05:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589432498;
	bh=v2wJfwp419exOl7Ke1ed12rDsFkCMWbprQv17uIQqzg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=txuUKjGYQ23I7UIorMPjDeKUoOQgI/+5aapUbg4OUnHta/sw3TOptRzZzR1bzqJuH
	 n/wC5N76pWRURnR+Djdd1D74bY6HI8uQ8owqmjlGj8uu4jpDIT+Xm8PIlED/g7X/RF
	 VHXPRHm3ryR6Kq9M4IMCBWJqvHtAiEXVZbJWbmDI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726037AbgENFBh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 01:01:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:43050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbgENFBg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 01:01:36 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2826A20728
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 05:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589432496;
        bh=v2wJfwp419exOl7Ke1ed12rDsFkCMWbprQv17uIQqzg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yS3WpFoAs3Bj9Lr2PlwR9kbOgxpxpDibprXjshZ7xklfzsEkaAB7TfP2DeSnxUx3c
         4ihktBhh6x2p6BpHrkI+GKohkZL2J+sK0z7nbxo6zrjfc3Ub6ADq/nR9BRSVoWmpYz
         yAlqBHeqt0myQgl2Dg5CS8ThW6d+2tbfGu6urZOk=
Received: by mail-wr1-f51.google.com with SMTP id e16so2126585wra.7
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 22:01:36 -0700 (PDT)
X-Gm-Message-State: AOAM5337u16pEl2dKTy4XNErXuD53YxpCqbtrL1porf1ZsJY2KwlCMWo
        83eHUO28o9ZwRvC97gHphITOb8o9c/BvwYFheGpRwA==
X-Google-Smtp-Source: ABdhPJx61a8Hvdvbz2qTw1HKNFfxb4ihQxzsn9wWiZ2uU0u/WzI2ixe4LaPjcyY6F7sy8fvkkrADzO2WEHOkVT2wQ4s=
X-Received: by 2002:adf:a389:: with SMTP id l9mr3239178wrb.18.1589432494530;
 Wed, 13 May 2020 22:01:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134926.578885807@linutronix.de> <20200505135313.938474960@linutronix.de>
In-Reply-To: <20200505135313.938474960@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 13 May 2020 22:01:23 -0700
X-Gmail-Original-Message-ID: <CALCETrUYgP2oDVoOnxQHwfPe-R=39zVWOPz9wP1CKGu5aBEWUA@mail.gmail.com>
Message-ID: <CALCETrUYgP2oDVoOnxQHwfPe-R=39zVWOPz9wP1CKGu5aBEWUA@mail.gmail.com>
Subject: Re: [patch V4 part 4 06/24] x86/entry: Convert INT3 exception to IDTENTRY_RAW
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
> Convert #BP to IDTENTRY_RAW:
>   - Implement the C entry point with DEFINE_IDTENTRY_RAW
>   - Invoke idtentry_enter/exit() from the function body
>   - Emit the ASM stub with DECLARE_IDTENTRY_RAW
>   - Remove the ASM idtentry in 64bit
>   - Remove the open coded ASM entry code in 32bit
>   - Fixup the XEN/PV code
>   - Remove the old prototypes

Gmail is so amused by your prototypo that it fixes it sometimes in the
quoted text.  See just above :)


Acked-by: Andy Lutomirski <luto@kernel.org>
