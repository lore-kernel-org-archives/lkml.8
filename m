Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE73C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:29:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6C4A207F5
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 13:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AaAdvH9l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728587AbgFDN3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 09:29:37 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39962 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726415AbgFDN3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 09:29:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591277375;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UHW0elg334+EX9xWdFEPkYJk1jedIAwRKPuLSP3ktnU=;
        b=AaAdvH9lm2p4/Liok4RIOpHS+qVaxMFBv5kRistlb5SAWP/YS3ONqyojb3Zm2SbHfQp60e
        mKuONgadqzXcqJKTbiZjoMPFl2ccU5X1KNx2zvaIvX70GGD1g/2jNT2w1vawkmY1zPr4Tg
        LiJa/tEYvoWsk8j+dkRMw20yOqD4GuY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-5qP1k4cHMi-ZXAMBGiroMQ-1; Thu, 04 Jun 2020 09:29:33 -0400
X-MC-Unique: 5qP1k4cHMi-ZXAMBGiroMQ-1
Received: by mail-wr1-f69.google.com with SMTP id w4so2443292wrl.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 06:29:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UHW0elg334+EX9xWdFEPkYJk1jedIAwRKPuLSP3ktnU=;
        b=WLnBgX2TUn8L6elYS/Xzvz3J/QE8QkDfOUDk2H7sWM/okPBieooXRtvSLXq/7Hq5EC
         3/J//Vi+43x2cF3QEH/00usgCOsGIgmtafW06pcEDdiBQSIIILbmPGh9HOLXx/XngV19
         eUcAoW2r+iiaqNxyjwQ32OuSj3erdVxsGG36CtSoG2BrmEhc/UcXIr80w0ro0qZlYduC
         M9ldfLoEjXvr+3qAygc6zeDBquJ0oVCuvW+9UxFZKQBELB08M/GkLznpfhVXrFZw1MXG
         X6K5o9sM4dLkEC7bkZB/ghJHVlS9jCUWsuUwrkqawRi21eIGBFeEmp5i2dGebDT0ypZx
         Z17w==
X-Gm-Message-State: AOAM532Nz/OAL75gdDQLD669BTXKwLSTMU+IIcS7lseIMowiINRAZ1Vi
        eOrTff0ZsnqRbpGpF20RfdF8kMvq6y/I8zqwzxvLQd+nMqDVGvZmjy2hHddJWOGUMn9MdVmHkg4
        o6uHKl6MPBQzW1G7q03J3l+Np
X-Received: by 2002:a05:600c:4401:: with SMTP id u1mr4017460wmn.36.1591277368155;
        Thu, 04 Jun 2020 06:29:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9t/DEHjp8gQ1fl4/0vDSbAs3hZgC2IqMlIOVkhFw8ORBM1VevinmP9FqFYcIWLvyp3Hs8og==
X-Received: by 2002:a05:600c:4401:: with SMTP id u1mr4017441wmn.36.1591277367926;
        Thu, 04 Jun 2020 06:29:27 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:a0c0:5d2e:1d35:17bb? ([2001:b07:6468:f312:a0c0:5d2e:1d35:17bb])
        by smtp.gmail.com with ESMTPSA id a6sm7362518wrn.38.2020.06.04.06.29.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 06:29:27 -0700 (PDT)
Subject: Re: [patch V9 00/39] x86/entry: Rework leftovers (was part V)
To:     Peter Zijlstra <peterz@infradead.org>,
        Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>, X86 ML <x86@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Frederic Weisbecker <frederic@kernel.org>,
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
        "H. Peter Anvin" <hpa@zytor.com>
References: <20200521200513.656533920@linutronix.de>
 <5e68aa83-feac-2aa7-10ee-aebebc60c83e@citrix.com>
 <20200522211706.GZ2483@worktop.programming.kicks-ass.net>
 <83474edd-195f-f10b-9fe9-8ee168344e29@citrix.com>
 <20200604132537.GA3976@hirez.programming.kicks-ass.net>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c150c709-15d6-b126-4522-364b6663dcd5@redhat.com>
Date:   Thu, 4 Jun 2020 15:29:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200604132537.GA3976@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/06/20 15:25, Peter Zijlstra wrote:
> It being enabled through IA32_DEBUGCTL instead of through DR7 means that
> the current code doesn't disable it and this then means we can have
> nested #DB again.

/me bangs head on door

> Who sodding throught this was a good idea ?! What happened to #AC that
> SLD currently uses?

It was per-core and (presumably) considered unfixable?

Paolo

