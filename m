Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 584F2C2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 07:18:05 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 169312076A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 07:18:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 169312076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729180AbgDMHSD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 03:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:58768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbgDMHSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 03:18:02 -0400
Received: from smtprelay.hostedemail.com (smtprelay0112.hostedemail.com [216.40.44.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2E2C008651;
        Mon, 13 Apr 2020 00:18:02 -0700 (PDT)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id 56D5F4DC3;
        Mon, 13 Apr 2020 07:18:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: trees54_28c6c4fb2e643
X-Filterd-Recvd-Size: 2146
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Mon, 13 Apr 2020 07:18:00 +0000 (UTC)
Message-ID: <f1033e80969fce39d9cc97fb924f7d68e5f96f74.camel@perches.com>
Subject: Re: [PATCH] net: mvneta: Fix a typo
From:   Joe Perches <joe@perches.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        thomas.petazzoni@bootlin.com, davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Date:   Mon, 13 Apr 2020 00:15:53 -0700
In-Reply-To: <eea1b700-4559-c8d1-1960-1858ed3d90ef@wanadoo.fr>
References: <20200412212034.4532-1-christophe.jaillet@wanadoo.fr>
         <6ecfa6cb686af1452101c0b727c9eb34d5582610.camel@perches.com>
         <eea1b700-4559-c8d1-1960-1858ed3d90ef@wanadoo.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-13 at 08:56 +0200, Christophe JAILLET wrote:
> Le 12/04/2020 à 23:35, Joe Perches a écrit :
> > On Sun, 2020-04-12 at 23:20 +0200, Christophe JAILLET wrote:
> > > s/mvmeta/mvneta/
> > nice. how did you find this?
> 
> Hi,
> 
> This is based on a bash script I've made a while ago (see [1])
> I've slightly updated it, but the idea is still the same. I search 
> strings in a file with some variation on the file name (2 inverted 
> chars, 1 missing char or 1 modified char).
> 
> The output is horrible, and a lot of filtering should be done.
> It is much like noise, with MANY false positives. But I manage to dig 
> some interesting stuff out of it.
> 
> If interested in the updated script, just ask, but except the concept 
> itself, I'm not sure than anything else worth anything and is should be 
> rewritten from scratch.
> 
> The update includes some tweaks in order to search into Kconfig files 
> instead.
> 
> CJ
> 
> [1]: https://marc.info/?l=kernel-janitors&m=156382201306781&w=4

Nice.

I was wondering if you used levenshtein distance or something else.

https://en.wikipedia.org/wiki/Levenshtein_distance


