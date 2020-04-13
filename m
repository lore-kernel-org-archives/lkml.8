Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC27C2BBFD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 00:29:47 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F142072D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 00:29:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01F142072D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726866AbgDMA3p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 20:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726185AbgDMA3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 20:29:45 -0400
Received: from smtprelay.hostedemail.com (smtprelay0040.hostedemail.com [216.40.44.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBE9C0A3BE0;
        Sun, 12 Apr 2020 17:29:45 -0700 (PDT)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 93A90181D337B;
        Mon, 13 Apr 2020 00:29:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: offer33_72017b532ee55
X-Filterd-Recvd-Size: 2330
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Mon, 13 Apr 2020 00:29:43 +0000 (UTC)
Message-ID: <8194c2197b9d57f6c37cc6417c9dc9b310732e6b.camel@perches.com>
Subject: Re: linux-next: manual merge of the realtek tree with Linus' tree
From:   Joe Perches <joe@perches.com>
To:     Andreas =?ISO-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>
Date:   Sun, 12 Apr 2020 17:27:36 -0700
In-Reply-To: <dbdc1f6b-faf8-7d0d-7730-4ae3f5610dde@suse.de>
References: <20200413085034.5e77f236@canb.auug.org.au>
         <dbdc1f6b-faf8-7d0d-7730-4ae3f5610dde@suse.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-13 at 02:22 +0200, Andreas Färber wrote:
> Hi,
> 
> Am 13.04.20 um 00:50 schrieb Stephen Rothwell:
> > Today's linux-next merge of the realtek tree got a conflict in:
> > 
> >    MAINTAINERS
> > 
> > between commit:
> > 
> >    3b50142d8528 ("MAINTAINERS: sort field names for all entries")
> > 
> > from Linus' tree and commit:
> > 
> >    d6656fa4c621 ("ARM: Prepare Realtek RTD1195")
> > 
> > from the realtek tree.
> 
> Already fixed on v5.8/soc but not yet merged into for-next - done now.

Hello Andreas.

One of the lines changed was from 2017.

d6656fa4 (Andreas Färber     2017-10-05 03:59:15 +0200 2263) F: arch/arm/mach-realtek/

Is that commit ever going forward?

commit d6656fa4c6215b293d23ed7242ced83a2fce1fec
Author: Andreas Färber <afaerber@suse.de>
Date:   Thu Oct 5 03:59:15 2017 +0200

    ARM: Prepare Realtek RTD1195
    
    Introduce ARCH_REALTEK Kconfig option also for 32-bit Arm.
    
    Override the text offset to cope with boot ROM occupying first 0xa800
    bytes and further reservations up to 0xf4000 (compare Device Tree).
    
    Add a custom machine_desc to enforce memory carveout for I/O registers.
    
    Signed-off-by: Andreas Färber <afaerber@suse.de>


