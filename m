Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2004C83002
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 02:05:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9818206E2
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 02:05:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="MSN75S3V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgD1CFJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 22:05:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726233AbgD1CFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 22:05:09 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F55C03C1A8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 19:05:09 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id 20so20314655qkl.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 19:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=5LYd/Zi3hJUwLPdN4usWASbwvT7potspOtjbDTRKL+A=;
        b=MSN75S3VoqV/AR+RnBUNfVVT/zqsH02MTG71nbJsBkVQouwReIRA7J5EWyzTyPCure
         lHgsfwgzJe6IL9gQY5InIzFAlvKctXKwIyutxCTvGPPqxSfyvAQ0SDRj/qyPJGQY9tRS
         n39366bQHT0GJnODcrMd/vzNQCyqKkfoXA74ydo6ucd9Airjtxfm3k5EU5mTGHueXZCW
         OJUEKu9Uir40jcdVZGTU7MtswJFIWLrCzMlBZa9Zc0D+tujVPvzEPVKpT/I4qPPTGQI7
         vMqhShC+6JafppW/8PqxDGgGKHAoD2SnhGAByhrdYq9F+IHOzuYg9octfCBEbEasUbs5
         RFWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=5LYd/Zi3hJUwLPdN4usWASbwvT7potspOtjbDTRKL+A=;
        b=hZLY1mkm2rDVohdbxdxpwQhEs+08f8XQfMxC+r9zn8UpzCdNDg/dQ8wYWN9Z7qlX7A
         c4/1nTdI6KFrL9PD6zxp1lEnEkUko7BwhIRoU554pdOGxzefbbJrljpcZ1sYUPvj3t59
         Gi0RKaqUew+iEb5trCYUH1IbQ+Q/plwnfFqhgMCd9pJW7Xrjp+l7Z79PYb6QQq6l89GU
         4CBOpK+meB6aO/Uc76QoufynUkgoOfrL8bDNMMZvAsiUL3gl1N1n/edZusUl+gzHrs2A
         ep49dgwOR02w5bPhwWicRC2sCATx2Xs59I9urjdW7b2JGMhNKOQ7Uh37iT5b7A5qYIph
         tWJA==
X-Gm-Message-State: AGi0PubPTOL0TeSrU+h1ThwcfhT0pi6rAA3XYenVb8O1BA2FL67fD8yW
        6MlmHXL3vC+X+9gNx1QcYXCXYA==
X-Google-Smtp-Source: APiQypLvvDPhvplvRIWxHEO72+RER7MJ5455VH9L3uYoQC6Zhtx2gpipkKWkiJHlMXJSqIAkSQu49g==
X-Received: by 2002:a37:278c:: with SMTP id n134mr26071276qkn.348.1588039508427;
        Mon, 27 Apr 2020 19:05:08 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id z90sm10396578qtd.75.2020.04.27.19.05.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 19:05:07 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [mm/debug] fa6726c1e7: kernel_BUG_at_include/linux/mm.h
Date:   Mon, 27 Apr 2020 22:05:06 -0400
Message-Id: <31CD915D-2E14-4897-AF62-82B6C5FD567A@lca.pw>
References: <51dcbcbf-6020-6672-05b0-5bb10c6292b5@arm.com>
Cc:     kernel test robot <lkp@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
In-Reply-To: <51dcbcbf-6020-6672-05b0-5bb10c6292b5@arm.com>
To:     Anshuman Khandual <Anshuman.Khandual@arm.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 27, 2020, at 9:49 PM, Anshuman Khandual <Anshuman.Khandual@arm.com>=
 wrote:
>=20
> This is an unsupported (enabled via CONFIG_EXPERT) X86 platform (CONFIG_X8=
6_PAE)
> and is known to fail. The latest (V17) patch had moved the test invocation=
 into
> a late_initcall() per Linus thus pushing down any possible failures (like t=
his)
> after early boot. Please ignore this report.
>=20
> Apart from this X86_PAE based config, no other platform failures have repo=
rted
> so far. Assuming that this test robot does have a good platform coverage, t=
he
> CONFIG_EXPERT method of enabling CONFIG_DEBUG_VM_PGTABLE should help in ge=
tting
> more platform coverage for this test.

This sounds really sloppy. Why can=E2=80=99t we make it impossible to select=
 this combination if nobody is willing to fix it?=
