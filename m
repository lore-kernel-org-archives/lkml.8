Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61B9CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 07:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CFC7204EF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 07:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="t9ZtB8Kr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgFHHFn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 03:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728053AbgFHHFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 03:05:43 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEDFC08C5C3
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 00:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7U+YuzUXCE0mJTp+dzDjktj85iFXgfVb4+sX78AimxA=; b=t9ZtB8KrPobjfP37mn9PfXTOLL
        hbJ48V3TGx/y1Ob8pefkO7PtqfJ1GhdVdawR2fBv9Nnt6Ry1l4i7RCTDpanqbn0543t5inWZpSiLJ
        MBHirWUVu4Bj4gjeitX3d0Xcy0BUMqCIZlJ5TDTPYSTPsW4rD20mPGeOqXhefVsDad/4p/uwXN9ts
        BFJQazZwUt8iQOhbgVV/u98RhSgAFQz/xYRyVbBHhUWpeupPcuahDUY4dQ/huAv/k521Tu0htnB8W
        TwuxXAuLOZC3LvaKs7g9iYJQEUwkUH+Xcw1g2E4xW7kCZdhElaGQyarktIVMkReqigHZQuuhY3uZv
        XaMSveiw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jiBqm-0003E7-8a; Mon, 08 Jun 2020 07:05:40 +0000
Date:   Mon, 8 Jun 2020 00:05:40 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Stefano Stabellini <sstabellini@kernel.org>
Cc:     jgross@suse.com, boris.ostrovsky@oracle.com,
        konrad.wilk@oracle.com, xen-devel@lists.xenproject.org,
        linux-kernel@vger.kernel.org, tamas@tklengyel.com,
        roman@zededa.com,
        Stefano Stabellini <stefano.stabellini@xilinx.com>
Subject: Re: [PATCH v2 04/11] swiotlb-xen: add struct device* parameter to
 xen_bus_to_phys
Message-ID: <20200608070540.GC15742@infradead.org>
References: <alpine.DEB.2.21.2006031506590.6774@sstabellini-ThinkPad-T480s>
 <20200603222247.11681-4-sstabellini@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603222247.11681-4-sstabellini@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Same comment as for the last one.  Also in the subject a whitespace
is missing after "device" and before "*".
