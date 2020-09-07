Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CE55C2BB84
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0FD120757
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgIGHar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 03:30:47 -0400
Received: from verein.lst.de ([213.95.11.211]:48007 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726443AbgIGHaq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 03:30:46 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C1B1168BFE; Mon,  7 Sep 2020 09:30:44 +0200 (CEST)
Date:   Mon, 7 Sep 2020 09:30:44 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Christoph Hellwig <hch@lst.de>, arnd@arndb.de,
        gregkh@linuxfoundation.org, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] /dev/zero: also implement ->read
Message-ID: <20200907073044.GE19875@lst.de>
References: <20200903155922.1111551-1-hch@lst.de> <8d430999-b155-dbfa-e7db-f414b48014b1@rasmusvillemoes.dk> <20200907062026.GA19076@lst.de> <4a981ee8-2d57-c7ce-a1ca-43ad237471d2@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4a981ee8-2d57-c7ce-a1ca-43ad237471d2@rasmusvillemoes.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 07, 2020 at 08:50:53AM +0200, Rasmus Villemoes wrote:
> 
> Actually, while you're micro-optimizing it, AFAIK VFS already handles
> count==0,

It doesn't.
