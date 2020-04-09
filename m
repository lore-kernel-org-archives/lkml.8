Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDD9C2BA2B
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 15:55:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBA320769
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 15:55:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ojz1e1Z3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgDIPzY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 11:55:24 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39289 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728343AbgDIPzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 11:55:24 -0400
Received: by mail-pf1-f196.google.com with SMTP id k15so4299600pfh.6
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 08:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=kiCvvdS5N1BgUIojOTEeH4J0yc5bPURmyHOSqbSwheM=;
        b=Ojz1e1Z3aFYKuGgs1af/b756Q84wd2aLn1groagKfOx7HLCW5iX5dJZ2zRi6uCzWAi
         2DP8xL7c1qqiq7HvqvAhIMT8LQKaishn5tbrYTetpfFWOjf5B0r4AGdH/S4k/26yK0+x
         JJb8yz3JbBwKw70ytUy2ODjcpIaB3edX0a3MO89mTyI2rN9bTLJDvyyQTxmUJbEPz0C8
         BIpy7p+qhxo5wYNA3M4YBByzsEARRfUt6gkPCvrGVN0T5ABIT2PshQvAU2D1MzKpblmC
         fLdleHXSHnmezWkqtyfExgvD0Su+ua+bdaj868UXpI1+Gc0JakAnyRO7nfCgzFJnD+yx
         DL5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=kiCvvdS5N1BgUIojOTEeH4J0yc5bPURmyHOSqbSwheM=;
        b=sZL6ebRFYKk2H00Iy/9yYKYyy2lm9ptbCi68CfO9lXs33H8TLHbw2nFuF3uEyjJRnF
         RPoqW74B0YlsEXfly5gKg59WVNZRtYSIxxjkdfqu/QLtZRIFqUy4Z5l2YmJM5ahND0Ux
         3qlfIJDGCobt3vDyaSwU7fm6o98I9wR44so2lHIGwHfDBzzqpjTCJn7GKdzPCJVArJu+
         gXKH81/pfNWAl4DvSobTpWKWgduTmfh80hfWRhupjNnQ1uYFEjmJDxw2nRGI49Pjg78j
         MtJWE2QL9j1kKymK8P7U4/2r0v1411NdFekLwTEEoYNCJwzfNtfzZInKGZH+TZUpASfn
         rYsg==
X-Gm-Message-State: AGi0PuYDQb/TqG5IigRXhaniPONFJ7mbOuZy8FnUOljo3tqOPDpb1oq0
        ydTsufII6KwYXi+YXsOWbrw=
X-Google-Smtp-Source: APiQypJHnNRRfl4t4QS6HUPHvhreXCZVwjbiwzBFi3eYmksPgPmpz8iCa6XCY/tGuR/6prLWtXYlJw==
X-Received: by 2002:a63:f91b:: with SMTP id h27mr63579pgi.339.1586447723589;
        Thu, 09 Apr 2020 08:55:23 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y29sm18316086pge.22.2020.04.09.08.55.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Apr 2020 08:55:22 -0700 (PDT)
Date:   Thu, 9 Apr 2020 08:55:21 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Philippe Liard <pliard@google.com>
Cc:     phillip@squashfs.org.uk, hch@lst.de, linux-kernel@vger.kernel.org,
        groeck@chromium.org
Subject: Re: [PATCH v3] squashfs: Migrate from ll_rw_block usage to BIO
Message-ID: <20200409155521.GA187729@roeck-us.net>
References: <20191106074238.186023-1-pliard@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106074238.186023-1-pliard@google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2019 at 04:42:38PM +0900, Philippe Liard wrote:
> The ll_rw_block() function has been deprecated in favor of BIO which
> appears to come with large performance improvements.
> 
> This patch decreases boot time by close to 40% when using squashfs for
> the root file-system. This is observed at least in the context of
> starting an Android VM on Chrome OS using crosvm
> (https://chromium.googlesource.com/chromiumos/platform/crosvm). The
> patch was tested on 4.19 as well as master.
> 
> This patch is largely based on Adrien Schildknecht's patch that was
> originally sent as https://lkml.org/lkml/2017/9/22/814 though with some
> significant changes and simplifications while also taking Phillip
> Lougher's feedback into account, around preserving support for
> FILE_CACHE in particular.
> 
> Signed-off-by: Philippe Liard <pliard@google.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

Hmm, I spent a lot of time reviewing this internally, but just realized that
I never sent a

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Sorry for that.

The patch still applies to current mainline. I'll run it through my test
system to give it some basic test coverage.

Guenter
