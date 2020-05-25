Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B186C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F11EA20888
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 14:28:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403955AbgEYO2E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 10:28:04 -0400
Received: from 8bytes.org ([81.169.241.247]:44600 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390879AbgEYO2E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 10:28:04 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id F2A51189; Mon, 25 May 2020 16:28:02 +0200 (CEST)
Date:   Mon, 25 May 2020 16:28:01 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Prakash Gupta <guptap@codeaurora.org>, mhocko@suse.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] iommu/dma: limit iova free size to unmmaped iova
Message-ID: <20200525142801.GF5221@8bytes.org>
References: <20200521113004.12438-1-guptap@codeaurora.org>
 <20200521114906.2f38fc04d3600d41f3409bd9@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521114906.2f38fc04d3600d41f3409bd9@linux-foundation.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 11:49:06AM -0700, Andrew Morton wrote:
> I'll assume that Joerg will handle this fix?

Yes, I will when it turns out necessary.


Regards,

	Joerg
