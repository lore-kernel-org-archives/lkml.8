Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19DAC47254
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 02:51:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83EEC20735
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 02:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726268AbgEFCvE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 22:51:04 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:46451 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725900AbgEFCvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 22:51:04 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49H1Lb02frz9sSw; Wed,  6 May 2020 12:51:02 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: e4a884cc28fa3f5d8b81de46998ffe29b4ad169e
In-Reply-To: <1586249263-14048-2-git-send-email-ego@linux.vnet.ibm.com>
To:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Tyrel Datwyler <tyreld@linux.ibm.com>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/5] powerpc: Move idle_loop_prolog()/epilog() functions to header file
Message-Id: <49H1Lb02frz9sSw@ozlabs.org>
Date:   Wed,  6 May 2020 12:51:02 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-04-07 at 08:47:39 UTC, "Gautham R. Shenoy" wrote:
> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> Currently prior to entering an idle state on a Linux Guest, the
> pseries cpuidle driver implement an idle_loop_prolog() and
> idle_loop_epilog() functions which ensure that idle_purr is correctly
> computed, and the hypervisor is informed that the CPU cycles have been
> donated.
> 
> These prolog and epilog functions are also required in the default
> idle call, i.e pseries_lpar_idle(). Hence move these accessor
> functions to a common header file and call them from
> pseries_lpar_idle(). Since the existing header files such as
> asm/processor.h have enough clutter, create a new header file
> asm/idle.h. Finally rename idle_loop_prolog() and idle_loop_epilog()
> to pseries_idle_prolog() and pseries_idle_epilog() as they are only
> relavent for on pseries guests.
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e4a884cc28fa3f5d8b81de46998ffe29b4ad169e

cheers
