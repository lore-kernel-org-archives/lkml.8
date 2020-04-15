Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD80C2BB85
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 05:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5BCFE206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 05:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yBawUuab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393244AbgDOFNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 01:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389851AbgDOFNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 01:13:06 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5383FC061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 22:13:05 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id w3so829937plz.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 22:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wk1gKnV9MOmeaNOmUZ1VBgW92zzoZRIHZhM6e54Z8YY=;
        b=yBawUuabGnud63/Poff12xtpKasP/5I8yL3emeRbWZtRY3AM4QET7F9YllgXspKsxk
         fcwQ25vXNZuyb7Ar+SGyUb/FXakl2aa7RrKPjI4Guy5ogg29KbeVh65NZD3UKEPnKAaa
         PFROMt9T/4ArwOn0gJ6pqvNN/STQ80Zmb+HyEJKhwPmetpVd07f9XHpUXu74PbFbGbvp
         7gnG/QiEYrqzzBD9BQEDrRH1be3R2X2qKosleoEvSMGau36oZQSBSeG6f6wCzFp4vNva
         Z0d+2dFSbQJnjlTYG2NGkZTlQDCnYNAGZcvHKc0qcTBgqeHCOeVJYzUq+u2CqQdtlY1D
         c56Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wk1gKnV9MOmeaNOmUZ1VBgW92zzoZRIHZhM6e54Z8YY=;
        b=lLhh3Ee2PrG7vFN+OLV7hPdHKj2uR7mi1QwiV4RqzR81SovGjXo6Zd5c9paMZTprSv
         SGdc/3WEFzIyPyU7qVo9Xl0UwfCmnI28P/bBYihjhRvAMTwL82KRBMHTlDPb1KWlg+ie
         TiOoZ3DEfNSduDmu6ANox5+iATJ4Y+kZOHtJFogOspd1UYNBQLJ+wXiH9QOD9HvJoSlf
         uih7o/xbrpLqb1qElF5MkbeDlkMq8oMPXLstsgcDvfHc2ZZ3DlQo72bg77U9TvGQY4MJ
         QEvHc4+lYg+T4dLNPAhL1s38hOBBH/Jsf7GxuoKnOsLnAnR20nSmgpbMjPRqDgKkSyh5
         ry5Q==
X-Gm-Message-State: AGi0PuZawYtUqUxgu7IwrhmwgcgFgv+DoUwZCMOrkvGo5KAOojIW4hUO
        wVI5ABVJsAYTbSgHXod+fEiWWA==
X-Google-Smtp-Source: APiQypLZCWZaT5X6kAbkuh9roJAA1F1pyZLhruHQXsvmBhTmT9lVWi4Um5aIJ5CKpacErdblQszF8A==
X-Received: by 2002:a17:90a:f313:: with SMTP id ca19mr4095267pjb.7.1586927584560;
        Tue, 14 Apr 2020 22:13:04 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id x70sm12270635pfc.21.2020.04.14.22.13.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Apr 2020 22:13:03 -0700 (PDT)
Date:   Wed, 15 Apr 2020 10:43:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rajendra Nayak <rnayak@codeaurora.org>
Cc:     sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC] opp: Fixup release of clock when using set/put clkname
Message-ID: <20200415051301.rvrstjodjlj42jic@vireshk-i7>
References: <1586848508-1320-1-git-send-email-rnayak@codeaurora.org>
 <20200414071823.jdhkprtkizyeua23@vireshk-i7>
 <83c523d0-e18e-0401-5456-2dbba524ee98@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83c523d0-e18e-0401-5456-2dbba524ee98@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-04-20, 20:35, Rajendra Nayak wrote:
> However, given I call these unconditionally in common drivers and on
> some (old) platforms we really don't have an OPP table (only scale clocks)
> things get a little tricky. So looks like the ref counting in such cases
> gets messed up, and we end up with dev_pm_opp_of_remove_table() calling
> _opp_table_kref_release() and releasing the clock, and then the subsequent
> call to dev_pm_opp_put_clkname() crashes.

We aren't supposed to call dev_pm_opp_of_remove_table() if
dev_pm_opp_of_add_table() isn't called or it failed. Either we can
handle this in core, which I would like to avoid, or just keep a
variable to track it in the driver, which will be easy enough I guess.

-- 
viresh
