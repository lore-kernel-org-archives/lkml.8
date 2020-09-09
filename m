Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 127D6C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 04:46:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C175621D40
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 04:46:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vw7IaWgk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgIIEqY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 00:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725826AbgIIEqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 00:46:23 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1023C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 21:46:22 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id m5so1149959pgj.9
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 21:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=k9xIdA5uNBsj+GJ5HARC5Tw5O2ikVymrpKoJIVRjtkM=;
        b=Vw7IaWgkIPBViICq+9eKHLp7LZ/to1OMgXtebdo/EIZZgKmOMZLTM3/FQ5NpoOhmPq
         5+AAN493iEpS9v7RtTiBPjmJ01SfcZhIfC+bn73OCQc11eowEonndExzCO7lNv487p6E
         1qKpWPrhXiCQOZ9mSpIMfZLlrhFxBETMM15M0cyOyJdkOIUaA1ktNyOKMkOzTSdSAdoy
         ekAPWhJxiE1h0r2JPV+GPCBOv4XSJSuIFCFLS35NlgoWYlvgJWB3ZhLmXOF62zLX9Mse
         B7E/Uoa7XdP5CPCdq/opJIsPNfiKfGYJdcFAn/VMhFg+HPBQIgSGUxvoWy1TVUHGIVKq
         4gHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=k9xIdA5uNBsj+GJ5HARC5Tw5O2ikVymrpKoJIVRjtkM=;
        b=YFocQo2hDF11CryGJtSBDTzAOnYVjtZ5OLznRgV5SR4bikaQbiUg5HWPWpeGlrkgqx
         3Dyv7EG5ExHgxzPt2YCewMx/qdZTSII2M0n1naglNfUqHJ2QguT1kBf5N//rulPy9FhO
         MW0PgG4b2F0ycWTRwyE9paRF2lYziCrls60ePme9f/lsMH14V9vHMzXkhnXCNnJ9qb1u
         qCEVGanUrM8n45ol30xwwALBRLCQNqQQqn6JylK7QggmciTHjsLWACFHFQ7snH5nhpck
         oisbYVtZkMIPFmPkJgFd9h4D1QO3NsYrAJi6Iera5GvvLfoa1htAT7y6/O9RnqnR7zKe
         KufQ==
X-Gm-Message-State: AOAM533S/joy9G5+CYP4x2wTNs8sTEq5tiN71oSR7M49yvS7J1A25tqJ
        MCMqzU3a8qOnKnSU74HWCRXXZA==
X-Google-Smtp-Source: ABdhPJyHmMxIsk8wCLCm/XLHUrlYlkUrjBTaPKthTCbkUVu/ZjM9745oGxKM3iNO1qOFVEjtJclaOg==
X-Received: by 2002:a17:902:bcc2:: with SMTP id o2mr1981556pls.87.1599626781598;
        Tue, 08 Sep 2020 21:46:21 -0700 (PDT)
Received: from localhost ([122.181.54.133])
        by smtp.gmail.com with ESMTPSA id p68sm1011133pfb.40.2020.09.08.21.46.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2020 21:46:20 -0700 (PDT)
Date:   Wed, 9 Sep 2020 10:16:18 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Sudeep Holla <sudeep.holla@arm.com>,
        Rob Herring <robh@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] dt-bindings: mailbox: add doorbell support to ARM MHU
Message-ID: <20200909044618.deyx37pzocxiga7u@vireshk-i7>
References: <20200605045645.GD12397@bogus>
 <CABb+yY2YZ99NjHYNi0=KLGFDsVUeJmqiJD3E25Chwk-THJV4iw@mail.gmail.com>
 <20200605085830.GA32372@bogus>
 <CABb+yY2TR7tuMx6u8yah6mO2GwZ5SWYOO80EQRL-i=ybgn=Wog@mail.gmail.com>
 <20200610093334.yznxl2esv5ht27ns@vireshk-i7>
 <20200611100027.GB18781@bogus>
 <CABb+yY1OwVB+uk+0w+D-4Xy46iYn8tPZYBZ0qjrzQFLA6SaTvw@mail.gmail.com>
 <20200612052853.nds4iycie6ldjnnr@vireshk-i7>
 <CAK8P3a0nVOR7YYSZaKmzm3WsUZLgOqL7yZq+f0Dfnn2=16AkLA@mail.gmail.com>
 <CABb+yY3HDs219C8Wcc+CJRLukV4OvCKhqevU-9jN4bCU6SC3rQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABb+yY3HDs219C8Wcc+CJRLukV4OvCKhqevU-9jN4bCU6SC3rQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-09-20, 22:23, Jassi Brar wrote:
> From the test case Sudeep last shared, the scmi usage on mhu doesn't
> not even hit any bottleneck ... the test "failed" because of the too
> small hardcoded timeout value. Otherwise the current code actually
> shows better numbers.

Its not important on why the test failed there, but the fact that
there were requests in queue which have to be completed one by one and
the last ones in the queue will always pay the penalty.

> We need some synthetic tests to bring the limitation to the surface. I
> agree that there may be such a test case, however fictitious. For that
> reason, I am ok with the doorbell mode.
> 
> I totally agree with one compat-string for one hardware. However, as
> you said, unlike other device classes, the mailbox driver runs the
> sumtotal of hardware and the remote firmware behaviour. Also the
> implementations wouldn't share much, so I think a separate file+dt
> will be better.

> But I wanna get rid of this toothache that flares up
> every season, so whatever.

I can't agree more :)

So to conclude the thread, if I have understood correctly, we are
going to implement another doorbell driver for this hardware which
will use a different compatible string and #mbox-cells value.

I will try to refresh the bindings soon, which will be followed by the
driver implementation.

Thanks everyone.

-- 
viresh
