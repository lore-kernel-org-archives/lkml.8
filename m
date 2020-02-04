Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5480C3524D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 12:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850242166E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 12:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbgBDMBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 07:01:35 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:33345 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbgBDMBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 07:01:34 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48BjwD2PG2zB3ws; Tue,  4 Feb 2020 23:01:31 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 43e76cd368fbb67e767da5363ffeaa3989993c8c
In-Reply-To: <20200118170335.21440-1-alex@ghiti.fr>
To:     Alexandre Ghiti <alex@ghiti.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Alexei Starovoitov <ast@kernel.org>,
        linux-next@vger.kernel.org, Zong Li <zong.li@sifive.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: Re: [PATCH v2] powerpc: Do not consider weak unresolved symbol relocations as bad
Message-Id: <48BjwD2PG2zB3ws@ozlabs.org>
Date:   Tue,  4 Feb 2020 23:01:31 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-01-18 at 17:03:35 UTC, Alexandre Ghiti wrote:
> Commit 8580ac9404f6 ("bpf: Process in-kernel BTF") introduced two weak
> symbols that may be unresolved at link time which result in an absolute
> relocation to 0. relocs_check.sh emits the following warning:
> 
> "WARNING: 2 bad relocations
> c000000001a41478 R_PPC64_ADDR64    _binary__btf_vmlinux_bin_start
> c000000001a41480 R_PPC64_ADDR64    _binary__btf_vmlinux_bin_end"
> 
> whereas those relocations are legitimate even for a relocatable kernel
> compiled with -pie option.
> 
> relocs_check.sh already excluded some weak unresolved symbols explicitly:
> remove those hardcoded symbols and add some logic that parses the symbols
> using nm, retrieves all the weak unresolved symbols and excludes those from
> the list of the potential bad relocations.
> 
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/43e76cd368fbb67e767da5363ffeaa3989993c8c

cheers
