Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6202AC2D0CE
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A5B7206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 16:24:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SV6U4Wn7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729417AbgAUQYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 11:24:16 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46235 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727817AbgAUQYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 11:24:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579623854;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZaPl343WQTeUca+zKxxAd+wT3iRZfUeitieV2HiNnn4=;
        b=SV6U4Wn78dGJLjm8F9mMc19riG3GWiI06FB/yS24nc2BsgmvZummPQS4bN9hErLSQFd/GE
        0EgUmdXYxIOKUZ8OJgQtZjYmocfb/T84T2qe0+Wl9iVj0mvkGOZHom/UGxc1lPFwAyn8Hz
        v0mNs3SY2FYI1ws1PoZB9+djEOrnHOA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-47-FarA3sOuOOamc-nNKUIInQ-1; Tue, 21 Jan 2020 11:24:08 -0500
X-MC-Unique: FarA3sOuOOamc-nNKUIInQ-1
Received: by mail-wm1-f70.google.com with SMTP id b9so837318wmj.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 08:24:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=ZaPl343WQTeUca+zKxxAd+wT3iRZfUeitieV2HiNnn4=;
        b=UMLai1g6fI/fSPQp1DHyRWf0+u0TV5tDK9fwk7cFb0DbSlJpemc7O49mTshf2bhO8y
         8ocHqSx8KtPcwgF6fc/RLwCO6C6WNhRSMUfpwEjTD3nD3SG+0sMi/O/XOOjjXx162TQF
         KWfQxeUzXhlsrcC8z1q5kD3W2+GS4BLwOY9mjH1gwp/wkpwoLCYia7749dxgghZqr6Ny
         PTXdOlq62ur5biasoAlUuXR+G00MFXcSdRQM4ZK1SF7PEOuvNveH18aaqzqZSW1s+5Kc
         dmdg7HlZM9Ov0U3ybGhiMkKO1ECr08EMZq8Hfgvbw4EtRwebm9XmW1oSrMiBto4O+AV8
         frQw==
X-Gm-Message-State: APjAAAWiLFJ57Vd4qy5lQt9dzHjGFfxJUEKUtqEkz9Ju6wTWEhKW/Lqi
        T1WWIGTZc/Gt9PIXaM72XA/tOO6B8X5qcjACwQs1D7AZyb4gqCJjR9UX6Etnhl8vuRcQLPH4f48
        kSGKmYCi+LJkc/w9ePfsBqjgl
X-Received: by 2002:a5d:4b88:: with SMTP id b8mr6093471wrt.343.1579623847834;
        Tue, 21 Jan 2020 08:24:07 -0800 (PST)
X-Google-Smtp-Source: APXvYqwM+z5tBgVa5M38L7rl8TPpnWIoxzUIAe2hIojMCSRUkazfR+rDk1yh4Jfo59VUrP1D1J9UnQ==
X-Received: by 2002:a5d:4b88:: with SMTP id b8mr6093447wrt.343.1579623847641;
        Tue, 21 Jan 2020 08:24:07 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id g7sm52700782wrq.21.2020.01.21.08.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jan 2020 08:24:07 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Tyler Hicks <tyhicks@canonical.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Anthony Steinhauser <asteinhauser@google.com>
Subject: Re: [PATCH RFC] x86/speculation: Clarify Spectre-v2 mitigation when STIBP/IBPB features are unsupported
In-Reply-To: <20200121161412.GL7808@zn.tnic>
References: <20200121160257.302999-1-vkuznets@redhat.com> <20200121161412.GL7808@zn.tnic>
Date:   Tue, 21 Jan 2020 17:24:06 +0100
Message-ID: <87v9p4eq1l.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Borislav Petkov <bp@alien8.de> writes:

> On Tue, Jan 21, 2020 at 05:02:57PM +0100, Vitaly Kuznetsov wrote:
>> When STIBP/IBPB features are not supported (no microcode update,
>> AWS/Azure/... instances deliberately hiding SPEC_CTRL for performance
>> reasons,...) /sys/devices/system/cpu/vulnerabilities/spectre_v2 looks like
>> 
>>   Mitigation: Full generic retpoline, STIBP: disabled, RSB filling
>> 
>> and this looks imperfect. In particular, STIBP is 'disabled' and 'IBPB'
>> is not mentioned while both features are just not supported. Also, for
>> STIBP the 'disabled' state (SPECTRE_V2_USER_NONE) can represent both
>> the absence of hardware support and deliberate user's choice
>> (spectre_v2_user=off)
>> 
>> Make the following adjustments:
>> - Output 'unsupported' for both STIBP/IBPB when there's no support in
>>   hardware.
>> - Output 'unneeded' for STIBP when SMT is disabled/missing (and this
>>   switch_to_cond_stibp is off).
>> 
>> RFC. Some tools out there may be looking at this information so by
>> changing the output we're breaking them. Also, it may make sense to
>> separate kernel and userspace protections and switch to something like
>> 
>>   Mitigation: Kernel: Full generic retpoline, RSB filling; Userspace:
>>    Vulnerable
>> 
>> for the above mentioned case.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>>  Documentation/admin-guide/hw-vuln/spectre.rst | 3 +++
>>  arch/x86/kernel/cpu/bugs.c                    | 9 +++++++--
>>  2 files changed, 10 insertions(+), 2 deletions(-)
>
> There's another attempt to fix similar aspects of this whole deal going
> on ATM:
>
> https://lkml.kernel.org/r/20191229164830.62144-1-asteinhauser@google.com

Missed that, thanks! (Cc: Anthony)

This patch seem to address my STIBP: disabled/unsupported concern but
not 'unneeded'. And not IBPB.

-- 
Vitaly

