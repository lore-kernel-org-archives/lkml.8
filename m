Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFD0C54E4B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:56:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED573206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731422AbgEKT4P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 15:56:15 -0400
Received: from smtprelay0098.hostedemail.com ([216.40.44.98]:47656 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729049AbgEKT4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 15:56:12 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 820CC837F253;
        Mon, 11 May 2020 19:56:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fall43_8d37d983a5062
X-Filterd-Recvd-Size: 1590
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Mon, 11 May 2020 19:56:10 +0000 (UTC)
Message-ID: <df390f30d2cca58bad013196b443f82e048c528c.camel@perches.com>
Subject: Re: [PATCH] Revert "dynamic_debug: Remove unnecessary __used"
From:   Joe Perches <joe@perches.com>
To:     Elliot Berman <eberman@codeaurora.org>,
        Jason Baron <jbaron@akamai.com>
Cc:     Trilok Soni <tsoni@codeaurora.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Murali Nalajala <mnalajal@codeaurora.org>
Date:   Mon, 11 May 2020 12:56:09 -0700
In-Reply-To: <9b6694ac-acb3-6bc4-49c9-39ad1c64d6e1@codeaurora.org>
References: <1589221618-21808-1-git-send-email-eberman@codeaurora.org>
         <59b3e2aac1388209d168a31294dfd2b1f7d21513.camel@perches.com>
         <9b6694ac-acb3-6bc4-49c9-39ad1c64d6e1@codeaurora.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-05-11 at 12:31 -0700, Elliot Berman wrote:
> On 5/11/2020 11:54 AM, Joe Perches wrote> Change-Id: probably isn't necessary.
> 
> Thanks for the catch
> 
> > Is there a separate mechanism possible to avoid bloating the
> > otherwise unused content?
> 
> This struct is being used in lib/dynamic_debug.c but compiler doesn't know
> about this usage when optimizing the struct/branch away.

I only remember that I removed __used awhile ago
because it _wasn't_ used in some paths.

Maybe that's changed, but I don't know.


