Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43688C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 18:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 284592077E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 18:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgCRS5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 14:57:08 -0400
Received: from gentwo.org ([3.19.106.255]:43780 "EHLO gentwo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726506AbgCRS5H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 14:57:07 -0400
Received: by gentwo.org (Postfix, from userid 1002)
        id 1FEAA3EF51; Wed, 18 Mar 2020 18:57:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 1DA593EF50;
        Wed, 18 Mar 2020 18:57:07 +0000 (UTC)
Date:   Wed, 18 Mar 2020 18:57:07 +0000 (UTC)
From:   Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To:     Michal Hocko <mhocko@kernel.org>
cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mel Gorman <mgorman@suse.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/3] mm/page_alloc: Keep memoryless cpuless node 0
 offline
In-Reply-To: <20200316085425.GB11482@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.2003181855260.18605@www.lameter.com>
References: <20200311110237.5731-1-srikar@linux.vnet.ibm.com> <20200311110237.5731-4-srikar@linux.vnet.ibm.com> <alpine.DEB.2.21.2003151416230.14449@www.lameter.com> <20200316085425.GB11482@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Mar 2020, Michal Hocko wrote:

> > We can dynamically number the nodes right? So just make sure that the
> > firmware properly creates memory on node 0?
>
> Are you suggesting that the OS would renumber NUMA nodes coming
> from FW just to satisfy node 0 existence? If yes then I believe this is
> really a bad idea because it would make HW/LPAR configuration matching
> to the resulting memory layout really hard to follow.

NUMA nodes are created by the OS based on information provided by the
firmware. Either the FW would need to ensure that a viable node 0 exists
or the bootstrap arch code could setup things to the same effect.

