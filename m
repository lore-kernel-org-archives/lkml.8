Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742A4C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E9352070A
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 17:38:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgEORiZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 13:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726191AbgEORiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 13:38:25 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22546C061A0C;
        Fri, 15 May 2020 10:38:25 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 82EBD736;
        Fri, 15 May 2020 17:38:24 +0000 (UTC)
Date:   Fri, 15 May 2020 11:38:23 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Waiman Long <longman@redhat.com>, Tony Luck <tony.luck@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        James Morse <james.morse@arm.com>,
        Robert Richter <rrichter@marvell.com>,
        linux-edac@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] doc: Fix some errors in ras.rst
Message-ID: <20200515113823.73172bff@lwn.net>
In-Reply-To: <20200506163715.GM16070@bombadil.infradead.org>
References: <20200506162217.16633-1-longman@redhat.com>
        <20200506163715.GM16070@bombadil.infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 May 2020 09:37:15 -0700
Matthew Wilcox <willy@infradead.org> wrote:

> On Wed, May 06, 2020 at 12:22:17PM -0400, Waiman Long wrote:
> > Make some miscellaneous fixes to the first paragraph of "ECC memory":
> >  - Change the incorrect "74 bits" to "72 bits".
> >  - Change "mentioned on" to "mentioned in".
> >  - Remove the extra "extra".
> >  - Rephrase some sentences as suggested by Matthew Wilcox.
> > 
> > Signed-off-by: Waiman Long <longman@redhat.com>  
> 
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
Applied, thanks.

jon
