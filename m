Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614A8C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 12:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 370F62075B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 12:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M6p2kFDQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729791AbgGMM6q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 08:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729564AbgGMM6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 08:58:46 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30245C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 05:58:46 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id l63so5971643pge.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 05:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5nLM2p6Virc+MlTPORY5QkSAiX5RMi7pPoL/1qaSWT4=;
        b=M6p2kFDQ1sebckHmBV7fKz/FtSnEJ6UrZLPaQVxZpSKNCgiKQNbjhD8FbeQwih6Ydx
         vodKB1vCOZCFmu6Qdvau4+B+KGQ2M2dDJnTZMOfnn7HoTnOjRCJK9b5UevrpKrjqg81U
         izJ5Gs3sFIWMk4fec9kdyAkbCwcmMNfTSQiEf7yGPCg6B1+CD0zmu6v+ECppuSOGWhCl
         QKYaS9AECk7euADYu5LeprnCBLelVWDse5o5P6LLDd3HEB8SwlYudOa+Pjs+1feyxaVe
         okH6IWpURv12QSVa1rtLDLSf70rQsV/yjC6W1WVuE+08AZ/X/f+P1HH2oQy61He0HXdX
         rEVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5nLM2p6Virc+MlTPORY5QkSAiX5RMi7pPoL/1qaSWT4=;
        b=pK4qrh0aXxvnibOdInX8msNuKXYjpB9OPj9iAU+npjhSFLrG3RXsGkqxvU6qngdSgy
         06Pyy/LWbdiEdUb/h77CtVp+Zh3b6tqDuTb9MvppbOj6S2ugNdMlC7rfDx78GJZtQgzx
         3UdOEEyWae5H5qU08itK8X4J5mhXNp9hOZe47ed2zBjs98nrMJsqk60xsg9EQdYDWBCA
         /RHiA1IikKO3rsUtIuSOaguF5KIBgcMQQ+KDBinw0GRiHalGFVvRze7nq+AiifadsuGg
         XR+OFNvRlatr/RS8gWtYRvKxazGFg+ynsHC78j69JLvm244MO3KBE2CvXU22cJ291/IL
         5GMA==
X-Gm-Message-State: AOAM530odpl0ek3mQaXcxeUOZvnoe1eSvONXDmOZNmnzCUeMLoQfID6W
        cQnHoWkpQa0UtSc7apLekQqHHw==
X-Google-Smtp-Source: ABdhPJzg97vi2ULpLvffDLSMsB1uoA6DeOFoMTJ9U/W4JJkBv/LrE63lAzv6D7LUShGstv9T663pZQ==
X-Received: by 2002:a63:778c:: with SMTP id s134mr66076188pgc.273.1594645125724;
        Mon, 13 Jul 2020 05:58:45 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id e16sm14750338pff.180.2020.07.13.05.58.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Jul 2020 05:58:45 -0700 (PDT)
Date:   Mon, 13 Jul 2020 20:58:39 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Will Deacon <will@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        sboyd@codeaurora.org, john.stultz@linaro.org
Subject: Re: [PATCH 0/5] arm64: perf: Proper cap_user_time* support
Message-ID: <20200713125839.GB6660@leoy-ThinkPad-X240s>
References: <20200512124058.833263033@infradead.org>
 <20200713060800.GA15400@leoy-ThinkPad-X240s>
 <20200713101156.GA2328@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713101156.GA2328@willie-the-truck>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Will,

On Mon, Jul 13, 2020 at 11:11:56AM +0100, Will Deacon wrote:
> Hi Leo,
> 
> On Mon, Jul 13, 2020 at 02:08:00PM +0800, Leo Yan wrote:
> > On Tue, May 12, 2020 at 02:40:58PM +0200, Peter Zijlstra wrote:
> > > Prompted by Leo's patches, here a series that corrects the arm64 perf cap_user_time situation.
> > 
> > I checked the latest mainline kernel code base, found this patch set
> > are missed to merge into it.
> > 
> > Could you confirm if this is missed or any other reasons to hold on it?
> 
> I was assuming you were going to pick them up, fix up the issues found
> by you and kbuild robot and then post a full series after testing.

Understand now, will rebase the patch set and verify it with SPE
timestamp related changes.

Thanks,
Leo
