Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA3D1C2BA1A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 02:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCAF820781
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 02:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IU+Y8FC1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbgDFCrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Apr 2020 22:47:31 -0400
Received: from mail-pj1-f45.google.com ([209.85.216.45]:52655 "EHLO
        mail-pj1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726536AbgDFCra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Apr 2020 22:47:30 -0400
Received: by mail-pj1-f45.google.com with SMTP id ng8so5875475pjb.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Apr 2020 19:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=L6SxNTH0XCWDO08MCGA5S5MO0ksHJfV/AHJr6LODNPc=;
        b=IU+Y8FC1HgrRO7zZYpgPFhW60uh9eThxh3QDAZ/VQTqk5dBvwQM4tQvblvHBTfbhRF
         h5AWfiNmRda3SCFQCGzNB2HXzyV1DFAcZjmV4utwJ9i5sYoxLC4pvfqTDsGXWRanOHM5
         IjNO//0yKYBuV+cERjO3wVLA28MJQ0BNzhiPmsepcPXuetITV+ToQoLYfNAjgACND7Yz
         /uwVwFCTH4HxhtrAhjKy0sXh885LhUVWkw+c0ljeN9IellHp20qkJ+yJKMphn3+DBuoP
         aw0UVSx6CLLk5wsUnisR1KTsqJG30mclb76p3JOwW8NgevbPP42EAhRhwsUhPPAROSz3
         Ej0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=L6SxNTH0XCWDO08MCGA5S5MO0ksHJfV/AHJr6LODNPc=;
        b=DV8yaJIiOi8s6mfMwyKH8NDRlKDO6p8NgiY5eeCasV4Nkj8cBI6g5YV163Tq6Y591B
         kbLarY9QLdcpuSQO5dUIIodEJMO5TlRH67mW3y1PJFSDbIBOFxgQWIa+T1n1VefOdaW1
         Q0KLtVpYWSj7mPsTUYNKrjJomkD/WITcv7+m4LrEJF+nvU7wS4e4cZ46FiBLa7xNBGp8
         CScd87ND4858pybHmSy6HoRILQghfZ3Z+EpohRYMY6CTYMXBz7YMOv0wwaENf3yXMIo7
         XmPLTUJEd3EBzwQN9yFhfQTHXqMzojFjDN2TZSM5ianiFwOCftZigQlwDvJMLauxMPMt
         6RSg==
X-Gm-Message-State: AGi0PuYOF62OvsVh37rZ71VqAEB9Gf8MLHJJfZ8DL0qfwh/pkVn5FWhm
        24/LXbxXaZjkWfWqS8K3f/hHFQ==
X-Google-Smtp-Source: APiQypLMEEARny7oaHdWXifOwzMJe8n167aqCyuBqUeiCXSRo4rYgte0KaxMXgcl8IifcQeVl/Iqhw==
X-Received: by 2002:a17:902:7485:: with SMTP id h5mr18244419pll.205.1586141249322;
        Sun, 05 Apr 2020 19:47:29 -0700 (PDT)
Received: from localhost ([122.171.118.46])
        by smtp.gmail.com with ESMTPSA id b25sm10385040pfp.201.2020.04.05.19.47.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Apr 2020 19:47:28 -0700 (PDT)
Date:   Mon, 6 Apr 2020 08:17:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sumit Gupta <sumitg@nvidia.com>
Cc:     rjw@rjwysocki.net, catalin.marinas@arm.com, will@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, talho@nvidia.com,
        linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bbasu@nvidia.com, mperttunen@nvidia.com
Subject: Re: [TEGRA194_CPUFREQ Patch v2 0/3] Add cpufreq driver for Tegra194
Message-ID: <20200406024726.sbtutqsv2t2p2gkg@vireshk-i7>
References: <1586028547-14993-1-git-send-email-sumitg@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1586028547-14993-1-git-send-email-sumitg@nvidia.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-04-20, 00:59, Sumit Gupta wrote:
> The patch series adds cpufreq driver for Tegra194 SOC.
> 
> v1[1] -> v2:
> - Remove cpufreq_lock mutex from tegra194_cpufreq_set_target [Viresh].
> - Remove CPUFREQ_ASYNC_NOTIFICATION flag [Viresh].
> - Remove redundant _begin|end() call from tegra194_cpufreq_set_target.
> - Rename opp_table to freq_table [Viresh].

Have we concluded the earlier discussion already ? I posted some
questions where I had doubts and you just answered them and posted a
new version. Please wait for the reviewers to have a chance to reply
to them. Your new version may be okay, but still we can avoid another
set of patches which may be wrong.

-- 
viresh
