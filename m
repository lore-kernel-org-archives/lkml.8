Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 275B1C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 23:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2E4820724
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 23:05:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598223928;
	bh=MT4hXiSC7bB81yIZ9jkCCwMmUeVSdfkfkly0vsYtmPU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=FfrIh1dqDF0zS5FNqhxMqcCL5RvkaChQgzk+E0arH1nmvy59uAOp/Juc6I9Kb9NKM
	 wV+LN/itMICRHD5FwaNwml7a89UcxBc52GwULpdiTIZVKUFYC7nliHUdCGke+91KeR
	 aywDuI+ahNhIkgsi45LniW5c29sB4bsvzrCWAwZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgHWXF0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 19:05:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:37364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726631AbgHWXFZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 19:05:25 -0400
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B320E22B3F
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 23:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598223925;
        bh=MT4hXiSC7bB81yIZ9jkCCwMmUeVSdfkfkly0vsYtmPU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=P75IuQ5hAYqoH15pniwwGB2pjnMfpNvP1nCJt7rlXAz/5OT/5RntYPqnDpxQiFplp
         ACocrfjHX0Y4olJJddRMi+P+Hvg3uq6RiUzENxgLMD7KQ9B8CeP/hW99QzUekIH7sp
         mnFTvoYyQ6RwbuOw3+2uruE/NBmS6txw3lM7QN9A=
Received: by mail-wr1-f51.google.com with SMTP id c15so6861196wrs.11
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 16:05:24 -0700 (PDT)
X-Gm-Message-State: AOAM532q4bxUR0KkvIgzHKDA4ko5OJOVMqqMXtta5eFTaSwFoN6vXaB1
        xbGTLW/iA0q94vb9C8fKNuYnbKH3o++fAia4JoaUUw==
X-Google-Smtp-Source: ABdhPJw3YGuseiXCPiqboMP11UPr12JryRp1xwhFLf/rVOMZP43mBgZCkm3+cDcQJewT9khUZ1LhWQMbkvdU5g26J2Y=
X-Received: by 2002:adf:9283:: with SMTP id 3mr3110796wrn.70.1598223923309;
 Sun, 23 Aug 2020 16:05:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200821093912.815135402@infradead.org> <20200821102052.969925934@infradead.org>
In-Reply-To: <20200821102052.969925934@infradead.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sun, 23 Aug 2020 16:05:12 -0700
X-Gmail-Original-Message-ID: <CALCETrVBfM0B8viVFZ5uPuLJnJWPmF8smciMmnf0n9nwegcNTQ@mail.gmail.com>
Message-ID: <CALCETrVBfM0B8viVFZ5uPuLJnJWPmF8smciMmnf0n9nwegcNTQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/8] x86/debug: Remove handle_debug(.user) argument
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
> The handle_debug(.user) argument is used to terminate the #DB handler
> early for the INT1-from-kernel case, since the kernel doesn't use
> INT1.
>
> Remove the argument and handle this explicitly in #DB-from-kernel.

Acked-by: Andy Lutomirski <luto@kernel.org>
