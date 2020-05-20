Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D60F2C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FDAC20842
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589934952;
	bh=J/akIsA1oOL9p2sWCBNnuoNZZYCrLhIfyDFgQpJ7M94=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=y/gPKejiXqnZTmfvH1cMC7+M9X23ooyk6msmgO9S0v0Sxel+e5M/5NFvpMqg5Mc2P
	 mRHAzF4p2OApg7ioqfWObhMaJS16ndIGMdXCyjySk2wejGAXu/1/PEbVrzXJcJaEKO
	 C2svhO6amDvm9qS/+vHbcIx1L83MHukiqZbBtjDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbgETAfv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 20:35:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:48978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726348AbgETAfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 20:35:51 -0400
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1E7420873
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 00:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589934950;
        bh=J/akIsA1oOL9p2sWCBNnuoNZZYCrLhIfyDFgQpJ7M94=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=g+0PDZmVIyaVDz8QiX5wDPnO2dTJwcdgsHx0dypr5/M5QgjotJRP1cAR6X+uzHVEp
         jAVAUTbg0G/oNSaOP3k2Ieh0AhYY0Mp2Yeq1q6LlnSnBEVSyFom5mSX8qn1CNJqEa3
         miPoM3UCeUoyBjxYpw0CFQvYGRCmgsHR7N8EwKcQ=
Received: by mail-wr1-f46.google.com with SMTP id s8so1318490wrt.9
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 17:35:50 -0700 (PDT)
X-Gm-Message-State: AOAM532ahJoFZ51MsG4De3lFRxoUbGWBvhnpGan03SWrF7QmCHSQXNHn
        W7T5A/RtMJd5CEtwfuZugGUB7iy5DZsqDiPOjv1emQ==
X-Google-Smtp-Source: ABdhPJz9EQw8jC2a6O/JC80MY/WNlOa4gTGrPkAsj+KgYVII37Ctm1bKe/RQHRv7QO/WKYwaIqx0hUB9ydnpKygkhDY=
X-Received: by 2002:adf:a298:: with SMTP id s24mr1470038wra.184.1589934949125;
 Tue, 19 May 2020 17:35:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235127.792767126@linutronix.de>
In-Reply-To: <20200515235127.792767126@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 19 May 2020 17:35:37 -0700
X-Gmail-Original-Message-ID: <CALCETrVthDHNfRwJRpxPZTNgCofYikjE8i3RSVpbzzCfcA-pSw@mail.gmail.com>
Message-ID: <CALCETrVthDHNfRwJRpxPZTNgCofYikjE8i3RSVpbzzCfcA-pSw@mail.gmail.com>
Subject: Re: [patch V6 34/37] x86/entry/32: Remove redundant irq disable code
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
> All exceptions/interrupts return with interrupts disabled now. No point in
> doing this in ASM again.

Acked-by: Andy Lutomirski <luto@kernel.org>
