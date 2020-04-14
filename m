Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98332C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 17:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 712682074D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 17:25:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rm2y649r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407685AbgDNRZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 13:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2407592AbgDNRZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 13:25:46 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9AAC061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 10:25:45 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a25so15371073wrd.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Apr 2020 10:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KbYz/0I1+T7Ngj2iLluoHDDSA6buCu83oB9tkgBzR2w=;
        b=rm2y649rkD0FNyssqBFQXdGKrdaSf1WRbYlqi1hLJjRXR6BrP5O12VkKRc+YL2+t2G
         nl6xsUn67RaREbYBiktiyfc1v1UcP81hYDNb/3cx7LWcu3NCl6hlMbw6W92A+7D0B4zF
         PtwljCT4YlDFPgWBB95H9pMqabBeG62rr2+RYjhWDEFIyBkTVLQgQBjrXX6SoTlgSCas
         Qxw66VslxmaSRHwMjfhcBiN5hBHh+qOcUvCqFSvt5pa41Ygy1xnfBJivCvl5BNHjG2je
         4igJgPAhTOaz2rs8iIhiqRy9Gwb/Fl1fad0QevvKeqavi9v07FPTQ/sdj22uREhFF/X4
         H+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KbYz/0I1+T7Ngj2iLluoHDDSA6buCu83oB9tkgBzR2w=;
        b=LgwbxyRvAP2PTOBUx/cqgFjUIWMtj1cTnCVJ1sun6tvUd12a6hVHdJF8gHGcDyE2tt
         bnIJfYO1L90/0uHtgBcanh9hxiBBe3WMqigin40XF7CC9f/Ruzr6ypaG9DB6D7qx2lSk
         ugPug+HaMW9EndbdhveGgOLMqS3sUkcHEU2qH4sdhBJYPPsnGoGkUHCvQT2E+HBCfiMI
         ksVz+xrj0PCLeVgXsuNtygyzCJkQJOGUbEH1X9zLQfAeR68gyKXC39F23s68NXjuaZ8M
         dooS1TyGjEtyrS0j7346AzqxMq1fV5wkhd9xX6s3fEGXPsaBbAIYoeKZoNDAWPzhS0xR
         Dnmw==
X-Gm-Message-State: AGi0PuZBzfdzYWh4Fd7x+cb51qi0J+gallQ7GrWdFihYdAYrpOlZel6D
        XgeyhNe/Bo9nsXWXLj3ocrDBOQ==
X-Google-Smtp-Source: APiQypIKxUlFuUhOd3sOuxcciZLq88J6lAyGia+QLXsGoyPJl1Cmyg71MDb1sm/8LfNvkRYqHcrTQA==
X-Received: by 2002:adf:cc88:: with SMTP id p8mr12911393wrj.21.1586885143518;
        Tue, 14 Apr 2020 10:25:43 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id h17sm7992615wmm.6.2020.04.14.10.25.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2020 10:25:42 -0700 (PDT)
Date:   Tue, 14 Apr 2020 18:25:39 +0100
From:   Quentin Perret <qperret@google.com>
To:     Patrick Bellasi <patrick.bellasi@matbug.net>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        ctheegal@codeaurora.org, dianders@chromium.org,
        valentin.schneider@arm.com, qais.yousef@arm.com,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH] sched/core: Fix reset-on-fork from RT with uclamp
Message-ID: <20200414172539.GA65662@google.com>
References: <20200414161320.251897-1-qperret@google.com>
 <20200414172120.GA20442@darkstar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414172120.GA20442@darkstar>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 Apr 2020 at 19:21:20 (+0200), Patrick Bellasi wrote:
> Fixes: 1a00d999971c ("sched/uclamp: Set default clamps for RT tasks")

Argh, you're right, we need this, I always forget ...

> Reviewed-by: Patrick Bellasi <patrick.bellasi@matbug.net>

Thanks!
Quentin
