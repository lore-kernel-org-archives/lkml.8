Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F040AC433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D47F92070B
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 07:26:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgG0H0v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 03:26:51 -0400
Received: from ozlabs.org ([203.11.71.1]:51567 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726116AbgG0H0t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 03:26:49 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BFWZt61TFz9sTR; Mon, 27 Jul 2020 17:26:46 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <610d6b1a60ad0bedef865a90153c1110cfaa507e.1593429426.git.christophe.leroy@csgroup.eu>
References: <610d6b1a60ad0bedef865a90153c1110cfaa507e.1593429426.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2 1/2] powerpc/ptdump: Refactor update of st->last_pa
Message-Id: <159583478842.602200.992568816713944364.b4-ty@ellerman.id.au>
Date:   Mon, 27 Jul 2020 17:26:46 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jun 2020 11:17:18 +0000 (UTC), Christophe Leroy wrote:
> st->last_pa is always updated in note_page() so it can
> be done outside the if/elseif/else block.

Applied to powerpc/next.

[1/2] powerpc/ptdump: Refactor update of st->last_pa
      https://git.kernel.org/powerpc/c/846feeace51bce13f5c645d5bf162455b89841fd
[2/2] powerpc/ptdump: Refactor update of pg_state
      https://git.kernel.org/powerpc/c/e54e30bca40233139290aecfce932dea9b996516

cheers
