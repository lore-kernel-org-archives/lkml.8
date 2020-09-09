Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8512CC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:34:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47FE72087C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731168AbgIIQeq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731115AbgIIQ12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:27:28 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A2A3C06179E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 06:27:48 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BmjVw3Dyxz9sTS; Wed,  9 Sep 2020 23:27:36 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <c2d2b8dfb8dd677026b26dffc8d31070c38a6b89.1597388079.git.christophe.leroy@csgroup.eu>
References: <c2d2b8dfb8dd677026b26dffc8d31070c38a6b89.1597388079.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2] powerpc: Drop _nmask_and_or_msr()
Message-Id: <159965716741.808686.7320618342225439057.b4-ty@ellerman.id.au>
Date:   Wed,  9 Sep 2020 23:27:36 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 14 Aug 2020 06:54:49 +0000 (UTC), Christophe Leroy wrote:
> _nmask_and_or_msr() is only used at two places to set MSR_IP.
> 
> The SYNC is unnecessary as the users are not PowerPC 601.
> 
> Can be easily writen in C.
> 
> Do it, and drop _nmask_and_or_msr()

Applied to powerpc/next.

[1/1] powerpc: Drop _nmask_and_or_msr()
      https://git.kernel.org/powerpc/c/e53281bc21f061f96c9004f534bc3e807d70cb73

cheers
