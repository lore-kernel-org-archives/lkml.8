Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE85C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E561D20760
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 09:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XtXvu6K1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727858AbgFJJdj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 05:33:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbgFJJdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 05:33:39 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AF6C03E96F
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 02:33:38 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id x207so868314pfc.5
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 02:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=gDnPaCqGGqbwLUgYXT8RQfx+Yi25CTYpPlgWUh+k1DU=;
        b=XtXvu6K1Uz1YjnpXdERt17M6pBkHDYVwHCy9UaMX6WqDUssPF9INUCclHDNNTCEEaZ
         q4hxviUAlk/YkgC8d4X/EwOfwz635nxrXQW4fBPO0PnzM/9fvI7uDjp7TxKWdvKpPRWt
         tf8FyeFeGTuNMIGxlY0t9umSLy84CNOoRvsoCYdYuU9yjO/H9dpOBO18GL63fSWEU9io
         yX77jxrbWQBzjzT9xMXfRNkrzO2IEXoibRVYJORPvN3liQu8veOBPWuX1FVuqd8BuFpS
         CYYafNkhZEc6/9ZonezXmUYWQiFzMm/As8rBg36aeU8BsKjdUtbQnDRwe6FOJLu+MlQ8
         7BbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gDnPaCqGGqbwLUgYXT8RQfx+Yi25CTYpPlgWUh+k1DU=;
        b=akH+GKbw8/ekHLTucxnBNoY+vqhYYOSuIsOM4O9NjgFxrpCu15l9g75MR8H6eOtZzM
         TW4vcllErAEYVIwenpv3g9u/IyAAK9/r6Cly8BuOcsylO0kPPOg7P/lKgy36Fxq4bypG
         tx4878WztvIOENAl4jF4GXmvLFiXw2lbvPSBLdjQouFGC9WtX5EbneyhjXMNSuUjTwd1
         WfPs3z889yzM8M85IQ2s42Y07RqyItuHYKUmH3t2kcXcqo1V5gk+gYrdFk3WAl2p9Vss
         F/ghhukZhOgL0F6WP5s7ne2JIr051cu51TEL80OwipkXG/Hcyq3fYGKP3bx0cbQ6urSC
         HN4Q==
X-Gm-Message-State: AOAM531MyU7CeM1gKGdMJNKlbEJUYlbJV1YDWxN3tgNTeyRJDoejZ+wV
        K+n/M4WFSo3smmh0jxEgSA/VWQ==
X-Google-Smtp-Source: ABdhPJyzL85kYroXLj9+vmzfJphNT9Bonj9nRBKzkkm5g4L1YoB1Va6xm3HiIlJ7CjmADnx7RrAx1g==
X-Received: by 2002:a62:8106:: with SMTP id t6mr1985814pfd.103.1591781617417;
        Wed, 10 Jun 2020 02:33:37 -0700 (PDT)
Received: from localhost ([122.172.62.209])
        by smtp.gmail.com with ESMTPSA id w73sm12759725pfd.113.2020.06.10.02.33.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jun 2020 02:33:36 -0700 (PDT)
Date:   Wed, 10 Jun 2020 15:03:34 +0530
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
Message-ID: <20200610093334.yznxl2esv5ht27ns@vireshk-i7>
References: <20200528192005.GA494874@bogus>
 <20200529040758.kneg2j4n3gxh2rfv@vireshk-i7>
 <20200603180435.GB23722@bogus>
 <CABb+yY0cW1GZHVmwEr19JRdJTmsAxw9uq83QV_aq-tdPJO5_Fg@mail.gmail.com>
 <20200604092052.GD8814@bogus>
 <CABb+yY27Ngb0C-onkU2qyt=uKgG4iVrcv8hGkC+anypQbTRA1w@mail.gmail.com>
 <20200605045645.GD12397@bogus>
 <CABb+yY2YZ99NjHYNi0=KLGFDsVUeJmqiJD3E25Chwk-THJV4iw@mail.gmail.com>
 <20200605085830.GA32372@bogus>
 <CABb+yY2TR7tuMx6u8yah6mO2GwZ5SWYOO80EQRL-i=ybgn=Wog@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABb+yY2TR7tuMx6u8yah6mO2GwZ5SWYOO80EQRL-i=ybgn=Wog@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-06-20, 10:42, Jassi Brar wrote:
> Since origin upto scmi_xfer, there can be many forms of sleep like
> schedule/mutexlock etc.... think of some userspace triggering sensor
> or dvfs operation. Linux does not provide real-time guarantees. Even
> if remote (scmi) firmware guarantee RT response, it makes sense to
> timeout a response only after the _request is on the bus_  and not
> when you submit a request to the api (unless you serialise it).
> IOW, start the timeout from  mbox_client.tx_prepare()  when the
> message actually gets on the bus.

There are multiple purposes of the timeout IMO:

- Returning early if the other side is dead/hung, in such a case the
  timeout can be put when the request is put on the bus as we don't
  care of the time it takes to complete the request until the time the
  request can be fulfilled. This can be a example of i2c/spi memory
  read.

- Ensuring maximum time in which the request needs to be serviced.
  There may be hard requirements, like in case for DVFS from
  scheduler's hot path (which is essential for better working of the
  overall system). And for such a case the timeout is placed at the
  right place IMO, i.e. right after a request is submitted to mailbox.

And some more points I wanted to share..

- I am not sure I understood the *serializing* part you guys were
  talking about. I believe mailbox framework is already serializing
  the requests it is receiving on a single channel with a spin lock,
  right ? Why does the client need to serialize them as well? Is that
  for avoiding timeouts ?

- For me, and Sudeep as well IIUC, the bigger problem isn't that
  timeouts are happening and requests are failing (and so changing the
  timeout to a bigger value isn't going to fix anything), but the
  problem is that it is taking too long (because of the queue of
  requests on a channel) for a request to finish after being
  submitted. Scheduler doesn't care of the underneath logistics for
  example, all it cares for is the time it takes to change the
  frequency of a CPU. If you can do it fast enough in a guaranteed
  manner, then you can use fast switching, otherwise not.

- The hardware can very well support the case today where this can be
  done in parallel and (almost) in a guaranteed time-frame. While the
  software wants to add a limit to that and so wants to serialize
  requests.

- As many people have already suggested it (like me, Sudeep, Rob,
  maybe Bjorn as well), it seems silly to not allow driving the h/w in
  the most efficient way possible (and allow fast cpu switching in
  this case).
 
> Interesting logs !  The time taken to complete _successful_ requests
> are arguably better in bad_trace ... there are many <10usec responses
> in bad_trace, while the fastest response in good_trace is  53usec.

Indeed this is interesting. It may be worth looking (separately) into
why don't we see those 3 us long requests anymore, or maybe they were
just not there in the logs.

> And the requests that 'fail/timeout' are purely the result of not
> serialising them or checkout for timeout at wrong place as explained
> above.

We can't allow for the requests to go on for ever in some cases, while
in other cases it may be absolutely fine.

-- 
viresh
