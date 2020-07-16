Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 172FAC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 03:35:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E8BE92075F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 03:35:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jsAfm+JT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgGPDf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 23:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726998AbgGPDf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 23:35:27 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C9AC08C5DD
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 20:35:26 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 1so3031373pfn.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 20:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=32gy8XoX3I4t0JZZ1KUze/2WJB+9G/goHCEZVw/rbtk=;
        b=jsAfm+JTZDUEV5ND1bWDoq+HtV3UNsUmLM88Nto4HvBpKTo4sRJK2E6n8gzy7DOQz8
         ri/kVxRdJRmElrtOD1q6sIWZ3QWiOwkOAeQswW5E7OkjybN8UsUBv4zLWdA7IQ2M8/sK
         b5HvF1VF6bMrPtIiwrQ00JGXYGOsVJlQrPn6JSi7egqM9SrV/1a9SCCzVqnazqxSwzDu
         9OWIdSz7/HDJbcoSwW7CvJoTi2KJS4T5pnlM1DjmvRsfx/WvDEc1yOTpuGW7pLVw+OnQ
         hZQx/pbnHQ7XID4vc+F4sb+arwtMG6eSKL2Am0vTQReYY46vZJ86TDPgGsPi1hUvuoXa
         5uaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=32gy8XoX3I4t0JZZ1KUze/2WJB+9G/goHCEZVw/rbtk=;
        b=gqhtwRmb91naGGnboKe+A8uc0dfxK/8zgUAHzT8vzS+DucWfJyMXCnsXISAinvaXq+
         /n3KF6+GN77paLfM2DgU8YQgjdUTJDkx3afyPBuBLvjiZfxI5BCcHI+w7Nev3mkD+o+I
         4MppTzEXhN5FrwQhgEAQlAWTjZMAeHWFnuQUeTn+VAlG4S/qL9SU7PlflkR1lFMBhOfq
         r2MBrdhyVQZHyZYaaaJ3jCNWJvQhCQYo2Wv+Ln3KSHVrCHldJ4bIZURNcyF+pz3F96lj
         KWip25+MagHWENw0ZPbLIhcyz8i3S0uYPRlrFE03+mJ1HxO5rTXFbBLpzaT1oFea9N3C
         JBvA==
X-Gm-Message-State: AOAM532SDW3969d/CnMyxyKxw8hgr3ap/VcfjePz6nbKdr/UWaAkPifS
        lY0vqTq0AF/0VtQW3uqtFlW2gg==
X-Google-Smtp-Source: ABdhPJycfZpepHR2R4Un/jr6qjGC1YgjN9Wo9S97UbquF2TaoOW9Luy33E0WLtrPkpArvp2nHxz0CA==
X-Received: by 2002:a05:6a00:15ca:: with SMTP id o10mr1989444pfu.169.1594870525980;
        Wed, 15 Jul 2020 20:35:25 -0700 (PDT)
Received: from localhost ([122.172.34.142])
        by smtp.gmail.com with ESMTPSA id o42sm3544975pje.10.2020.07.15.20.35.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2020 20:35:25 -0700 (PDT)
Date:   Thu, 16 Jul 2020 09:05:23 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     Jon Hunter <jonathanh@nvidia.com>, rjw@rjwysocki.net,
        catalin.marinas@arm.com, will@kernel.org, thierry.reding@gmail.com,
        robh+dt@kernel.org, mirq-linux@rere.qmqm.pl,
        devicetree@vger.kernel.org, talho@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bbasu@nvidia.com, mperttunen@nvidia.com
Subject: Re: [TEGRA194_CPUFREQ PATCH v6 3/3] cpufreq: Add Tegra194 cpufreq
 driver
Message-ID: <20200716033523.fhlfh5m5magifspx@vireshk-i7>
References: <1594819885-31016-1-git-send-email-sumitg@nvidia.com>
 <1594819885-31016-4-git-send-email-sumitg@nvidia.com>
 <d0a4a28a-f471-22bd-273a-dc5c62a79051@nvidia.com>
 <78636522-c433-a015-e4f3-02843ce58139@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78636522-c433-a015-e4f3-02843ce58139@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-07-20, 20:57, Sumit Gupta wrote:
> Sorry, missed to remove this. Will wait if any other comments before
> re-spin.

I don't have any further comments, maybe just send a new version of
this patch alone and name it v6.1.

-- 
viresh
