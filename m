Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CF23C4CECE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:26:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7021E206BE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 13:26:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726736AbgCMN0G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 09:26:06 -0400
Received: from 8bytes.org ([81.169.241.247]:51100 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726691AbgCMN0F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 09:26:05 -0400
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 8B8EA269; Fri, 13 Mar 2020 14:26:04 +0100 (CET)
Date:   Fri, 13 Mar 2020 14:26:01 +0100
From:   Joerg Roedel <joro@8bytes.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: Re: linux-next: Fixes tag needs some work in the iommu tree
Message-ID: <20200313132601.GM3794@8bytes.org>
References: <20200311093638.3b442a3d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311093638.3b442a3d@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 09:36:38AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   57744190bf30 ("iommu/vt-d: dmar: replace WARN_TAINT with pr_warn + add_taint")
> 
> Fixes tag
> 
>   Fixes: fd0c8894893c ("intel-iommu: Set a more specific taint flag for invalid BI
> 
> has these problem(s):
> 
>   - Subject has leading but no trailing parentheses
>   - Subject has leading but no trailing quotes
> 
> Please do not truncate Fixes tag lines.

Fixed now, thanks.


