Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9798CC433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DC2E20767
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:27:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgIBP11 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:27:27 -0400
Received: from verein.lst.de ([213.95.11.211]:32775 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727999AbgIBP0B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:26:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 777EE68B05; Wed,  2 Sep 2020 17:25:59 +0200 (CEST)
Date:   Wed, 2 Sep 2020 17:25:59 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jim Quinlan <james.quinlan@broadcom.com>,
        Santosh Shilimkar <ssantosh@kernel.org>
Subject: Re: linux-next: build warning after merge of the dma-mapping tree
Message-ID: <20200902152559.GA2053@lst.de>
References: <20200902100317.142db5be@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902100317.142db5be@canb.auug.org.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding Santosh,

I'm trying to understand the code that Jim changed for the range
dma offsets.  Do I miss something or can the whole DMA offset case
for keystone only happen when CONFIG_LPAE is enabled?  Which means
we could ifdef out this section to avoid the warning?
