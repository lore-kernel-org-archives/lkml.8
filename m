Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB64C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 12:49:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5513620899
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 12:49:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qXX0f0LO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgGCMts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 08:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbgGCMtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 08:49:47 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F92EC08C5C1;
        Fri,  3 Jul 2020 05:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VMSzCqiPU0UwJ1IxHxA0ouN7RVM3z3sQz/cKALPThE8=; b=qXX0f0LOoxo/HMlK+xkEsj19uj
        ZBGcv1f03nhihT/+45lxEYy7mXw1jsKBmMf8bqC9GDB4wrVcvD4A05WeZUC6zTZ4v04wNki5LiZt3
        suIpPJaVUQmgcS3dfP9yvXrw4WEX6/jeegsNlN47b20YG3XXFexSGoeQoa1rabELibqOJww9vsOZN
        AyMmFfWkp8oVs8QlyyJvXLTC9254GjtlmeboD1IgK/upsCAC834Qd1Q40AmsmFLklWNwpQfmfz/OC
        xdAvnpEvW9crxlRulpYs87eJW2qcP9iggcQStDMa9VbNh87SGEIlk+SwC0GenNn4yVk/29oq8B3mN
        QszlCi4A==;
Received: from willy by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrL8N-0002iY-H2; Fri, 03 Jul 2020 12:49:39 +0000
Date:   Fri, 3 Jul 2020 13:49:39 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Danny Lin <danny@kdrag0n.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] editorconfig: Add automatic editor configuration file
Message-ID: <20200703124939.GG25523@casper.infradead.org>
References: <16043769.gqpzGLO8mG@pinwheel>
 <20200703073143.423557-1-danny@kdrag0n.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200703073143.423557-1-danny@kdrag0n.dev>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 12:31:43AM -0700, Danny Lin wrote:
> +# This avoids introducing too many unnecessary changes in trivial commits
> +trim_trailing_whitespace = false

I think we prefer trailing whitespace to be trimmed, even for trivial commits.

> +# General 4-space files
> +[*.{pl,pm,py,tc,json,tc}]
> +indent_style = space
> +indent_size = 4
> +
> +# General 2-space files
> +[*.{rb,rst,yaml,cocci,xsl,svg,bconf,clang-format}]
> +indent_style = space
> +indent_size = 2

The rst files I've seen either use tabs or three spaces for indent.
Where did this 2 come from?

