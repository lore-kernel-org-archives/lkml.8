Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,
	URIBL_BLOCKED,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A953C352A2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 11:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41053222C2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 11:04:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sB7E81O0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbgBGLE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 06:04:27 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55209 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726819AbgBGLE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 06:04:27 -0500
Received: by mail-wm1-f65.google.com with SMTP id g1so2091488wmh.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Feb 2020 03:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xem4yoLuDiGV1bFoT24QkK2yom3EsuSvS2kCT0Ylemk=;
        b=sB7E81O03DAYYirI0STiqZz4jkisdzyh4QLhgZeHcXYv/up1tW5uVj6EdjxkrQ0S4b
         6w2UdXI6dlmHpzh/VCUufKsIm5GMvCU4uvX5mfB1Xf/qgsl7Mj+tf08L12zzxyN8FXPX
         Y3WsshQ0WD7RZRXwRt8cnShPj6hgoMN0KUQPGba2Px4PaBJ5J4+AQe3Jpw9tOPui+hI5
         3eoByWTsgs53Lm7ca0U0QDe5qbKdXDg31+nhdirswNHc4gS+Yo9qRK0yKpb4GkgM5ZiN
         S6KGuzymCJZkxhuAAl1lTg0GYVei9bxMvVEOKY0nRNeCq0Wup45ZJ8Uq1hxjc9pvs5Qi
         cQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xem4yoLuDiGV1bFoT24QkK2yom3EsuSvS2kCT0Ylemk=;
        b=QcynJ3ljt+rFF9jDzhR4WrjIfloDh1+QHWv6s80/ZN+cwnhvJBjI9nK8ZLNZhrpudE
         KznKe0Bchk7qRW0j3PYp/7WEj98ppxUllakLGpoI21rPNqaaRvydNRce6clPU+kr8Nw+
         g3WVy+RvujXiaQGN17obXkl6HBsbiAe+s7B89Gjyb9oVR3BqsbKjCL4hwbDTzOnVepu2
         S5h/hO+hrC1DTVOCHH1ZWo3FPt6Ot5gwQawqNambsdHiUmF5xVXEXWIMnFpEDiM1oQTu
         F9m78O0JA7SbQGbW38Ppb4AZBZ6BvMxUvQ4ZeOgIQkT2Gx16LbRxpoZjg2g3k48MPV2M
         dBQA==
X-Gm-Message-State: APjAAAWdYToe2Nnpq+3KQp1xVpVu1H4RHMU54uONEiaTzwTCDXXszfBX
        rwCt1LqH3uyQPkQhH3or+dM5vKn4CIM=
X-Google-Smtp-Source: APXvYqxJjFVzHV+6wGIr8CKHK6HrnJiHWiUhDJzDF8gH1iuSQVLpHkURpeITG8MIjdqvu8WfshEHuA==
X-Received: by 2002:a1c:4e01:: with SMTP id g1mr3686698wmh.12.1581073465865;
        Fri, 07 Feb 2020 03:04:25 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id w22sm2817179wmk.34.2020.02.07.03.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2020 03:04:25 -0800 (PST)
Date:   Fri, 7 Feb 2020 11:04:22 +0000
From:   Quentin Perret <qperret@google.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        adharmap@codeaurora.org, pkondeti@codeaurora.org
Subject: Re: [PATCH v4 3/4] sched: Remove for_each_lower_domain()
Message-ID: <20200207110422.GB239598@google.com>
References: <20200206191957.12325-1-valentin.schneider@arm.com>
 <20200206191957.12325-4-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206191957.12325-4-valentin.schneider@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 06 Feb 2020 at 19:19:56 (+0000), Valentin Schneider wrote:
> The last remaining user of this macro has just been removed, get rid of
> it.
> 
> Suggested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>

Reviewed-by: Quentin Perret <qperret@google.com>

Thanks,
Quentin
