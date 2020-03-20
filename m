Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D44BC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 23:47:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A402072C
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 23:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbgCTXrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 19:47:42 -0400
Received: from smtprelay0082.hostedemail.com ([216.40.44.82]:38320 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726773AbgCTXrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 19:47:42 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave05.hostedemail.com (Postfix) with ESMTP id 680DC1828B307;
        Fri, 20 Mar 2020 23:47:41 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 948CC18224D60;
        Fri, 20 Mar 2020 23:47:40 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: party49_8ab4ee1cae54
X-Filterd-Recvd-Size: 1785
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Fri, 20 Mar 2020 23:47:39 +0000 (UTC)
Message-ID: <eb9037a20c81b189468eee3e4849f2707b49278e.camel@perches.com>
Subject: Re: [PATCH] coding-style.rst: Add fallthrough as an emacs keyword
From:   Joe Perches <joe@perches.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Federico Vaga <federico.vaga@vaga.pv.it>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 20 Mar 2020 16:45:51 -0700
In-Reply-To: <20200320173119.2707c083@lwn.net>
References: <7a2977ea9baacd1580ff80689f2c8f20d45b069d.camel@perches.com>
         <20200320173119.2707c083@lwn.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-03-20 at 17:31 -0600, Jonathan Corbet wrote:
> On Sat, 14 Mar 2020 14:13:59 -0700
> Joe Perches <joe@perches.com> wrote:
> 
> > fallthrough was added as a pseudo-keyword by commit 294f69e662d1
> > ("compiler_attributes.h: Add 'fallthrough' pseudo keyword for switch/case use")
> > 
> > Add fallthrough as a keyword to the example .emacs content
> > so emacs can colorize or highlight the uses.
> > 
> > Signed-off-by: Joe Perches <joe@perches.com>
> > ---
> > 
> > I've no idea how to remove the infinite monkeys jibe from the chinese translation
> 
> Removing the "jibe" is a second change for this patch, and one which is
> not reflected in the changelog.  If we want to sanitize the docs that's
> something we can talk about, but I don't want to sneak such changes in.

And I don't want to bother with the naysayers.


