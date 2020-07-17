Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D66FC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 487A320684
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 09:51:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726422AbgGQJvV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 05:51:21 -0400
Received: from smtprelay0220.hostedemail.com ([216.40.44.220]:36768 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725864AbgGQJvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 05:51:21 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 860B4182CF66E;
        Fri, 17 Jul 2020 09:51:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: star74_1d16f1b26f09
X-Filterd-Recvd-Size: 1558
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Fri, 17 Jul 2020 09:51:19 +0000 (UTC)
Message-ID: <9bd42f458908eedd810c5e8805f997997763d32a.camel@perches.com>
Subject: Re: [PATCH 3/3] media: Add support for the AM/FM radio chip KT0913
 from KT Micro.
From:   Joe Perches <joe@perches.com>
To:     Hans Verkuil <hverkuil@xs4all.nl>,
        Santiago Hormazabal <santiagohssl@gmail.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        linux-kernel@vger.kernel.org
Date:   Fri, 17 Jul 2020 02:51:18 -0700
In-Reply-To: <b8cb9dbf-2a81-6a12-c754-e524f42a0574@xs4all.nl>
References: <20200717004441.116248-1-santiagohssl@gmail.com>
         <20200717004441.116248-4-santiagohssl@gmail.com>
         <b8cb9dbf-2a81-6a12-c754-e524f42a0574@xs4all.nl>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-07-17 at 11:29 +0200, Hans Verkuil wrote:
> It's standard linux codingstyle to use lowercase for hex numbers.
> Can you change that throughout the source for the next version?

Is there a standard?  It's not in coding-style.rst.

While I prefer lowercase too, it seems the kernel has
only ~2:1 preference for lowercase to uppercase hex.

$ git grep -ohP '\b0[xX][0-9a-f]+\b' | grep [a-f] | wc -l
1149833
$ git grep -ohP '\b0[xX][0-9A-F]+\b' | grep [A-F] | wc -l
575781


