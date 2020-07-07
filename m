Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A88C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:50:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C44652067D
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 08:50:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbgGGIuj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 04:50:39 -0400
Received: from verein.lst.de ([213.95.11.211]:57827 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725825AbgGGIuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 04:50:39 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id C59CA68AFE; Tue,  7 Jul 2020 10:50:36 +0200 (CEST)
Date:   Tue, 7 Jul 2020 10:50:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        baolin.wang7@gmail.com, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] Some cleanups for NVMe-pci driver
Message-ID: <20200707085036.GB27485@lst.de>
References: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1593743937.git.baolin.wang@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,

applied to nvme-5.9.
