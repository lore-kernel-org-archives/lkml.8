Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0CAC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 04:25:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEE6720684
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 04:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="ipgyBIiz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbgGVEZ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 00:25:27 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:33067 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725843AbgGVEZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 00:25:27 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BBMnt5ZW1z9sPB;
        Wed, 22 Jul 2020 14:25:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1595391924;
        bh=qAm3Ccutxcy1GjzClSJFUEMJeVzNgrnTzX0RTNep1/A=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ipgyBIiz2TASWCM4uo7asEhhIi+fSNmSYJ948zzcfbHg//f6/OvKe3lTWHL4vAqB7
         eU208+WBeoL/Rq6bM3v6p/srh985sEwTM9j+7HTV2BI7a2ZYRgzcYwWPDnFcbrf8yM
         AHbofXD/M16u4tiCm+BMYJ4JGsRHJA2b5HYr54JeoLaucp3063seyP54aHYPLna/rX
         Oi6W24NzBNZJFW9daEF7bJbs3Kpb7gojdK0bfUvEWCqsYsN2AxeEFM9N3g6OYc/tk+
         Cri/cBoXAFMAjyVNIUBmM1SG9T6OTEbAxzlNOXhYNxIGP4rR+XyZJQWduu5U7rs2nw
         8aMRDscSBsngA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Hari Bathini <hbathini@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel test robot <lkp@intel.com>, Pingfan Liu <piliu@redhat.com>,
        Kexec-ml <kexec@lists.infradead.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Petr Tesarik <ptesarik@suse.cz>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Sourabh Jain <sourabhjain@linux.ibm.com>,
        lkml <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Dave Young <dyoung@redhat.com>, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v4 07/12] ppc64/kexec_file: add support to relocate purgatory
In-Reply-To: <159524956457.20855.12480643681198700190.stgit@hbathini.in.ibm.com>
References: <159524918900.20855.17709718993097359220.stgit@hbathini.in.ibm.com> <159524956457.20855.12480643681198700190.stgit@hbathini.in.ibm.com>
Date:   Wed, 22 Jul 2020 14:25:19 +1000
Message-ID: <871rl4rxao.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hari Bathini <hbathini@linux.ibm.com> writes:
> Right now purgatory implementation is only minimal. But if purgatory
> code is to be enhanced to copy memory to the backup region and verify
> sha256 digest, relocations may have to be applied to the purgatory.
> So, add support to relocate purgatory in kexec_file_load system call
> by setting up TOC pointer and applying RELA relocations as needed.
>
> Reported-by: kernel test robot <lkp@intel.com>
> [lkp: In v1, 'struct mem_sym' was declared in parameter list]
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> ---
>
> * Michael, can you share your opinion on the below:
>     - https://lore.kernel.org/patchwork/patch/1272027/
>     - My intention in cover note.

It seems like a lot of complexity for little benefit.

AFAICS your final purgatory_64.c is only 36 lines, and all it does is a
single (open coded) memcpy().

It seems like we could write that in not many more lines of assembler
and avoid all this code.

What am I missing?

cheers
