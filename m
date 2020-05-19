Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35E96C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 03:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 136FB204EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 03:31:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OtsyfSQl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbgESDbI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 23:31:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbgESDbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 23:31:06 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03B41C05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 20:31:05 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id ci21so729352pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 20:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=KO3Z9hueRakPgAx9Ac4Lw9qP6WW8KjlpYbXitB6bWSM=;
        b=OtsyfSQlKTEjylyOPRxpPGUcGz8k7uGMLR62alTvDkaoxXCQglR7nJ7rV7uW9KWv6E
         EKyqvWjzO8hmrqfjjZuUpn7FP+TPDdswox4M2rVwu/qA/jjwozjXmByWiEckY9soQXl6
         exuw2AKYBeQOH9hzuCbiWCpbPWtdvMicE7J58tyEw8wVSchfM1LX5/3cCXx+Rx6d9TKU
         tqegmblQ8zYMpY2qD7ykz9jFsYaxPPkc4bFHxAxlTs+WNO91nh4JvylaOgqUrrwqWa8m
         zsU9DHGJW33EEHIWjZXQenSVzF8qsLbRupskLRZjhB/e/txudaShaKvdh29+hYLW61FY
         jpUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=KO3Z9hueRakPgAx9Ac4Lw9qP6WW8KjlpYbXitB6bWSM=;
        b=kub4ZwiGTSQ+4Jl2RuO5erOUXdur0fggDJ12F0Xo5o5cVuH/4CzsBf6CS8H3vVwCSg
         tyqLn+rV7NDwEsOntVUg6A03badrc3Ex4hMRGb/sam0uOQ2von7QFtfiRO3ybLu5mVLK
         5TWubmJXDXrq+3xTAjRIpKsdgIuTJ59CSU2dpuDX6Hr4BKFS7717lKmam9SNclfFSaQ0
         +alyw7N3EOpX9pPSMcnSsnxvkE6JVGiREBtHQxV1kF3LpjBmN4a6pG4i4FRUMPnEV/Qx
         1TYLK4+R5yYd7HknS3fLf/EtIsFxGv2Ujel0f3HFPU99nS1XpFfj/7XVvlFW8I4ryi7u
         7nRQ==
X-Gm-Message-State: AOAM5300vF6JCZ9++YASwSayJSzh5sA3W1zDjnsG3rECj0EILPE8m0Hu
        J7sQZR87wv039rR/TAy11pNbLY07qPI=
X-Google-Smtp-Source: ABdhPJx2exZggkmdCdR9LnIIv36HDIca/L6gu/8aoM/2VReOK6PBJlLaeDMuS91GY0To15weB0y3Vg==
X-Received: by 2002:a17:90a:71c3:: with SMTP id m3mr2756791pjs.17.1589859064517;
        Mon, 18 May 2020 20:31:04 -0700 (PDT)
Received: from localhost ([122.167.130.103])
        by smtp.gmail.com with ESMTPSA id n14sm785468pjh.45.2020.05.18.20.31.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 May 2020 20:31:03 -0700 (PDT)
Date:   Tue, 19 May 2020 09:01:01 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: Re: [PATCH] interconnect: Disallow interconnect core to be built as
 a module
Message-ID: <20200519033101.fi6oa4xjchdzafi3@vireshk-i7>
References: <b789cce388dd1f2906492f307dea6780c398bc6a.1567065991.git.viresh.kumar@linaro.org>
 <CAOCOHw4ri6ikRpkJWtAdaPQiMhdKMrdNciqQ8YNaXR+ApSnAew@mail.gmail.com>
 <66c3d470-48e2-619a-dd95-6064a85161e0@linaro.org>
 <20200515071152.GA1274556@kroah.com>
 <20200518184010.GF2165@builder.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518184010.GF2165@builder.lan>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-05-20, 11:40, Bjorn Andersson wrote:
> It most certainly does.
> 
> With INTERCONNECT as a bool we can handle its absence with stub
> functions - like every other framework does. But as a tristate then
> every driver with a call to the interconnect api needs an entry in
> Kconfig to ensure the client driver must be a module if the interconnect
> framework is.

This patch has been pushed to linux-next a few days back.

-- 
viresh
