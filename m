Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62CDAC47247
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 13:00:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3EDDD214D8
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 13:00:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CvFkioWP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbgEIM77 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 08:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgEIM76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 08:59:58 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B719C05BD09
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 05:59:58 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id s20so1918596plp.6
        for <linux-kernel@vger.kernel.org>; Sat, 09 May 2020 05:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Xj1T5YhvcvBwjGMJQVL7Y5xOMpKxjTRljl4dKQ9HXJo=;
        b=CvFkioWPZs+/vvAZ+Voj7zix8SnckXQ6RWMT0akzkWEfkwaFK/PLHcZaC5kxZE8Fxq
         1vx3VBzxpahwyVqwlOFH5JknOvVXQ8fF+vaSA/UUG+zJX38cVbzxuEZmI/ELtxJw5/sN
         PIQPGi9SSZ2Z/cSBBhF2unEZA+56ostGZ4+wHcAzXRcul4uK93aBOrvuhgyNs9SXSHJq
         NZJm4vY9vY8Y7jNUSbeoE+nRhzPMu0YHNhpeRUuPUhO2hnImUdWjXHZapJLNVZr1R+Tk
         61OKI5t3DqZx2gi7wpqnw7SKXFrtEnMuKGWVtHpg82WE4DQiuOzbP5Try5cSTej6jmyP
         BQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Xj1T5YhvcvBwjGMJQVL7Y5xOMpKxjTRljl4dKQ9HXJo=;
        b=qfKGb8S6AVlTQ4Dn8Xl5NHkVOp5cF99mJ5hrCSph+zygz0Cvll3zYvDTlJBSKpH7Rr
         Y75KSefVXxJBSl84wvrjiKQ9BdTH6bGFEb/Hg3CSnRpQKDrgaMySBK1JFasJn7S7ySGj
         1TbryQEAirc2+PMor7VYt5wuqyyaA/VcbuBAxpQMw1AgLurSysVrDm6KiBNrK8qN96n/
         HOJ3kvO1KJXVYmM/niLfMBUQnNdr2zIOCxyO7BfDRG7EgztdeWHqDNh71y/ds0BUz0JL
         ezQXENKttfxmcNLciLigRfG04syf9rmy6KHkvvHKmyOauNB3etW4up/+UQ2crfglPDv1
         4XiA==
X-Gm-Message-State: AGi0PuYCobKsXjuJ9Xv5EfbZx6TQkMXaAOy+vvFN4BEeKVx7Mr+9V9pV
        Oo+0f9GCjpkZGP6O/C22g/lzNQ==
X-Google-Smtp-Source: APiQypKBuBxoge/WoRey+HXDRJR/KwDvY4v6JT6FlgETkFS/2RfUCD9RD8qn0q0SidSfKsq4mMpKzw==
X-Received: by 2002:a17:902:9a08:: with SMTP id v8mr6763383plp.90.1589029197880;
        Sat, 09 May 2020 05:59:57 -0700 (PDT)
Received: from dragon ([80.251.214.228])
        by smtp.gmail.com with ESMTPSA id y63sm4540692pfg.138.2020.05.09.05.59.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 09 May 2020 05:59:57 -0700 (PDT)
Date:   Sat, 9 May 2020 20:59:44 +0800
From:   Shawn Guo <shawn.guo@linaro.org>
To:     Konrad Dybcio <konradybcio@gmail.com>
Cc:     freedreno@lists.freedesktop.org,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        David Airlie <airlied@linux.ie>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        zhengbin <zhengbin13@huawei.com>,
        Rob Clark <robdclark@gmail.com>,
        Ben Dooks <ben.dooks@codethink.co.uk>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thomas Gleixner <tglx@linutronix.de>,
        AngeloGioacchino Del Regno <kholk11@gmail.com>,
        Sean Paul <sean@poorly.run>
Subject: Re: [Freedreno] [v2 PATCH] drivers: gpu: drm: Add MDP5 configuration
 for MSM8x36.
Message-ID: <20200509125943.GC26840@dragon>
References: <20200509104812.202981-1-konradybcio@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200509104812.202981-1-konradybcio@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 09, 2020 at 12:48:10PM +0200, Konrad Dybcio wrote:
> This change adds MDP5 configuration for MSM8x36-based SoCs,
> like MSM8936, 8939 and their APQ variants.
> The configuration is based on MSM8916's, but adds some notable
> features, like ad and pp blocks, along with some register
> changes.
> 
> changes since v1:
> - add an ad block
> - add a second mixer @ 0x47000
> - adjust .max_width
> - write a more descriptive commit message
> 
> Signed-off-by: Konrad Dybcio <konradybcio@gmail.com>

Subject prefix "drm/msm/mdp5: " seems to be more idiomatic as per
git log of file/folder changed here.  Other than that:

Reviewed-by: Shawn Guo <shawn.guo@linaro.org>
