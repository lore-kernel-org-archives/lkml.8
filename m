Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8997C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 16:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9B5F92072E
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 16:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VEdj1nnn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbgC3QtP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 12:49:15 -0400
Received: from mail-qv1-f67.google.com ([209.85.219.67]:46340 "EHLO
        mail-qv1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbgC3QtP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 12:49:15 -0400
Received: by mail-qv1-f67.google.com with SMTP id bu9so3271515qvb.13
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 09:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a71i7JdkAqliwtmEviweeJJ9ZM+t+PVsWqn8Bh5mLGQ=;
        b=VEdj1nnnmrtVSY3gvhdlHyPYfcYpOkoM11AlgfxCZqb4l1zjWjEQuyjNlUilrGPjAV
         RnVNaZn4e/c7gOw72UJrCpT/qsyTozKTTeG0KgM5odqyR6UwbOz6+oBagsYSu99kr7PM
         e/JLTetCGJFG0H756UPQ4yFeaKLB8jehZrfXeMPmlEMeukE40w8JqNUQDGNQvNZeifW/
         PaAImIU31dzFzm1dMppfFYXqgNXyDZ6pU3ujlqDqxFs302Ee7GRLFSXUM4zMzmZAG8LS
         6ght+tJ8DxDDZmepUdwP2BE4EqxceTztvIvpWflnNyTe2p05bzcAESRfsA6Rw2zHc5Kd
         1sOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a71i7JdkAqliwtmEviweeJJ9ZM+t+PVsWqn8Bh5mLGQ=;
        b=lpGliqH3K/wyDEYAVpEXQ1os+CiH4f85XKnWLuxcFg24ncHBizC/dG4Q3nb74rBbD1
         Dd0E1N8grMOWva3Y+uaqwM4zQhXjjUkmJBOWlMK2nDsyt/2Ge6IX2eqw9ls3Vj9s/F6W
         FUCEmbd43O81T7Kntq6D78O34LMpFupji6S1hfxmw7/ZkwRo7M1rK/nSAHLPNi2BE7Z/
         PQKn5CvudnoeGTJ3TUBylVB/izjZmenk3DS/kKAK+0+6NU8k3000RynQR1bjo9aWMrsq
         i+L9ypZhkGP9aEdPhP/yLjLXC6e1x9rE0KZVfRTVZKQXQxpWIOaVPYysgs7k/MGlTljU
         UWLw==
X-Gm-Message-State: ANhLgQ3yYJQOG7cTytcesnEs7re6A/D4nFuvTIip8MOzdouv2izzIOGA
        oa1gMzI/lKUkrKgrqDVTug0Tqg==
X-Google-Smtp-Source: ADFU+vvPHjxytK86MxCeJ6R7R3lGmqQNNS4izpxzKyF+vrKQzVB9NqaoPpArMoQ8BTa7Bn1qpTr+AA==
X-Received: by 2002:a0c:9104:: with SMTP id q4mr12856377qvq.61.1585586954002;
        Mon, 30 Mar 2020 09:49:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id n142sm10803480qkn.11.2020.03.30.09.49.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 09:49:13 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jIxb6-0002W9-JI; Mon, 30 Mar 2020 13:49:12 -0300
Date:   Mon, 30 Mar 2020 13:49:12 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     George Spelvin <lkml@SDF.ORG>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [RFC PATCH v1 01/50] IB/qib: Delete struct qib_ivdev.qp_rnd
Message-ID: <20200330164912.GK20941@ziepe.ca>
References: <202003281643.02SGh6eG002694@sdf.org>
 <20200329141710.GE20941@ziepe.ca>
 <20200329160825.GA4675@SDF.ORG>
 <20200330132808.GB20969@lakrids.cambridge.arm.com>
 <20200330164333.GB2459@SDF.ORG>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330164333.GB2459@SDF.ORG>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 04:43:33PM +0000, George Spelvin wrote:
> On Mon, Mar 30, 2020 at 02:28:08PM +0100, Mark Rutland wrote:
> > Also, if you do send a series, *please* add a cover-letter explaining
> > what the overall purpose of the series is, and have all patches chained
> > in-reply-to that rather than patch 1. Otherwise reviewers have to
> > reverse-engineer the intent of the author.
> > 
> > You can generate the cover letter with:
> > 
> > $ git format-patch --cover $FROM..$TO
> > 
> > ... and IIRC git send-email does the right thing by default if you hand
> > it all of the patches at once.
> 
> Er, I *did* send a cover letter.  Cc:ed to the union of everyone
> Cc:ed on any of the individual patches.  It's appended.  (I left in
> the full Cc: list so you can see you're on it.)
> 
> My problem is I don't have git on my e-mail machine, so I fed them to 
> sendmail manually, and that does some strange things.

The problem is that none of the patches had a in-reply-to header to
the cover letter so it is very difficult to find it.

Things work best if you can use git send-email :) I've never tried it,
bu I wonder if you can tell git that the sendmail is 'ssh foo-server
/usr/bin/sendmail' ?

Jason
