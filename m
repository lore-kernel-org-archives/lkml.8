Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA5B6C2BB1D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 04:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9787620736
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 04:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgCOE2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 00:28:01 -0400
Received: from smtprelay0200.hostedemail.com ([216.40.44.200]:40474 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725837AbgCOE2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 00:28:01 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 21D5F182CED28;
        Sun, 15 Mar 2020 04:28:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: queen11_45b03e9819604
X-Filterd-Recvd-Size: 1633
Received: from XPS-9350.home (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf02.hostedemail.com (Postfix) with ESMTPA;
        Sun, 15 Mar 2020 04:27:58 +0000 (UTC)
Message-ID: <e8c0df0e7adb53c2e16f5a4f85de9f5a0f627b4f.camel@perches.com>
Subject: Re: [PATCH] coding-style.rst: Add fallthrough as an emacs keyword
From:   Joe Perches <joe@perches.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sat, 14 Mar 2020 21:26:13 -0700
In-Reply-To: <20200315021222.GU22433@bombadil.infradead.org>
References: <7a2977ea9baacd1580ff80689f2c8f20d45b069d.camel@perches.com>
         <20200315021222.GU22433@bombadil.infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-03-14 at 19:12 -0700, Matthew Wilcox wrote:
> On Sat, Mar 14, 2020 at 02:13:59PM -0700, Joe Perches wrote:
> > I've no idea how to remove the infinite monkeys jibe from the chinese translation
> 
> I don't think you should.  That's part of Linus' original text, and I
> don't think it deters contributors.
> 
> > -uses are less than desirable (in fact, they are worse than random
> > -typing - an infinite number of monkeys typing into GNU emacs would never
> > -make a good program).
> > +uses are less than desirable.

It's silly, and moderately offensive,
unrepresentative of the softer, modern Linus.


