Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D38C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 15:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA86720720
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 15:01:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sXjsW/W8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgGIPBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 11:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726371AbgGIPBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 11:01:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08C4DC08C5CE;
        Thu,  9 Jul 2020 08:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=d6Fy1Ff8XKWJW7cdhpnfoPEQT8m7nn2QugrKA2y4BTE=; b=sXjsW/W8stofL0fSqv1devL9iA
        NF8pTtSu1pmMI2cx2Ezm5BoeofYSnPN6/rZYmpD+i2SwKMs8rbtY2EPcBcEn7LmzBMlRLH+HYv4ou
        IIiSGFJU8JQLbSCfDquQtv8nlD8xpYOQ1F33SWeREt+m+MKW2AS9lsim693P8pOA6Vn81rDU4U0pQ
        5CL7N1SiSxz2S6PRS4eEqvntN+bK6HeL9i5oI+CCBxoYMsT/JAjCwF5JHINgYNRZxp7hyfyhsJm5A
        TrgN6ANkFqMOJfU2KX4+HzhiTpzqnYh8wY/zml3sRidyoIzqKYX3E/qQYPkqN/E1WGtoJpXZ0IVyl
        KCO5FDkg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jtY2d-0004br-7k; Thu, 09 Jul 2020 15:00:51 +0000
Date:   Thu, 9 Jul 2020 16:00:51 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-nvdimm@lists.01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/12] PM, libnvdimm: Add 'mem-quiet' state and
 callback for firmware activation
Message-ID: <20200709150051.GA17342@infradead.org>
References: <159408711335.2385045.2567600405906448375.stgit@dwillia2-desk3.amr.corp.intel.com>
 <159408717289.2385045.14094866475168644020.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <159408717289.2385045.14094866475168644020.stgit@dwillia2-desk3.amr.corp.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 06, 2020 at 06:59:32PM -0700, Dan Williams wrote:
> The runtime firmware activation capability of Intel NVDIMM devices
> requires memory transactions to be disabled for 100s of microseconds.
> This timeout is large enough to cause in-flight DMA to fail and other
> application detectable timeouts. Arrange for firmware activation to be
> executed while the system is "quiesced", all processes and device-DMA
> frozen.
> 
> It is already required that invoking device ->freeze() callbacks is
> sufficient to cease DMA. A device that continues memory writes outside
> of user-direction violates expectations of the PM core to be to
> establish a coherent hibernation image.
> 
> That said, RDMA devices are an example of a device that access memory
> outside of user process direction. RDMA drivers also typically assume
> the system they are operating in will never be hibernated. A solution
> for RDMA collisions with firmware activation is outside the scope of
> this change and may need to rely on being able to survive the platform
> imposed memory controller quiesce period.

Yikes.  I don't think we should support such a broken runtime firmware
activation.
