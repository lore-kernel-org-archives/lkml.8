Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D16C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 792A320716
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbgHKLPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 07:15:55 -0400
Received: from verein.lst.de ([213.95.11.211]:39919 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728469AbgHKLPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 07:15:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 00C5C67357; Tue, 11 Aug 2020 13:15:51 +0200 (CEST)
Date:   Tue, 11 Aug 2020 13:15:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Miles Chen <miles.chen@mediatek.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "David S . Miller" <davem@davemloft.net>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        wsd_upstream@mediatek.com
Subject: Re: [PATCH] net: untag pointer in sockptr_is_kernel
Message-ID: <20200811111551.GA3958@lst.de>
References: <20200811102704.17875-1-miles.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811102704.17875-1-miles.chen@mediatek.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 06:27:04PM +0800, Miles Chen wrote:
> From: Miles Chen <miles.chen@mediatek.com>
> 
> sockptr_is_kernel() uses (sockptr.kernel >= TASK_SIZE) to tell
> if the pointer is kernel space or user space. When user space uses
> the "top byte ignored" feature such as HWAsan, we must untag
> the pointer before checking against TASK_SIZE.
> 
> sockptr_is_kernel() will view a tagged user pointer as a kernel pointer
> and use memcpy directly and causes a kernel crash.

Dave merged a patch from me to rever the optimized sockptr
implementation for now.  If we bring it back we should fold in your
fix.
