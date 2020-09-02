Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA82BC433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 20:14:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A81C12083B
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 20:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Qwf6X/kG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgIBUOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 16:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgIBUN6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 16:13:58 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D335EC061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 13:13:57 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id w186so1005315qkd.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 13:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VtKLlAudRnA2vKDoZNQw5csEIPXvQwIKm3VyTbaIKFY=;
        b=Qwf6X/kGgSmY9tKp7Kmk3c8MgxIjvqFpEQAe+tb1+XOXXgvyehDPKeYG7dZ/Yg3IX6
         htTDkWFcqvo513Hi/a7qgs846lJoqXVAXRLY91hdU61Y6OJwM73W0pMKYYASAJzRG86+
         Dg/4lQzFDbgl69fZkKJw7LZwiwF3cwnrxKfHjCVxdDezuLssdPD1RCUPY998/GHXvD66
         vXdCC47ctdTSW43mZLLck7PEVdwrveAum6OrxzF6kuLEFcjT+1LtRvd1cwQbcz8kXeCO
         1YqtVf246V4JoEYZACerGXbT/EI/gGjAeg6BCbC2etnr610vhlV/2Mf9s7fG3C/sl3Zf
         cwzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VtKLlAudRnA2vKDoZNQw5csEIPXvQwIKm3VyTbaIKFY=;
        b=jMBew3d6EqurLalpRfA3SNWid1byjuLbpo+9z7eHaQLowdTHaGnNeptGvPgHjmJAjG
         R5KfMUKQDDV7KI9kS7JRbFw8EMzX86P99culhyd+YJa3Htmtsb6KM/+HRTHBwxCu0M6e
         IQKQKxJ1/hotcNpfXKsqzUQpWXZC7Li/5dZtKAYN/5toLM2UxJGMWAZsyg2KPTpCDVRS
         nsvcy+ZpeZ/SyMO4o1uCWsWOs5cIafz4BmaBydmF3pvHxVUti/rawola0/4df7KaloNM
         pWaYRKQvKAczeBDseOgexiD50JdLadbnA+Pg2DNaBr5wT/lVpVJ8UlVojOY/5LQnCxIu
         exvw==
X-Gm-Message-State: AOAM533aw7ehg+1yeLhSyiwu1xcRhJgc5f7K7aMUKBKWQSDUyUbiosW/
        PxYkbn5qg1xKmisln/fzsAFKpw==
X-Google-Smtp-Source: ABdhPJxP9sYQMnp7dADWRBTcdNFumTmUhJGfW+FF9H/GSd4vNcNPJ3p18WOwE1ej6gXtP23Bzcc3NA==
X-Received: by 2002:a37:a484:: with SMTP id n126mr8834583qke.5.1599077636904;
        Wed, 02 Sep 2020 13:13:56 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id g18sm347980qtu.69.2020.09.02.13.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2020 13:13:56 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kDZ8l-0068s3-Em; Wed, 02 Sep 2020 17:13:55 -0300
Date:   Wed, 2 Sep 2020 17:13:55 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [RFC PATCH 0/2] mm/gup: fix gup_fast with dynamic page table
 folding
Message-ID: <20200902201355.GJ24045@ziepe.ca>
References: <20200828140314.8556-1-gerald.schaefer@linux.ibm.com>
 <9071c9fa-ba6a-90dc-2d7a-8b155141d890@de.ibm.com>
 <20200831121553.8be5dcdbdbc5256846ac513e@linux-foundation.org>
 <20200901194020.418da486@thinkpad>
 <91988792-069c-31a6-7840-0122357538c7@nvidia.com>
 <20200902142437.5f39b4bb@thinkpad>
 <20200902170958.09be0c3e@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902170958.09be0c3e@thinkpad>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 05:09:58PM +0200, Gerald Schaefer wrote:
> I guess we *could* assume that all the extra pXd_offset() calls and
> also the de-referencing would be optimized out by the compiler for other
> archs, but it is one example where my gut tells me that this might not
> be so trivial and w/o unwanted effects after all.

Assigning to a variable that is never read should be eliminated.. If
things are very complex then the pXX_offset function might need to be
marked with attribute pure, but I think this should be reliable?

Jason
