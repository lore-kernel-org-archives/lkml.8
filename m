Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E48C35240
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 07:07:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D7AE2467B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 07:07:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="HLqlIR1y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725922AbgA1HHK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 02:07:10 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:40111 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgA1HHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 02:07:09 -0500
Received: by mail-qt1-f193.google.com with SMTP id v25so9501226qto.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 23:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=S88X9kdR1m457FxjowRY1cG95Ez9+awfEFeNZBzBj5c=;
        b=HLqlIR1y5B5/PsLNv/5LbKmkRD0LOfvs+3Uw5UFR8XmB3CZjk35sCKEGU7QUrB0DXx
         ro3J8jPDeF5kpX6rK5bqvFjVyygmmBxTqc+U9+GqB6XkJi7vq8NcYRCERMAEMhDVXUCh
         582xGO5f2XyXtpU5uRDgb4Bc99IiX0ZDjMomKpIHbbLRjRqqVt+qwAOuBjm+lP5W2SJ+
         vCTV/46saWz+DSrfHpwXbiE5Bw1kdqVnfBTP+u5/moAx6Z3f1YyRVCqjbBB5F8ReCJuz
         rLNiGsK+2jKaexspyfqYWjO7Gf6gMQ5SLYW8N1k3kz0BSFSsLmhau83aEBKEGep3vOtX
         Tp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=S88X9kdR1m457FxjowRY1cG95Ez9+awfEFeNZBzBj5c=;
        b=Ok/j0dyCyBVrQPr/HG1KqytPoIk2LUpkg9KNRTUCzqPin0u6M7sOumWVhy78QzzBB1
         SqK4DUftSeRKQOzBZ/hrko75Kove3UBiaytdH95FAm18j5/Z5s+Gz8J9gMe6LIkGaeQ0
         9/TWTEcgCNA3VGi317vbgU4CziI5Lff3cdiDtuE0YeplQlJApKBRai+7WoKv81GHx5Fe
         cBziYLyG+5IweVtKdggJUWNNXjRTXmjDTKC0CqDT5VEKm99lXdkp8gD9p//iHGDAx9xo
         BoidWqLxRtMhuxnlEb4XfBZf39zA5Xq+4X2RhQ/b+X4nBSMiwsUhWybLAV1XUx17VVPD
         WP3A==
X-Gm-Message-State: APjAAAWrKOJQsMSs73kar8I4JGiad01TT+f9Wjyg+e+k2hzGyYBSS9z3
        AksvTSfFlwLBX8o5+WJ4EmT0cQ==
X-Google-Smtp-Source: APXvYqwjL/tF2WR3QmLuG8LOj7E2zvaXqRI6bLl13yd8OQ3r0ofRKuuNBE3aHo9M+hTpUmSXvKe5+w==
X-Received: by 2002:aed:3fce:: with SMTP id w14mr20841113qth.0.1580195228489;
        Mon, 27 Jan 2020 23:07:08 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id q130sm11341027qka.114.2020.01.27.23.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2020 23:07:07 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH V12] mm/debug: Add tests validating architecture page table helpers
Date:   Tue, 28 Jan 2020 02:07:07 -0500
Message-Id: <C0CC7DB9-5B58-40D3-BE7A-D15B3738C971@lca.pw>
References: <ba5a836a-b594-f846-1734-71dcd5d089e6@arm.com>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
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
        Ingo Molnar <mingo@kernel.org>,
        linux-snps-arc@lists.infradead.org, linux-mips@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <ba5a836a-b594-f846-1734-71dcd5d089e6@arm.com>
To:     Anshuman Khandual <Anshuman.Khandual@arm.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 28, 2020, at 2:03 AM, Anshuman Khandual <Anshuman.Khandual@arm.com>=
 wrote:
>=20
> 'allyesconfig' makes 'DEBUG_VM =3D y' which in turn will enable 'DEBUG_VM_=
PGTABLE =3D y'
> on platforms that subscribe ARCH_HAS_DEBUG_VM_PGTABLE.

Isn=E2=80=99t that only for compiling testing? Who is booting such a beast a=
nd make sure everything working as expected?=
