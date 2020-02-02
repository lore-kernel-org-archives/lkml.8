Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17FAEC3F68F
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 11:26:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC9D2080D
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 11:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ktqi1Si5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgBBL0d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 06:26:33 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39785 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726205AbgBBL0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 06:26:32 -0500
Received: by mail-qk1-f195.google.com with SMTP id w15so11414601qkf.6
        for <linux-kernel@vger.kernel.org>; Sun, 02 Feb 2020 03:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=haUAAZdbmdU3COyJ/sqnDbNti6tUXhiH5WpEb5CUu3o=;
        b=ktqi1Si5IANgowqGSuWt2goxaefj9MArH9hBL4drDxYpQy5gO9eIMpaj4x1g9qz0Ft
         wJg8PZziG/0FMCaYMFvU0R1ed/sRIgt60RVYo/fiPoIuWPHtw5CoKADSbrdPinp59eNX
         GqmqoNXOemL5q0rosXYIx2UJ1orNdlYcFK73Ygg0a/RE2arXPeSnjr+QO/TuQNX54JbP
         bi9ii20//c0h4YooeibM3yZGm2vZjIxTdT2q1agyMmadm90FFuyO+OFJ2urFPdZeXwtw
         AgKWNyLv5Arxyw8debfI90Lt1gaaDIBA8bYeatlKiESPBREuLesS3poug3ybj8+iH21/
         Psqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=haUAAZdbmdU3COyJ/sqnDbNti6tUXhiH5WpEb5CUu3o=;
        b=qoWomqjCR/YtTZxwoHMZ0LDQlmP0NzCfUT0L0ZoRT81gtkyfRNYXsIuZEIjUwI/sFF
         DHOe7r6YxVhj/WlsQlqFW6BWguSmLIQFOjNgxB4LA2mUPD0o/I3kHmXkP8bnls077mbM
         xWUC1vJdUnSI0RpSwbb098UTlJ3q/k9bPSRAP4wD3JM3ForlgPr9hi7Y0X9GnJu8tUQt
         UjxcWdvbkCNmQ8Bhy+37zd3QxSPUlAXgzQiTeQB7xVOt5KtLdigEA+NuYqKZmxJFjveh
         DK1U5z7CkY+KKCjM7gFNkxRGApthMKbjxYjOj+I2sAR1P+unpf0CRvWtPiI/cWIa5Qv1
         Sm6Q==
X-Gm-Message-State: APjAAAW4Pk01blNJcIcUyYedpAk3jPrRQsL7qpf4WQOgncIT2XxUhCBG
        12xsP2yzJnJZf7UZHCTkH6A9LA==
X-Google-Smtp-Source: APXvYqz2LMXXgwCpUXH7EnnO/Ck2Cj8Gc2SWzAj6pxocjOsHmdsAhT1kwXiGUD+liMIX2mq/rCkMKw==
X-Received: by 2002:a05:620a:218d:: with SMTP id g13mr19497581qka.286.1580642791619;
        Sun, 02 Feb 2020 03:26:31 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id s1sm7274932qkm.84.2020.02.02.03.26.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Feb 2020 03:26:30 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH V12] mm/debug: Add tests validating architecture page table helpers
Date:   Sun, 2 Feb 2020 06:26:29 -0500
Message-Id: <2C4ADFAE-7BB4-42B7-8F54-F036EA7A4316@lca.pw>
References: <473d8198-3ac4-af3b-e2ec-c0698a3565d3@c-s.fr>
Cc:     Anshuman Khandual <Anshuman.Khandual@arm.com>, linux-mm@kvack.org,
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
        Ingo Molnar <mingo@kernel.org>,
        linux-snps-arc@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        kasan-dev <kasan-dev@googlegroups.com>
In-Reply-To: <473d8198-3ac4-af3b-e2ec-c0698a3565d3@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 30, 2020, at 9:13 AM, Christophe Leroy <christophe.leroy@c-s.fr> wr=
ote:
>=20
> config DEBUG_VM_PGTABLE
>    bool "Debug arch page table for semantics compliance" if ARCH_HAS_DEBUG=
_VM_PGTABLE || EXPERT
>    depends on MMU
>    default 'n' if !ARCH_HAS_DEBUG_VM_PGTABLE
>    default 'y' if DEBUG_VM

Does it really necessary to potentially force all bots to run this? Syzbot, k=
ernel test robot etc? Does it ever pay off for all their machine times there=
?=
