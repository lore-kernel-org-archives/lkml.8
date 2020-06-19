Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6CE3C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 07:45:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA4542073E
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 07:45:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731096AbgFSHpM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 03:45:12 -0400
Received: from mailbackend.panix.com ([166.84.1.89]:60735 "EHLO
        mailbackend.panix.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730830AbgFSHpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 03:45:12 -0400
Received: from xps-7390 (cpe-23-242-39-94.socal.res.rr.com [23.242.39.94])
        by mailbackend.panix.com (Postfix) with ESMTPSA id 49p9ng23w8zWCb;
        Fri, 19 Jun 2020 03:45:11 -0400 (EDT)
Date:   Fri, 19 Jun 2020 00:45:10 -0700 (PDT)
From:   "Kenneth R. Crudup" <kenny@panix.com>
Reply-To: "Kenneth R. Crudup" <kenny@panix.com>
To:     Christoph Hellwig <hch@lst.de>
cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Commit 25f12ae45fc1 ("maccess: rename probe_kernel_address to
 get_kernel_nofault") causing several OOPSes
In-Reply-To: <20200619074233.GA3723@lst.de>
Message-ID: <alpine.DEB.2.22.394.2006190043240.9276@xps-7390>
References: <alpine.DEB.2.22.394.2006181751270.9276@xps-7390> <20200619065007.GA3041@lst.de> <alpine.DEB.2.22.394.2006182351090.9276@xps-7390> <20200619074233.GA3723@lst.de>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 19 Jun 2020, Christoph Hellwig wrote:

> Just to re-reconfirm, you had to
> revert "maccess: rename probe_kernel_address to get_kernel_nofault",
> "maccess: make get_kernel_nofault() check for minimal type compatibility"
> wasn't enough?

Yeah. the bisect turned up the commit in the subject: and reverting it
(only) stopped the crashes. This was this afternoon's (US PST) Linus' master.

> Below is a patch to do a "partial revert" for probe_roms.c.

I'll give it a shot later, thanks.

	-Kenny

-- 
Kenneth R. Crudup  Sr. SW Engineer, Scott County Consulting, Orange County CA
