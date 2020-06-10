Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F70C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 12:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D587C2072E
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 12:38:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="XSoUosvV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729132AbgFJMil (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 08:38:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728933AbgFJMij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 08:38:39 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CB9C03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 05:38:38 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id k22so1541952qtm.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 05:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=74QRp+fFVrmSINpFkFNz/AyQxHDWN5CpI1MCB1mJkcA=;
        b=XSoUosvVcltD8InvwL3/x1D+LTJ4K9Z8qU1dp/3uX6RVtvk3Spg7UGJM8igm0mhy0d
         uYIT5d7Xa09xeS+Ka8eSI4Cu+GLB203vZqEXbSFbYojWU+wH9CtEc9ICPIl/0cvdiycB
         rKiaygLCyrbezsZg1iUIYCtafevgux+t28e1s/akXMI+aYrymGVGzjCzRcwOUBZ5Nz0D
         b5E3jBGHmJr0j9N998HZX1YudiNnttH/JHcaOeEPQApO59vTNJ8MsQZlUM97V4Ffzhwt
         bqTE5mzeybw4c47XGH6dfuO4zKcUbpVzdDr1EafuOBKaHelxA6d0QodhgCJbu79xLytv
         v+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=74QRp+fFVrmSINpFkFNz/AyQxHDWN5CpI1MCB1mJkcA=;
        b=hoEBucG8KfVzxvly9a6g2wuBs5fhZD9jEGOUhjCIFHBt/Hl+8zWb9q1i/61OzULMch
         m4jtA5IYc7uEG8nS0SguGJRFhFgLOUSLa8x7wBXIC4cTqi2DXDnum925YU9yIP5dFUD+
         FEJY5cVpgpf0IRLRTSBnLUgOWfdQLnWxw+6nwkDjgwm6WLEr8byE5Pbq4Skc9IM9u21S
         si2+GvCpDCp3WwZJqEyMPodDafUMGWKH4Nzr4inlb6jOIWIIhym+4jHtz4fw/jxqeV+r
         +zpaOvEgwnsj9g5ktjuVld7uDNbv2UhGLnBBOgs8bR6XH0V/1tBefwrDRO+dyXfYBq4p
         PjKQ==
X-Gm-Message-State: AOAM532dCzCbhjOUb7p8uTgwTmCDESgC/I4Zzb8Ikko+tTAmCX+WnmQy
        YqMNdywAH8M7BojWh+FvNCbF4g==
X-Google-Smtp-Source: ABdhPJx11Ru8V8taKZBApNZoZCZDRjW9r/ulNbSGFoKV/WO0hYpUzCv2eV+/3mRcwKkincysWNLi6Q==
X-Received: by 2002:ac8:378f:: with SMTP id d15mr2984163qtc.136.1591792717396;
        Wed, 10 Jun 2020 05:38:37 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id b53sm13101819qtc.65.2020.06.10.05.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 05:38:36 -0700 (PDT)
Date:   Wed, 10 Jun 2020 08:38:33 -0400
From:   Qian Cai <cai@lca.pw>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
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
        Alexander Potapenko <glider@google.com>
Subject: Re: [patch V9 10/39] x86/entry: Provide helpers for execute on
 irqstack
Message-ID: <20200610123833.GD954@lca.pw>
References: <87zh9cnfmg.fsf@nanos.tec.linutronix.de>
 <87wo4gnetx.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wo4gnetx.fsf@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 10:50:50PM +0200, Thomas Gleixner wrote:
> Qian,
> 
> Thomas Gleixner <tglx@linutronix.de> writes:
> >> BAD (after oom02)
> >> # cat /sys/kernel/debug/stackdepot/info
> >> Unique stacks: 140476
> >
> > That's indeed odd. I try to reproduce and figure out what really breaks
> > here.
> 
> I checked your config file and I think I know where this comes from. Can
> you plase disable KASAN just for testing purposes and compare before
> after again?

It turns out I'll need a few days to be able to get ahold of those
affected systems again. I'll be reporting back as soon as possible.
