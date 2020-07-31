Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B8CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7860E20829
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 09:00:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732049AbgGaJAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 05:00:25 -0400
Received: from verein.lst.de ([213.95.11.211]:58601 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727102AbgGaJAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 05:00:25 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id D1C4E68BFE; Fri, 31 Jul 2020 11:00:22 +0200 (CEST)
Date:   Fri, 31 Jul 2020 11:00:22 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Christoph Hellwig <hch@lst.de>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>, lkft-triage@lists.linaro.org
Subject: Re: linux-next: Tree for Jul 30 [build failure on arm64]
Message-ID: <20200731090022.GB12930@lst.de>
References: <20200730214659.0fbfdfc4@canb.auug.org.au> <72b073ba-ee41-1a1c-ce6c-ffd8b5936b09@hisilicon.com> <20200731140842.46abe589@canb.auug.org.au> <CA+G9fYvykg9Ly=tRXLrf4hvd4siYKAt5eM0EMnwMgqVDHnbVYQ@mail.gmail.com> <20200731185354.70926525@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731185354.70926525@canb.auug.org.au>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please just drop the branch for now.
