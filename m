Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71AEAC352A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 17:22:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C95820702
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 17:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727361AbgBERWc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 12:22:32 -0500
Received: from ms.lwn.net ([45.79.88.28]:52536 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727109AbgBERWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 12:22:31 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id C745E60C;
        Wed,  5 Feb 2020 17:22:30 +0000 (UTC)
Date:   Wed, 5 Feb 2020 10:22:29 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     SeongJae Park <sj38.park@gmail.com>
Cc:     paulmck@kernel.org, SeongJae Park <sjpark@amazon.de>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Documentation: Fix trivial nits
Message-ID: <20200205102229.3497c3b1@lwn.net>
In-Reply-To: <20200131205237.29535-1-sj38.park@gmail.com>
References: <20200131205237.29535-1-sj38.park@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Jan 2020 21:52:32 +0100
SeongJae Park <sj38.park@gmail.com> wrote:

> his patchset fixes trivial nits in the documentations.
> 
> SeongJae Park (5):
>   docs/locking: Fix outdated section names
>   docs/ko_KR/howto: Insert missing dots
>   Documentation/ko_KR/howto: Update broken web addresses
>   Documentation/ko_KR/howto: Update a broken link
>   Documentation/memory-barriers: Fix typos
> 
>  Documentation/locking/spinlocks.rst        |  4 ++--
>  Documentation/memory-barriers.txt          |  8 ++++----
>  Documentation/translations/ko_KR/howto.rst | 10 +++++-----
>  3 files changed, 11 insertions(+), 11 deletions(-)

OK, I've applied parts 1, 3, and 4.  It looks like Paul picked up #5, and
I had separate comments on #2.

Thanks,

jon
