Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECAAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B43F206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 16:27:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732694AbgFWQ14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 12:27:56 -0400
Received: from verein.lst.de ([213.95.11.211]:39847 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732212AbgFWQ1z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 12:27:55 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 078AE68AEF; Tue, 23 Jun 2020 18:27:52 +0200 (CEST)
Date:   Tue, 23 Jun 2020 18:27:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        baolin.wang7@gmail.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] nvme-pci: Add controller memory buffer supported
 macro
Message-ID: <20200623162751.GA4846@lst.de>
References: <cover.1592916850.git.baolin.wang@linux.alibaba.com> <eab18c7696ea0e34a6ab0371d7d17ad45d1566ce.1592916850.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eab18c7696ea0e34a6ab0371d7d17ad45d1566ce.1592916850.git.baolin.wang@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 09:24:33PM +0800, Baolin Wang wrote:
> Introduce a new capability macro to indicate if the controller
> supports the memory buffer or not, instead of reading the
> NVME_REG_CMBSZ register.

This is a complex issue.  The CMBS bit was only added in NVMe 1.4 as
a backwards incompatible change, as the CMB addressing scheme can lead
to data corruption.  The CMBS was added as part of the horribe hack
that also involves the CBA field, which we'll need to see before
using it to work around the addressing issue.  At the same time we
should also continue supporting the legacy pre-1.4 CMB with a warning
(and may reject it if we know we run in a VM).
