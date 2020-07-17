Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF4EDC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:58:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 979AD206BE
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:58:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgGQR6l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 13:58:41 -0400
Received: from smtprelay0060.hostedemail.com ([216.40.44.60]:57412 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726322AbgGQR6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 13:58:40 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id A4DDB180A7FCE;
        Fri, 17 Jul 2020 17:58:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: board51_1313e3626f0c
X-Filterd-Recvd-Size: 2673
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Fri, 17 Jul 2020 17:58:38 +0000 (UTC)
Message-ID: <97fc1ed63f4b4d1b6b450acf0cfc2dcad84e9ca1.camel@perches.com>
Subject: Re: [PATCH 3/3] media: Add support for the AM/FM radio chip KT0913
 from KT Micro.
From:   Joe Perches <joe@perches.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Santiago Hormazabal <santiagohssl@gmail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-kernel@vger.kernel.org
Date:   Fri, 17 Jul 2020 10:58:37 -0700
In-Reply-To: <234961cc-f783-475c-d3db-69720a7da010@xs4all.nl>
References: <20200717004441.116248-1-santiagohssl@gmail.com>
         <20200717004441.116248-4-santiagohssl@gmail.com>
         <b8cb9dbf-2a81-6a12-c754-e524f42a0574@xs4all.nl>
         <9bd42f458908eedd810c5e8805f997997763d32a.camel@perches.com>
         <234961cc-f783-475c-d3db-69720a7da010@xs4all.nl>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-07-17 at 12:04 +0200, Hans Verkuil wrote:
> On 17/07/2020 11:51, Joe Perches wrote:
> > On Fri, 2020-07-17 at 11:29 +0200, Hans Verkuil wrote:
> > > It's standard linux codingstyle to use lowercase for hex numbers.
> > > Can you change that throughout the source for the next version?
> > 
> > Is there a standard?  It's not in coding-style.rst.
> > 
> > While I prefer lowercase too, it seems the kernel has
> > only ~2:1 preference for lowercase to uppercase hex.
> > 
> > $ git grep -ohP '\b0[xX][0-9a-f]+\b' | grep [a-f] | wc -l
> > 1149833
> > $ git grep -ohP '\b0[xX][0-9A-F]+\b' | grep [A-F] | wc -l
> > 575781
> > 
> Well, it's indeed not a standard for the kernel as a whole, but certainly
> for drivers/media:
> 
> $ git grep -ohP '\b0[xX][0-9a-f]+\b' drivers/media/ | grep [a-f] | wc -l
> 109272
> $ git grep -ohP '\b0[xX][0-9A-F]+\b' drivers/media/ | grep [A-F] | wc -l
> 22392
> 
> The media subsystem has a 5:1 preference for lowercase. And uppercase is
> mostly found in older drivers.
> Still, I really prefer lowercase over uppercase, especially in new drivers.

That's certainly any maintainer's preference right.

Slightly unrelated:

The last 100k commits have only a ~2.5:1 use of
lowercase to uppercase hex constants.

While my cut-off for declaring something a generic
kernel style standard is also ~5:1, this isn't a
style check I would put into checkpatch as the
per-subsystem variability is quite high.

cheers, Joe

