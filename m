Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA0CC55185
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 23:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E498720672
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 23:51:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726295AbgDYXv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 19:51:28 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:47487 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbgDYXvR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 19:51:17 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 498nql587Wz9sSJ; Sun, 26 Apr 2020 09:51:15 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 94c0b013c98583614e1ad911e8795ca36da34a85
In-Reply-To: <20200416221908.7886-1-chris.packham@alliedtelesis.co.nz>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        benh@kernel.crashing.org, christophe.leroy@c-s.fr,
        tglx@linutronix.de, paulus@samba.org, cai@lca.pw, oss@buserror.net
From:   Michael Ellerman <patch-notifications@ellerman.id.au>
Cc:     Chris Packham <chris.packham@alliedtelesis.co.nz>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] powerpc/setup_64: Set cache-line-size based on cache-block-size
Message-Id: <498nql587Wz9sSJ@ozlabs.org>
Date:   Sun, 26 Apr 2020 09:51:15 +1000 (AEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-04-16 at 22:19:08 UTC, Chris Packham wrote:
> If {i,d}-cache-block-size is set and {i,d}-cache-line-size is not, use
> the block-size value for both. Per the devicetree spec cache-line-size
> is only needed if it differs from the block size.
> 
> Originally the code would fallback from block size to line size. An
> error message was printed if both properties were missing.
> 
> Later the code was refactored to use clearer names and logic but it
> inadvertently made line size a required property. This caused the
> default values to be used and in turn leads to Power9 systems using the
> wrong size.
> 
> Fixes: bd067f83b084 ("powerpc/64: Fix naming of cache block vs. cache lin=
> e")
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/94c0b013c98583614e1ad911e8795ca36da34a85

cheers
