Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 518E6C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 12:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F46B20675
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 12:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732604AbgDAMxR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 08:53:17 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:58215 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732596AbgDAMxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 08:53:15 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 48smMZ0W0pz9sTJ; Wed,  1 Apr 2020 23:53:13 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 7703889e8ee1b318f632be7ba4d58d9962ecf34f
In-Reply-To: <20200224233146.23734-1-mpe@ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] powerpc: Update MAINTAINERS
Message-Id: <48smMZ0W0pz9sTJ@ozlabs.org>
Date:   Wed,  1 Apr 2020 23:53:13 +1100 (AEDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-02-24 at 23:31:39 UTC, Michael Ellerman wrote:
> A while back Paul pointed out I'd been maintaining the tree more or
> less solo for over five years, so perhaps it's time to update the
> MAINTAINERS entry.
> 
> Ben & Paul still wrote most of the code, so keep them as Reviewers so
> they still get Cc'ed on things. But if you're wondering why your patch
> hasn't been merged that's my fault.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Series applied to powerpc next.

https://git.kernel.org/powerpc/c/7703889e8ee1b318f632be7ba4d58d9962ecf34f

cheers
