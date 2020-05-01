Return-Path: <SRS0=nvtT=6P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MIME_QP_LONG_LINE,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89D8EC4724C
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 01:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 630862073E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 May 2020 01:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="JWz/HNe9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgEABUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 21:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727920AbgEABUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 21:20:43 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34725C035495
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 18:20:43 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id p25so890177pfn.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 18:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=+ob/X0QXFpxvmr3EWB8fQOJcF1u/V0cTtMVpIs2p45o=;
        b=JWz/HNe9QVe3KpMe6Fx9Bq2GqkBQAoBVa8iqrJqTOXH9HIZzwUCDZU8rE102fg1z7o
         0kalZERJUV6gw/xA8MPaoOfaHwYAbAANimUog9Hm676+TIjcO+dBY89FjUJ4wcMs975/
         SKm9CbmjdES6fxlHT0h2/dzk9hxGqC1/y06ZPZMjk0uNY0N5EoJ6K6sn0qt6pUf2eCuJ
         jgwqP5f32gdTlY0FX3Gs1FAz+ZOhcRu86YggMsjZ1RdG5yNctLB6+vmapn45gRamTYGp
         fRbPwUxOjDOzHfI5AUlpxdC9aNAaFqoSCkIZ/PKmcj6qIrFM96yFQKqxFpwDUaMHMKf7
         yvLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=+ob/X0QXFpxvmr3EWB8fQOJcF1u/V0cTtMVpIs2p45o=;
        b=ZDYnR6gW4jmsNoZ5cjDmt7KT4l2W2MdNE2PQmgdpywoL9qZhtBNw482TlMCbbhoQEi
         y47xgqUxsZ8NTIbpvpUiKBapTwEJJ04gTSSF9vIhkD2bBbLPfqGcvd7qBJ8MztKmMPHX
         zaEf8/fzAJT6sxRoZ0Lv6qBcWT5+Qb1p/WHq3HZLkyYKnktp0DraGAay5oWVKHlPMKi2
         UXRoc9ndZdQBE5nUqEjgUAfqMaPQRrpWWLlSH7uV/vRbdpkIu+TcKiBqPl38jw89wqTA
         GtV0r9Id0GhfD57edxn7n08TMpO8XU1sad3IFob+wtdTNKLLc+fi/CDLfeFez+ZOB/D1
         4hYQ==
X-Gm-Message-State: AGi0PuaEfl9dsf4KmnL053sC7ys/LbnTgQxx48kZFuJ84s1fnlykHz5Z
        8Au8M9qkqc1dNFbXhq3asqH0OA==
X-Google-Smtp-Source: APiQypJVdLbyXVtAGU4O61QE9USzd9aHvhWz43HYF+zei+FPbOx+DYcTAVOeS9XOsayG60rqSExmJg==
X-Received: by 2002:aa7:819a:: with SMTP id g26mr1723584pfi.193.1588296042609;
        Thu, 30 Apr 2020 18:20:42 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:d495:581b:d692:e814? ([2601:646:c200:1ef2:d495:581b:d692:e814])
        by smtp.gmail.com with ESMTPSA id h31sm784779pjb.33.2020.04.30.18.20.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Apr 2020 18:20:41 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 0/2] Replace and improve "mcsafe" with copy_safe()
Date:   Thu, 30 Apr 2020 18:20:39 -0700
Message-Id: <D47C71D3-349B-49C4-9945-330C9F42A3E0@amacapital.net>
References: <CAHk-=wh1SPyuGkTkQESsacwKTpjWd=_-KwoCK5o=SuC3yMdf7A@mail.gmail.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        stable <stable@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Erwin Tsaur <erwin.tsaur@intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-nvdimm <linux-nvdimm@lists.01.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <CAHk-=wh1SPyuGkTkQESsacwKTpjWd=_-KwoCK5o=SuC3yMdf7A@mail.gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: iPhone Mail (17E262)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 30, 2020, at 5:25 PM, Linus Torvalds <torvalds@linux-foundation.org=
> wrote:
>=20
>=20
> It wasn't clear how "copy_to_mc()" could ever fault. Poisoning
> after-the-fact? Why would that be preferable to just mapping a dummy
> page?

If the kernel gets an async memory error and maps a dummy page, then subsequ=
ent reads will subsequently succeed and return garbage when they should fail=
.  If x86 had write-only pages, we could map a dummy write-only page. But we=
 don=E2=80=99t, so I think we=E2=80=99re stuck.

As for naming the kind of memory we=E2=80=99re taking about, ISTM there are t=
wo classes: DAX and monstrous memory-mapped non-persistent cache devices.  B=
oth could be Optane, I suppose.

But I also think it=E2=80=99s legitimate to use these accessors to increase t=
he chance of surviving a failure of normal memory. If a normal page happens t=
o be page cache when it fails and if page cache access use these fancy acces=
sors, then we might actually survive a failure.

We could be ambitious: declare that all page cache and all get_user_page=E2=80=
=99d memory should use the new accessors.  I doubt we=E2=80=99ll ever really=
 succeed due to magical things like rseq and anything that thinks that users=
 can set up their own memory as a kernel-accessed ring buffer, but I suppose=
 we could try.

