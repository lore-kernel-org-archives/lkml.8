Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0CD0C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C402E2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 09:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vJKwxIRw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgHQJbz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 05:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgHQJby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 05:31:54 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B25C061389;
        Mon, 17 Aug 2020 02:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+Mwzdd5TmWK436GJyXFCq0eX/F+xGzHfq7QX6jo+m2U=; b=vJKwxIRw343oq9qZRi0kzGe4Qu
        HBUYrr3bBRrN5xeRPLrsHf3I0ASm9oaBh9OSM3AaYprIySLCLkYY0MQOyXW+dqVi1RWM79M0b6ge0
        06aid+RM0YK64s7IkRC6+0NxbOiDRFe7IYqpi2CeVMZghgSNOdwuJl4ChM2BAR7xaBs7wYmEENtKq
        Lv02UzXmgYmi24EleG4we86LcRfVtN5+PJooB4eRZxqyml19UNk6255TOUCPub5DLJP05AwBYwDgf
        WUjUVq9ankXrJGQrOunw+MlkyIEFlQ0xIKZrQYPveJkHVld7RPDUa0ceDapXJ1njxF4IShH1hJ70S
        V+nIYjkQ==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k7bUM-00035D-Ni; Mon, 17 Aug 2020 09:31:34 +0000
Date:   Mon, 17 Aug 2020 10:31:34 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxarm@huawei.com, mauro.chehab@huawei.com,
        John Stultz <john.stultz@linaro.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Wei Xu <xuwei5@hisilicon.com>, devicetree@vger.kernel.org,
        Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>,
        iommu@lists.linux-foundation.org,
        Chenfeng <puck.chen@hisilicon.com>, devel@driverdev.osuosl.org,
        Suzhuangluan <suzhuangluan@hisilicon.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/16] IOMMU driver for Kirin 960/970
Message-ID: <20200817093134.GA11250@infradead.org>
References: <cover.1597650455.git.mchehab+huawei@kernel.org>
 <20200817082106.GA16296@infradead.org>
 <20200817112725.26f1b7d6@coco.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200817112725.26f1b7d6@coco.lan>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 17, 2020 at 11:27:25AM +0200, Mauro Carvalho Chehab wrote:
> I need to start from the original patch in order to preserve its
> authorship.

Nom you don't.  We have plenty of example where people submit code
written by other, especially when it is significantly reworked,

> My plan is to work with the iommu subsystem maintainers after
> have this (and another pending patch series for DRM) merged.

Please submit it to the iommu list directly.  Seriously - you did not
even cc the relevant list, and you don't even have a comment from
the maintainers.  Don't do this kind of crap.
