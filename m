Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EBFC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47C8D20829
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589934701;
	bh=6+agXW4zenIC/HJ/Zp4vlFlE90oquxkrfOuA8MnRMbg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=sBvmZmLmg1MBYLJfyJ3LhzOp7iHx3oHD+SXAhEw+uupGM++GbK0xykweD4A8m23qB
	 73ZohTxf1NI0nmYn3wPJlc8Bfjtspix6mZe6MxKNkCVmOQUK8i68jI0PTbl0YKJdaC
	 zHQUziF+YDm8A/QQ2di62PJxcD5xZbrpxQ/jCkAY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728533AbgETAbk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 20:31:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:44338 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbgETAbk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 20:31:40 -0400
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DD822088E
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 00:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589934699;
        bh=6+agXW4zenIC/HJ/Zp4vlFlE90oquxkrfOuA8MnRMbg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tzmy3tXGTRIFG4hidXwsx5NlPpY7RQUWDhgEH9Sg9/+0wzENwOswgfoKum/GY+7L3
         o3eYOilR8QgdXfNnrzHq66vZ0F3iE7QO7VGt0dAW4O9A8CwswH+ZMvah/GqVvucKeO
         uX5Hly11Ma3LomzOy1pdL7ZJZwQ/9M3HxogScWTw=
Received: by mail-wr1-f53.google.com with SMTP id v12so1289632wrp.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 17:31:39 -0700 (PDT)
X-Gm-Message-State: AOAM531611THSaYmDMA8mlmlu1jbmlJJXb/7dk59sJxYHAOSuLEv94sf
        gXWVO/cPEBtHBHmBlCmG3Uxhn7o/Z6QtCFUPxCOs4Q==
X-Google-Smtp-Source: ABdhPJxV1KoPs65Fz1IP88n6YQGZ0w97Ca3JTWU0ZbvBvyaaboIOZRpNFMD9EAqOJuyY3WxdZa7LGxhw/4Y4VpXeBtg=
X-Received: by 2002:adf:a389:: with SMTP id l9mr1522509wrb.18.1589934697658;
 Tue, 19 May 2020 17:31:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235127.198194779@linutronix.de>
In-Reply-To: <20200515235127.198194779@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 19 May 2020 17:31:26 -0700
X-Gmail-Original-Message-ID: <CALCETrVXEYxp3=E8u=uWTfbpCEvspMe+oRT+YAHcQOLx0OOggQ@mail.gmail.com>
Message-ID: <CALCETrVXEYxp3=E8u=uWTfbpCEvspMe+oRT+YAHcQOLx0OOggQ@mail.gmail.com>
Subject: Re: [patch V6 28/37] x86/entry: Convert various hypervisor vectors to IDTENTRY_SYSVEC
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
        Will Deacon <will@kernel.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Jason Chen CJ <jason.cj.chen@intel.com>,
        Zhao Yakui <yakui.zhao@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 15, 2020 at 5:10 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
>
> Convert various hypervisor vectors to IDTENTRY_SYSVEC
>   - Implement the C entry point with DEFINE_IDTENTRY_SYSVEC
>   - Emit the ASM stub with DECLARE_IDTENTRY_SYSVEC
>   - Remove the ASM idtentries in 64bit
>   - Remove the BUILD_INTERRUPT entries in 32bit
>   - Remove the old prototypes
>
> No functional change.

Acked-by: Andy Lutomirski <luto@kernel.org>
