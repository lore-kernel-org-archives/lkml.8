Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196C8C433E9
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E30C92098B
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 16:13:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728951AbgICQNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 12:13:18 -0400
Received: from verein.lst.de ([213.95.11.211]:38563 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728575AbgICQNM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 12:13:12 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id BD48967357; Thu,  3 Sep 2020 18:13:08 +0200 (CEST)
Date:   Thu, 3 Sep 2020 18:13:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Nicolin Chen <nicoleotsuka@gmail.com>, hch@lst.de,
        sfr@canb.auug.org.au, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, rth@twiddle.net,
        ink@jurassic.park.msu.ru, mattst88@gmail.com,
        linux-alpha@vger.kernel.org, tony.luck@intel.com,
        fenghua.yu@intel.com, linux-ia64@vger.kernel.org,
        gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com,
        linux-s390@vger.kernel.org, davem@davemloft.net,
        sparclinux@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com,
        James.Bottomley@HansenPartnership.com, deller@gmx.de,
        linux-parisc@vger.kernel.org
Subject: Re: [PATCH 0/2] dma-mapping: update default segment_boundary_mask
Message-ID: <20200903161308.GB24841@lst.de>
References: <20200901221646.26491-1-nicoleotsuka@gmail.com> <2c8db0aa-e8b5-e577-b971-1de10ecc6747@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c8db0aa-e8b5-e577-b971-1de10ecc6747@linux.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied with the recommendation from Michael folded in.
