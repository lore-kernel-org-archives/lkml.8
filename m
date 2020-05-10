Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2354C54E8A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 12:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7607B214DB
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 12:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iH5BKeNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729037AbgEJM5W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 08:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726863AbgEJM5V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 08:57:21 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319EBC061A0C;
        Sun, 10 May 2020 05:57:21 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id l18so7368647wrn.6;
        Sun, 10 May 2020 05:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zSSzgZJ2ruA4nJC33X8E8VAN7DAGf5BP0u/CxtrtLx0=;
        b=iH5BKeNOhFLBEpN+M/P3twrB0aP0uBQYfQsx6orVfhMPAfupkoxj1N9vtRgJC0jixJ
         mE5Y+zxd1RmH9cCvXLWEilv1cuo2zI8BgW4FfKr05fH7LfqI2U1o14rOEkOg/Med2zSx
         fUKmL+M+KMtyKl3iscMJzpuSaFYRuY6NXTkyfA8JDRsA6tiIKGUBTwx51px5G0EZWqHB
         +EE4M0J39uvcJf11bysbd9Ki3TuxFldI5yD5dJSW17up+hfXpIaP9LThvt/miH3foviA
         iZLJWzYB/gjRqA0cXFjvQfGSALhQ1410H90qVDyxf6RlLdsF/V/S7tD45dexd5JnFktw
         GD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zSSzgZJ2ruA4nJC33X8E8VAN7DAGf5BP0u/CxtrtLx0=;
        b=Lf2KeqBMTn1QiSpUqzVSV6yhdzEyiNnKCuRqwaxOFl9ntu7PKIIGP5vzxvGCQaYg5J
         NuHo3+zO6Q4ne7dMiQCiNl4ohz6YTiu42jqZ6RJFyb9q75KmQnoiRkwXR42sQb38jgGk
         wDeGTZleBgHw/SJicm81l9kjFVusrjYvDWuQokfQWFkSCp33rOqgdsPjY19qH0quHvzW
         jxFfu3W2SC0JbfOOFzPkkZZ8G/huokE1YhMAsWjQyqKm1noboH6RFe9IshZwEO4vESiD
         EvhSIpYdzpD7tDXqRNhpbOVPrpp5zw+VY3r+MYKULxQejnOU19Zi26WfNa5hkW/WOeJC
         YMOg==
X-Gm-Message-State: AGi0PuYyVzCF3JuXHrzKX+VdUOs5E63KjmaVBWzB/LFRIa97OdTTTay/
        w1hVyEofkz8YrAauzwvWjhMzWH5T98pJAFx0
X-Google-Smtp-Source: APiQypKjx9pY0cnYf+p+xvYTLNTeHRZbik4IOpqbrRJPR1SdBS0VXZ7b+XKZMhkQM9rWrm21tJzwpQ==
X-Received: by 2002:a5d:514b:: with SMTP id u11mr13257245wrt.53.1589115439458;
        Sun, 10 May 2020 05:57:19 -0700 (PDT)
Received: from andrea ([86.61.236.197])
        by smtp.gmail.com with ESMTPSA id z11sm12454556wro.48.2020.05.10.05.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2020 05:57:18 -0700 (PDT)
Date:   Sun, 10 May 2020 14:57:11 +0200
From:   Andrea Parri <parri.andrea@gmail.com>
To:     Akira Yokosawa <akiyks@gmail.com>
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linux-kernel@vger.kernel.org, vpillai@digitalocean.com,
        Jonathan Corbet <corbet@lwn.net>,
        Alan Stern <stern@rowland.harvard.edu>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Daniel Lustig <dlustig@nvidia.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/3] tools/memory-model, Documentation/litmus-test: Sort
 out location of litmus test and README
Message-ID: <20200510125711.GA13991@andrea>
References: <20200323015735.236279-1-joel@joelfernandes.org>
 <7809dbfa-7a76-8663-799a-908c4ead8d30@gmail.com>
 <21e1ba24-22d0-8083-770c-53d320ba5420@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <21e1ba24-22d0-8083-770c-53d320ba5420@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Akira Yokosawa (3):
>   tools/memory-model: Fix reference to litmus test in recipes.txt
>   Revert "Documentation: LKMM: Move MP+onceassign+derefonce to new
>     litmus-tests/rcu/"
>   Documentation/litmus-tests: Merge atomic's README into top-level one

For the series:

Acked-by: Andrea Parri <parri.andrea@gmail.com>

Thanks,
  Andrea


> 
>  Documentation/litmus-tests/README             | 22 ++++++++++++++++---
>  Documentation/litmus-tests/atomic/README      | 16 --------------
>  tools/memory-model/Documentation/recipes.txt  |  2 +-
>  .../MP+onceassign+derefonce.litmus            |  0
>  tools/memory-model/litmus-tests/README        |  3 +++
>  5 files changed, 23 insertions(+), 20 deletions(-)
>  delete mode 100644 Documentation/litmus-tests/atomic/README
>  rename {Documentation/litmus-tests/rcu => tools/memory-model/litmus-tests}/MP+onceassign+derefonce.litmus (100%)
> 
> -- 
> 2.17.1
> 
> 
