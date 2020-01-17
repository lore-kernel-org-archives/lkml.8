Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70528C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 13:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F1F120661
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 13:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="drX53zdM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgAQNpI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 08:45:08 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:39331 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgAQNpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 08:45:07 -0500
Received: by mail-wm1-f43.google.com with SMTP id 20so7679036wmj.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 05:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JwGNcsaOwsdIGiFLCGnm5OvJExu3K0oz+leXPxDq+dM=;
        b=drX53zdMo95yuNUFI0I80VLnpmJtKrMRgWPQQYp7UeRCAVhfMHHoQ4YwFYzOINerTn
         6r3OHhDnw9QpzzY6Z3hnM07NKQ18wcEMc55XmbOmdfI7p8zXtfIILcYNG9e/APANB8+i
         J4z83lkMz/0RxBatK4dpsjZbKM3vNt4hk+FoL4OreMPD7xxjc4yJlPlDMvCrc8NZN5Je
         TFf4j+93CwOPoH4Hznj0BORQmmu+Z3yGHJMc/0FeyZKooxDGSuKQcXdVCo75MqyrPO64
         EeMUi504XvJTJ8W/grBBzu/WdKG/pLeDHbwJUdAGy1+S3+lnlT77TqUxh2rZtypjQ3+g
         G/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JwGNcsaOwsdIGiFLCGnm5OvJExu3K0oz+leXPxDq+dM=;
        b=X7z0fssn5aKXAP+VpP+g7j7EQKq6J8oF2JWW3UVzXXDxQmIBYpO9DBQ1kExL4s1Pwb
         SzIuKoFItFPX1YFcNR0mh2OILW0xSP8DtEKtu4sNOxk8zjgJ81nXlbT3zgdcosK6YcLK
         B3Hb8q2wPKCSrts2OBMhVT26P68QBFBVOkNmaVV6enKPCaOyotfO0bhPOGkev1vvWnN8
         gLHlzWwpDQvduu62UDdakMN6TkpJfT4XI/qB8t1qjf3f/A4l3r973mszA29zeyYNCfkr
         /9KckjLnZsNqY++4EU8kT/bcTdpnxE1nRIfZRj166ARm86j0ddg2/S2QAxTRjxFe2LcH
         WGTA==
X-Gm-Message-State: APjAAAVROB6LohYv3ZufkBsgCgJGziYp4r2+2ymCsm9sIdMcNxzmoD7C
        UeNhLG9X7juD+OLtqqGKA3LCUQ==
X-Google-Smtp-Source: APXvYqxK24GB+JQs5elRO7cgGfHabNkPefr7EPhZ06YGAC8Ffup6LXwkJYMhSvc7TeG6Bpn68+3ysw==
X-Received: by 2002:a05:600c:251:: with SMTP id 17mr4652620wmj.88.1579268705289;
        Fri, 17 Jan 2020 05:45:05 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id z187sm10126098wme.16.2020.01.17.05.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 05:45:04 -0800 (PST)
Date:   Fri, 17 Jan 2020 13:45:01 +0000
From:   Quentin Perret <qperret@google.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thara Gopinath <thara.gopinath@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Ionela Voinescu <ionela.voinescu@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        viresh kumar <viresh.kumar@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Amit Kachhap <amit.kachhap@gmail.com>,
        Javi Merino <javi.merino@kernel.org>,
        Amit Kucheria <amit.kucheria@verdurent.com>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [Patch v8 4/7] sched/fair: Enable periodic update of average
 thermal pressure
Message-ID: <20200117134501.GA19008@google.com>
References: <1579031859-18692-1-git-send-email-thara.gopinath@linaro.org>
 <1579031859-18692-5-git-send-email-thara.gopinath@linaro.org>
 <20200116151502.GQ2827@hirez.programming.kicks-ass.net>
 <20200117114045.GA219309@google.com>
 <20200117123103.GB14879@hirez.programming.kicks-ass.net>
 <CAKfTPtALUU7SRmyU=u6-fxa8dkNWFrxE59JfYh+TmiDCqf0Kqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtALUU7SRmyU=u6-fxa8dkNWFrxE59JfYh+TmiDCqf0Kqg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 Jan 2020 at 14:17:36 (+0100), Vincent Guittot wrote:
> On Fri, 17 Jan 2020 at 13:31, Peter Zijlstra <peterz@infradead.org> wrote:
> > Sure, but we should still track the thermals unconditionally, even if
> > only CFS consumes it.
> 
> I agree, tracking thermal pressure should happen even if no cfs task are running

Bah, I got confused with cpu_capacity update stuff. This is for the PELT
signal, so +1 this should be updated unconditionally.

Thanks,
Quentin
