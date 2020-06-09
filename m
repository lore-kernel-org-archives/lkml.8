Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DB8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 05:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 069EE20810
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 05:28:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgFIF2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 01:28:44 -0400
Received: from ozlabs.org ([203.11.71.1]:53815 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbgFIF2k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 01:28:40 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49gzDl1xxcz9sT6; Tue,  9 Jun 2020 15:28:39 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <7f24b5961a6839ff01df792816807f74ff236bf6.1582567319.git.christophe.leroy@c-s.fr>
References: <7f24b5961a6839ff01df792816807f74ff236bf6.1582567319.git.christophe.leroy@c-s.fr>
Subject: Re: [PATCH] powerpc/kprobes: Use probe_address() to read instructions
Message-Id: <159168034650.1381411.840854749818290996.b4-ty@ellerman.id.au>
Date:   Tue,  9 Jun 2020 15:28:38 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2020 18:02:10 +0000 (UTC), Christophe Leroy wrote:
> In order to avoid Oopses, use probe_address() to read the
> instruction at the address where the trap happened.

Applied to powerpc/next.

[1/1] powerpc/kprobes: Use probe_address() to read instructions
      https://git.kernel.org/powerpc/c/9ed5df69b79a22b40b20bc2132ba2495708b19c4

cheers
