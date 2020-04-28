Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AE83C83004
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:41:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED43A2053B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 08:41:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="ZV6+AjD5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726924AbgD1IlS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 04:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726641AbgD1IlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 04:41:13 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7911EC03C1A9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 01:41:13 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id z90so16603372qtd.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Apr 2020 01:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=aamdPM+52xGHFB+afysrMVCWr42QJeoGJErWQQvvA6o=;
        b=ZV6+AjD5FGcO2evi1mAsjYsXpQBvOVd+F/dm/KHJMa2Y/Diq5eNlcnyJJS+bOjMi/H
         pifVd52FeOUkRrT6kOj+PkBW1olJLKHhmMGr+5lopzgAqqQiDWigfUF8/CMWCB0t93nj
         gye0WbeWiSheWGKGmfyxjfe5J+Tsj357UU+L/NTgO+x5xcnUJ11v+0zO31WXpH2nt7r0
         Mtzk1GRkcZrEnEhe2Ayd9GzJ4Nr7g4kKmT5zjWWLRzVWFEcgfBMZxVlPlA/xdw7ZsPSt
         T2yVhOtJVh1u/zEPbWBTVTJMH47QaiFGFxqf/yGOzkAre0zboEZWkRqHZtOvTp0O9bWh
         5UMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=aamdPM+52xGHFB+afysrMVCWr42QJeoGJErWQQvvA6o=;
        b=BRMbmLAsbFXmhW2+C+ixUs6P0zX/+JttNC5AhSlG9EiXDVT5yLKZGypvvFkvKL4wil
         b7S9TqzAEHt0PtJ3V9Ty6peMkR4ISJI+sP2asr5K7EEckIVRPucv7Asp5Lirqg0Pm5VI
         AL2sEg2gNmINuWo0YUVCfHbs+tDSPUG0QNa4Y5iDyTT5qpTe7FAFkdLl1oEy3N8i8X9e
         InkjiYNvydGzhw+OVEAMSAa/uiPOML4dy50sTb1wjtgxiiUmJWuWh0S/XDQY3RkPQlQK
         nmkGQvvThQho63r/uzqPmJI7Ukq03yQVI0dZrUR4I+xDXBIaGWpNk710yqhdiQ27ppSv
         eBGQ==
X-Gm-Message-State: AGi0Pub6ReuDiYyJ5uTp4rWSugJrZb1NhpNf1hIuLOVw3wzC8gU/9XjZ
        f+RQkAEraniMU2c+x2UXz/ywSg==
X-Google-Smtp-Source: APiQypJtOlgQ6hz4c5ADcQto0JzA4zKLCZB3kSPLouYrCYCv9NXQwRqE3jBvID2u83mliS75Qf9aQg==
X-Received: by 2002:aed:2a43:: with SMTP id k3mr27529682qtf.208.1588063272584;
        Tue, 28 Apr 2020 01:41:12 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id v27sm13756590qtb.35.2020.04.28.01.41.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Apr 2020 01:41:11 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [mm/debug] fa6726c1e7: kernel_BUG_at_include/linux/mm.h
Date:   Tue, 28 Apr 2020 04:41:11 -0400
Message-Id: <813D7CD3-F31C-4056-92DF-D462633E9D69@lca.pw>
References: <9e9091b9-6918-d0af-dd92-3bdc0e29a4d5@arm.com>
Cc:     Christophe Leroy <christophe.leroy@c-s.fr>,
        kernel test robot <lkp@intel.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
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
In-Reply-To: <9e9091b9-6918-d0af-dd92-3bdc0e29a4d5@arm.com>
To:     Anshuman Khandual <Anshuman.Khandual@arm.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 28, 2020, at 1:54 AM, Anshuman Khandual <Anshuman.Khandual@arm.com>=
 wrote:
>=20
> That is true. There is a slight change in the rules, making it explicit ye=
s
> only when both ARCH_HAS_DEBUG_VM_PGTABLE and DEBUG_VM are enabled.
>=20
> +config DEBUG_VM_PGTABLE
> +    bool "Debug arch page table for semantics compliance"
> +    depends on MMU
> +    depends on !IA64 && !ARM
> +    depends on ARCH_HAS_DEBUG_VM_PGTABLE || EXPERT
> +    default y if ARCH_HAS_DEBUG_VM_PGTABLE && DEBUG_VM
> +    help
>=20
> The default is really irrelevant as the config option can be set explicitl=
y.

That could also explain. Since not long time ago, it was only =E2=80=9Cdefau=
lt y if DEBUG_VM=E2=80=9D, that caused the robot saved a .config with DEBUG_=
VM_PGTABLE=3Dy by default.

Even though you changed the rule recently, it has no effect as the robot cou=
ld =E2=80=9Cmake oldconfig=E2=80=9D from the saved config for each linux-nex=
t tree execution and the breakage will go on.=
