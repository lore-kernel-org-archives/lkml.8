Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA408C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 05:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C80C5207F7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 05:29:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dk3ugeAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgFLF3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 01:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgFLF3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 01:29:01 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD84C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 22:28:59 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id e9so3602635pgo.9
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 22:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sn8Q2QTIJp4z3aJYpXX1ZHPFtT0KGOrsa14hJOj2CZ4=;
        b=dk3ugeAESJZcB7Ib32BwlQGgfx9iTvtwl1PuBEikxgRo0Lc4TtKRi/8Xi2tYQC/z6Q
         KM/rkoZDO2B3Vv+BV/qKKsEdHASexOfVLUWpEpXby0ddy7vegM42ltm/7YlidZkGXL0j
         T72ZH63bHrOfLmKNiPoWWBfGFumnggDr1CGNgMOw92+0KZvZTNSskiMm82+LjGyUoY5R
         2/5dD1b/x0KUfQAS8eAkSu8+/oXb59fy+4zMwQlmbYNTcjQVB9ubXOT0ReEB+k8zt21C
         D/uS7AKn5xQhG7c6hZ7A8gAN1oMOwXNexQuDSoEovnBE0nrC/yM44wL5x2lLAdlrUFfN
         mjvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sn8Q2QTIJp4z3aJYpXX1ZHPFtT0KGOrsa14hJOj2CZ4=;
        b=Q5U8NvxN+caZ7+fGJIglWa9G+QAERRkWB1i40moTegkgprQRnsc7hYfS8wdDrArKVN
         +qiK+hXPA9pZ+BlFq2ZxH++dhHO/O2mTxic1zLgstAZRunAywcUK2M8bua3rtmHH7rq3
         RLzsiO4DfNLNHtu44yOl4srA8Rgc7dcGi0uspgkmPOXjRLndgdaXHG6LKJxGWAGvnMrW
         +fbp6Y93okwQlUAuD8gkLCSKw7RZiCk9llPNtiztT81ZlEXiyHWHHqBJ3tvT0Sdyjkbn
         DO6v3532FEtY5NLczJY4L7ocrU1tpOoGwefplffwKe4s3pqgvVXfuYmWaJGeGoWlxdV2
         h6eA==
X-Gm-Message-State: AOAM530xyoUrblZUHegBdEiCdbeWYvf8NlQy/AiNyfj/wqOGqIYVCkBW
        SXr+n8mIcfjdMWN2/axO53UGUg==
X-Google-Smtp-Source: ABdhPJyHqEKil6Mou/zBNdyhF9uHnkjkpxj+ljkhROJsCnXD4KjAtn8p08f6zo/SXq+4izoXTulfCw==
X-Received: by 2002:a62:e40f:: with SMTP id r15mr10236310pfh.247.1591939738558;
        Thu, 11 Jun 2020 22:28:58 -0700 (PDT)
Received: from localhost ([122.172.62.209])
        by smtp.gmail.com with ESMTPSA id u14sm5369429pfk.211.2020.06.11.22.28.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jun 2020 22:28:57 -0700 (PDT)
Date:   Fri, 12 Jun 2020 10:58:53 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] dt-bindings: mailbox: add doorbell support to ARM MHU
Message-ID: <20200612052853.nds4iycie6ldjnnr@vireshk-i7>
References: <CABb+yY0cW1GZHVmwEr19JRdJTmsAxw9uq83QV_aq-tdPJO5_Fg@mail.gmail.com>
 <20200604092052.GD8814@bogus>
 <CABb+yY27Ngb0C-onkU2qyt=uKgG4iVrcv8hGkC+anypQbTRA1w@mail.gmail.com>
 <20200605045645.GD12397@bogus>
 <CABb+yY2YZ99NjHYNi0=KLGFDsVUeJmqiJD3E25Chwk-THJV4iw@mail.gmail.com>
 <20200605085830.GA32372@bogus>
 <CABb+yY2TR7tuMx6u8yah6mO2GwZ5SWYOO80EQRL-i=ybgn=Wog@mail.gmail.com>
 <20200610093334.yznxl2esv5ht27ns@vireshk-i7>
 <20200611100027.GB18781@bogus>
 <CABb+yY1OwVB+uk+0w+D-4Xy46iYn8tPZYBZ0qjrzQFLA6SaTvw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABb+yY1OwVB+uk+0w+D-4Xy46iYn8tPZYBZ0qjrzQFLA6SaTvw@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-06-20, 19:34, Jassi Brar wrote:
> In the first post in this thread, Viresh lamented that mailbox
> introduces "a few ms" delay in the scheduler path.
> Your own tests show that is certainly not the case -- average is the
> same as proposed virtual channels 50-100us, the best case is 3us vs
> 53us for virtual channels.

Hmmm, I am not sure where is the confusion here Jassi. There are two
things which are very very different from each other.

- Time taken by the mailbox framework (and remote for acknowledging
  it) for completion of a single request, this can be 3us to 100s of
  us. This is clear for everyone. THIS IS NOT THE PROBLEM.

- Delay introduced by few of such requests on the last one, i.e. 5
  normal requests followed by an important one (like DVFS), the last
  one needs to wait for the first 5 to finish first. THIS IS THE
  PROBLEM.

Just increasing the timeout isn't going to solve anything as I said in
the last email, we can make it 5 minutes for what's its worth. The
idea is to make the turn-around-time less for all the requests..

From Google (I know you must already know it, I am just trying to
highlight the importance of this thing here):

Turnaround time (TAT) is the time interval from the time of submission
of a process (read request) to the time of the completion of the
process.

This is what people care about, that is the whole reason kernel has
multi-processing support in the first place. If making things
sequential was good enough, we would have never reached here. The
whole idea is to parallelize things as much as possible without
hurting efficiency in a bad way (like too much parallelism). The
hardware allows parallelism and there is absolutely no point in not
allowing that. The kernel doesn't need to worry about how the remote
is going to handle it. Remote may be simple and handle it sequentially
or it may be running Linux itself and can schedule multiple threads
for requests.

-- 
viresh
