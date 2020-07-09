Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A114EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 04:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73320206F6
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 04:09:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="iCc6UqOp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726305AbgGIEJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 00:09:26 -0400
Received: from ozlabs.org ([203.11.71.1]:56311 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726064AbgGIEJZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 00:09:25 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
        id 4B2N3R3m99z9sRR; Thu,  9 Jul 2020 14:09:23 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
        t=1594267763; bh=x3yYAYWDQc/AdH5qio9yXXUu0zr/fL7TKBtMwdncb/c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iCc6UqOpjAdIOX2JTPrizZlG7+t7aHyyI5SgduWOnArh6gkN/ti74h+PyG40pemmv
         gdNifGpSclbkJE3kf3Lu5m8/zyEfs6Vd1EO5TJrV94DD3UPMzEuBbezVcufHTvAbRy
         aUHB9XpOli1FDFOxjDPKHB4s0vr2W51vRHYpX4GITYl9QhTcgNM6prVSqp7tHHkPKP
         JzvfhQ+RD4mlx3P8YW0jqC5kE7wLn937/qthldPGhURUf/ZzuyaGbGFSIitV9kln2m
         DSjAYumx/SA6f38vH3qntEn988EhWL23FfJqigij+Bn7uASbQ9FKCdlBKiJl6CKUue
         h5Cd7+pE+jYeQ==
Date:   Thu, 9 Jul 2020 14:09:18 +1000
From:   Paul Mackerras <paulus@ozlabs.org>
To:     Leonardo Bras <leobras.c@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 1/1] KVM/PPC: Fix typo on H_DISABLE_AND_GET hcall
Message-ID: <20200709040918.GA2822576@thinks.paulus.ozlabs.org>
References: <20200707004812.190765-1-leobras.c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707004812.190765-1-leobras.c@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 09:48:12PM -0300, Leonardo Bras wrote:
> On PAPR+ the hcall() on 0x1B0 is called H_DISABLE_AND_GET, but got
> defined as H_DISABLE_AND_GETC instead.
> 
> This define was introduced with a typo in commit <b13a96cfb055>
> ("[PATCH] powerpc: Extends HCALL interface for InfiniBand usage"), and was
> later used without having the typo noticed.
> 
> Signed-off-by: Leonardo Bras <leobras.c@gmail.com>

Acked-by: Paul Mackerras <paulus@ozlabs.org>

Since this hypercall is not implemented in KVM nor used by KVM guests,
I'll leave this one for Michael to pick up.

Paul.
