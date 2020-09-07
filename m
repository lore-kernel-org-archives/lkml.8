Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95D1C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:01:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B552207C3
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 07:01:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g4rWFwqP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgIGHBl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 03:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgIGHAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 03:00:43 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A8BDC061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 00:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mOwuNgBR5sDIJB+BvLt/e/G3W0U4pZcy6kQxubHpOsc=; b=g4rWFwqPV1Go6Awo3Xadh/+FTc
        rhkqVOirmN3euJ0YqlVMZuHmarTPW9k/+KBS0IBJiq7PF6T/kKmi+Jfc3KrgtB827pIK6HWC/Mdht
        5xhoUhE0TgTLAd6RWIpqSgFwrqFKpVC7zMd2tCVTTzzCpWaSypFoADb7e9sp/QltHPE07bTrXlPCo
        jJpbTL7D5CEklu82hlfFs0pIt6EB91s9Pmo7ouUpJXku2JCl7cHofEBhAXLGEdBYyHfDd6vouz/NI
        JFp7LEB0sCZpyV49c8FZmuTBa8B14Fk7K9ICTPjCb0tLjN2FnTVYTfg2bFkUBB72NcK8nFsDXX9cL
        9fzmjARw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFB8l-0006fv-7r; Mon, 07 Sep 2020 07:00:35 +0000
Date:   Mon, 7 Sep 2020 08:00:35 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Tom Murphy <murphyt7@tcd.ie>
Cc:     iommu@lists.linux-foundation.org,
        David Woodhouse <dwmw2@infradead.org>,
        linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        intel-gfx@lists.freedesktop.org
Subject: Re: [PATCH V2 5/5] DO NOT MERGE: iommu: disable list appending in
 dma-iommu
Message-ID: <20200907070035.GA25114@infradead.org>
References: <20200903201839.7327-1-murphyt7@tcd.ie>
 <20200903201839.7327-6-murphyt7@tcd.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903201839.7327-6-murphyt7@tcd.ie>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 03, 2020 at 09:18:37PM +0100, Tom Murphy wrote:
> Disable combining sg segments in the dma-iommu api.
> Combining the sg segments exposes a bug in the intel i915 driver which
> causes visual artifacts and the screen to freeze. This is most likely
> because of how the i915 handles the returned list. It probably doesn't
> respect the returned value specifying the number of elements in the list
> and instead depends on the previous behaviour of the intel iommu driver
> which would return the same number of elements in the output list as in
> the input list.

So what is the state of addressing this properly in i915?  IF we can't
get it done ASAP I wonder if we need a runtime quirk to disable
merging instead of blocking this conversion..
