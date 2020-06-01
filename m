Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1934C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:34:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA655206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 15:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727121AbgFAPep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 11:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726075AbgFAPeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 11:34:44 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A912C05BD43;
        Mon,  1 Jun 2020 08:34:44 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id B294537B;
        Mon,  1 Jun 2020 15:34:43 +0000 (UTC)
Date:   Mon, 1 Jun 2020 09:34:42 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zswap: docs/vm: Fix typo accept_threshold_percent in
 zswap.rst
Message-ID: <20200601093442.584b7eca@lwn.net>
In-Reply-To: <20200601005911.31222-1-sedat.dilek@gmail.com>
References: <20200601005911.31222-1-sedat.dilek@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  1 Jun 2020 02:59:11 +0200
Sedat Dilek <sedat.dilek@gmail.com> wrote:

> Recently, I switched over from swap-file to zramswap.
> 
> When reading the Documentation/vm/zswap.rst file I fell over this typo.
> 
> The parameter is called accept_threshold_percent not accept_threhsold_percent
> in /sys/module/zswap/parameters/ directory.
> 
> Fixes: 45190f01dd402 ("mm/zswap.c: add allocation hysteresis if pool limit is hit")
> Cc: Vitaly Wool <vitaly.wool@konsulko.com>
> Signed-off-by: Sedat Dilek <sedat.dilek@gmail.com>

Applied, thanks.

> Changes v1->v2:
> - Changed subject line
> - Resend to LKML with correct email-address

When you make a v2 like this, it's helpful if you mark it as "[PATCH v2]".
I had three versions of this in my inbox and had to figure out what was
going on...

jon
