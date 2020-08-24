Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E654DC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 23:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B49AE206EB
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 23:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="i0hzNdiE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbgHXXxM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 19:53:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60013 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbgHXXxM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 19:53:12 -0400
Received: from carbon-x1.hos.anvin.org ([IPv6:2601:646:8600:3280:1098:42a1:36db:233c])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 07ONqLRP2464825
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 24 Aug 2020 16:52:21 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 07ONqLRP2464825
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020072401; t=1598313144;
        bh=JM6qo6j85EsiFGJo5bpjdiQ4d9EYsiab14JL4DBBCQI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=i0hzNdiE6BrFVawkgDXaHtoE+pTY37EXLlolpCHpcfbYjtMFclVq8ndCg9cj0Cjkn
         5+R+2V/liasUhKg0uyO2epUJTZ5/u2g2vIPOVSGfRVX7eiAS+VJEivjdDmpo5krBcI
         T3/Ij8ID1Q8qWH57wS0xs3qnI3Tx4fl1bv4QgAJ0Nz42AvwvRqnwMFeIRoabG0rcg7
         HumzkNZs2Rs9zuNy8i8Pdue31bd1zZaJhQKUhtlvG81pckGCniRzoIFwVrVVDiUtNg
         kvhXqiIpHroklTtMUELFOj+A/0SawIg6FU4x9ibV+AH7qfQZKp1Hg9gD6YBjPrWhex
         VGM/zfAhYCXBA==
Subject: Re: [REGRESSION] x86/cpu fsgsbase breaks TLS in 32 bit rr tracees on
 a 64 bit system
To:     Andy Lutomirski <luto@kernel.org>,
        "Robert O'Callahan" <robert@ocallahan.org>
Cc:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Kyle Huey <me@kylehuey.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
References: <CAOp6jLYrwMqV=7hmxgdZUdDZ2aeUB27TTHm=j6cQT7C10Muhww@mail.gmail.com>
 <7DF88F22-0310-40C9-9DA6-5EBCB4877933@amacapital.net>
 <CALCETrUrvrQNw6dPau_rtHjA_YuCVdCTWYd4dsdcvcGsOaspmg@mail.gmail.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <b0813ec5-b163-cc11-bfc9-e9d08c9c4ff2@zytor.com>
Date:   Mon, 24 Aug 2020 16:52:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CALCETrUrvrQNw6dPau_rtHjA_YuCVdCTWYd4dsdcvcGsOaspmg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-24 14:10, Andy Lutomirski wrote:
> 
> PTRACE_READ_SEGMENT_DESCRIPTOR to read a segment descriptor.
> 
> PTRACE_SET_FS / PTRACE_SET_GS: Sets FS or GS and updates the base accordingly.
> 
> PTRACE_READ_SEGMENT_BASE: pass in a segment selector, get a base out.
> You would use this to populate the base fields.
> 
> or perhaps a ptrace SETREGS variant that tries to preserve the old
> base semantics and magically sets the bases to match the selectors if
> the selectors are nonzero.
> 
> Do any of these choices sound preferable to any of you?
> 

My suggestion would be to export the GDT and LDT as a (readonly or mostly
readonly) regset(s) rather than adding entirely new operations. We could allow
the LDT and the per-thread GDT entries to be written, subject to the same
limitations as the corresponding system calls.

	-hpa

