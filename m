Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B3C6C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 145A020C09
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 16:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730877AbgIIQyk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 12:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730544AbgIIP5T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 11:57:19 -0400
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC273C0617BA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 06:38:39 -0700 (PDT)
Received: by ozlabs.org (Postfix, from userid 1034)
        id 4BmjkS68hFz9sVT; Wed,  9 Sep 2020 23:37:36 +1000 (AEST)
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
To:     Michael Ellerman <michael@ellerman.id.au>,
        Nicholas Mc Guire <hofrat@osadl.org>
Cc:     Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <1530522496-14816-1-git-send-email-hofrat@osadl.org>
References: <1530522496-14816-1-git-send-email-hofrat@osadl.org>
Subject: Re: [PATCH] powerpc: hwrng; fix missing of_node_put()
Message-Id: <159965824096.811679.9956430323113603887.b4-ty@ellerman.id.au>
Date:   Wed,  9 Sep 2020 23:37:36 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Jul 2018 11:08:16 +0200, Nicholas Mc Guire wrote:
>  The call to of_find_compatible_node() returns a node pointer with refcount
> incremented thus it must be explicitly decremented here before returning.

Applied to powerpc/next.

[1/1] powerpc/pseries: Fix missing of_node_put() in rng_init()
      https://git.kernel.org/powerpc/c/67c3e59443f5fc77be39e2ce0db75fbfa78c7965

cheers
