Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E018DC38A2A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 00:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B672D207FF
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 00:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589158708;
	bh=EexeP/ilwIZIsF6lCaIb4mzp2+v0kWIN11dxzvZYatU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=0omif+z54WHpUiRQ638GfQ41TbDFx49u2E0k8whkUc9wvlE/hjI33fkYoWrXnxnEz
	 aABvpzdDrDNRG/j2wEU10a0bSOY3gnUh+YZn25BVKqtMHQM0gmd4iUFgNKubtu2Mpw
	 3d4dcxOwPUutzsvb7sBJbWWjtARcMsQg3CWZFilo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729491AbgEKA61 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 20:58:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:36892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729095AbgEKA61 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 20:58:27 -0400
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A341A24954
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 00:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589158706;
        bh=EexeP/ilwIZIsF6lCaIb4mzp2+v0kWIN11dxzvZYatU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O/3TcNgVcp3io/qY+F35V6gKwN9vVwERE1h2SfqO7vUUTVzZ8bU8kXhLgZ7yxoLF2
         7iOn/PaIgdS8ilbWQeUc81v7ddhJxGVMcXI8Mng+pDNFDPIUZbdkqekvEu0EUGBwIr
         Qja12BvW2RseNdTHvXUbOLgZ2KaR4LAUqllzzz8w=
Received: by mail-wr1-f48.google.com with SMTP id w7so8819388wre.13
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 17:58:26 -0700 (PDT)
X-Gm-Message-State: AGi0Pua3kfNHADf08NdLhxhHOWsyt6HrzbX03LLbmDi/Aq59gpZSsYhz
        +AYgnne+8q4fEW/CyqE5wkO2+3ZNY4SIb48H5tc/iQ==
X-Google-Smtp-Source: APiQypKQx34W5bTiJF1j8ItGCE+ziX9ZT/qr+fACzfs4qZF6q1/RHJSRLQQRtnSlqdQcApFgan5R32tlDjB+XdDBE1o=
X-Received: by 2002:adf:eccf:: with SMTP id s15mr14992853wro.70.1589158705155;
 Sun, 10 May 2020 17:58:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134354.774943181@linutronix.de> <20200505134904.273363275@linutronix.de>
In-Reply-To: <20200505134904.273363275@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 10 May 2020 17:58:14 -0700
X-Gmail-Original-Message-ID: <CALCETrXd+-nvDcwupvbtr8-Gj2RQsGfFiUu-wr86dw4-nJ=S5w@mail.gmail.com>
Message-ID: <CALCETrXd+-nvDcwupvbtr8-Gj2RQsGfFiUu-wr86dw4-nJ=S5w@mail.gmail.com>
Subject: Re: [patch V4 part 3 10/29] x86/idtentry: Provide macros to
 define/declare IDT entry points
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
> Provide DECLARE/DEFINE_IDTENTRY() macros.

Acked-by: Andy Lutomirski <luto@kernel.org>

except:

>
> DEFINE_IDTENTRY() provides a wrapper which acts as the function
> definition. The exception handler body is just appended to it with curly
> brackets. The entry point is marked notrace/noprobe so that irq tracing and
> the enter_from_user_mode() can be moved into the C-entry point.

"noinstr", perhaps?  I'm guessing you write this text before noinstr happened.

Also, would it perhaps make sense in the future to include the
idtentry macro somehow (via inline asm or gcc options) so that
DEFINE_IDTENTRY() could emit the stub instead of leaving it to
DECLARE_IDTENTRY()?  It might end up too messy in practice, I suppose.
This is obviously not worth changing right now, but maybe down the
road.
