Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F02C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 01:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D682220752
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 01:24:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgCSBYX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 21:24:23 -0400
Received: from smtprelay0117.hostedemail.com ([216.40.44.117]:52480 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726596AbgCSBYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 21:24:23 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 246F82C6D;
        Thu, 19 Mar 2020 01:24:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fork59_8ba5e05ec15f
X-Filterd-Recvd-Size: 1916
Received: from XPS-9350 (unknown [172.58.27.183])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Thu, 19 Mar 2020 01:24:19 +0000 (UTC)
Message-ID: <7584d7937f4bb929beb0b9f5e80523653297676d.camel@perches.com>
Subject: Re: [PATCH -next 016/491] KERNEL VIRTUAL MACHINE FOR POWERPC
 (KVM/powerpc): Use fallthrough;
From:   Joe Perches <joe@perches.com>
To:     Paul Mackerras <paulus@ozlabs.org>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Wed, 18 Mar 2020 18:22:29 -0700
In-Reply-To: <20200319011840.GA5033@blackberry>
References: <cover.1583896344.git.joe@perches.com>
         <37a5342c67e1b68b9ad06aca8da245b0ff409692.1583896348.git.joe@perches.com>
         <20200319011840.GA5033@blackberry>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-03-19 at 12:18 +1100, Paul Mackerras wrote:
> On Tue, Mar 10, 2020 at 09:51:30PM -0700, Joe Perches wrote:
> > Convert the various uses of fallthrough comments to fallthrough;
> > 
> > Done via script
> > Link: https://lore.kernel.org/lkml/b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe.com/
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> 
> The subject line should look like "KVM: PPC: Use fallthrough".

There's no way to generate a subject line like that via a script
so far as I can tell.

> Apart from that,
> 
> Acked-by: Paul Mackerras <paulus@ozlabs.org>
> 
> How are these patches going upstream?  Do you want me to take this via
> my tree?

If you want.

Ideally, these changes would go in treewide via a script run
by Linus at an -rc1, but if the change is OK with you, it'd
be fine to have you apply it now.

cheers, Joe



