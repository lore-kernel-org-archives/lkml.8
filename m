Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E52C33CB3
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 12:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79E6824688
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 12:30:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Rbz1P8X1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgA1MaQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 07:30:16 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:45642 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726034AbgA1MaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 07:30:16 -0500
Received: by mail-qk1-f194.google.com with SMTP id x1so13068634qkl.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 04:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:date:subject:message-id
         :cc:to;
        bh=8GwDVchQDE0RRDd6Z1x4gzFv6pXtLF378PeW6dBbf+w=;
        b=Rbz1P8X1bfckF8p5+fQPfltDNpYpc5sp5fHqq9u1T5/uhK6rRW78SfwJEw2v28znfV
         wPfmUeOnrz7CBbeIgQixtLq2TPQmdgtO1vVi6z9urV65HN1x4ZK0nWUORD8codoMVkS8
         rPApC12IYdkgP3grHEjFihd/Jh4OgeLy2QqFihiQOoNERJPGlH4ggjAY8evnQXoqrTaN
         KqoP6/pkU7BjH0xE18gbhqENWpt3g5gz/4WQxHhB9FaTgVokGRGk0m2PJgFNbLse/V1Q
         DUm5C86KbFXNmme7COzfebOm4aubFGvujqheNY2AxjxXyz7y4nv8h1Ou8ChS1lBEdbUk
         SJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version:date
         :subject:message-id:cc:to;
        bh=8GwDVchQDE0RRDd6Z1x4gzFv6pXtLF378PeW6dBbf+w=;
        b=Hwb8HSjAMhK+ZdZn8FzSL400dvAIUmwCqXU2Xoy8Cbrnw+T/dBXmQTnagBEJcoeT81
         us9ETCxWX89Ubt5dd8D4hmYbkPIapJZFEozD7gcRYNbJKM0N2O2vGUCDvDD2ruGQmlVj
         i2edqvmZCOEjjhDIaDS5aARapPuVwQW8MRpXiZ3x2Bh2BPz5DbtI/ZLUlefj+fjat2NL
         uTracoEvCwjfYEXTZMDe7twdG6gmlFn4Yu8xrXy69TBrx8blXal56MAJ6zJ10r7m3BqU
         VbzKlQlN2w4JGvGaSiEfAX2ed2M5q+ZLeKciAHxenTdc+8mYSdTYKWBHCkC2k7ITPIhq
         vtCA==
X-Gm-Message-State: APjAAAWKHMkwHdj8RChpJEB131t0syisUHbuFu0ygIKoHopA0F/rpIAB
        XAMMB3hvu4iryf4MyF3NGc/jqQ==
X-Google-Smtp-Source: APXvYqw4NHHH616JlS/IrWEyv4wSaDB7EoG4ap5GXk6Z++ZZIlsdVUcHztpJPWJHmyylARL29R+hpQ==
X-Received: by 2002:a37:9ce:: with SMTP id 197mr22314564qkj.194.1580214614838;
        Tue, 28 Jan 2020 04:30:14 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 69sm11862264qkk.106.2020.01.28.04.30.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Jan 2020 04:30:14 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Date:   Tue, 28 Jan 2020 07:30:13 -0500
Subject: Re: [PATCH V12] mm/debug: Add tests validating architecture page table helpers
Message-Id: <0C97A195-CBF2-43EF-88A0-7683BB9EF892@lca.pw>
Cc:     Anshuman Khandual <Anshuman.Khandual@arm.com>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Steven Price <Steven.Price@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Matthew Wilcox <willy@infradead.org>,
        Sri Krishna chowdary <schowdary@nvidia.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Mackerras <paulus@samba.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Vineet Gupta <vgupta@synopsys.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Ingo Molnar <mingo@kernel.org>,
        linux-snps-arc@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
To:     Mike Rapoport <rppt@linux.ibm.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 28, 2020, at 7:10 AM, Mike Rapoport <rppt@linux.ibm.com> wrote:
>=20
> Aren't x86 and arm64 not decent enough?
> Even if this test could be used to detect regressions only on these two
> platforms, the test is valuable.

The question is does it detect regressions good enough? Where is the list of=
 past bugs that it had found?

It is an usual deal for unproven debugging features remain out of tree first=
 and keep gathering unique bugs it found and then justify for a mainline inc=
lusion with enough data.=
