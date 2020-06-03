Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2D2C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 799BD206C3
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 12:58:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgFCM6b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 08:58:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:53904 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725833AbgFCM6b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 08:58:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 62077AF95;
        Wed,  3 Jun 2020 12:58:32 +0000 (UTC)
Date:   Wed, 3 Jun 2020 14:58:26 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Abdul Haleem <abdhalee@linux.vnet.ibm.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-next <linux-next@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        mpe <mpe@ellerman.id.au>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        sachinp <sachinp@linux.vnet.ibm.com>,
        manvanth <manvanth@linux.vnet.ibm.com>,
        "aneesh.kumar" <aneesh.kumar@linux.vnet.ibm.com>,
        akpm@linux-foundation.org, Steven Rostedt <rostedt@goodmis.org>,
        hch <hch@lst.de>
Subject: Re: [mainline][Oops][bisected 2ba3e6 ] 5.7.0 boot fails with kernel
 panic on powerpc
Message-ID: <20200603125826.GK6857@suse.de>
References: <1591181457.9020.13.camel@abdul>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591181457.9020.13.camel@abdul>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Abdul,

On Wed, Jun 03, 2020 at 04:20:57PM +0530, Abdul Haleem wrote:
> Greeting's
> 
> Today's mainline kernel panics when booting on my powerpc lpar

Thanks for the report, I am looking into it with my limited powerpc
knowledge. But I have an idea and will send you something to test later
today.

Thanks,

	Joerg

