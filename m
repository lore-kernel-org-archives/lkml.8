Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	PDS_TONAME_EQ_TOLOCAL_SHORT,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F366C2BA80
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 09:29:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77EC206F8
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 09:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lA2dD1pU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbgDFJ3v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 05:29:51 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39018 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbgDFJ3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 05:29:50 -0400
Received: by mail-pj1-f67.google.com with SMTP id z3so6200378pjr.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 02:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZCzHwl/tdcpxDCvekc0v2ATl1ivxbmKIM4V06jUFE4o=;
        b=lA2dD1pU3P/Ty4DeO3ShHycc7coGr4rgguYE94pdUYB0rQeBI4R+O+XPILIDswxwUZ
         8/0N/Nf87j7tRNEWERwPiO+a8fKnsi9Y6Ftu3dVR3xICxGhLDWb+KGsFDsQaBOcgI3tr
         jSqz9jjdv+rGEp7nNDmxgLrZQKooGMiHIMJTMjPW9qY6OwddYlWPTFKeb8bg7qZU3AwG
         qBX3zWIimob9XlsraxiQ+pWhNKsyugcy2Q068sezTmHZQY54B4p2jq0lnirIIi91YGmo
         NGF9j8S2DD7riX6aAyxCPnvM0QyW2GEyt48nwV9aXfhYqowCQbI+nfwwy4PbTMDIoY32
         YE4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZCzHwl/tdcpxDCvekc0v2ATl1ivxbmKIM4V06jUFE4o=;
        b=UHc1bK/MlY9QxnAZX+yMOkfJMrO7KP4B+a6aY5RqaNt+iWou4tRxMhMKoQKnSDCWAZ
         8kPm0B0Iw1+hQgTFYlT9Skj9tTwqYQzMWry4SRCVnrqJaNKOMURNTARk1AbVk5hzH6xW
         +CYP6MyeRcMJ9K3YrBwCdtmDrWfI/jSwSNdxpBBU4Hrt5XgDKnu1JnebUjUKSk5cvuU6
         v8CzAKegx+bSyz0ema/uIbHN3b0q03y2ygINtIqxyPbvg8q30DY2xixT3H6EVKs3mR/B
         +uuqPEH0pFDiuo1Fc3Temdbef5mrYDDrPbzJ8U0S5lgCf/CkmR7g4+wkJ3Sya7Lgs7Hm
         49aA==
X-Gm-Message-State: AGi0PuaLqXwNraAS2ZwwLIGs8sicya1z+lJROFSAbxv6li5QuCDkMDIv
        C/IUIn0ZjMJCIondFGuNp8tzHQ==
X-Google-Smtp-Source: APiQypJ1tW013VPp2UhXvt/1Bxz5iwbypmAuTEFj+PUd/NiBUPS+9Nx3CgJdVnertByvQXbdXVoStw==
X-Received: by 2002:a17:902:b593:: with SMTP id a19mr19581254pls.92.1586165388661;
        Mon, 06 Apr 2020 02:29:48 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id c128sm11053782pfa.11.2020.04.06.02.29.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2020 02:29:47 -0700 (PDT)
Date:   Mon, 6 Apr 2020 14:59:45 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "andrew-sh.cheng" <andrew-sh.cheng@mediatek.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Nishanth Menon <nm@ti.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Fan Chen =?utf-8?B?KOmZs+WHoSk=?= <fan.chen@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [v5, PATCH 4/5] cpufreq: mediatek: add opp notification for SVS
 support
Message-ID: <20200406092945.d5thcd2h3bo7mn45@vireshk-i7>
References: <1574769046-28449-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <1574769046-28449-5-git-send-email-andrew-sh.cheng@mediatek.com>
 <20191127083619.etocnhpyyut3hzwq@vireshk-i7>
 <1575874588.13494.4.camel@mtksdaap41>
 <20191210064319.f4ksrxozp3gv4xry@vireshk-i7>
 <1583827865.4840.1.camel@mtksdaap41>
 <20200311060616.62nh7sfwtjwvrjfr@vireshk-i7>
 <1584084154.7753.3.camel@mtksdaap41>
 <20200313091038.q7q7exiowoah4nk4@vireshk-i7>
 <1586164366.5015.6.camel@mtksdaap41>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586164366.5015.6.camel@mtksdaap41>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06-04-20, 17:12, andrew-sh.cheng wrote:
> I will use regulator in the locked region.
> And regulator will use mutex_lock.

Yeah, you can't use spinlock here, use a mutex.

-- 
viresh
