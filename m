Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEF2C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2481C2075F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MUk5eR9g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbgGMGIH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgGMGIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 02:08:07 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3088BC061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 23:08:07 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id b92so5706774pjc.4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 23:08:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=z/f/JdaD7B9OptJVP+D83s9CjevqGzX1paaoJaaTiL4=;
        b=MUk5eR9gmbZ+q2XjgXjWsGpnCh2PQacDaMSNE2Em5/km2ZR+EGwqi35xnVO+7hf3UP
         WMpbSvQPTFJHGOq007Io8yzMBFVGDL0WTu/ZJFIdjtn1jQufDH6Vd8nMvdvRFSIMXRTf
         IycBG41/WWSMt30gO0DTQzBpQph+G/3NXDf7ASW3n+s6+c8cMl6MCNY6p94Wf1m1Lzom
         Tqc7+81mE3txN1rTbyxUWTy8XdtYHFscORTAV3NR0mOSUwUepY9cplZ5RdIngh2t6Z+Z
         jbnXNwXtf4eKFaG1xS3rUWUjkdubTkR9W8BNF/DHzW1P13WBOIkIa6XretwtyJOmqvmf
         Tl+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=z/f/JdaD7B9OptJVP+D83s9CjevqGzX1paaoJaaTiL4=;
        b=VAH9y4WCq4bElQUfLfilki1aMr1eKaNxWNAgdfqBkI7miyGQ8JbeMINSMi8jbpm2sV
         xV38hF7Vg2ROZRPTTEJqw9Z6x+dDTCRBDEwV5hZD0U88GVI/qI2SIZRyxDakxuuk67+j
         X7bSMbeFsxQYrvRvY5FLxJdsy/uecdv8W1+Dlq4hsxNDGYYCxX8TlskXcBsloEr+t/jp
         rXbe3+N98acNmPAmv1wCl0FIEJwLSsB+eb34D1WsW2UVhq7xYCBMlvb3VJL6LDc/GVcD
         YBduXSKXgAtUOLLgDuRO0MP3+LZaMZiaLAYgftmBL1cXm31PWMo+xs5KO59J5PgxuOw4
         hLPA==
X-Gm-Message-State: AOAM5333XYzVO0VMZXImkZVIwrMRZZBcuPzLRaT2leps10hi/FcTZWC4
        bI/rQM2mwY+ICN/S0Ng72ow2fWxXDsXyGw==
X-Google-Smtp-Source: ABdhPJzIBiA+iECxB70iS9Jx0pjXE7SxZczFgrIhvWNR2DeyeoBU91eAVRoJW279mfSq3HoWmtjcHQ==
X-Received: by 2002:a17:902:ab94:: with SMTP id f20mr27044914plr.232.1594620486740;
        Sun, 12 Jul 2020 23:08:06 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id r70sm13761646pfc.109.2020.07.12.23.08.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 Jul 2020 23:08:06 -0700 (PDT)
Date:   Mon, 13 Jul 2020 14:08:00 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        sboyd@codeaurora.org, john.stultz@linaro.org
Subject: Re: [PATCH 0/5] arm64: perf: Proper cap_user_time* support
Message-ID: <20200713060800.GA15400@leoy-ThinkPad-X240s>
References: <20200512124058.833263033@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200512124058.833263033@infradead.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

On Tue, May 12, 2020 at 02:40:58PM +0200, Peter Zijlstra wrote:
> Prompted by Leo's patches, here a series that corrects the arm64 perf cap_user_time situation.

I checked the latest mainline kernel code base, found this patch set
are missed to merge into it.

Could you confirm if this is missed or any other reasons to hold on it?

Thanks,
Leo
