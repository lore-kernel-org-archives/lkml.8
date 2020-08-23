Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1EFC433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 23:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 897F22072D
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 23:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598224296;
	bh=BCwIL8BZHn3eI2tqa/kgvc98qVPVBfUsxvsIzZrfJ3g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1AcebnnvfkvXZ2bFYlkrcCLcccVYR0WI/hw4BFVpo1vfs4mDoFrWaJIlYve3AkSI5
	 PLjYfCZPjRASGWNJy1WHHjJISN7fG5zYYhqhMz8gqG+psMW3hBhq+0aiYyUPvglOEj
	 Z7os1FmYlvwJErGzhvJRMtki3xd8nTwGGh6YvSqo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgHWXLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 19:11:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:40160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgHWXLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 19:11:32 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35E45221E2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 23:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598224291;
        bh=BCwIL8BZHn3eI2tqa/kgvc98qVPVBfUsxvsIzZrfJ3g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=XHNpaLqfzGlDhobM8HCFCbVvtDNvg4cdhZ+xWNXKFGtC3KKyT3kLsK4adLu+O71qc
         EnOxLyAI+xCEGVSSOEXMZ0jvdWcxgx/AUPen3MBDQjaIjs7yMpa86GtozO5sD7KI2Z
         ifYhR1pD3eLt57bMZ/2UMjFqBgXmh4H61JJsf9Sw=
Received: by mail-wm1-f45.google.com with SMTP id a65so3050045wme.5
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 16:11:31 -0700 (PDT)
X-Gm-Message-State: AOAM533bXrsw8/xcDNVH/8hYbCmT3T4bzyDaMQRIvxrU9Pk5FbyKurlO
        ZjPWSp6bysz7+ZNINs+26TNH+EKueVju6GsE7xdWaw==
X-Google-Smtp-Source: ABdhPJz8B6sM7+LM2fthhpeY9wjeM67AlrTus0j2XWe7olFHIGn6T6qEvgzyAhqEGJia10bJyk48lWg8laNqXsQesoI=
X-Received: by 2002:a7b:c76e:: with SMTP id x14mr2904019wmk.176.1598224289860;
 Sun, 23 Aug 2020 16:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200821093912.815135402@infradead.org> <20200821102053.219655533@infradead.org>
In-Reply-To: <20200821102053.219655533@infradead.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 23 Aug 2020 16:11:18 -0700
X-Gmail-Original-Message-ID: <CALCETrWJhes7QVmqit1XU+ioq13Ly7A9QJ5s4grp3+Vq75vMxw@mail.gmail.com>
Message-ID: <CALCETrWJhes7QVmqit1XU+ioq13Ly7A9QJ5s4grp3+Vq75vMxw@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] x86/debug: Remove the historical junk
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Kyle Huey <me@kylehuey.com>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Robert O'Callahan" <rocallahan@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
        Andy Lutomirski <luto@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Daniel Thompson <daniel.thompson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 3:21 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Remove the historical junk and replace it with a WARN and a comment.
>
> The problem is that even though the kernel only uses TF single-step in
> kprobes and KGDB, both of which consume the event before this,
> QEMU/KVM has bugs in this area that can trigger this state so we have
> to deal with it.

Almost acked by me.

If you make the change I suggested earlier, then the ->debugreg6
garbage can actually die.

--Andy
