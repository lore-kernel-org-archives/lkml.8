Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82AE9C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:29:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38F4A206B8
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731098AbgIIQ3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731133AbgIIQ1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 12:27:40 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0C2C061786
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 06:27:40 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BmjVq4KxKz9sTv; Wed,  9 Sep 2020 23:27:30 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <d5641ada199b8dd2af16ad00a66084cf974f2704.1596716418.git.christophe.leroy@csgroup.eu>
References: <d5641ada199b8dd2af16ad00a66084cf974f2704.1596716418.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 1/2] powerpc/fpu: Drop cvt_fd() and cvt_df()
Message-Id: <159965716721.808686.10133921588629579775.b4-ty@ellerman.id.au>
Date:   Wed,  9 Sep 2020 23:27:30 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Aug 2020 12:20:34 +0000 (UTC), Christophe Leroy wrote:
> Those two functions have been unused since commit identified below.
> Drop them.

Applied to powerpc/next.

[1/2] powerpc/fpu: Drop cvt_fd() and cvt_df()
      https://git.kernel.org/powerpc/c/63442de4301188129e1fcff144fbfb966ad5eb19
[2/2] powerpc: drop hard_reset_now() and poweroff_now() declaration
      https://git.kernel.org/powerpc/c/82eb1792426f8a171cdaa6cfccb63c39f55bc9bd

cheers
