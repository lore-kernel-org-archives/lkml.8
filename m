Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5324BC433EC
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:25:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3884A2065F
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 13:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgGXNY7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 09:24:59 -0400
Received: from ozlabs.org ([203.11.71.1]:51383 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726764AbgGXNY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 09:24:58 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BCqgV4J65z9sV1; Fri, 24 Jul 2020 23:24:52 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Ingo Molnar <mingo@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Leonardo Bras <leobras.c@gmail.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        kvm-ppc@vger.kernel.org
In-Reply-To: <20200707004812.190765-1-leobras.c@gmail.com>
References: <20200707004812.190765-1-leobras.c@gmail.com>
Subject: Re: [PATCH 1/1] KVM/PPC: Fix typo on H_DISABLE_AND_GET hcall
Message-Id: <159559697292.1657499.11332603391566688077.b4-ty@ellerman.id.au>
Date:   Fri, 24 Jul 2020 23:24:52 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Jul 2020 21:48:12 -0300, Leonardo Bras wrote:
> On PAPR+ the hcall() on 0x1B0 is called H_DISABLE_AND_GET, but got
> defined as H_DISABLE_AND_GETC instead.
> 
> This define was introduced with a typo in commit <b13a96cfb055>
> ("[PATCH] powerpc: Extends HCALL interface for InfiniBand usage"), and was
> later used without having the typo noticed.

Applied to powerpc/next.

[1/1] KVM: PPC: Fix typo on H_DISABLE_AND_GET hcall
      https://git.kernel.org/powerpc/c/0f10228c6ff6af36cbb31af35b01f76cdb0b3fc1

cheers
