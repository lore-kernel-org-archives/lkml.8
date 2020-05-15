Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 887EDC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6014D20728
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589520470;
	bh=8dI/vbbPskuu2o8TVN0BhT+heOYmcal5N0YfkmVfQig=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Zel4F7w9jyAUGMCaXh9DerJWP1yGSzkSGdxYQVn6mLeB5aYH94/i6BUTCTVl15shD
	 Pdyd1xg6n3DKc0O1Ux4ZnhsonAl2mz1E7m4LoWPFvIkOmaPSn9fsku5BY2lP1PquW7
	 Kg1mk/Od6EjKxCsyUh+fJdvN2wFF6pK+xIHiBn0A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgEOF1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 01:27:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726163AbgEOF1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 01:27:49 -0400
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3821F2065F
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 05:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589520468;
        bh=8dI/vbbPskuu2o8TVN0BhT+heOYmcal5N0YfkmVfQig=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0nDjhW0OZgP/jhHza8g6LhWKAf1+ZHvc4bSuOn+AOhubFqH378HvxOtCneEbYj0WS
         cwNSlwMmZCGwuAgon+i0ZcFVm7xIrBoj668ia439EHFyXstMnm2U9aMnRIgeARNXXA
         aiACqcAWKFd3ntDhXDP3vS6VDya1S0O40OXVD3fY=
Received: by mail-wr1-f41.google.com with SMTP id h17so1910306wrc.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 22:27:48 -0700 (PDT)
X-Gm-Message-State: AOAM531G3LijvMVihGHT+vlBGTP7rF/cRXZWTTelfngVByKVkMgMpuPl
        nT198sf+f9BmA2IOF08773/+bV1BM2qLU7JcJduBUQ==
X-Google-Smtp-Source: ABdhPJzTJln3owtDKZB4cmdrg4+c+IqR2JpFimvkDlkaIKxStwjvAODlbh/bhG0Qh79+faiDrCyaePCsQashJjzahgI=
X-Received: by 2002:adf:a389:: with SMTP id l9mr2231651wrb.18.1589520466744;
 Thu, 14 May 2020 22:27:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134926.578885807@linutronix.de> <20200505135314.900297476@linutronix.de>
In-Reply-To: <20200505135314.900297476@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 14 May 2020 22:27:35 -0700
X-Gmail-Original-Message-ID: <CALCETrXtWyYP9ZhrxEyzwRP1pcuzsUUJpJGWJed_5Kj0V7ccsQ@mail.gmail.com>
Message-ID: <CALCETrXtWyYP9ZhrxEyzwRP1pcuzsUUJpJGWJed_5Kj0V7ccsQ@mail.gmail.com>
Subject: Re: [patch V4 part 4 16/24] x86/entry: Convert Debug exception to IDTENTRY_DB
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
> Convert #DB to IDTENTRY_ERRORCODE:
>   - Implement the C entry point with DEFINE_IDTENTRY_DB
>   - Emit the ASM stub with DECLARE_IDTENTRY
>   - Remove the ASM idtentry in 64bit
>   - Remove the open coded ASM entry code in 32bit
>   - Fixup the XEN/PV code
>   - Remove the old prototyoes
>
> No functional change.


Acked-by: Andy Lutomirski <luto@kernel.org>
