Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DD7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 05:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 847852073E
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 05:22:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726863AbgG0FWy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 01:22:54 -0400
Received: from verein.lst.de ([213.95.11.211]:41964 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgG0FWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 01:22:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6EA4D68B05; Mon, 27 Jul 2020 07:22:52 +0200 (CEST)
Date:   Mon, 27 Jul 2020 07:22:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH] kernel.h: Remove duplicate include of asm/div64.h
Message-ID: <20200727052252.GA949@lst.de>
References: <20200727034852.2813453-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727034852.2813453-1-nivedita@alum.mit.edu>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 26, 2020 at 11:48:52PM -0400, Arvind Sankar wrote:
> This seems to have been added inadvertently in commit
>   72deb455b5ec ("block: remove CONFIG_LBDAF")
> 
> Fixes: 72deb455b5ec ("block: remove CONFIG_LBDAF")
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> Cc: Christoph Hellwig <hch@lst.de>

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
