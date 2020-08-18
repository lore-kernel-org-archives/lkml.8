Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9619DC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:52:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B10020786
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 16:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgHRQwY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 12:52:24 -0400
Received: from smtprelay0107.hostedemail.com ([216.40.44.107]:51764 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726840AbgHRQwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 12:52:23 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 2A3AF18029210;
        Tue, 18 Aug 2020 16:52:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: join51_5b0c31127020
X-Filterd-Recvd-Size: 1694
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Tue, 18 Aug 2020 16:52:21 +0000 (UTC)
Message-ID: <15980e07c369b2cbfc7b06f58f3a521a5495bdf6.camel@perches.com>
Subject: Re: [PATCH] clang-format: Fix: Maximum line length is now 100
From:   Joe Perches <joe@perches.com>
To:     Alex Dewar <alex.dewar90@gmail.com>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Date:   Tue, 18 Aug 2020 09:52:20 -0700
In-Reply-To: <20200818162431.696423-1-alex.dewar90@gmail.com>
References: <20200818162431.696423-1-alex.dewar90@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-08-18 at 17:24 +0100, Alex Dewar wrote:
> Since commit bdc48fa11e46 ("checkpatch/coding-style: deprecate 80-column
> warning") the kernel style is now for lines to be a maximum of 100 rather
> than 80 columns. Update .clang-format accordingly.
[]
> diff --git a/.clang-format b/.clang-format
[]
> @@ -52,7 +52,7 @@ BreakConstructorInitializersBeforeComma: false
>  #BreakConstructorInitializers: BeforeComma # Unknown to clang-format-4.0
>  BreakAfterJavaFieldAnnotations: false
>  BreakStringLiterals: false
> -ColumnLimit: 80
> +ColumnLimit: 100

No thank you.

100 is used for exceptional line length, not
for reformatting all lines up to 100 chars.

See the previous discussion about the same patch
submitted earlier in June:

https://lore.kernel.org/lkml/20200610125147.2782142-1-christian.brauner@ubuntu.com/


