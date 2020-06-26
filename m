Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00580C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC39620B1F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:01:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725882AbgFZWBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 18:01:35 -0400
Received: from smtprelay0204.hostedemail.com ([216.40.44.204]:42576 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725803AbgFZWBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 18:01:35 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id E4384837F24A;
        Fri, 26 Jun 2020 22:01:33 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: silk04_4e0f1b526e58
X-Filterd-Recvd-Size: 2139
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Fri, 26 Jun 2020 22:01:32 +0000 (UTC)
Message-ID: <58f25e61b285362ab28d14ac55d1cd632c460fa8.camel@perches.com>
Subject: Re: [PATCH v2] Replace HTTP links with HTTPS ones: Documentation/arm
From:   Joe Perches <joe@perches.com>
To:     Jonathan Corbet <corbet@lwn.net>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     mchehab+samsung@kernel.org, alexandre.belloni@bootlin.com,
        nicolas.ferre@microchip.com, robh@kernel.org,
        j.neuschaefer@gmx.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 26 Jun 2020 15:01:31 -0700
In-Reply-To: <20200626150911.3d4f9ca7@lwn.net>
References: <20200626194408.61245-1-grandmaster@al2klimov.de>
         <20200626150911.3d4f9ca7@lwn.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-06-26 at 15:09 -0600, Jonathan Corbet wrote:
> On Fri, 26 Jun 2020 21:44:08 +0200
> "Alexander A. Klimov" <grandmaster@al2klimov.de> wrote:
> 
> > Rationale:
> > Reduces attack surface on kernel devs opening the links for MITM
> > as HTTPS traffic is much harder to manipulate.
[]
> >  Changes in v2:
> >  Undone all handhelds.org changes and 0 of 0 wearablegroup.org changes.
> 
> I wasn't asking that the changes be undone, I was asking that those links
> simply be removed.  They are actively harmful - much more so than any http:
> links - and shouldn't be there.  *Sigh*.  I guess I'll just do that.

One argument to mark old/invalid links differently somehow is
that the wayback machine at archive.org may still have them.

But when the domain has been transferred to a 3rd party, it is
possibly harmful.

Another option might be to grab any archive.org content and
put it into a Documentation/archived/outdated directory or
the like.

For instance:

https://web.archive.org/web/20090423133742/http://www.handhelds.org/projects/h1940.html

Then gain, this might as well be prehistoric content.

