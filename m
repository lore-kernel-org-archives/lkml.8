Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3D5C83007
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 08:47:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4B6120775
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 08:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgD2Irn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 04:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726345AbgD2Irm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 04:47:42 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0C6C03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 01:47:42 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 6F3E329A; Wed, 29 Apr 2020 10:47:40 +0200 (CEST)
Date:   Wed, 29 Apr 2020 10:47:38 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Qian Cai <cai@lca.pw>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] iommu/amd: fix a race in fetch_pte()
Message-ID: <20200429084738.GM21900@8bytes.org>
References: <20200418121022.GA6113@8bytes.org>
 <57CBF6B2-4745-4E36-9AA5-7E0876E3DA8F@lca.pw>
 <20200418183429.GH21900@8bytes.org>
 <7D03A3E2-647B-4FAD-886D-EE2764EC1EDB@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7D03A3E2-647B-4FAD-886D-EE2764EC1EDB@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qian,

On Mon, Apr 20, 2020 at 09:26:12AM -0400, Qian Cai wrote:
> 
> No dice. There could be some other races. For example,

Okay, I think I know what is happening. The increase_address_space()
function increases the address space, but does not update the
DTE and does not flush the old DTE from the caches. But this needs to
happen before domain->pt_root is updated, because otherwise another CPU
can come along and map something into the increased address-space which
is not yet accessible by the device because the DTE is not updated yet.

Regards,

	Joerg
