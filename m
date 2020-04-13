Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B52C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88F742072C
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 15:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730556AbgDMPmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 11:42:00 -0400
Received: from smtprelay0053.hostedemail.com ([216.40.44.53]:50396 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728597AbgDMPl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 11:41:58 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 3BC1A18224504;
        Mon, 13 Apr 2020 15:41:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: dolls70_4b08d2e0a8857
X-Filterd-Recvd-Size: 1657
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Mon, 13 Apr 2020 15:41:55 +0000 (UTC)
Message-ID: <ba11f20b35eb1b4fbdcaf353eeec29950146af9f.camel@perches.com>
Subject: Re: [PATCH 1/2] staging: rtl8192u: Refactoring setKey function
From:   Joe Perches <joe@perches.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Camylla Goncalves Cantanheide <c.cantanheide@gmail.com>
Cc:     navid.emamdoost@gmail.com, sylphrenadin@gmail.com,
        nishkadg.linux@gmail.com, stephen@brennan.io,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Date:   Mon, 13 Apr 2020 08:39:48 -0700
In-Reply-To: <20200413125015.GA3077651@kroah.com>
References: <20200413030129.861-1-c.cantanheide@gmail.com>
         <20200413125015.GA3077651@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-13 at 14:50 +0200, Greg KH wrote:
> On Mon, Apr 13, 2020 at 03:01:28AM +0000, Camylla Goncalves Cantanheide wrote:
> > Changes of the local variable value and
> > modification in the seletive repetition structure.
[]
> > diff --git a/drivers/staging/rtl8192u/r8192U_core.c b/drivers/staging/rtl8192u/r8192U_core.c
[]
> You are receiving this message because of the following common error(s)
> as indicated below:
[]
> greg k-h's patch email bot

Hey Greg.

I think I wrote most (all?) of this as a suggestion
to Camylla.

It's a refactoring patch which would be difficult
or impossible to separate into multiple patches.


