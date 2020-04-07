Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91706C2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639572078A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:16:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="sY6pD4XW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbgDGOQk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:16:40 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:32898 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728861AbgDGOQj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 10:16:39 -0400
Received: by mail-pg1-f193.google.com with SMTP id d17so1805278pgo.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 07:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=nLSA7WGf+iI/uqjocg3jy7gnQIxiPv4ZG9SRGV0SsjM=;
        b=sY6pD4XWO6yDRQ48KIuHy/LVVx8uJGPOGYNLFtNBzgUriQ3gQs9j9xWzROUkdQJREm
         H88BLVe3guteuTBAPJcg3JMiafRq/RJ3Wm1n9XeY/hnysJjHKVmjcHA04uZvjmzmHHSp
         fUe+ZspqMLIbyiw4JvHHkXLC5XHJf0DSSivnKArAamAebIfMY3BoEzWk0JB4Xh6brHPV
         FL5+C4L/B8VyW5C7zEiJwFDUw2BXwNPiRl1uwrGg804wKmNG+ymk4eGT6NNH/7uTBKTa
         J0T1CR8qCu60AptbaAhPso72A4M7xVgoDykEA71O/uBS6sg+YjTGxKQ0ebbVz8LE216P
         lqgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=nLSA7WGf+iI/uqjocg3jy7gnQIxiPv4ZG9SRGV0SsjM=;
        b=Ofk+Bx1BGbeaT3URvoZNXST9sEbuMZ6/kP2aUgdNQs5YjrjpBcI1I6VxdAHNR4HWlK
         qbqK7mBeOa2/4bSxMr3SG9HLW5cL8ZbvUsHVRKTpH8IKjnG4IBhymqzOVN0nDeB950Gn
         iOjnSeSysTDvZVzvgUFHSwvbSweJS8vKatWftsK+V2GzOLRJY6qjEzVC194hPk0UzLHJ
         VT9yvSN3MLOkN8LHCBqiVBh+WusSPW+9GIvz7Daz9jxJ32Ye6f8bk7QPfprg7M0bCXc/
         EUhuzCZsxpiesVnf3QNHDKtnIPLieWodk6g1Q9VwyGw9BnMCGxNJG6LcNcKHx6O6KrCL
         zR+g==
X-Gm-Message-State: AGi0PuYlJaWbTDEeAP6ijBuBq9xv4inppBuJ3wX33QjKL2MUvWLh4SIl
        r4O7wXRb4PeBqEhXbozp6/olTg==
X-Google-Smtp-Source: APiQypIynIOntpedXRAuRnA+JSjxtWZI/O0qjQNmxZI9NkXKo72GAkhWr64AizC6zCJPxKJFF+zflQ==
X-Received: by 2002:a62:92:: with SMTP id 140mr2693207pfa.186.1586268997569;
        Tue, 07 Apr 2020 07:16:37 -0700 (PDT)
Received: from ?IPv6:2600:1010:b064:7066:dc53:1479:9187:9f80? ([2600:1010:b064:7066:dc53:1479:9187:9f80])
        by smtp.gmail.com with ESMTPSA id 144sm14198363pfx.184.2020.04.07.07.16.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Apr 2020 07:16:36 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [RFC PATCH v2] x86/arch_prctl: Add ARCH_SET_XCR0 to set XCR0 per-thread
Date:   Tue, 7 Apr 2020 07:16:34 -0700
Message-Id: <BEA3CCB8-5127-4E6A-9696-E293C00BFA82@amacapital.net>
References: <a5b07aa9-96ea-a9b5-13db-e5dcbd7760e6@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Keno Fischer <keno@juliacomputing.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andi Kleen <andi@firstfloor.org>,
        Kyle Huey <khuey@kylehuey.com>,
        Robert O'Callahan <robert@ocallahan.org>
In-Reply-To: <a5b07aa9-96ea-a9b5-13db-e5dcbd7760e6@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
X-Mailer: iPhone Mail (17E255)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 7, 2020, at 7:07 AM, Dave Hansen <dave.hansen@intel.com> wrote:
>=20
> =EF=BB=BFOn 4/7/20 5:21 AM, Peter Zijlstra wrote:
>> You had a fairly long changelog detailing what the patchd does; but I've
>> failed to find a single word on _WHY_ we want to do any of that.
>=20
> The goal in these record/replay systems is to be able to recreate thee
> exact same program state on two systems at two different times.  To make
> it reasonably fast, they try to minimize the number of snapshots they
> have to take and avoid things like single stepping.
>=20
> So, there are some windows where they just let the CPU run and don't
> bother with taking any snapshots of register state, for instance.  Let's
> say you read a word from shared memory, multiply it and shift it around
> some registers, then stick it back in shared memory.  Most of these
> things will just a record the snapshot at the memory read and assume
> that all the instructions in the middle execute deterministically.  That
> eliminates a ton of snapshots.
>=20
> But, what if an instruction in the middle isn't deterministic between
> two machines.  Let's say you record a trace on a a Broadwell system,
> then try to replay it on a Skylake, and one of the non-snapshotted
> instructions is xgetbv.  Skylake added MPX, so xgetbv will return
> different values.  Your replay diverges from what was "recorded", and
> life sucks.
>=20
> Same problem exists for CPUID, but that was hacked around in another set.
>=20
> I'm also trying to think of what kinds of things CPU companies add to
> their architectures that would break this stuff.  I can't recall ever
> having a discussion with folks at Intel where we're designing a CPU
> feature and we say, "Can't do that, it would break record/replay".  I
> suspect there are more of these landmines around and I bet that we're
> building more of them into CPUs every day.

TSX!

I think rr should give the raw KVM API at least a try.  It should be possibl=
e to fire up a vCPU in CPL3 in the correct state.  No guest kernel required.=
  I don=E2=80=99t know if there will be issues with the perf API, though.

If we actually do merge this XCR0 hack, I think the rule should be that it h=
as no effect on kernel behavior.  Signals, ptrace, etc reflect the normal XC=
R0, not the overridden value.=
