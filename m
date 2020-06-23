Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FBEDC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DF1D20707
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 06:15:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731098AbgFWGPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 02:15:41 -0400
Received: from verein.lst.de ([213.95.11.211]:37822 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730515AbgFWGPk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 02:15:40 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2D36668AEF; Tue, 23 Jun 2020 08:15:38 +0200 (CEST)
Date:   Tue, 23 Jun 2020 08:15:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH 2/2] asm-generic: Make cacheflush.h self-contained
Message-ID: <20200623061538.GB32219@lst.de>
References: <20200622234740.72825-1-natechancellor@gmail.com> <20200622234740.72825-3-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622234740.72825-3-natechancellor@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>

Stephen also just sent a very similar one.
