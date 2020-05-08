Return-Path: <SRS0=wESH=6W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C90C38A2A
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 427DD20735
	for <linux-kernel@archiver.kernel.org>; Fri,  8 May 2020 13:18:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ove31f7p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729437AbgEHNSx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 May 2020 09:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728689AbgEHNSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 09:18:45 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4CCBC05BD43
        for <linux-kernel@vger.kernel.org>; Fri,  8 May 2020 06:18:44 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id m12so5230381wmc.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 May 2020 06:18:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4KMLQ4EJCkyzbgYa2IJD+khf7hToXVbXh2lcQiHZtv0=;
        b=ove31f7pciE4Fbhm6NDLjUI9JBlFL/PA3cUZfCszFLpIChGlte7eSbOLZymdajQ9kK
         gvPBvpGJZMgMzeDA1EWhE0mUt1GnwHlyuFs+gm9exfx6IXGGNHzVY4W50lYSmpTxaCsr
         60fGF+UTCK5hnkhDKeZlzt0pslaA7Y4MwXdN6ESNWcuWEQBFvqVx6K1UAb/+sraNF90l
         xMAMizHB0CVXKviA38ftlh3FUyyE1yDtVKxWT6kZls3slkOAl0Q435rKgLdXkdtvuOtf
         FVitAidX3tCzTkx6dJUJxHvvAArCb6NPH2LSG4Egd+Ea7/031fRzmYTwHdvZh+FaQx0J
         x81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4KMLQ4EJCkyzbgYa2IJD+khf7hToXVbXh2lcQiHZtv0=;
        b=tOcSO3lXmyCTANxLnCcKd4fL97pXnBe+ibFiruG7BSNTgkZHLpAhoFV+pNyny5YBdB
         xBzYhXw6Ikm5VFsxy62zkwNL1keWWc/fyPkcC8WfwSWouaXBX/Tnb7DMpCu4qxCQkfhe
         Ecfuy02o6KLtQZ4V/0SBq7b2bekExD/P4r89ufYlzNGv+ydlEMFZ2eaRB0ElcNv9rbjb
         5tMfY639lgtP2zhpRzXR1LnRp3do2aXHU3QOW7jNIjZjCpL6A4MFwy/YKa+GKEItLMJt
         Gm50PAs7Ri7M2+oUG/tgh4gCWYxr2rVyid26Mg/K9cFg098Le/mopJz6kcEV07Qs1xll
         n+5Q==
X-Gm-Message-State: AGi0PuaycTSH51JOJcml6Jch/Z0mOLldHatot/l5lnQM7cznMa2fYQhX
        Gfekj35p6o25oMsP5oBD6ZjfTg==
X-Google-Smtp-Source: APiQypJdRU9stBd3NG3JUQJliF1xwamMgT+gqtFcU/P7BSs1kniXBB4NJN4eJrTemJwu3kbPfB9g1Q==
X-Received: by 2002:a1c:c345:: with SMTP id t66mr17057953wmf.189.1588943923328;
        Fri, 08 May 2020 06:18:43 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id m82sm988007wmf.3.2020.05.08.06.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 06:18:42 -0700 (PDT)
Date:   Fri, 8 May 2020 14:18:39 +0100
From:   Quentin Perret <qperret@google.com>
To:     Pavan Kondeti <pkondeti@codeaurora.org>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, sudeep.holla@arm.com, gregkh@linuxfoundation.org,
        rafael@kernel.org, viresh.kumar@linaro.org, peterz@infradead.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, mcgrof@kernel.org, keescook@chromium.org,
        yzaikin@google.com, fweisbec@gmail.com, tkjos@google.com,
        kernel-team@android.com
Subject: Re: [PATCH 04/14] sched: cpufreq: Move
 sched_cpufreq_governor_change()
Message-ID: <20200508131839.GD10541@google.com>
References: <20200507181012.29791-1-qperret@google.com>
 <20200507181012.29791-5-qperret@google.com>
 <20200508053523.GH19464@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200508053523.GH19464@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 08 May 2020 at 11:05:23 (+0530), Pavan Kondeti wrote:
> In the previous patch, you removed reference to schedutil and replaced it with
> " an EAS-compatible CPUfreq governor (schedutil)". May be you could do the
> same here.

Good point, I add it to the todo list for v2 ;)

Thanks,
Quentin
