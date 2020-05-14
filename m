Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22E2C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 04:58:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7718205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 04:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589432326;
	bh=1bJl5V9rIa6F/KokSx6T9TyYU8drhQZpBwxhsnGNptA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WfgekHtSJIW5CZAQaNfkK/T0c3VreZuqBK27D3+DywGefIqQi37VWcDYGMqxB2taL
	 wH3fJZQ13k7bEHU93EcLOY58KfPlHlwpGnglanukgRjtx+DjeNvI2J1PMCib+3qYrK
	 um9WTKmxMcQVg35OS7NoW4eutpWcJWK4sloy0DjI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbgENE6p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 00:58:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:41070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgENE6p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 00:58:45 -0400
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 98C41205CB
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 04:58:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589432324;
        bh=1bJl5V9rIa6F/KokSx6T9TyYU8drhQZpBwxhsnGNptA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vQn/dP/iLKrrTc2XC0HKokLn2gw7p2FQgRjMrt8Vhb5zQaHAITfYtp9YyCtZq8K2E
         k4D0iTEchW19nbbgb/BkolyE/V1Gx6/T2Pj+XokOwXlQ3KLS6agVpSrBlbdaYlCpra
         BxWo9ABd6mExWlGvrt7ljJm/dkURGp8OUNM1l3BU=
Received: by mail-wr1-f50.google.com with SMTP id y16so2154486wrs.3
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 21:58:44 -0700 (PDT)
X-Gm-Message-State: AOAM533C/XH0Kt02ih6JHyq2t3AmBCREoP/VJqO+DYmQeR9EFSdT0BFf
        PDo/N2FI4ZLgwBgBHFjtFnzqggkWCB9AqggBi16Ybw==
X-Google-Smtp-Source: ABdhPJwSupgk0tJFS3rmq6v6FMlkcjjT9kwiAmtqx6+k291nr5Bxt+2tOY/v1qQ3jotcVLnQO2vKDcyeqys9J4y/rlc=
X-Received: by 2002:adf:a389:: with SMTP id l9mr3227189wrb.18.1589432323046;
 Wed, 13 May 2020 21:58:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134926.578885807@linutronix.de> <20200505135313.624443814@linutronix.de>
In-Reply-To: <20200505135313.624443814@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Wed, 13 May 2020 21:58:31 -0700
X-Gmail-Original-Message-ID: <CALCETrUkeDWw6c26GH_AdBr40QUCBdvy6WDtgh0GsZB3VqmNgA@mail.gmail.com>
Message-ID: <CALCETrUkeDWw6c26GH_AdBr40QUCBdvy6WDtgh0GsZB3VqmNgA@mail.gmail.com>
Subject: Re: [patch V4 part 4 03/24] lib/bsearch: Provide __always_inline variant
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
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 7:15 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> From: Peter Zijlstra <peterz@infradead.org>
>
> For code that needs the ultimate performance (it can inline the @cmp
> function too) or simply needs to avoid calling external functions for
> whatever reason, provide an __always_inline variant of bsearch().


Acked-by: Andy Lutomirski <luto@kernel.org>

Although maybe a more explicit name (e.g. __inlined_bsearch()) would
be more clear?
