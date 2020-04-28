Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A034C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 23:17:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F2FB20730
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 23:17:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgD1XRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 19:17:07 -0400
Received: from smtprelay0092.hostedemail.com ([216.40.44.92]:40440 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726386AbgD1XRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 19:17:07 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 35322182CED28;
        Tue, 28 Apr 2020 23:17:06 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: body11_780e320e03c1f
X-Filterd-Recvd-Size: 1981
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf14.hostedemail.com (Postfix) with ESMTPA;
        Tue, 28 Apr 2020 23:17:04 +0000 (UTC)
Message-ID: <a2d7dbae193800ce430321d3fcc71ab5d1a5ed03.camel@perches.com>
Subject: Re: [PATCH v3] checkpatch: add dedicated checker for 'Fixes:' tag
From:   Joe Perches <joe@perches.com>
To:     Wang YanQing <udknight@gmail.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andy Whitcroft <apw@canonical.com>, Markus.Elfring@web.de,
        mcroce@redhat.com
Date:   Tue, 28 Apr 2020 16:17:03 -0700
In-Reply-To: <b452dc29fb553fa5993b90131dcdbc04ed87532e.camel@perches.com>
References: <20200428020223.GA28074@udknight>
         <b452dc29fb553fa5993b90131dcdbc04ed87532e.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-04-28 at 09:10 -0700, Joe Perches wrote:
> On Tue, 2020-04-28 at 10:02 +0800, Wang YanQing wrote:
> > According to submitting-patches.rst, 'Fixes:' tag has a little
> > stricter condition about the one line summary:
> > ...
> > Do not split the tag across multiple
> > lines, tags are exempt from the "wrap at 75 columns" rule in order to simplify
> > parsing scripts
> > ...
> > 
> > And there is no 'Fixes:' tag format checker in checkpatch to check
> > the commit id length too, so let's add dedicated checker to check
> > these conditions for 'Fixes:' tag.
> 
> There's no need to duplicate functionality like this.
> Put this additional Fixes: logic into the existing block.
> 
> (and don't take advise from Markus too seriously when it
> comes to English grammar or wording.  He is not an arbiter
> of taste for this code)
> 

btw:  I suggested this patch last year.

https://lore.kernel.org/lkml/40bfc40958fca6e2cc9b86101153aa0715fac4f7.camel@perches.com/


