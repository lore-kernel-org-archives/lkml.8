Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2C1C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 11:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F5242072B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 11:48:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GkYwQUYO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727047AbgAQLsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 06:48:05 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:40491 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgAQLsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 06:48:05 -0500
Received: by mail-wr1-f48.google.com with SMTP id c14so22397352wrn.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 03:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=qqkxnrx3HzuDPmPjQfwC1GI4loEmDbDbTR3bN9P7ZZ0=;
        b=GkYwQUYOrsUVmzU0u/ktmDP996TPqL3/mEQu22A/PAwN9HhXEWUDTpXEcDYzyMKX+o
         2hj3xTydd1rjb3EOG9TI5P2lsgvo9gagL4MtLZaG/wEX3TVqflON8Nqy4oBqBoF4Xovc
         ddgItAXXurbywiUYt2Tai9Na/7RpRYTqlOmPOfQ2R7ptnDA4rEK0TSnYdECjqjSPh4PF
         8djpOoJwynZv/Il6EJ6gCybwMD96BADwXo346xhmAUfkHepemK1YLBbYNEieSVgNJb4W
         Wc02Z0NopIpLD+7ydzlddUy2fdC86uAud1w6Ueel1zRYxbjJWT5Jw7pfT18HK0JlPDCt
         Hi4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qqkxnrx3HzuDPmPjQfwC1GI4loEmDbDbTR3bN9P7ZZ0=;
        b=hHaWQJ2S4iCcHBNQ4k8UhM9myN38Q2gfRgx5ZP8N0+soLPXKXZeFJ1YpoqAMJL8v+M
         imCHkgPkhDkLNhMsHlDMEOL1G0OvLVoT/H1i40hHGwUgHrvw7bFAfDy1KtaJPjtFmgr5
         N5+/2P19NCNlGVNam+WGKlo51vkUdHymtgCWirKcVszZHJQJW4hTvk60biv5P582yRfd
         f8ZykHaKuDehz+YhyA4/CRYsc49RxC7AZZ78vq8u84kJJbJ+8IG1ACZRFak6XBaksP1R
         d0/vYZbik0IHYw25c419YCNX5areAwRJonwXukVVmguXD5W+YGgQd7pX0Tl1LMMT5VFH
         SBbA==
X-Gm-Message-State: APjAAAVZEstnwBsPlazXZnQaQsjqArjpw97Foupzt61jT+0fVWVw6Z4a
        ewqYD3z7Pe/pslK6jVcbtswU3A==
X-Google-Smtp-Source: APXvYqwwRw8rNfZci6g/8Dp0gQuxvHAtlDox1wQQnmfGO7HRw3bpYz4kxSfUFm69yLkEQ42LtbIRAw==
X-Received: by 2002:adf:eb8e:: with SMTP id t14mr2603060wrn.384.1579261682747;
        Fri, 17 Jan 2020 03:48:02 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id i16sm9709716wmb.36.2020.01.17.03.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 03:48:02 -0800 (PST)
Date:   Fri, 17 Jan 2020 11:47:58 +0000
From:   Quentin Perret <qperret@google.com>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, ionela.voinescu@arm.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rui.zhang@intel.com, daniel.lezcano@linaro.org,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        amit.kachhap@gmail.com, javi.merino@kernel.org,
        kernel-team@android.com
Subject: Re: [Patch v8 7/7] sched/fair: Enable tuning of decay period
Message-ID: <20200117114758.GB219309@google.com>
References: <1579031859-18692-1-git-send-email-thara.gopinath@linaro.org>
 <1579031859-18692-8-git-send-email-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579031859-18692-8-git-send-email-thara.gopinath@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 14 Jan 2020 at 14:57:39 (-0500), Thara Gopinath wrote:
> +static int __init setup_sched_thermal_decay_shift(char *str)
> +{
> +	int _shift;
> +
> +	if (kstrtoint(str, 0, &_shift))
> +		pr_warn("Unable to set scheduler thermal pressure decay shift parameter\n");

Nit: looking at kstrtoint() it seems that _shift will be left unmodified
upon failure. To avoid feeding a random value to clamp() below, perhaps
initialize _shift to 0 ?

> +	sched_thermal_decay_shift = clamp(_shift, 0, 10);
> +	return 1;
> +}

Thanks,
Quentin
