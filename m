Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A62D6C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 18:24:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C70C20776
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 18:24:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389240AbgEYSYc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 14:24:32 -0400
Received: from smtprelay0220.hostedemail.com ([216.40.44.220]:57382 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387644AbgEYSYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 14:24:31 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id D8289837F24A;
        Mon, 25 May 2020 18:24:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: boy42_4301fb626d43
X-Filterd-Recvd-Size: 1665
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Mon, 25 May 2020 18:24:29 +0000 (UTC)
Message-ID: <7b93effe211b5439b6b8697e8ed3a2b070bfbb31.camel@perches.com>
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: documentation
From:   Joe Perches <joe@perches.com>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 25 May 2020 11:24:28 -0700
In-Reply-To: <0b3b5ae5-457a-b550-63a8-08a77bb862d7@al2klimov.de>
References: <20200520200037.88705-1-grandmaster@al2klimov.de>
         <20200525102825.63d72ed2@lwn.net>
         <0b3b5ae5-457a-b550-63a8-08a77bb862d7@al2klimov.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-05-25 at 20:01 +0200, Alexander A. Klimov wrote:
> Does it matter whether I just feed the output of ...
> 
> perl scripts/get_maintainer.pl --separator , --norolestats 
> 0001-Replace-HTTP-links-with-HTTPS-ones-documentation.patch
> 
> ... into Git send-email To: prompt or actually CC: (not To:) mailing lists?

Yes.  vger mailing lists drop emails with large to:/cc:
headers (It was >1024 chars, it may be different now)

It's generally better to add --nogit --nogit-fallback to
get_maintainer to avoid the git lookup addition of people
that have modified files that aren't listed in MAINTAINERS.

You could add a --bcc with those dropped names if you
really want to have those people receive the emails.

