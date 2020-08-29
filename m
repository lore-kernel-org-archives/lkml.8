Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F02C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 19:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D07C72076D
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 19:38:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728491AbgH2TiR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 15:38:17 -0400
Received: from smtprelay0236.hostedemail.com ([216.40.44.236]:57094 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728370AbgH2TiR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 15:38:17 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id E46C9181D337B;
        Sat, 29 Aug 2020 19:38:15 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: baby09_0a1426127080
X-Filterd-Recvd-Size: 1712
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Sat, 29 Aug 2020 19:38:14 +0000 (UTC)
Message-ID: <489164b541e344f254b70429e4f6d467e1602931.camel@perches.com>
Subject: Re: [RFC PATCH] coccinelle: misc: add uninitialized_var.cocci script
From:   Joe Perches <joe@perches.com>
To:     Julia Lawall <julia.lawall@inria.fr>,
        Denis Efremov <efremov@linux.com>
Cc:     cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org,
        Kees Cook <keescook@chromium.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
Date:   Sat, 29 Aug 2020 12:38:13 -0700
In-Reply-To: <alpine.DEB.2.22.394.2008292133360.3629@hadrien>
References: <20200811210127.11889-1-efremov@linux.com>
         <alpine.DEB.2.22.394.2008292133360.3629@hadrien>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-08-29 at 21:36 +0200, Julia Lawall wrote:
> 
> On Wed, 12 Aug 2020, Denis Efremov wrote:
> 
> > Commit 63a0895d960a ("compiler: Remove uninitialized_var() macro") and
> > commit 4b19bec97c88 ("docs: deprecated.rst: Add uninitialized_var()")
> > removed uninitialized_var() and deprecated it.
> > 
> > The purpose of this script is to prevent new occurrences of open-coded
> > variants of uninitialized_var().

> > Cc: Kees Cook <keescook@chromium.org>
> > Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
> > Signed-off-by: Denis Efremov <efremov@linux.com>
> 
> Applied, without the commented out part.
> 
> I only got three warnings, though.  Perhaps the others have been fixed?

uninitialized_var does not exist in -next


