Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3E3C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 23:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F995206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 23:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgIAXaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 19:30:21 -0400
Received: from kernel.crashing.org ([76.164.61.194]:52834 "EHLO
        kernel.crashing.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725949AbgIAXaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 19:30:20 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Tue, 01 Sep 2020 19:30:19 EDT
Received: from localhost (gate.crashing.org [63.228.1.57])
        (authenticated bits=0)
        by kernel.crashing.org (8.14.7/8.14.7) with ESMTP id 081NMtMT027356
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 1 Sep 2020 18:22:58 -0500
Message-ID: <658051b1ba6533fef92648eba08dfdf240af7a18.camel@kernel.crashing.org>
Subject: Re: [PATCH] arm64: Enable PCI write-combine resources under sysfs
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Bjorn Helgaas <helgaas@kernel.org>, Clint Sbisa <csbisa@amazon.com>
Cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 02 Sep 2020 09:22:53 +1000
In-Reply-To: <20200901183702.GA196025@bjorn-Precision-5520>
References: <20200901183702.GA196025@bjorn-Precision-5520>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-09-01 at 13:37 -0500, Bjorn Helgaas wrote:
> On Mon, Aug 31, 2020 at 03:18:27PM +0000, Clint Sbisa wrote:
> > Using write-combine is crucial for performance of PCI devices where
> > significant amounts of transactions go over PCI BARs.
> > 
> > arm64 supports write-combine PCI mappings, so the appropriate
> > define
> > has been added which will expose write-combine mappings under sysfs
> > for prefetchable PCI resources.
> > 
> > Signed-off-by: Clint Sbisa <csbisa@amazon.com>
> 
> Fine with me, I assume Will or Catalin will apply this.

Haha ! Client had sent it to them originally and I told him to resend
it to linux-pci, yourself and Lorenzo :-)

So the confusion is on me.

Will, Catalin, it's all yours. You should have the original patch in
your mbox already, otherwise:

https://patchwork.kernel.org/patch/11729875/

Cheers,
Ben.


