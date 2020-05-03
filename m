Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38A4C28CBC
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 18:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DCA7206F0
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 18:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgECSjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 14:39:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728863AbgECSjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 14:39:31 -0400
Received: from theia.8bytes.org (8bytes.org [IPv6:2a01:238:4383:600:38bc:a715:4b6d:a889])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04734C061A0E
        for <linux-kernel@vger.kernel.org>; Sun,  3 May 2020 11:39:30 -0700 (PDT)
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id 191A2452; Sun,  3 May 2020 20:39:29 +0200 (CEST)
Date:   Sun, 3 May 2020 20:39:27 +0200
From:   Joerg Roedel <joro@8bytes.org>
To:     Qian Cai <cai@lca.pw>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] iommu/amd: fix a race in fetch_pte()
Message-ID: <20200503183927.GA18353@8bytes.org>
References: <20200418121022.GA6113@8bytes.org>
 <57CBF6B2-4745-4E36-9AA5-7E0876E3DA8F@lca.pw>
 <20200418183429.GH21900@8bytes.org>
 <7D03A3E2-647B-4FAD-886D-EE2764EC1EDB@lca.pw>
 <20200429112014.GN21900@8bytes.org>
 <E351FE35-3130-48B0-90ED-BC55469C73F7@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E351FE35-3130-48B0-90ED-BC55469C73F7@lca.pw>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qian,

On Sun, May 03, 2020 at 09:04:03AM -0400, Qian Cai wrote:
> > On Apr 29, 2020, at 7:20 AM, Joerg Roedel <joro@8bytes.org> wrote:
> > Can you please test this branch:
> > 
> > 	https://git.kernel.org/pub/scm/linux/kernel/git/joro/linux.git/log/?h=amd-iommu-fixes
> > 
> > It has the previous fix in it and a couple more to make sure the
> > device-table is updated and flushed before increase_address_space()
> > updates domain->pt_root.
> 
> I believe this closed the existing races as it had survived for many
> days. Great work!

Thanks a lot for testing these changes! Can I add your Tested-by when I
send them to the mailing list tomorrow?

Regards,

	Joerg

