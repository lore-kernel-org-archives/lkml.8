Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14CEC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 07:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 851FB20578
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 07:10:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbgHYHKa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 03:10:30 -0400
Received: from verein.lst.de ([213.95.11.211]:57720 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728936AbgHYHK0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 03:10:26 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7909968BEB; Tue, 25 Aug 2020 09:10:24 +0200 (CEST)
Date:   Tue, 25 Aug 2020 09:10:24 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     james.smart@broadcom.com, hch@lst.de, sagi@grimberg.me,
        chaitanya.kulkarni@wdc.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] nvmet-fc: Fix a missed _irqsave version of spin_lock
 in 'nvmet_fc_fod_op_done()'
Message-ID: <20200825071024.GE29268@lst.de>
References: <20200821075819.152474-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200821075819.152474-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 09:58:19AM +0200, Christophe JAILLET wrote:
> The way 'spin_lock()' and 'spin_lock_irqsave()' are used is not consistent
> in this function.
> 
> Use 'spin_lock_irqsave()' also here, as there is no guarantee that
> interruptions are disabled at that point, according to surrounding code.
> 
> Fixes: a97ec51b37ef ("nvmet_fc: Rework target side abort handling")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Not tested, only based on what looks logical to me according to
> surrounding code

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
