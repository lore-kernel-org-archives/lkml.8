Return-Path: <SRS0=Vo5z=36=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7475CC352A4
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 21:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45DC320733
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Feb 2020 21:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581371102;
	bh=OoBqoydlyZkqvBmLg2fmdFZHGzFhBF/BYuSUYZfNjb4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FZ/gsWzCP3G6ufAI60r2xzRx4xYEoerUCFmfb5+Nlg2X6djtakdsGAcLqucYvRtrq
	 MVKBM+Fgjf4crCGgWTvfHcb+PO5kmiAylf24cq1hrO61XHinU1Aj80G4QMFxY2z5BU
	 +GsEP49o6xNXeKKzTvWgxQMgVCq+MQgotYC0c0Z0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbgBJVpB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Feb 2020 16:45:01 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:43892 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgBJVo6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Feb 2020 16:44:58 -0500
Received: by mail-pl1-f195.google.com with SMTP id p11so3348350plq.10
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 13:44:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=t+13fvzNsA3W3IKzD16kC7FQP1bNXynWnDk+WN5MOzw=;
        b=RTjCSPz4i6Ocw2e9eaRmFAI/J2aDI1HOHJX0nuwSOzkinHFAWTVoGHbvCsdA7obkiw
         wjLURhgRA2lBpgDoXVxvRmJFAHvfbO+4nlt96JPvUommVtTEp9JJc6wMxRCD/HqQMbH2
         4n142Ebc4FN60Va7QFe904j208V6SrshdNus4bP0DH2r3eVpty8tB9Uwji+XRIqpFde1
         nvBtRQLUGE4Vum8N2n+yYkxbpaLYZ65cW7kbxq08ZWWTnSR/g5BQeJaUg9CDve9ZKsYF
         k8lXgjQ7mNcUAjjSfC+Hp2LRavoA2DrZcoJhemwoKrzPcPr1wL2eYcW294ka8QBe9p/K
         jBOw==
X-Gm-Message-State: APjAAAUoLenHWxIUh04OBDIo0dod3JYGU+LZo9izR+5sJB6J9hr1T0bp
        V1WDOWEvR9cLreYLX8OHBH0=
X-Google-Smtp-Source: APXvYqwKDvX0o+Ef/84eXTM6XegMzFwcLEJZdbcPGcGQRn03n69VEHk2f9CvqkXDGYcf/qvMZztSpA==
X-Received: by 2002:a17:90a:e28e:: with SMTP id d14mr1380322pjz.56.1581371097577;
        Mon, 10 Feb 2020 13:44:57 -0800 (PST)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id v7sm1331980pfn.61.2020.02.10.13.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 13:44:56 -0800 (PST)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id E01234060F; Mon, 10 Feb 2020 21:44:55 +0000 (UTC)
Date:   Mon, 10 Feb 2020 21:44:55 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Davidlohr Bueso <dave@stgolabs.net>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        broonie@kernel.org, alex.williamson@redhat.com,
        Davidlohr Bueso <dbueso@suse.de>
Subject: Re: [PATCH 1/5] lib/rbtree: introduce linked-list rbtree interface
Message-ID: <20200210214455.GO11244@42.do-not-panic.com>
References: <20200207180305.11092-1-dave@stgolabs.net>
 <20200207180305.11092-2-dave@stgolabs.net>
 <20200210200712.GM11244@42.do-not-panic.com>
 <20200210212832.2i2i3kbybhk2rcee@linux-p48b>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210212832.2i2i3kbybhk2rcee@linux-p48b>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2020 at 01:28:32PM -0800, Davidlohr Bueso wrote:
> On Mon, 10 Feb 2020, Luis Chamberlain wrote:
> > > access to the first node as well as
> > > both its in-order successor and predecessor. This is done at the cost of higher
> > > memory footprint: mainly additional prev and next pointers for each node. Such
> > > benefits can be seen in this table showing the amount of cycles it takes to
> > > do a full tree traversal:
> > > 
> > >    +--------+--------------+-----------+
> > >    | #nodes | plain rbtree | ll-rbtree |
> > >    +--------+--------------+-----------+
> > >    |     10 |          138 |        24 |
> > >    |    100 |        7,200 |       425 |
> > >    |   1000 |       17,000 |     8,000 |
> > >    |  10000 |      501,090 |   222,500 |
> > >    +--------+--------------+-----------+
> > 
> > Sold, however I wonder if we can have *one new API* where based on just one
> > Kconfig you either get the two pointers or not, the performance gain
> > then would only be observed if this new kconfig entry is enabled. The
> > benefit of this is that we don't shove the performance benefit down
> > all user's throughts but rather this can be decided by distributions
> > and system integrators.
> 
> I don't think we want an all or nothing approach

I'm not suggesting all or nothing for all rb tree users, I'm suggesting
an all or nothing approach to users of a *new* API. That is, users would
still need to be converted over, and *iff* the new kconfig entry is
enabled would the two pointers be added / used, otherwise we'd fallback
to the default current boring rbtree.

> as different users in the
> kernel have different needs and some users are simply unable to deal with
> enlarging data structures, while others have no problem.

The approach would allow distros which are not yet sure if two pointers
are worth it yet to continue to chug on as they used to, but also allow
them to explore this prospect in a flexible way.

  Luis
