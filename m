Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12D6C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 20:50:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98AF9206E9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 20:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442200AbgDOUul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 16:50:41 -0400
Received: from ms.lwn.net ([45.79.88.28]:52672 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2442190AbgDOUui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 16:50:38 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8CB612D8;
        Wed, 15 Apr 2020 20:50:37 +0000 (UTC)
Date:   Wed, 15 Apr 2020 14:50:36 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        NeilBrown <neilb@suse.de>, Jessica Yu <jeyu@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] docs: admin-guide: merge sections for the
 kernel.modprobe sysctl
Message-ID: <20200415145036.671e46f9@lwn.net>
In-Reply-To: <20200414172430.230293-1-ebiggers@kernel.org>
References: <20200414172430.230293-1-ebiggers@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Apr 2020 10:24:30 -0700
Eric Biggers <ebiggers@kernel.org> wrote:

> Documentation for the kernel.modprobe sysctl was added both by
> commit 0317c5371e6a ("docs: merge debugging-modules.txt into
> sysctl/kernel.rst") and by commit 6e7158250625 ("docs: admin-guide:
> document the kernel.modprobe sysctl"), resulting in the same sysctl
> being documented in two places.  Merge these into one place.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
> 
> Jon, could you take this through the docs tree as a fix for 5.7?

Applied, thanks.

jon
