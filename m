Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37189C433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 03:23:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 181C5205CB
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 03:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728126AbgGPDXf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 23:23:35 -0400
Received: from smtprelay0082.hostedemail.com ([216.40.44.82]:46076 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726960AbgGPDXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 23:23:35 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 5037F181D341E;
        Thu, 16 Jul 2020 03:23:34 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pump70_0116adc26efe
X-Filterd-Recvd-Size: 2024
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Thu, 16 Jul 2020 03:23:32 +0000 (UTC)
Message-ID: <04d15af886da8c91309134b67c0d3e8d69089188.camel@perches.com>
Subject: Re: [PATCH] SUNDANCE NETWORK DRIVER: Replace HTTP links with HTTPS
 ones
From:   Joe Perches <joe@perches.com>
To:     Jakub Kicinski <kuba@kernel.org>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     kda@linux-powerpc.org, davem@davemloft.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 15 Jul 2020 20:23:31 -0700
In-Reply-To: <20200715174437.04890794@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
References: <20200709204925.27287-1-grandmaster@al2klimov.de>
         <20200715174437.04890794@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-07-15 at 17:44 -0700, Jakub Kicinski wrote:
> On Thu,  9 Jul 2020 22:49:25 +0200 Alexander A. Klimov wrote:
> > Rationale:
> > Reduces attack surface on kernel devs opening the links for MITM
> > as HTTPS traffic is much harder to manipulate.
> > 
> > Deterministic algorithm:
> > For each file:
> >   If not .svg:
> >     For each line:
> >       If doesn't contain `\bxmlns\b`:
> >         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> > 	  If neither `\bgnu\.org/license`, nor `\bmozilla\.org/MPL\b`:
> >             If both the HTTP and HTTPS versions
> >             return 200 OK and serve the same content:
> >               Replace HTTP with HTTPS.
> > 
> > Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> 
> Applied to net-next, but please find a better algorithm for generating
> the subject prefixes. 

Suggestions welcomed for automating patch subject prefixes
for generic treewide conversions by subsystem.

git history doesn't work particularly well for that.



