Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DF2C433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 21:31:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3399206F6
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 21:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W6Fe6hfg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gvXpoJL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbgGXVbg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 17:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgGXVbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 17:31:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59144C0619D3;
        Fri, 24 Jul 2020 14:31:36 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595626293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4aIj5BJFXygT8U4O1CTI3DzA3eMR9QI7whCGEMz/ttI=;
        b=W6Fe6hfg8SE4RiJMMLflHKp+NIWV0wPCb2wlrzrl1CWSYcA1ZeoGi7rq+Rv/c+87J015Ii
        ymqZRbBlkoC7snn6il30NJ9jrjaCZ2P5M9uWUecoBkwg2isk3ACjECD/reQ1fV64r8c6zK
        xXifmMt2Q2pN3iCuMj2WGD03NU0TkqnIl/4taUWW9AGKc9Kh6VVD0kyGKEw4odlDuHki5Q
        +KRrBOygiG05siOdbNw9K7vJEd7aC9LPaw6OfErJFt7c0v8VEO7A7HSr0cWdh4gT0jFy+q
        qIoaWcdYlCOxUrjclZMWRFUgn6vPWyAhHcJ/nA+kp0o5rWTg6Ypjjd3Hok5B8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595626293;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4aIj5BJFXygT8U4O1CTI3DzA3eMR9QI7whCGEMz/ttI=;
        b=gvXpoJL9j0ueMxbRK7LxQkpKPtXsWnCEONeSpDv+LpS7hSA8x+8FAQ2hRnaenRubtW+dhH
        8fovrLUcNueXU0BA==
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH RFC V2 17/17] x86/entry: Preserve PKRS MSR across exceptions
In-Reply-To: <874kpwtxlh.fsf@nanos.tec.linutronix.de>
References: <20200717072056.73134-1-ira.weiny@intel.com> <20200717072056.73134-18-ira.weiny@intel.com> <87r1t2vwi7.fsf@nanos.tec.linutronix.de> <20200723220435.GI844235@iweiny-DESK2.sc.intel.com> <87mu3pvly7.fsf@nanos.tec.linutronix.de> <874kpwtxlh.fsf@nanos.tec.linutronix.de>
Date:   Fri, 24 Jul 2020 23:31:33 +0200
Message-ID: <871rl0txai.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:
> static __always_inline idtentry_state_t idtentry_nmi_enter(void)
> {
>      	idtentry_state_t state = {};
>
>         nmi_enter();
>         instrumentation_begin();
>         state.key = save_and_clear_key();
>         instrumentation_end();

Clearly lacks a

        return state;

But I assume you already spotted it. Otherwise the compiler would have :)

Thanks,

        tglx
