Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E2FEC33CB1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D4FDF217BA
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 09:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ds/jQbXw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728921AbgANJSI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 04:18:08 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:45008 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725820AbgANJSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 04:18:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WK5mNxJmZlMfIlStInjtnW5+mJGwXwB5z2/WQVXG1Jc=; b=Ds/jQbXw8nbCbaPbNliOhbJDq
        KRbr0XuNT25GWjjXRRA5yAqh1Da7rGWcqlnnYvdFiAD8ygBETMN7VXlqYCXgf/wb0yOtP57s4o7pv
        Pb3K2Nb2vi1Guqqj/ZJrxwyALOCGwLp4wMfNpa3mtW9YX7qygiafQvbgD2bEuVGRZIpAyi5GBoFQg
        Z3lkknNFmrn9RvgdFJqr2RBBu6kuj41+RXps4G8qrJcU5gpOPyOWdkCvdswyMPnC7usamVnGubICq
        rEWIHGG7Tl/C6/XgqeuF+WXL9K0EeYt0CWsjciSD4oOwHucsDoXXnsjZMtR10U4YZmowdmrMJmPPi
        VVbeiAZSA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irIKt-0005gj-4d; Tue, 14 Jan 2020 09:18:07 +0000
Date:   Tue, 14 Jan 2020 01:18:07 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Julian Stecklina <julian.stecklina@cyberus-technology.de>
Cc:     intel-gvt-dev@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        zhiyuan.lv@intel.com, hang.yuan@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFC PATCH 0/4] Support for out-of-tree hypervisor modules in
 i915/gvt
Message-ID: <20200114091807.GA12664@infradead.org>
References: <4079ce7c26a2d2a3c7e0828ed1ea6008d6e2c805.camel@cyberus-technology.de>
 <20200109171357.115936-1-julian.stecklina@cyberus-technology.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109171357.115936-1-julian.stecklina@cyberus-technology.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 07:13:53PM +0200, Julian Stecklina wrote:
> These patch series removes the dependency of i915/gvt hypervisor
> backends on the driver internals of the i915 driver. Instead, we add a
> small public API that hypervisor backends can use.
> 
> This enables out-of-tree hypervisor backends for the Intel graphics
> virtualization and simplifies development. At the same time, it
> creates at least a bit of a barrier to including more i915 internals
> into kvmgt, which is nice in itself.

Err, hell no.  This is not how Linux kernel development works.
