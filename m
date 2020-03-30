Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15EADC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE45D20771
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 22:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlDnJ+HX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730836AbgC3WD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 18:03:58 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40428 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729386AbgC3WD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 18:03:58 -0400
Received: by mail-pg1-f195.google.com with SMTP id t24so9334800pgj.7;
        Mon, 30 Mar 2020 15:03:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=Fn5bbEwDKA1CjrL2t4+buEZ5DMdOn8ZLIb0ux0e5B3Q=;
        b=QlDnJ+HXQj0YHxnX8aX313kM6rHoKORnaNm2WYXDMn1aeXXbnF8UNEQ4VowdZeG4zl
         uV2sLQkwXOtnNAwFLkHNHrGIdHbHg2WXKZ+OCxvcK6XGQ4p7XyOtNEZguQcao8eEbZik
         jzhJzwgxyju9KgyIAO6AGWgfZzTJEGj7PCStu/3VWR74BEj6493pWtlmOVLr3PXjMy6j
         EvPvcs8zuq5fFUGMmdyzRW3LnvxqECq4R5074NxZe/sQXvq3wyUHonW+iSMHkNnpBI2D
         MA52ER9NNMOOvvHw75Dyrr3HHU19n2Cm6kVIde2BUnl4kJPuV5rqVxtOQP/DKfiUAQTz
         Rlnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Fn5bbEwDKA1CjrL2t4+buEZ5DMdOn8ZLIb0ux0e5B3Q=;
        b=XlyaJQ75YmYZFlHYQ3CsRkt7hNrVdnNy1xCTwovTHU+C8ASxZAQbCcCI8UjYnILFma
         MoF/XvJ3SWBj4nXIQxoZkOvKzMYAfQfO1BBMUzGACPklifq9Weu6pCCOSkL9C5b6MvcP
         ZxWP5cb6998V5c2kOTtHtDSj8YYijRKZ136kQ0QXOx1nKOhQrRI8RJH6ngcAcQnA6h2d
         UtlTaR1RIYc6WEcWXpzh7E8kn5zVf+h/7BZq+gmKkzqkCSWgVk8ePKokzRw5O2GqGpTs
         TYSbj9ap8KTJJwiQxmXVKpOVV+wIjbZmFvAsthINGHVLlU/NcDYV+7m3T5NKiATY37rC
         HdVg==
X-Gm-Message-State: AGi0Puapi+qiYG6iLMKtdCei6VgfebfVrffPlu6r8GYItW73WV4tcK9t
        0zIWT4Y9QKhek/pehQzNyRtRRQg//G3+tg==
X-Google-Smtp-Source: APiQypIZ7rugn26VNzMH9f1FGurreUtTRDwMeVEoQLstiLOtdeGMyyyqnQhROZmrQSttmeLztEHYWg==
X-Received: by 2002:a65:55c6:: with SMTP id k6mr1200130pgs.52.1585605836849;
        Mon, 30 Mar 2020 15:03:56 -0700 (PDT)
Received: from OptiPlexFedora ([47.144.161.84])
        by smtp.gmail.com with ESMTPSA id h4sm1230719pgg.67.2020.03.30.15.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2020 15:03:56 -0700 (PDT)
Message-ID: <53befe00af657428b591200b31b5349a4a462eb1.camel@gmail.com>
Subject: Re: [Outreachy kernel] [PATCH] staging: fbtft: Replace udelay with
 preferred usleep_range
From:   "John B. Wyatt IV" <jbwyatt4@gmail.com>
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     Julia Lawall <julia.lawall@inria.fr>,
        Soumyajit Deb <debsoumyajit100@gmail.com>,
        outreachy-kernel@googlegroups.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Payal Kshirsagar <payal.s.kshirsagar.98@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Mon, 30 Mar 2020 15:03:55 -0700
In-Reply-To: <20200330194043.56c79bb8@elisabeth>
References: <20200329092204.770405-1-jbwyatt4@gmail.com>
         <alpine.DEB.2.21.2003291127230.2990@hadrien>
         <2fccf96c3754e6319797a10856e438e023f734a7.camel@gmail.com>
         <alpine.DEB.2.21.2003291144460.2990@hadrien>
         <CAMS7mKBEhqFat8fWi=QiFwfLV9+skwi1hE-swg=XxU48zk=_tQ@mail.gmail.com>
         <alpine.DEB.2.21.2003291235590.2990@hadrien>
         <20200330194043.56c79bb8@elisabeth>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-03-30 at 19:40 +0200, Stefano Brivio wrote:
> On Sun, 29 Mar 2020 12:37:18 +0200 (CEST)
> Julia Lawall <julia.lawall@inria.fr> wrote:
> 
> > On Sun, 29 Mar 2020, Soumyajit Deb wrote:
> > 
> > > I had the same doubt the other day about the replacement of
> > > udelay() with
> > > usleep_range(). The corresponding range for the single argument
> > > value of
> > > udelay() is quite confusing as I couldn't decide the range. But
> > > as much as I
> > > noticed checkpatch.pl gives warning for replacing udelay() with
> > > usleep_range() by checking the argument value of udelay(). In the
> > > documentation, it is written udelay() should be used for a sleep
> > > time of at
> > > most 10 microseconds but between 10 microseconds and 20
> > > milliseconds,
> > > usleep_range() should be used. 
> > > I think the range is code specific and will depend on what range
> > > is
> > > acceptable and doesn't break the code.
> > >  Please correct me if I am wrong.  
> > 
> > The range depends on the associated hardware.
> 
> John, by the way, here you could have checked the datasheet of this
> LCD
> controller. It's a pair of those:
> 	https://www.sparkfun.com/datasheets/LCD/ks0108b.pdf
> 

No I have not. This datasheet is a little over my head honestly.

What would you recommend to get familiar with datasheets like this?

