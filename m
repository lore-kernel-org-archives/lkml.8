Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AACC433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:56:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 805ED204EA
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 21:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727883AbgHXV44 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 17:56:56 -0400
Received: from ms.lwn.net ([45.79.88.28]:56684 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgHXV4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 17:56:55 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 9F44260C;
        Mon, 24 Aug 2020 21:56:54 +0000 (UTC)
Date:   Mon, 24 Aug 2020 15:56:53 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Marta Rybczynska <rybczynska@gmail.com>
Cc:     peterz@infradead.org, will@kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] Documentation/locking/locktypes: fix local_locks
 documentation
Message-ID: <20200824155653.202de8af@lwn.net>
In-Reply-To: <CAApg2=SKxQ3Sqwj6TZnV-0x0cKLXFKDaPvXT4N15MPDMKq724g@mail.gmail.com>
References: <CAApg2=SKxQ3Sqwj6TZnV-0x0cKLXFKDaPvXT4N15MPDMKq724g@mail.gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Jul 2020 20:54:40 +0200
Marta Rybczynska <rybczynska@gmail.com> wrote:

> Fix issues with local_locks documentation:
> - fix function names, local_lock.h has local_unlock_irqrestore(),
> not local_lock_irqrestore()
> - fix mapping table, local_unlock_irqrestore() maps to local_irq_restore(),
> not _save()
> 
> Signed-off-by: Marta Rybczynska <rybczynska@gmail.com>
> ---
>  Documentation/locking/locktypes.rst | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)

Applied (finally).  I had to fix some mailer-inflicted line wrapping
before the patch would apply...

jon
