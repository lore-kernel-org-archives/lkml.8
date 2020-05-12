Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFC5C54E8F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 04:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBA1C20730
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 04:21:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y43K56Df"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbgELEVQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 00:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725851AbgELEVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 00:21:14 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D33BC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 21:21:13 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id y25so5753230pfn.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 21:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IdjYh0oULyLJ5bKtvUfrpKY/2RKuAj8/Dl3bei8f6k4=;
        b=y43K56Dfg/lBfYBZTCGXMXhFb6d7tRa60kQPwF899DRyGef9/q2FtoD2Jfq/ZCrVs1
         E0CsaE1tM4k+NHsP3W/LVLuDD8mlF297aj4IGgmlAHHeEivD1jDFVAR1q9h1rl2SDAvM
         9/cPC/FiLdFYHFKgi7ae0Z8DRv/RNIA+lHtIKXm2D1vj5LfFZf5zqIptDJK+gY9tYbTf
         Vk/HwtggQJ1bpYthbTPDcWSa4ot8Qg7ubveZ36oooDLWPNrYNCCzT4zidKfYn3nwmuAR
         8IPu2ZXkbSD/pi9lotIhEeGy7uu7WiLk3rLRM5E3S1BiLTZv+6lfB8g/yVYDPPkD40e4
         VPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IdjYh0oULyLJ5bKtvUfrpKY/2RKuAj8/Dl3bei8f6k4=;
        b=OgwJhZr++Wol0Hullhl68iYrtbX3Ir74N+/XGcqvWLRa1yaQikWOudOWMFbmWJDfWd
         QcAniw69MTls8oc7q7cpUcUy1WwSfPuiWoy92YHclf+WqrF2M8z5YEm7KEzsU325bjX4
         FS8qVJtytrweunjJWDAmDUVwVNCaBoWXsN8Su3v+haemJQXyK6sZLBUwhtysQqSFOrpU
         S6WQEIrAaGTR5QxY5gFOpjlZ7amEuogn55jEDPrRX9FKWHIko/vpzxxvnSLvNK2X/JQr
         3Oj7pZmCQupEv7VDqQCqXV5JIYlObageHY+lazTct444KTTCv4N3EH7BN3RDQc6VFC/C
         HgSA==
X-Gm-Message-State: AGi0PuZFVOdJ0v7lWJmkiEG/3nmyNSCKY7qxr9LNjN2LYyIxqHgXZ62k
        oY+HxxJx5BdNzUx5As2+aRkucw==
X-Google-Smtp-Source: APiQypKjWODnYY86agN2yEWC9uxMVeLfVAM2apbPJioRbCX8VaeEXSRQ0fMmHf5BAc6q+ja5I8RfmQ==
X-Received: by 2002:a65:4c41:: with SMTP id l1mr18142702pgr.43.1589257272699;
        Mon, 11 May 2020 21:21:12 -0700 (PDT)
Received: from localhost ([122.167.130.103])
        by smtp.gmail.com with ESMTPSA id 1sm10749022pff.180.2020.05.11.21.21.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 May 2020 21:21:12 -0700 (PDT)
Date:   Tue, 12 May 2020 09:51:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        daniel.lezcano@linaro.org,
        Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Javi Merino <javi.merino@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 00/14] thermal core include cleanups
Message-ID: <20200512042110.drvrtnwj5tynnkqo@vireshk-i7>
References: <cover.1589199124.git.amit.kucheria@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1589199124.git.amit.kucheria@linaro.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-05-20, 17:54, Amit Kucheria wrote:
> I noticed some remnants from when thermal core could be modular. While
> cleaning that up, I fixed up the includes to be sorted alphabetically and
> included export.h in files that were using EXPORT_SYMBOL* or THIS_MODULE
> while at the same time removing inclusion of module.h from core files.
> 
> Finally, the names of the source files for the governors and core have some
> inconsistencies and the last couple of patches rename them.
> 
> Build and boot tested on some ARM boards.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
