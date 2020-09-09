Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71069C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 426E020C09
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:54:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730949AbgIIQyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730538AbgIIP5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:57:19 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D265EC0617AB
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 06:37:39 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BmjkT4fZ6z9sTv; Wed,  9 Sep 2020 23:37:37 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1530691407-3991-1-git-send-email-hofrat@osadl.org>
References: <1530691407-3991-1-git-send-email-hofrat@osadl.org>
Subject: Re: [PATCH] powerpc: icp-hv: fix missing of_node_put in success path
Message-Id: <159965824114.811679.16588415498534668818.b4-ty@ellerman.id.au>
Date:   Wed,  9 Sep 2020 23:37:37 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jul 2018 10:03:27 +0200, Nicholas Mc Guire wrote:
>  Both of_find_compatible_node() and of_find_node_by_type() will
> return a refcounted node on success - thus for the success path
> the node must be explicitly released with a of_node_put().

Applied to powerpc/next.

[1/1] powerpc/icp-hv: Fix missing of_node_put() in success path
      https://git.kernel.org/powerpc/c/d3e669f31ec35856f5e85df9224ede5bdbf1bc7b

cheers
