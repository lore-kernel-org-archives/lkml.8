Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5B6C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 06:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53F8D20747
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 06:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592114719;
	bh=gjtaa0VNN3qmgf1nzWIgFU7LxaP664Sux0mY1hwad9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=h1gJSSNI577kCu7vOdQGpD9JECb27JDpNKxh6mg9MGcR8E/eqmzua1CDMz65R7RV1
	 JuroOGzrB5qIFqyYvG1Ph2fcy2EK/E+RAfbelNaZfTQ5n5uddrbikBQYJwW+XByCCz
	 ayIY5ap/qrs6se14XTNGARC5hNsMrSRIVf0v68vE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbgFNGEG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 02:04:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:38124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725265AbgFNGEG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 02:04:06 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DCFD2068E;
        Sun, 14 Jun 2020 06:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592114646;
        bh=gjtaa0VNN3qmgf1nzWIgFU7LxaP664Sux0mY1hwad9U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=g/WYkX3OKj70Bo1wYRWeIfvijunID8FYXL962nn9JUwQO4GcsVykMV6BRcTWuYLIK
         +HFcuHsMMiCN7oYg9PwLIk9zuHUQkcO4zT4S8/4idvaK4Ger5FD6IfYInHbumF5P0e
         bIHRVzAsduxwX+JAS8VsNwM1mFr/3W5fKSwbM0RY=
Date:   Sun, 14 Jun 2020 08:04:01 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jim Cromie <jim.cromie@gmail.com>
Cc:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, linux@rasmusvillemoes.dk,
        Jonathan Corbet <corbet@lwn.net>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Orson Zhai <orson.zhai@unisoc.com>,
        Petr Mladek <pmladek@suse.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 01/24] dyndbg-docs: eschew file /full/path query in
 docs
Message-ID: <20200614060401.GA2608744@kroah.com>
References: <20200613155738.2249399-1-jim.cromie@gmail.com>
 <20200613155738.2249399-2-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200613155738.2249399-2-jim.cromie@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 13, 2020 at 09:57:15AM -0600, Jim Cromie wrote:
> Regarding:
> commit 2b6783191da7 ("dynamic_debug: add trim_prefix() to provide source-root relative paths")
> commit a73619a845d5 ("kbuild: use -fmacro-prefix-map to make __FILE__ a relative path")
> 
> 2nd commit broke dynamic-debug's "file $fullpath" query form, but
> nobody noticed because 1st commit had trimmed prefixes from
> control-file output, so the click-copy-pasting of fullpaths into new
> queries had ceased; that query form became unused.
> 
> Removing the function is cleanest, but it could be useful in
> old-compiler corner cases, where __FILE__ still has /full/path,
> and it safely does nothing otherwize.
> 
> So instead, quietly deprecate "file /full/path" query form, by
> removing all /full/paths examples in the docs.  I skipped adding a
> back-compat note.
> ---
>  .../admin-guide/dynamic-debug-howto.rst       | 19 +++++++++----------
>  1 file changed, 9 insertions(+), 10 deletions(-)

None of your patches have a signed-off-by line so they can't be applied
anywhere :(
