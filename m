Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED31C8300A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FBD52078D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 12:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gUmy9IDn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726790AbgD3M45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 08:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726483AbgD3M44 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 08:56:56 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDAFFC035494;
        Thu, 30 Apr 2020 05:56:56 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t16so2212768plo.7;
        Thu, 30 Apr 2020 05:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=wdAvI3LUiwrfy87yREuLPNednn19RW9tCdeasjU7N08=;
        b=gUmy9IDnD49clVIBN/3OEWsI1xjBCVLrFqz7imxdr3r2losZbkBbVhp6M/Igt76Ere
         gppPSSzSF5f/bMZj8HWm0QM58EYMhonSosu8NIG7Rw6MiOdQ7m20lgwGQVqqPEsjYIK+
         AMQb+ObbgEH0Ua7GejCvZxDJVZaGTKMNNUqamzLUfvmhczYAd6kT9xKEKI/JJ38qek5T
         9uyvtzM4ZB4C/yl0lDBjH6r7YLq+Lugys7uxGqSD3BYmtDgACDJlWA9TI87H/mQWEx8C
         QujKVOuPxEo+QGPS51SNipSY7XJf7aD0V0hG42uh7FJMOIV74b7hvxeSKmrP0KV4gG4/
         Imcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=wdAvI3LUiwrfy87yREuLPNednn19RW9tCdeasjU7N08=;
        b=cp0jN18C4Ln2xE4d/SX7mUy7aBIsggq3Kv0yvfOqTMz4cCkVe2PP9T/P/p/DgEdIT5
         324Kx8wCQ2Ao5M1koSMnJYelx7q/7s3f7A1NAjZkIxcABul9w5XbRPFvHsdJTy1GoRGK
         J/tIPMC9iERpeZe7R7NjGe2D8JBoaHBFm4Vcx0qWx32p9/+4YEltg70Efz/PTR986oRg
         DcFs4kpUscYIQvHyUzqTaYrElB4cQvtGZq/Bm6cE7SJKysMau9j/4fmzTddfkvOWpJVn
         iWs7Cnw53zwfkoA+4TeyQzEattS1W8Ic9eFD7V86YdVF/mWEf8OER4jme7bOn/CVonDm
         EICg==
X-Gm-Message-State: AGi0PuZ9iRacPdSza9r03cdngxk8lc8TBn9z5HNwHY/QAo7jaGhuxHhS
        6IXI3jvWmZ1Xt1SAO7E8OlA=
X-Google-Smtp-Source: APiQypJMKCg7VEQEGEHUX1dvUj24J0y6xfNsMXad59jrgTG3CCrz5osVl0OYO2sI/qh4gmFR2/Eh7w==
X-Received: by 2002:a17:902:14b:: with SMTP id 69mr3624171plb.121.1588251416235;
        Thu, 30 Apr 2020 05:56:56 -0700 (PDT)
Received: from udknight.localhost ([59.57.158.27])
        by smtp.gmail.com with ESMTPSA id a16sm3111592pgg.23.2020.04.30.05.56.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Apr 2020 05:56:55 -0700 (PDT)
Received: from udknight.localhost (localhost [127.0.0.1])
        by udknight.localhost (8.14.9/8.14.4) with ESMTP id 03UCuJrl032023;
        Thu, 30 Apr 2020 20:56:19 +0800
Received: (from root@localhost)
        by udknight.localhost (8.14.9/8.14.9/Submit) id 03UCuEeT032019;
        Thu, 30 Apr 2020 20:56:14 +0800
Date:   Thu, 30 Apr 2020 20:56:14 +0800
From:   Wang YanQing <udknight@gmail.com>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>
Subject: Re: [PATCH] checkpatch: add support to check 'Fixes:' tag format
Message-ID: <20200430125614.GA30691@udknight>
Mail-Followup-To: Wang YanQing <udknight@gmail.com>,
        Markus Elfring <Markus.Elfring@web.de>,
        Joe Perches <joe@perches.com>, Andy Whitcroft <apw@canonical.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Matteo Croce <mcroce@redhat.com>
References: <20200429163645.GA13810@udknight>
 <4112ab7e-1f06-d880-e471-084c78bc84d4@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4112ab7e-1f06-d880-e471-084c78bc84d4@web.de>
User-Agent: Mutt/1.7.1 (2016-10-04)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 07:40:21PM +0200, Markus Elfring wrote:
> > “...
> > Do not split the tag across multiple
> > lines, tags are exempt from the "wrap at 75 columns" rule in order to simplify
> > parsing scripts
> > ...”
> 
> Why do you not like the reformatting of the quotation so far
> (if such change descriptions should cope also with specific
> Unicode characters)?
> 
> “…
> Do not split the tag across multiple lines, tags are exempt from
> the "wrap at 75 columns" rule in order to simplify parsing scripts.
> …”
> 
>

Sigh. I will fix it, but I want to hear from Joe Perches before
next patch version.

> 
> > And there is no sanity check for 'Fixes:' tag format in checkpatch the same
> > as GIT_COMMIT_ID for git commit description, so let's expand the GIT_COMMIT_ID
> > to add 'Fixes:' tag format check support.
> 
> I have got the impression that this wording might need another bit
> of fine-tuning.

The current wording is enough I think.

> 
> 
> > +				      "Please use git commit description style '$prefix <12+ chars of sha1> (\"<$title>\")' - ie: '${init_char}" . substr($prefix, 1) . " $id (\"$description\")'\n" . $herecurr);
> 
> I imagine that the support for different quotation characters
> can become helpful, can't it?

No, we don't need to support other quotation character for 'Fixes:' tag
at least now. The submitting-patches.rst tells us the pretty format is:
“...
Fixes: %h (\"%s\")
...”

> 
> Regards,
> Markus

Thanks.
