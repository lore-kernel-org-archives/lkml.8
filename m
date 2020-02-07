Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812B6C352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 11:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55B5B222C2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 11:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PsGEa1/K"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727045AbgBGLDG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 06:03:06 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50616 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgBGLDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 06:03:06 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so2139466wmb.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 03:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=lc+UKzDCEQ2twAErbpT+nUTNnxbVGiuy49uJ4xpQ64Q=;
        b=PsGEa1/KKslVaQjygUoCaqH50y3bxGSj4Qrt3BFeuwBykFqsyuPvNIciPQHEdXiXGw
         KXyE1mN+E/cRhmKY3mWE9fo78QXZb8V/g78GT/9b+tSK3qK69+idWSZowW8+QCZXEt7Z
         uxPL+hQeo6m2q+y1rAY+bzj0UFHLThCAiDrvoIZhKLzdVSl4z1d5sKdnD8w6chff90RJ
         UtD/FGiFxPwbbL10pq6zpU7sz+6FIog1+hQN0/fZy6jpzowbSpD9hcD9M2ACHAZBC/BJ
         1hUPZp+FAW9i7uHhno7xsow8VFKXfX14qxR9e78MHrlzfeguJrND0+NdKTby1D9HvW/i
         Bgfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lc+UKzDCEQ2twAErbpT+nUTNnxbVGiuy49uJ4xpQ64Q=;
        b=VgShwA44noEgf5BOVpIoYmT/MlEFzrkO7pYSGu/kF1sExW5T4GTVb97mnB3NCb4ST6
         pqcPH9zI6bgjxV3Iemotd1evNB2RAVS+8zS067UqmqDoVImI8VoJDJGx73ct0hnaf8LL
         iGYNdI1vHdAuEUEo2+I0dB1eS73tcFCeix33o9QoR95ScixvaNwUDXShrkGnljp6Wz1Y
         Zr59UC7nKPLQfc/+pLzlKKpx3D0Ngvp48DMg6bQhScdut2+GLNla9K3aPwudATfKEbn9
         HNz7S+fQU/qnEaxcEq7qP+DSs6S+RJ/qkcQXdFYtQfQn1Jdux/vC+eG/B8Q8MZNmAK5c
         x9sQ==
X-Gm-Message-State: APjAAAWc26WogfG1CvaD3JxN0wSl9kCQAg6ud+FwPu4oiAHzre7Ro4BF
        w8lz68jH/5r7B34O5oK7P6RSWPp7wtc=
X-Google-Smtp-Source: APXvYqxPusJ+uOOiK76zmYCwBUv3/qt7BPqYxV44+rNxRaow4kEr26ivgxhbWC/yCxfoLYgiD+lwsQ==
X-Received: by 2002:a7b:cbc9:: with SMTP id n9mr3873380wmi.89.1581073383931;
        Fri, 07 Feb 2020 03:03:03 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id s8sm3054287wmf.45.2020.02.07.03.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 03:03:03 -0800 (PST)
Date:   Fri, 7 Feb 2020 11:03:00 +0000
From:   Quentin Perret <qperret@google.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        adharmap@codeaurora.org, pkondeti@codeaurora.org
Subject: Re: [PATCH v4 2/4] sched/topology: Remove SD_BALANCE_WAKE on
 asymmetric capacity systems
Message-ID: <20200207110300.GA239598@google.com>
References: <20200206191957.12325-1-valentin.schneider@arm.com>
 <20200206191957.12325-3-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206191957.12325-3-valentin.schneider@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 Feb 2020 at 19:19:55 (+0000), Valentin Schneider wrote:
> From: Morten Rasmussen <morten.rasmussen@arm.com>
> 
> SD_BALANCE_WAKE was previously added to lower sched_domain levels on
> asymmetric CPU capacity systems by commit 9ee1cda5ee25 ("sched/core: Enable
> SD_BALANCE_WAKE for asymmetric capacity systems") to enable the use of
> find_idlest_cpu() and friends to find an appropriate CPU for tasks.
> 
> That responsibility has now been shifted to select_idle_sibling() and
> friends, and hence the flag can be removed. Note that this causes
> asymmetric CPU capacity systems to no longer enter the slow wakeup path
> (find_idlest_cpu()) on wakeups - only on execs and forks (which is aligned
> with all other mainline topologies).
> 
> Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
> [Changelog tweaks]
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

Reviewed-by: Quentin Perret <qperret@google.com>

Thanks,
Quentin
