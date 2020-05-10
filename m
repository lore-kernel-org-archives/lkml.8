Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54416C38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 20:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 344B120731
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 20:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589142690;
	bh=LfFf6ZVT2QkA6Dtvvht9TOnFtd+bdPkSZsNrSwHsybo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=P3XLbgc0s063Eh8JWFoBkL8Un+WSfriltmD2HjWbGl34nyCFpDL1H6ZCTnnH7UxlN
	 HqHpqP0W0aBq2UPrNV60IrQGrPsk3fGW/fAOtQwEJ+dxf9qcV6PdWBidTYp4QqgIx8
	 Jr/fU/eeihP+np5dwxXKcAEMQbsro+VrObocrjfI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729321AbgEJUb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 16:31:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:38528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728468AbgEJUb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 16:31:28 -0400
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45EA420731
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 20:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589142688;
        bh=LfFf6ZVT2QkA6Dtvvht9TOnFtd+bdPkSZsNrSwHsybo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2NupWFCZ3k0yTEcTI14LQv+FJnLP7aZ+u9axLeO+nzvK/ofiShJfbA4zKx0STIrtz
         5rGvWNK1zGM+Qdw36s+kloNPxySOtzDqBC2RQHCF6FS4AMgy7+cehprcKv4GbxIDd2
         Y43nDyerY/uG28I3mg5b8UxBLlZCZrhq8iBgixLs=
Received: by mail-wm1-f48.google.com with SMTP id u16so16843557wmc.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 May 2020 13:31:28 -0700 (PDT)
X-Gm-Message-State: AGi0PuaeQK/sYELr878E8jW+i3eIZ7ed9GH2taZGAnyiUCa+NCQ08tXg
        C6rPD61CCneEiaHrSG1A307Dc/6rR+4S84ng8OS2Vw==
X-Google-Smtp-Source: APiQypJ6xO7jNX24c2MwAVgxgagog95NUtkNmOpqwlQ/nIEPmIByfqutAZZ0BPV6VeoidLZdW7OmqZmjG64p347cqNo=
X-Received: by 2002:a7b:c5d3:: with SMTP id n19mr20552281wmk.21.1589142686852;
 Sun, 10 May 2020 13:31:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134354.774943181@linutronix.de> <20200505134903.949227617@linutronix.de>
In-Reply-To: <20200505134903.949227617@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 10 May 2020 13:31:15 -0700
X-Gmail-Original-Message-ID: <CALCETrX=dgHba0yQVwi2a30w3RJTe2v7O7m+6pHVJXickVcEEA@mail.gmail.com>
Message-ID: <CALCETrX=dgHba0yQVwi2a30w3RJTe2v7O7m+6pHVJXickVcEEA@mail.gmail.com>
Subject: Re: [patch V4 part 3 07/29] x86/entry: Distangle idtentry
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
> idtentry is a completely unreadable maze. Split it into distinct idtentry
> variants which only contain the minimal code:
>
>   - idtentry for regular exceptions
>   - idtentry_mce_debug for #MCE and #DB
>   - idtentry_df for #DF
>
> The generated binary code is equivalent.

Acked-by: Andy Lutomirski <luto@kernel.org>
