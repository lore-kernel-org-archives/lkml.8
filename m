Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5773EC83001
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 05:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36E6421973
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 05:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n6k9T2eu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgD3F2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 01:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726378AbgD3F2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 01:28:25 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7DDAC035495
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 22:28:24 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id u22so1821085plq.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 22:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=55tWQMue1CeWVhCSNKBFeKjct6AhC09nUnb+2ARVFbE=;
        b=n6k9T2euH6MbkTuaaSTLYdRko/Rvzhix+ZGxCCISN5B4ZHJzQj05CNp7caqivWUQYK
         Tapk90HkAI2PQsYHdWw8T+2qrDxmrSOLO6W1SsOoJG8gFYZvpcRt0tHYsbVWoSSYxL5O
         PxsXQv5rVT3XrGH/jjp2zR/vwe2ZezV4oB90IuuG6qRV4YaKn1SEW1V6BkWdWvY4ny3G
         vHcwLuErIwNS94zgPpurzj4yt0h3a7zbren2pPsJvLTPzm4sVJa4xhjLNH3/QtVLzuJ0
         Sz0sGFZ7UkkwHCLN2g5hwl1bgF8RBpEQDC6p+XEJEe1VEJfN4/VShbhOKofWxsLmW1vl
         RZ1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=55tWQMue1CeWVhCSNKBFeKjct6AhC09nUnb+2ARVFbE=;
        b=VGO2ualR1H0vWAjr6LtH3MvALEsd9WzZQFvGuWCdcSRL6FoQdVclyqY2Wou9FQ6OHf
         oyXLLrwSrp4+q6QdwKncicR5JkwYa5qaUTm3NUH6r3Scl78w/8xHKdlDhu/5zQ/xWbta
         eMUhNiirbjdfWtQfDnB8oDgXbW5PbZpGMZl4IYpHqdSB8L0NLoek7WJFPQklHEhJlEyN
         ZUBZs2qAFF8Y6N5SsXyXwTUj99agx2VpiK6DJNwWIg57ZvvrlDaBzoqUkprzz+RFHqDj
         cWnC/uPt0nw6dNcZERwYBmGjc1jxtvHM1NSWUVzvJ2GVGRjDAN92j4Q4Yu0YBUjDu6CP
         YqDA==
X-Gm-Message-State: AGi0PuYqvHxua9tbvZnMsRj40/sHK7k+YkxVpWFPVSyznR10+V7TaKJh
        1GR/+wmQoDQImSTNzi/rFz140Q==
X-Google-Smtp-Source: APiQypKoeSP3spOViYGktj9mT+PvpFos0abjKj3LkQ1BzRxJsd/lNPqVNDsO4w9ZM8zsbKrRdj88wQ==
X-Received: by 2002:a17:902:7b92:: with SMTP id w18mr1948964pll.273.1588224504269;
        Wed, 29 Apr 2020 22:28:24 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id b140sm2500509pfb.119.2020.04.29.22.28.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Apr 2020 22:28:23 -0700 (PDT)
Date:   Thu, 30 Apr 2020 10:58:21 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Georgi Djakov <georgi.djakov@linaro.org>, vireshk@kernel.org,
        nm@ti.com, sboyd@kernel.org, robh+dt@kernel.org, rjw@rjwysocki.net,
        saravanak@google.com, sibis@codeaurora.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        jcrouse@codeaurora.org, evgreen@chromium.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 4/7] OPP: Add support for parsing interconnect
 bandwidth
Message-ID: <20200430052821.thv63n4olbngjhjo@vireshk-i7>
References: <20200424155404.10746-1-georgi.djakov@linaro.org>
 <20200424155404.10746-5-georgi.djakov@linaro.org>
 <20200424192025.GA4525@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424192025.GA4525@google.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-04-20, 12:20, Matthias Kaehlcke wrote:
> On Fri, Apr 24, 2020 at 06:54:01PM +0300, Georgi Djakov wrote:
> > +	for (i = 0; i < num_paths; i++) {
> > +		opp_table->paths[i] = of_icc_get_by_index(dev, i);
> > +		if (IS_ERR(opp_table->paths[i])) {
> > +			ret = PTR_ERR(opp_table->paths[i]);
> > +			if (ret != -EPROBE_DEFER) {
> > +				dev_err(dev, "%s: Unable to get path%d: %d\n",
> > +					__func__, i, ret);
> > +			}
> 
> nit: curly braces not needed

Again, braces are preferred across multi-line blocks. Please keep it.

-- 
viresh
