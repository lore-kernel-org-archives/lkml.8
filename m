Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBAA3C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 04:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91DE820888
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 04:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590467648;
	bh=qVTX+YX6F63Pfda7rmUlj2X1xHs0/WE2NmKhekGoR4c=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VksKA0V5DowvaKn++Q1Q/zVzrUmHypU9USWW5D6hcUVY7YHD6aNcrczp82vbDRj3G
	 nlGM8uQB4w8OQhUD4Chmubs6uuHLeNAOqBOZhMffH7CHi1MlZ3VFmqyAUIn/3ag+JB
	 5fF1BQQcoNBSUw8y6i+/pWucS5HVAhQFJo+yfQnA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgEZEeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 00:34:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:42844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbgEZEeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 00:34:07 -0400
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C86420888
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 04:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590467646;
        bh=qVTX+YX6F63Pfda7rmUlj2X1xHs0/WE2NmKhekGoR4c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X3mIzEKB7mcZaev42a2ZKCpl88KbBF3koEsBuTfutF0aNomXIwk8GWjU31Y8hxmvP
         WHlzIWm3SpPB+tf/tPjuEkfq0JpmExhrJFHAtDGDWXbzlMTF/rNG3pSlf7i75RdGGZ
         ZOZgcZmX/1BVm0bqUtBrTwdRBpLkldMYdJKOCSco=
Received: by mail-wr1-f47.google.com with SMTP id y17so10624634wrn.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 21:34:06 -0700 (PDT)
X-Gm-Message-State: AOAM5300JzYn2TrC1kNYyfZJV3jGiGQEMtXfQrkvZswSlPT3xpaVkEJn
        STLSnQvxz6JYZeKXSF/V73E/3tj5elkIw18Q9lXghQ==
X-Google-Smtp-Source: ABdhPJyBjYggt/4KvjVWHQUq2FU5fdBEKAOA4JrMSrmL6UCDPJYYioUa9sg8atAzSdADhoX+JjRirTc6yjh2k8K8ppg=
X-Received: by 2002:adf:ea11:: with SMTP id q17mr16108387wrm.75.1590467644721;
 Mon, 25 May 2020 21:34:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200521200513.656533920@linutronix.de>
In-Reply-To: <20200521200513.656533920@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Mon, 25 May 2020 21:33:53 -0700
X-Gmail-Original-Message-ID: <CALCETrVYBj3KQTCeDt9V=4yTYVqs4X5_TKx=v8=Z5w=q0Ay8cw@mail.gmail.com>
Message-ID: <CALCETrVYBj3KQTCeDt9V=4yTYVqs4X5_TKx=v8=Z5w=q0Ay8cw@mail.gmail.com>
Subject: Re: [patch V9 00/39] x86/entry: Rework leftovers (was part V)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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

On Thu, May 21, 2020 at 1:31 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Folks!
>
> This is V9 of the rework series. V7 and V8 were never posted but I used the
> version numbers for tags while fixing up 0day complaints. The last posted
> version was V6 which can be found here:

The whole pile is Acked-by: Andy Lutomirski <luto@kernel.org>

Go test on Linus' new AMD laptop!

--Andy
