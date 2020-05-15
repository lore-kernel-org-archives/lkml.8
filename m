Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D06C0C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E54320760
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 05:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589520268;
	bh=D1Mhutuxg2DPblPSYiRI6z8kl0kDMOThuWJYcrtIiFE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VNHjqS8eYdlddksmWQcLKO/MuClg0HDmW/gQM7CSCIyqAkL3JAtCdPZuBVr8oneKt
	 hn3FTunV/guntfwq2y22WFFn5v17RKC8U2y19R7qM6JP7wLEIiWwYsdUGruhYxZLwz
	 X4AxY2PnQjlaFTThJnXYTumri1Tcq0Dkufv+y3ok=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgEOFY2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 01:24:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:60682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726217AbgEOFY1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 01:24:27 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA051207BB
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 05:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589520266;
        bh=D1Mhutuxg2DPblPSYiRI6z8kl0kDMOThuWJYcrtIiFE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oH20iWvHaCfMvTa6hdO5LPadiHLQTZ6tW5VigGbBTfPP2/xUEuRcTFP4XIV4+L7SC
         mN5jOQ+wtS3JVKNkF9Nvw6HmOGL+Fzfo0aeL1Wiuvo0bUmiCotRIBM3Mw5wk2bKjyH
         MGXgnzmJVbHKj9W42ikL/UX79uJeEEkbbZzvlltM=
Received: by mail-wr1-f44.google.com with SMTP id l17so1936368wrr.4
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 22:24:26 -0700 (PDT)
X-Gm-Message-State: AOAM530vPKBP/Y6vT+/LhbjmwN4rOkRIKffGKjvGy0toGwFxCM9btcmc
        oHIHsVhPLDQydrSJLmIx2Q98uvl6r0vtHNp0Xy8lLw==
X-Google-Smtp-Source: ABdhPJzSIQbfHVa7DLub5UxHPTEj/YFF+5eHMmsgI74FtkHo1/mIRCMGaTAN0QuAek7CcaZNVdRddfQgTYIYGDtVLU4=
X-Received: by 2002:adf:fe45:: with SMTP id m5mr2099016wrs.257.1589520265063;
 Thu, 14 May 2020 22:24:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200505134926.578885807@linutronix.de> <20200505135314.334980426@linutronix.de>
In-Reply-To: <20200505135314.334980426@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Thu, 14 May 2020 22:24:13 -0700
X-Gmail-Original-Message-ID: <CALCETrXbZpJGj1y46mixKbe-hu71cE=14OXMwa9DC0KTX6QjAQ@mail.gmail.com>
Message-ID: <CALCETrXbZpJGj1y46mixKbe-hu71cE=14OXMwa9DC0KTX6QjAQ@mail.gmail.com>
Subject: Re: [patch V4 part 4 10/24] x86/entry: Convert Machine Check to IDTENTRY_IST
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
> Convert #MC to IDTENTRY_MCE:
>   - Implement the C entry points with DEFINE_IDTENTRY_MCE
>   - Emit the ASM stub with DECLARE_IDTENTRY_MCE
>   - Remove the ASM idtentry in 64bit
>   - Remove the open coded ASM entry code in 32bit
>   - Fixup the XEN/PV code
>   - Remove the old prototyoes
>   - Remove the error code from *machine_check_vector() as
>     it is always 0 and not used by any of the functions
>     it can point to. Fixup all the functions as well.
>
> No functional change.


Acked-by: Andy Lutomirski <luto@kernel.org>
