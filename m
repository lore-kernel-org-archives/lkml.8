Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC13EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B445220738
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 15:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591197059;
	bh=3MPsv1f0boeVtrXpwRMj3TVYK6WQy/4p6Q+AEX6nQrg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=jdPuwbffmT6IHW4Btd+2MEZB9WXKRsJl2DcWpV8tqP7Eyh73ABXi6R6SDE/iM78CY
	 0tzoD3g95lzfyP6OxQCE8+oHssDrs1Pw8BBzjOyhvC8/bxPxAEt/zlrP8GRdqaQQ2w
	 /ucf0AWzcSU7a3LyiycqgXPlX8m0cAYnCpWSwV2U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgFCPK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 11:10:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:60522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726142AbgFCPK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 11:10:58 -0400
Received: from tzanussi-mobl (c-73-211-240-131.hsd1.il.comcast.net [73.211.240.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 942A4206E6;
        Wed,  3 Jun 2020 15:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591197058;
        bh=3MPsv1f0boeVtrXpwRMj3TVYK6WQy/4p6Q+AEX6nQrg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=qHUJkL/GWdKG8cz+qBXbh+ADpRnxGM4ySLLOdKMvPBlAGU7zPx0qkcwLuy56teSZl
         bRk/idYBxSTuEUyGxGsSAs3zh8L+A+4/ZQZurYYruIuVzORXt094otTQyL+binNDcl
         TS0AkwMhQMOMSURrdzhn/o2gC+QIuG9GkhREhr0g=
Message-ID: <71bcd300a32c0ddde8473625ba81bad3ba6f5dfe.camel@kernel.org>
Subject: Re: linux-next: build failure after merge of the ftrace tree
From:   Tom Zanussi <zanussi@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Date:   Wed, 03 Jun 2020 10:10:56 -0500
In-Reply-To: <20200603174253.60deace5@canb.auug.org.au>
References: <20200603174253.60deace5@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 2020-06-03 at 17:42 +1000, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the ftrace tree, today's linux-next build (htmldocs)
> failed like this:
> 
> 
> Sphinx parallel build error:
> docutils.utils.SystemMessage:
> /home/sfr/next/next/Documentation/trace/histogram-design.rst:219:
> (SEVERE/4) Unexpected section title.
> 
> .
> .
> 
> Caused by commit
> 
>   16b585fe7192 ("tracing: Add histogram-design document")
> 
> I am running a slightly out of date version os sphynx (2.4.3) ...
> 

Apparently sphynx doesn't like my funky ascii-art.  I'll post a patch
fixing this shortly.

Thanks,

Tom

