Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007A5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 09:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C357B20787
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 09:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590485394;
	bh=PbnuSbjrPKx+frOK/02YHoC+zKJxsOZXbZBogVNVYUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=GF2MP1EWv3QOul+zwD07PXDreY1gBY3CMj8sbEUKmobERrK91m2P7HPG44VAFYgT3
	 6C4TAVQF6B9SfPMLu9zlLO9g9twr/rGOeY0+QO/D+rMjT3r+RrLRa21ayz4MPfXBIQ
	 7SVS9q5Eyiu7gPFRZnbdJiXwGyM3kT43eMgdZ08M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388550AbgEZJ3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 05:29:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44230 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388187AbgEZJ3x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 05:29:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id y17so11293211wrn.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 02:29:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ShjgF4SNUEG7M04ROEYeQ8ZjVBRjeIQdGVLkBtQG+ak=;
        b=Xy0H4SIOiF7fFa7UyTUgTqh3hqkGaQTj8v0oD/DB/gI2qX0CN6CB5zDY+PbZHyl0UB
         XpmQvnMz0hQHz8Gn4JV1FJLTRPDLv86M1Wswx97lCUDccdf78wuyKo8kH2U9afFiG+Lc
         CiEFmU0IlWraxxJbpwXtDcVKIP/xcd3zg5g6LT94xGQGlGnFQjcJyv3daLhkleQI93nl
         KrnXCnMYEeMhmMXEkLLuGXsfNiJ1//bCJqE5/ppX6przq5JW0PHWHM76/TrS1V5Hx3jJ
         wSCQd3o3o9IFSzLZJjkNv8mST2AYnF/s+Q20e11k9JzxTUUcISY947C1rLC0WizDNXaS
         +6aQ==
X-Gm-Message-State: AOAM533VrPI9oT9EH4fEDHFkXgb4q29NiBg4kGXG+V7uBugnERE/Z0ay
        D/G8Dwx7huIn8JgiV69LVAI=
X-Google-Smtp-Source: ABdhPJxPLemHBV0CT+S/xiQ8ckgGW5J9NJuBXtGnIc5m2r1m0PNqXrW4TPaPYYpcShID9RPqgZLwkg==
X-Received: by 2002:a5d:4cd1:: with SMTP id c17mr17472482wrt.199.1590485391877;
        Tue, 26 May 2020 02:29:51 -0700 (PDT)
Received: from debian (82.149.115.87.dyn.plus.net. [87.115.149.82])
        by smtp.gmail.com with ESMTPSA id o10sm9725133wrq.40.2020.05.26.02.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 02:29:51 -0700 (PDT)
Date:   Tue, 26 May 2020 10:29:48 +0100
From:   Wei Liu <wei.liu@kernel.org>
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
Subject: Re: [patch V9 30/39] x86/entry: Convert various hypervisor vectors
 to IDTENTRY_SYSVEC
Message-ID: <20200526092948.buwjs26ybsnmr67e@debian>
References: <20200521200513.656533920@linutronix.de>
 <20200521202119.647997594@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521202119.647997594@linutronix.de>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 10:05:43PM +0200, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> Convert various hypervisor vectors to IDTENTRY_SYSVEC
>   - Implement the C entry point with DEFINE_IDTENTRY_SYSVEC
>   - Emit the ASM stub with DECLARE_IDTENTRY_SYSVEC
>   - Remove the ASM idtentries in 64bit
>   - Remove the BUILD_INTERRUPT entries in 32bit
>   - Remove the old prototypes
> 
> No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Andy Lutomirski <luto@kernel.org>

For Hyper-V bits:

Reviewed-by: Wei Liu <wei.liu@kernel.org>
