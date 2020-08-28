Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A82C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EF80208FE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 09:12:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="WX4NqpDL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbgH1JMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 05:12:02 -0400
Received: from mta-p5.oit.umn.edu ([134.84.196.205]:53650 "EHLO
        mta-p5.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728548AbgH1JMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 05:12:00 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p5.oit.umn.edu (Postfix) with ESMTP id 4BdDPW1gfMz9vBrh
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 09:11:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p5.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p5.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id vmrsdfwp5iLm for <linux-kernel@vger.kernel.org>;
        Fri, 28 Aug 2020 04:11:59 -0500 (CDT)
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p5.oit.umn.edu (Postfix) with ESMTPS id 4BdDPV692rz9vBrd
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 04:11:58 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p5.oit.umn.edu 4BdDPV692rz9vBrd
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p5.oit.umn.edu 4BdDPV692rz9vBrd
Received: by mail-ej1-f72.google.com with SMTP id d24so303881ejb.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 02:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Wj6eMRmeud8x6L/d++7XRxBYl/GCWJAIhC6QOk0E8ps=;
        b=WX4NqpDLxg/3qSuqYK8f6LtHw9PfsWu2G2FZjcxdic8tkO0C1wbImDgTIulClFlCcF
         /I/cW4dJw01DjTdQsRMHj8SZYm8YoNneU0igz33tF4s9c4iaRcbez0AdjWjbh8vN6OG8
         pgyyLMr/HQ9r49NP5tObEDxLz1lgcijCWCUwdWwjPpHiCA7gRp+1lUEDOJcPf858TM+r
         K5drwEDJRkt90bwB8BvuZIG9i8JBgE6jd6dBjGXLmeOOcAjthHXolf6ssjYsmyRqo/+3
         UsJML6HWzCcgxqjCdSc/Ncuhy34+0uaujT/eNBQlyBMZMUBl2hsO/Fdmh/xsQCk5mu60
         HMOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Wj6eMRmeud8x6L/d++7XRxBYl/GCWJAIhC6QOk0E8ps=;
        b=DJ55ZphhcVFKDt8MkDwCtPyM71k/ZDOjdBtPtBBPE4J4VNd7IKnqvaVWSfcB7TVOgx
         SQmO1E5ONNypq/Oz/szWn3XyJo4Mkzpa6ZUtyVU/TVu7E1ZFyYcs0vXOb5mt0YmxFzNm
         2X6YJHQRjT28/OzYkLj+RUg+nqyF+gon7KZE5uBWZfhFm48l2/VQkNmR407sEiIeotG1
         1dpSYIS6hlB95owCmMUGuyCbVehBMzdHUqO+KNTVSDkxrDsnU0nJXFmBt9350wF9NOpe
         5WWakgYmSrbyFQRS9aRICaj7YLFGkWWxfNTd3asL0Q4lIieSoHiHtMOLHAxwG860ojSr
         Ed7g==
X-Gm-Message-State: AOAM530Eni7iDusrcx4eddzovhLbKXb/14nr14NDcdEd4H+4x8aMhtlB
        MooUmFYaEsY2q9QvvyJdYlJlqn4Ozrt2RcZIMgHxRDI/+C/tVh7Z8lqZlszdqBfMKLJDmJCetQB
        kvH+HIjvL3iDXmUvcjWUUX5elXszC/B325ADJgokNC3Kd
X-Received: by 2002:a17:906:f142:: with SMTP id gw2mr868241ejb.90.1598605917456;
        Fri, 28 Aug 2020 02:11:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJySHhGrgf/XnhSfsn4NRmoSUgt1EZhJQJNjYeuHLWfRcEBE4iSryzOC5NEKEVVfj3HAWKI9VbAgtN9FfwqGXjY=
X-Received: by 2002:a17:906:f142:: with SMTP id gw2mr868210ejb.90.1598605917088;
 Fri, 28 Aug 2020 02:11:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAMV6ehGKBfXN89XeDzMHKQ_6qLg41R2Tb7=sE+NC7KrbPsigDw@mail.gmail.com>
 <20200827182730.GA712693@kroah.com> <CAMV6ehEwaStF7Xvy-u4p+eU9C1UObCN8eVmuJmVZRFykROdnnw@mail.gmail.com>
 <20200828062042.GF56396@kroah.com> <CAMV6ehGwjKit-uOSv1=mRON6Sw6258Xyr8RB3bkLm0-wFymOng@mail.gmail.com>
 <20200828082608.GA1083216@kroah.com>
In-Reply-To: <20200828082608.GA1083216@kroah.com>
From:   Qiushi Wu <wu000273@umn.edu>
Date:   Fri, 28 Aug 2020 04:11:46 -0500
Message-ID: <CAMV6ehF_ExXybMO=_hZLkughDt07FkaoDLUgO0vrtZXp=f8+fg@mail.gmail.com>
Subject: Re: Some questions about the patching process
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>, Kangjie Lu <kjlu@umn.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 28, 2020 at 3:25 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, Aug 28, 2020 at 02:59:25AM -0500, Qiushi Wu wrote:
> > Hi Greg,
> > Thanks for your response!
> >
> > > You responded in html format which got rejected by the public list,
> > > please resend in text-only and I will be glad to reply.
> > >
> > Sorry about this!
> >
> >
> > > > 1. Linux allows anyone to submit a patch because it is an open community.
> > > >
> > > And how is 1. a "risk"?
> >
> > We are assuming the possibility of potential malicious commit contributors
> > and want to reduce the risk of accepting vulnerable patches from them.
>
> No, you are thinking about this all wrong.
>
> ALL contributors make mistakes, you should not be treating anyone
> different from anyone else.  I think I probably have contributed more
> bugs than many contributors, does that make me a "malicious"
> contributor?  Or just someone who contributes a lot?

Sorry for my confusion!  I don't mean to say that our kernel
contributors are 'malicious' or some similar, and previously I have also
made mistakes and send buggy code into the kernel accidentally.
Also, we are trying to summarize the methods to efficiently auditing
patches to prevent potential issues in the patch.


> So checking on patches needs to be done for everyone, right?
>
> We have an idea of "trust" in kernel development, it's how we work so
> well.  I don't trust people not that they will always get things
> "correct", but rather that they will be around to fix it when they get
> it "wrong", as everyone makes mistakes, we are all human.
>
> So we trust people who we accept pull requests from, we don't review
> their contributions because we trust that they did, and again, they will
> fix it when it goes wrong.

agree : )


> We use lots, everything we do is in the open, I suggest doing some
> research first please.
> > Also, can these tools have a
> > high coverage rate to test corner cases like error-paths, indirect calls,
> > concurrency issues, etc?
>
> Since when does code coverage actually matter as a viable metric?
>
> Look at the tools we use, again, it's all in the open, and tell us what
> we could be doing differently by offering to help us implement those
> tools into our workflows.  That would be the best way to contribute
> here, don't you agree?
Okay, I see.

Thanks again for your patient reply, and apologies for my confusing description.

Best regards,
Qiushi
