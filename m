Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845ACC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 638C6206C3
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HIHVwEf3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389471AbgF2Ukm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:40:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731694AbgF2TOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:14:10 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF79C0086E5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 02:37:56 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id b6so15805974wrs.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 02:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kmk9PEgAXfYX2bQEnnaPEK9UG50WCVEeb9HUTIaZ6ks=;
        b=HIHVwEf3uKroAtkA2j00G2TvjJVsfI5vDmYQo9hgKekYiEtoI6uJu6QrzkRwqxv8/r
         hhbT2XlYMBMMTmZaTiyqQEdhfeeqSk5d393nidVqZa5EqXWLksVDv47GnfB5KRC3n0Ha
         1w68QHUmBBMvKngmvdR5yOM+rAPrgxUrVoqJexgAdhRr+7XgRmTWNHhw16n2gFqwB4LM
         rCpenAik59TMHvWskoZrozvBkNw0X60EA0TYO32KvhlyN/L8YqfhRFYvpRuQG3wWacqj
         kVFfQWTN5lghDM45tj8fKPm3AV5/Bfw/NuDkwrrZ2oSTro+dGeVFIQmifl1BuXvTy2UV
         i2Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kmk9PEgAXfYX2bQEnnaPEK9UG50WCVEeb9HUTIaZ6ks=;
        b=YqsUh6s1Vly33U/tgARSyPiB19Jp7GqKivok/YgHoSo+d6sG1GYvLqzeY4EMy/chLs
         L+rt7wlICK0coC/SX4nqC+bGfhHGbWRiQfq8Fb25Etn3cTKpr0GsiCUP/taklwc5476B
         CuWFhFjSuCs+x5m81kbYgehl85U5RlYcY7lBeRMle7VhFA4irWz/9ADsbkv/3XLaqzga
         XZCz44JtEpgDvu6ITjFSsMyL/8b9OOAyxUMJXKGin893t7PBYRbFNLJt94biAdNkxuUv
         qeBJ/FwkSrlQMwyfLRYrZmGCPYbEgWm+vDOBZqKILunKLYD3XlS8ZP+M8iB5FVGTwe8/
         O7TQ==
X-Gm-Message-State: AOAM533x9JV+izN11MVJCyn6Ag2jQrfpUiCqHSpP94tQGFOK4+TQQN17
        6wkC/t4w5cTZMESOkU2HfHVOjw==
X-Google-Smtp-Source: ABdhPJx6Z/8IkgiDv1TC0Pn03hEfVmplxyRbpiorG1BP0etmk31pED46eotBFiDcjMQIaBTwUldYHg==
X-Received: by 2002:adf:ff8d:: with SMTP id j13mr15755850wrr.11.1593423474559;
        Mon, 29 Jun 2020 02:37:54 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id e23sm9731999wme.35.2020.06.29.02.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 02:37:53 -0700 (PDT)
Date:   Mon, 29 Jun 2020 10:37:50 +0100
From:   Quentin Perret <qperret@google.com>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        kernel-team@android.com, tkjos@google.com, adharmap@codeaurora.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 1/3] cpufreq: Fix locking issues with governors
Message-ID: <20200629093750.GA1228312@google.com>
References: <cover.1593418662.git.viresh.kumar@linaro.org>
 <fdc55a7550a6a6a95dab1c80ff94d461b8ba0664.1593418662.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fdc55a7550a6a6a95dab1c80ff94d461b8ba0664.1593418662.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 Jun 2020 at 13:54:58 (+0530), Viresh Kumar wrote:
> The locking around governors handling isn't adequate currently. The list
> of governors should never be traversed without locking in place. Also we
> must make sure the governor isn't removed while it is still referenced
> by code.
> 
> Reported-by: Quentin Perret <qperret@google.com>

Reviewed-by: Quentin Perret <qperret@google.com>

Thanks!
Quentin
