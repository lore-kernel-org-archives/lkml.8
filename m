Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD8C5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 14:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95B1420723
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 14:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbgEZOox (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 10:44:53 -0400
Received: from ms.lwn.net ([45.79.88.28]:36976 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbgEZOow (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 10:44:52 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 846722AE;
        Tue, 26 May 2020 14:44:52 +0000 (UTC)
Date:   Tue, 26 May 2020 08:44:51 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>
Subject: Re: linux-next: Signed-off-by missing for commit in the jc_docs
 tree
Message-ID: <20200526084451.69a3bd45@lwn.net>
In-Reply-To: <20200526080122.5a91c78a@canb.auug.org.au>
References: <20200526080122.5a91c78a@canb.auug.org.au>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 May 2020 08:01:22 +1000
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Commit
> 
>   1fe411077207 ("Replace HTTP links with HTTPS ones: documentation")
> 
> is missing a Signed-off-by from its author.

Argh, I don't know how I missed that.  Thanks for catching it, it will be
fixed up.

jon
