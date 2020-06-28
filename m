Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00237C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 07:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C87C220775
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 07:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726117AbgF1HKS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 03:10:18 -0400
Received: from verein.lst.de ([213.95.11.211]:55584 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbgF1HKS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 03:10:18 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 301AC68AFE; Sun, 28 Jun 2020 09:10:15 +0200 (CEST)
Date:   Sun, 28 Jun 2020 09:10:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Richard Weinberger <richard@nod.at>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        sumit.semwal@linaro.org, robin.murphy@arm.com,
        m.szyprowski@samsung.com, hch@lst.de, dan.carpenter@oracle.com
Subject: Re: Passing NULL dev to dma_alloc_coherent() allowed or not?
Message-ID: <20200628071014.GA16213@lst.de>
References: <1669515915.65540.1593258316061.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1669515915.65540.1593258316061.JavaMail.zimbra@nod.at>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You can't pass NULL.  The synclink case is dead code as we stopped
supporting non-PCI adapters a while ago.  I had a patch to remove
the !PCI code a while ago, but it seems like it never made it upstream.

The staging code is, well .. staging code.
