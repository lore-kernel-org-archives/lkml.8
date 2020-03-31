Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62FF4C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 07:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3768F206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 07:53:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OI8IJ9+J"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbgCaHxl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 03:53:41 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45792 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730130AbgCaHxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 03:53:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jv4+KuR3idZ0ryXOQniTU4jklAdh9yBU+MqGGUdPioY=; b=OI8IJ9+Jw2muef+hta2hpEAp24
        gF9Hk/OQL/e+W08mm4drAMofTuN1VwGworwxsQIosdBQtdtRmkCWceRcBLkJTHw2f/qAxwb4lURtV
        zL2uTwXfaDGjAWVvXrXrrPQ6qqrMfTkNs3oHIBy4kGq0KN/cDtjILhyufOuyWLCLICo06SL1en5N8
        Bqf0Fza1QnX6ZxIdPtARkSMDpY6D2NCCtoW4Flomj03Er7eg3ugtPP/cBZFyeGxXg/7etaQkT6ANo
        PVaMN3wEvwifpPhZMJqiwLgJ+5beYRpaXFTzKmz9M+1INF5TUN4FbA3Y/scNLW97fjdbU+F/NYv7w
        gicUQGig==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jJBiF-00072Y-Av; Tue, 31 Mar 2020 07:53:31 +0000
Date:   Tue, 31 Mar 2020 00:53:31 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Liu, Yi L" <yi.l.liu@intel.com>
Cc:     alex.williamson@redhat.com, eric.auger@redhat.com,
        jean-philippe@linaro.org, kevin.tian@intel.com,
        ashok.raj@intel.com, kvm@vger.kernel.org, jun.j.tian@intel.com,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        yi.y.sun@intel.com, hao.wu@intel.com
Subject: Re: [PATCH v1 1/8] vfio: Add VFIO_IOMMU_PASID_REQUEST(alloc/free)
Message-ID: <20200331075331.GA26583@infradead.org>
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
 <1584880325-10561-2-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584880325-10561-2-git-send-email-yi.l.liu@intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Who is going to use thse exports?  Please submit them together with
a driver actually using them.
