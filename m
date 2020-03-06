Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDA9C3F2D7
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 00:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 604B520801
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 00:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgCFA1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 19:27:54 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:53273 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726436AbgCFA1n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 19:27:43 -0500
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48YT3K1BwNz9sRY; Fri,  6 Mar 2020 11:27:40 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 9e27086292aa880921a0f2b8501e5189d5efcf03
In-Reply-To: <8ee3bdbbdfdfc64ca7001e90c43b2aee6f333578.1580470482.git.christophe.leroy@c-s.fr>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] powerpc/32: Warn and return ENOSYS on syscalls from kernel
Message-Id: <48YT3K1BwNz9sRY@ozlabs.org>
Date:   Fri,  6 Mar 2020 11:27:40 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-01-31 at 11:34:54 UTC, Christophe Leroy wrote:
> Since commit b86fb88855ea ("powerpc/32: implement fast entry for
> syscalls on non BOOKE") and commit 1a4b739bbb4f ("powerpc/32:
> implement fast entry for syscalls on BOOKE"), syscalls from
> kernel are unexpected and can have catastrophic consequences
> as it will destroy the kernel stack.
> 
> Test MSR_PR on syscall entry. In case syscall is from kernel,
> emit a warning and return ENOSYS error.
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9e27086292aa880921a0f2b8501e5189d5efcf03

cheers
