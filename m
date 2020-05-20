Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF60AC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B22DE20842
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589934721;
	bh=Vj4MoAZThD5PoYBowKDvHhxtY/1LGMsiKWqhJznIkng=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FLkfoYLp4e2PRl7dtxv/uJ/N9vZTzbT1kQPf1WRQtO2gKziJ4LmKpwLK82C6RNvNv
	 6b+8S81I+7z+kMaZGsEmZZVew3hqyk4RMPl686Kp0TGom7PhUPja6W5dlBb9FKPC8f
	 Gc6zeBSadeh9X286aIjsIQeShmzktpj/qwQI2MH8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728552AbgETAcB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 20:32:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:44864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726379AbgETAcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 20:32:00 -0400
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB98C2084C
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 00:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589934720;
        bh=Vj4MoAZThD5PoYBowKDvHhxtY/1LGMsiKWqhJznIkng=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=2PmFq1vw/FyVhhV7d6ycDo7fq0pEuRLuFkWtSUHTX3x1ey5AParqm+yBzdtELQN1Z
         vN+3ZjlDuKqCtx9O0MqoLiWWnHhHQTCZmZLSojL8lF1SZkiU/RgXqEJrF2UmirvQPc
         Tug2wbVHcQbQMXBdRtrtwiB4oDgepD21E1gvNeCY=
Received: by mail-wm1-f54.google.com with SMTP id h4so968558wmb.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 17:31:59 -0700 (PDT)
X-Gm-Message-State: AOAM532PKUCemLkBJ8FmXcFVqnhVn4n1DReBVh586bQn1Iy34JIWdMYz
        GicEcFxA+iZUg66qpcj1iyiGLljFIZZtKAu1E5CA+g==
X-Google-Smtp-Source: ABdhPJzzDKUeEaYabpXRpicgoQvKxEfar3no7w9TJB1TEE4osBscRYYshK1gHwo1Y1OxoHLixuVXOunq9vgrz4y8dlg=
X-Received: by 2002:a1c:9989:: with SMTP id b131mr1898692wme.176.1589934718338;
 Tue, 19 May 2020 17:31:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200515234547.710474468@linutronix.de> <20200515235127.311082011@linutronix.de>
In-Reply-To: <20200515235127.311082011@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Tue, 19 May 2020 17:31:46 -0700
X-Gmail-Original-Message-ID: <CALCETrXshKD6g1tKUi=qgdhaRSegRbTnbW04kUDUo+3VY6+ynQ@mail.gmail.com>
Message-ID: <CALCETrXshKD6g1tKUi=qgdhaRSegRbTnbW04kUDUo+3VY6+ynQ@mail.gmail.com>
Subject: Re: [patch V6 29/37] x86/entry: Convert XEN hypercall vector to IDTENTRY_SYSVEC
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
> Convert the last oldstyle defined vector to IDTENTRY_SYSVEC
>   - Implement the C entry point with DEFINE_IDTENTRY_SYSVEC
>   - Emit the ASM stub with DECLARE_IDTENTRY_SYSVEC
>   - Remove the ASM idtentries in 64bit
>   - Remove the BUILD_INTERRUPT entries in 32bit
>   - Remove the old prototypes

Acked-by: Andy Lutomirski <luto@kernel.org>
