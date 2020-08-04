Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E155C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 05:47:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85ACD206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 05:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hVuoAigv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728473AbgHDFrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 01:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725917AbgHDFrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 01:47:32 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB10FC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 22:47:32 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id p3so21496399pgh.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 22:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=vDqLDzenSWHFK8n0k98ye2lU5LkLmPsSvSRCb9qxZYw=;
        b=hVuoAigv2raGWMd83qJY6Xz7QDJMBlSMXKKSrBXoHU9m3M17SJ0c9uH6OmVJvDEF5N
         x4m6SqByvLXKRZXo592ojSYyEtM/vSn16TObpqVzepkkIa5oFHVouIlAZqGrC0iKtFxu
         n5JwBYVxv4i6Pp9FKOi27oNl62DBwhQC7jnKDiTyebSGmiFCJi/zvS8hrNAyQA6eVmqu
         u2i1M8JJ9VLoIo09Q3Op77rt3rhwbo99d+/C0DO7FHVT1AZReRC7RLVBHnDwX9uV6JXf
         duyoVekZpyrBIMsHNlVf2DbTqgD3gGzZqciEayJsPAYsloT+PjnPk1YLnlcFFSbHBedh
         iK+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=vDqLDzenSWHFK8n0k98ye2lU5LkLmPsSvSRCb9qxZYw=;
        b=b1G88rgVcgaEA0CfEMhdaKPHuN3W0/hBM9cpKHxZspYV/pJefNhZCsqthx5KJoeEou
         knpI6KuqQAug+TO4o1yGcU9vvoaayJKxFr9dXTCV1/TFPoDM3W4Pcxe3NRET5wp+Tz2X
         7UyCMD/MBbdEDA45EMu7CJ6ic9C8ePOzJ85whxD5pNpLgwbRiVtOpmG1q2SPh3IMHG3D
         Rd1EY2+JMIm5NA4qBTmEQ1cf1E3kA5hL2rLB+S57Xn9ugvoPsuZpA773ZBPyB9Ep2oF/
         dd92SnGg4uJVk8LmZdX0hqvydVfRRXtGSSx9d22SRXlcXTBL0pMZ8cnU8C2FVzQmT5kw
         2vyA==
X-Gm-Message-State: AOAM531xOqvdC6N/PVxl+konOYBaMdoLtdl9qW9YsFrm1mB1JG7unoCJ
        4khhw8Y+akSCiwVmu3r5vB3+eQ==
X-Google-Smtp-Source: ABdhPJypAAH2b4OuHX0Wo/y3QyqH1t6HOyEPeMQOxwksBRX1krFfIabU82XdsK7AvSB1E6Vh2xzU9A==
X-Received: by 2002:a63:210c:: with SMTP id h12mr17617691pgh.152.1596520052288;
        Mon, 03 Aug 2020 22:47:32 -0700 (PDT)
Received: from localhost ([122.162.244.227])
        by smtp.gmail.com with ESMTPSA id r7sm19970036pfl.186.2020.08.03.22.47.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Aug 2020 22:47:31 -0700 (PDT)
Date:   Tue, 4 Aug 2020 11:17:28 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Dongdong Yang <contribute.kernel@gmail.com>
Cc:     gregkh@linuxfoundation.org, rjw@rjwysocki.net, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-pm@vger.kernel.org, yangdongdong@xiaomi.com,
        tanggeliang@xiaomi.com, taojun@xiaomi.com, huangqiwu@xiaomi.com,
        rocking@linux.alibaba.com, fengwei@xiaomi.com,
        zhangguoquan@xiaomi.com, gulinghua@xiaomi.com, duhui@xiaomi.com
Subject: Re: [PATCH v3] Provide USF for the portable equipment.
Message-ID: <20200804054728.ojudxu5fmd54lar5@vireshk-mac-ubuntu>
References: <cover.1596464894.git.yangdongdong@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1596464894.git.yangdongdong@xiaomi.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-08-20, 22:31, Dongdong Yang wrote:
> From: Dongdong Yang <yangdongdong@xiaomi.com>
> 
> This patch provides USF(User Sensitive Feedback factor) auxiliary
> cpufreq governor to support high level layer sysfs inodes setting
> for utils adjustment purpose from the identified scenario on portable
> equipment. Because the power consumption and UI response are more cared
> for by portable equipment users. And the "screen off" status stands for
> no request from the user, however, the kernel is still expected to
> notify the user in time on modem, network or powerkey events occur. USF
> provides "sched_usf_non_ux_r" sysfs inode to cut down the utils from
> user space tasks according to high level scenario. In addition, it
> usually hints more cpufreq demand that the preemptive counts of the
> tasks on the cpu burst and over the user expecting completed time such
> as the ratio sysctl_sched_latency to sysctl_sched_min_granularity on
> "screen on" status, which more likely with more UI. The sysfs inodes
> "sched_usf_up_l0_r" and "sched_usf_down_r" have been provided to adjust
> the utils according to high level identified scenario to alloc the
> cpufreq in time.
> 
> Changes in v3
>   - Move usf.c to kernel/sched.
>   - Remove trace_printk and debugfs.
>   - Add document draft.
>   - Update comments.
> 
> Changes in v2
>   - Add adjust_task_pred_set switch.
>   - Move adjust_task_pred_demand declaration into sched.h
>   - Update comments.

Sending updated patchset for this isn't going to help you my friend. You need
people (maintainers) to agree on the idea here first. The patch can be
beautified later if required once the idea is agreed upon. I saw Peter already
gave his NAK to it during V1. You need to discuss with people here to see why
they don't like it first and as Greg said earlier, this should not go to staging
at all if it ever makes it mainline.

The more versions you send now (without proper discussions first), the harder it
will be for this stuff to get merged upstream.

-- 
viresh
