Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1933FC34047
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 09:29:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDDF024656
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 09:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbgBSJ3i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 04:29:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:46152 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726195AbgBSJ3i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 04:29:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 885C2B2CC;
        Wed, 19 Feb 2020 09:29:36 +0000 (UTC)
Date:   Wed, 19 Feb 2020 10:29:34 +0100
From:   Joerg Roedel <jroedel@suse.de>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] iommu/vt-d: Add attach_deferred() helper
Message-ID: <20200219092934.GJ23114@suse.de>
References: <20200217193858.26990-1-joro@8bytes.org>
 <20200217193858.26990-2-joro@8bytes.org>
 <20200218171454.GA7067@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200218171454.GA7067@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 09:14:54AM -0800, Christoph Hellwig wrote:
> > +static bool attach_deferred(struct device *dev)
> > +{
> > +	return dev->archdata.iommu == DEFER_DEVICE_DOMAIN_INFO;
> > +}
> 
> This is not a very useful helper.

Depends on what one considers useful. I think such helpers make the code
better readable, which is pretty useful to me.

Regards,

	Joerg

