Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEE0C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFFD120671
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589521305;
	bh=J/xAjUGNLO5gxT2AEedNfb/b/hDd1DvZ708ZwFjsd+4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1tV8ezMurNAOGf1bk168KADIHSADwteMmYSrBhrzV34cMG9BAhRZDsL+2GS/VAwLE
	 F2OblcvugyIclGGpX8YoB3xGzlP7VRKVn3F6FHYgpp+bVG1Hy/ng7C043PJH7KvBwE
	 J1qsxWb6ZzJ9d052QLO3QgSTUcGvxes3ShGDgXf0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgEOFlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 01:41:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:47212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725899AbgEOFln (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 01:41:43 -0400
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2A3E207C3
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 05:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589521303;
        bh=J/xAjUGNLO5gxT2AEedNfb/b/hDd1DvZ708ZwFjsd+4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=S05F/2oIq2x4hgpQHwEgQ/h9z5q9J2zJqify9VBJ1DU5IHCETH/c5VGMrKPBepfKh
         jDHthBFvDEU8iSSPC/Tp4hsGqbfUFHZ2F1PVpD5KIhVdCrKq2D4oDIxCP2ik74WE27
         BZZ0Vxe51m25CbJix0JmaQv/kQ45E2+uQLq4/W/g=
Received: by mail-wm1-f45.google.com with SMTP id m12so974027wmc.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 22:41:42 -0700 (PDT)
X-Gm-Message-State: AOAM533Fbt+O6D4s/aZ7WY9uhXaZ+/57DVtXzTs8OFwQPILaClzqqKeo
        Hrv+2PciKbpU2eD8gu4RKpr6yZI2WGfxio7aJRSrVA==
X-Google-Smtp-Source: ABdhPJyqW1K9nDENEb5LYSY8PKlJYn4LQIqwbARCQHg+ge/3Db+I3QWPcGaBlrX/3BqliMfWoLc5HYOiiGpTfiBHeRo=
X-Received: by 2002:a1c:b3c1:: with SMTP id c184mr1984329wmf.36.1589521301508;
 Thu, 14 May 2020 22:41:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134926.578885807@linutronix.de> <20200505135315.583415264@linutronix.de>
In-Reply-To: <20200505135315.583415264@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 14 May 2020 22:41:30 -0700
X-Gmail-Original-Message-ID: <CALCETrVfrO3ww_raqVnDi6OGf8VkcvzELPsvWu3QXpJiAkGbMg@mail.gmail.com>
Message-ID: <CALCETrVfrO3ww_raqVnDi6OGf8VkcvzELPsvWu3QXpJiAkGbMg@mail.gmail.com>
Subject: Re: [patch V4 part 4 23/24] x86/entry: Provide IDTENTRY_DF
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

On Tue, May 5, 2020 at 7:16 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Provide a separate macro for #DF as this needs to emit paranoid only code
> and has also a special ASM stub in 32bit.

Acked-by: Andy Lutomirski <luto@kernel.org>

but... maybe it would be cleaner just to open-code all of this in the
next patch?  This is a lot of macro to do nothing at all.
