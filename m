Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D23C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81DC42064B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZV91GvcK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729042AbgG1LW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 07:22:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728954AbgG1LWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 07:22:54 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36AF6C061794;
        Tue, 28 Jul 2020 04:22:54 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l12so633265pgt.13;
        Tue, 28 Jul 2020 04:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=+H8mbfz5G/XdCrlZ7IyriBgUJEkjk8H0AAeiqtbMsJA=;
        b=ZV91GvcKpfS8oMm4oA56q3PJts9xJtLVCObdQv7mQ8YLDgxzlYe8aW/kICb4Irs9iM
         1WD6vpmJxAAvQXwIon2pgUY5xGf4dLPerRktobcdaWsJZhjqvNB1mWUpStQZvjk+dYIV
         2W/fFhebuSrFiQpafQZMm3TPKPBec1gVNfwJwba60dXr8Yslz4lGpMSiKT/0BpHiTTHp
         xV2fnUHRauQkSqV079H2TH6WkCikFY7eX3TGXyl/lfFSDy/7KRBNkZ47cRNTSyvlYV9q
         B3FCAIj7KsJKBK2oEXHPQ5Fc5/JWwW/p4pF4FE4zy9pj4mOCQhvwoStVejW6IDMSrodW
         M3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=+H8mbfz5G/XdCrlZ7IyriBgUJEkjk8H0AAeiqtbMsJA=;
        b=dLnGR4et1D+Ow3trve1/dVGxkxD+OkY50cEphdlLoXykd+CD4Sd5w1kSsIV2PBKHxm
         4d8h22TdjSF1ZnVfcFlr2ElEv62m0d4XTBC6DsyJUMpRnjLXq1tMVFxZysoA8hSasT7f
         4P71/0rJq9wzsmNo13mryvlEPyIVLgN+M7cNojqgzfb5YmgnrNLiDBcPc/KmQC6t7B/C
         pR3iKI7ZRFD4XyGvZPxWtzUsKDtAGeBc2iX7Gajbl1U859H4ELDrV2C2CmmQTsEQ2kaX
         ldkiBcgU1CaZ0B5BDWwZVOupJGOPf7pfbx7uChvwHg+r2W5P0js3zG+k7GGUqXF9m2vP
         HVng==
X-Gm-Message-State: AOAM532qYCVl5eVf/Imo+XSIKOrWNvSo1bzVb9JxqB3eUgzKEVr00QNR
        Q2Lz5ru8OyR2MSvUiXZjYuw=
X-Google-Smtp-Source: ABdhPJyc88XpIEAWy7T80FPO3au3IMlAnQJQgd80vb9ee0D2KN8IYKKugRZS+LKGSsxnKrBu7QaSgw==
X-Received: by 2002:a62:ab15:: with SMTP id p21mr25070853pff.146.1595935373634;
        Tue, 28 Jul 2020 04:22:53 -0700 (PDT)
Received: from localhost (110-174-173-27.tpgi.com.au. [110.174.173.27])
        by smtp.gmail.com with ESMTPSA id y6sm2753154pji.2.2020.07.28.04.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 04:22:53 -0700 (PDT)
Date:   Tue, 28 Jul 2020 21:22:47 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/2] lockdep: improve current->(hard|soft)irqs_enabled
 synchronisation with actual irq state
To:     peterz@infradead.org
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
References: <20200723105615.1268126-1-npiggin@gmail.com>
        <20200725202617.GI10769@hirez.programming.kicks-ass.net>
        <1595735694.b784cvipam.astroid@bobo.none>
        <20200726121138.GC119549@hirez.programming.kicks-ass.net>
In-Reply-To: <20200726121138.GC119549@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-Id: <1595934957.l1u0ucmyps.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from peterz@infradead.org's message of July 26, 2020 10:11 pm:
> On Sun, Jul 26, 2020 at 02:14:34PM +1000, Nicholas Piggin wrote:
>> Excerpts from Peter Zijlstra's message of July 26, 2020 6:26 am:
>=20
>> > Which is 'funny' when it interleaves like:
>> >=20
>> > 	local_irq_disable();
>> > 	...
>> > 	local_irq_enable()
>> > 	  trace_hardirqs_on();
>> > 	  <NMI/>
>> > 	  raw_local_irq_enable();
>> >=20
>> > Because then it will undo the trace_hardirqs_on() we just did. With th=
e
>> > result that both tracing and lockdep will see a hardirqs-disable witho=
ut
>> > a matching enable, while the hardware state is enabled.
>>=20
>> Seems like an arch problem -- why not disable if it was enabled only?
>> I guess the local_irq tracing calls are a mess so maybe they copied=20
>> those.
>=20
> Because, as I wrote earlier, then we can miss updating software state.
> So your proposal has:
>=20
> 	raw_local_irq_disable()
> 	<NMI>
> 	  if (!arch_irqs_disabled(regs->flags) // false
> 	    trace_hardirqs_off();
>=20
> 	  // tracing/lockdep still think IRQs are enabled
> 	  // hardware IRQ state is disabled.

... and then lockdep_nmi_enter can disable IRQs if they were enabled?

The only reason it's done this way as opposed to a much simple counter=20
increment/decrement AFAIKS is to avoid some overhead of calling=20
trace_hardirqs_on/off (which seems a bit dubious but let's go with it).

In that case the lockdep_nmi_enter code is the right spot to clean up=20
that gap vs NMIs. I guess there's an argument that arch_nmi_enter could
do it. I don't see the problem with fixing it up here though, this is a=20
slow path so it doesn't matter if we have some more logic for it.

Thanks,
Nick
