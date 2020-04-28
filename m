Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C4DC83002
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 02:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8B0C206D9
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 02:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="n7cru2yJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgD1CvH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 22:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726264AbgD1CvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 22:51:06 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B947C03C1A8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 19:51:06 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id di6so9701942qvb.10
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 19:51:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=5KphgjdoDcqAnhEFd5uD9BKBv6nlgqlIlOB0p/IZazo=;
        b=n7cru2yJnW/LXz0piawVuIdHMeHB6RJP1pJBIKRSyJZt3FBZZ+MBzurdvO1lvWoQ6C
         sQH37wnVX1cac8PZzuVO+Y4kp0sS1worSEmi5mCtBve9/kQlSwJYEcMcwzNZmjL1y/Wf
         Y+SRsuOOYvUUXxxF63btSYrMIgdvgmZlCrPlWi58M5kyYs7xBmPTKZ2XhMcetBO2vAcO
         hygfr6n0B4NyPk+vCWDU0+SVlm4/SPoQ9KTwLv00cnkwmvXfHQJ2jV2luUMH3a7wFNOh
         pqTYy3bKvQjnAY814T9S5ARTs/wd+Pfu/rRDFHUVkR9tDaP8my5mjeNs7nWCBzb/b6sx
         AJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=5KphgjdoDcqAnhEFd5uD9BKBv6nlgqlIlOB0p/IZazo=;
        b=gzd30WMju9Gb9HAG+zUA2u/9ce4Jo0ycgfrPIauPaj/NOdntyGovODO2LsohXjrWf8
         4znXWvip8vRBBILDwdc7WCitYnyYBQkqVOqyd1wUWXP05EvEY3vxoWXv5SW/v7LXKUCZ
         qTDc0ScraoXyZjb6PWzWP7lytxIH1q02nqin5k3TUqTA3gHHF2qdhEVMMbvewHOFCuke
         uGWUEaDVFSjNONjKyaS57PgOZDcwn6CZDeiHnNzWrzRD8i3BPvwnBWccPljolpFXvSus
         A4U4Dr3oyblvNcmjDTBKps2MivpjX0vplfbhxjFHh7mJ11y+189DlNCq8KkhlGqdghBa
         l3uw==
X-Gm-Message-State: AGi0PuavlY85ihIHHjgTL/aNvB9BEUmuF9fcE1h/BYDuEgedq3RgrGWl
        JGTli3vtMn4wEgBYTsue79QAvg==
X-Google-Smtp-Source: APiQypJ22EG5GBWRPOUnZNGW/UIF8ruce3Vuy9c+4yrrjfzI1WIfyoKKVqRjWUSp9iU8QUPEG6j/6w==
X-Received: by 2002:a0c:fa4c:: with SMTP id k12mr8533550qvo.85.1588042265518;
        Mon, 27 Apr 2020 19:51:05 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id o67sm12408717qkc.2.2020.04.27.19.51.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 19:51:04 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [mm/debug] fa6726c1e7: kernel_BUG_at_include/linux/mm.h
Date:   Mon, 27 Apr 2020 22:51:04 -0400
Message-Id: <D30E4C88-408A-438B-803B-D9F8F82D87A7@lca.pw>
References: <096a07fc-4525-feb6-5658-40bcffbd0a58@arm.com>
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
In-Reply-To: <096a07fc-4525-feb6-5658-40bcffbd0a58@arm.com>
To:     Anshuman Khandual <Anshuman.Khandual@arm.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 27, 2020, at 10:35 PM, Anshuman Khandual <Anshuman.Khandual@arm.com=
> wrote:
>=20
> Letting CONFIG_DEBUG_VM_PGTABLE enabled via CONFIG_EXPERT for unsupported
> platforms i.e without ARCH_HAS_DEBUG_VM_PGTABLE, was a conscious decision
> meant to expand it's adaptability and coverage without requiring any code
> (i.e Kconfig) change. The easier it is to enable the test on unsupported
> platforms right now, more folks are likely to try it out thus increasing
> it's probability to get fixed on those platforms. That is a valid enough
> reason to have CONFIG_EXPERT based enablement method, IMHO. Also even with=

> CONFIG_EXPERT set, CONFIG_DEBUG_VM_PGTABLE does not get enabled by default=

> automatically.

No, I am talking about PAE. There is a distinction between known broken that=
 nobody cares (like arm32) and in-progress/unknown status (like s390).

Also, it is not very nice to introduce regressions for robots when testing P=
AE because they always select CONFIG__EXPERT and CONFIG_DEBUG_VM.=
