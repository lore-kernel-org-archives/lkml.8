Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B0EBC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 02:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 431CE2086A
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 02:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596594545;
	bh=lqvSHXD4E2M1Y2QxqPhHvlkc03P+gqROV6eDD6PvWhY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=EOSD/K2oKTMXwF4n7UvlmXLN80rKJISakyUKvhfZdz6RL1WuK5a8RzfJhRv5PDvI+
	 FZAdDjzRsiBkdcIXBqYYWBSjdAUkg1q46fFts2u08pYU0/ME8Mtflfh/kw54noa9WR
	 A56XngbZC+/OlXCvE9lNV9gGCef1HvBSqxgsTtOA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgHEC3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 22:29:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:42084 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726865AbgHEC3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 22:29:03 -0400
Received: from localhost (mobile-166-175-186-42.mycingular.net [166.175.186.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF29220792;
        Wed,  5 Aug 2020 02:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596594543;
        bh=lqvSHXD4E2M1Y2QxqPhHvlkc03P+gqROV6eDD6PvWhY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=m2fM+u7jpfFLuznvMAgUwtc79lcb/iWZ3d3NaYsAmoWo4Du+RZ7qL+QG6srejOSoK
         GMKGxYGOq8270yMlLPrs5bV4AIBC7A4VmmdHtvXsL4PIjpstLypfhAcTESa/SpC1HD
         kXLXgUYpYj9WFZkSJqvsFaRb+GCyq7cyUCqJpeeE=
Date:   Tue, 4 Aug 2020 21:29:01 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: linux-next: build warning after merge of the pci tree
Message-ID: <20200805022901.GA464417@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805113216.28ddc0f2@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 05, 2020 at 11:32:16AM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the pci tree, today's linux-next build (x86_64 allmodconfig)
> produced this warning:
> 
> drivers/pci/controller/pcie-altera.c: In function 'altera_pcie_parse_dt':
> drivers/pci/controller/pcie-altera.c:697:17: warning: unused variable 'dev' [-Wunused-variable]
>   697 |  struct device *dev = &pcie->pdev->dev;
>       |                 ^~~
> 
> Introduced by commit
> 
>   caecb05c8000 ("PCI: Remove dev_err() when handing an error from platform_get_irq()")

Yeah, I blew it, sorry.

e2dcd20b1645 ("PCI: controller: Convert to
devm_platform_ioremap_resource_byname()") removed one use of "dev",
and caecb05c8000 ("PCI: Remove dev_err() when handing an error from
platform_get_irq()") removed the other.  They were on independent
branches and I didn't catch it when merging them.  I thought I had
built the result, but I must not have.

Fixed and re-pushed.
