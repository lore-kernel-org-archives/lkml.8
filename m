Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C79C55186
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 08:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D52E20728
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 08:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgDXIkU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 04:40:20 -0400
Received: from foss.arm.com ([217.140.110.172]:57392 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726324AbgDXIkU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 04:40:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6CEA1FB;
        Fri, 24 Apr 2020 01:40:19 -0700 (PDT)
Received: from gaia (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B69153F68F;
        Fri, 24 Apr 2020 01:40:18 -0700 (PDT)
Date:   Fri, 24 Apr 2020 09:40:12 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jonathan Corbet <corbet@lwn.net>, Will Deacon <will@kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: Re: linux-next: manual merge of the jc_docs tree with the
 arm64-fixes tree
Message-ID: <20200424084011.GA3881@gaia>
References: <20200424121513.0750e300@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424121513.0750e300@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Stephen,

On Fri, Apr 24, 2020 at 12:15:13PM +1000, Stephen Rothwell wrote:
> Today's linux-next merge of the jc_docs tree got a conflict in:
> 
>   Documentation/arm64/amu.rst
> 
> between commit:
> 
>   59bff30ad6ce ("Documentation: arm64: fix amu.rst doc warnings")
> 
> from the arm64-fixes tree and commit:
> 
>   d91589556b6a ("docs: amu: supress some Sphinx warnings")
> 
> from the jc_docs tree.

I should have checked whether there is a fix already.

> I fixed it up (I used the former version sonce that seems to be a superset
> of the latter)

I think Randy's version is indeed better, at least the bullet points are
now consistently aligned to the first column throughout the document.

-- 
Catalin
