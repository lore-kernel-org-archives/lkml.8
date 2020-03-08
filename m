Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BF90C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 19:46:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1526120675
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 19:46:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgCHTq0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 15:46:26 -0400
Received: from smtprelay0161.hostedemail.com ([216.40.44.161]:49848 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726318AbgCHTq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 15:46:26 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id D4B57182CED2A;
        Sun,  8 Mar 2020 19:46:24 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: drop48_721bcbfa29e4f
X-Filterd-Recvd-Size: 2473
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Sun,  8 Mar 2020 19:46:24 +0000 (UTC)
Message-ID: <b934b12940ab50218be3b7c5d1b98f5d4f24a1fd.camel@perches.com>
Subject: Re: [PATCH] cvt_fallthrough: A tool to convert /* fallthrough */
 comments to fallthrough;
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     clang-built-linux@googlegroups.com
Date:   Sun, 08 Mar 2020 12:44:44 -0700
In-Reply-To: <7a0a3e7b-9c76-22f8-8dbf-acd9960d7950@embeddedor.com>
References: <b56602fcf79f849e733e7b521bb0e17895d390fa.1582230379.git.joe@perches.com>
         <576fe2ab-7937-4698-b32a-8599813d6ad1@embeddedor.com>
         <4304de54a44b7c8c22d8c2d9249d716664cf5ce8.camel@perches.com>
         <6773b7e3-8ce4-55d1-8bb7-bde6d9f6e887@embeddedor.com>
         <259f405155a948f90229d3fc8cad928d434b46f9.camel@perches.com>
         <1f71509d-6c58-412d-a817-45b1cc78c06e@embeddedor.com>
         <18d7df753cb90d6c6f5a6b5e2a12b4c102ac8749.camel@perches.com>
         <7a0a3e7b-9c76-22f8-8dbf-acd9960d7950@embeddedor.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-03-08 at 14:14 -0500, Gustavo A. R. Silva wrote:
> 
> On 3/8/20 03:58, Joe Perches wrote:
> > On Sun, 2020-03-08 at 01:11 -0600, Gustavo A. R. Silva wrote:
> > > On 3/8/20 01:02, Joe Perches wrote:
> > > > > or if you are suggesting that
> > > > > the maintainers will have the predisposition of applying
> > > > > patches that will modify their coding style and then go and
> > > > > willingly fix that. I doubt the latter, though.
> > > > 
> > > > If any do actually use the script, I guess we'll see.
> > > > 
> > > Yep. In the meantime is a NACK from me for this version
> > > of your patch.
> > 
> > Generic code reformatters of comments to code are not
> > particularly common.
> > 
> 
> It's no a matter of
> reformatting something. It's the opposite, it's a matter of
> not messing (removing existing blank lines) with the current
> format and merely focusing on replacing comments.

You are not correct in your assumption.

This is precisely reformatting of comments to code.

Nor are you correct in what appears to be your
general point.  It's quite fine to reformat comments
for consistency.


