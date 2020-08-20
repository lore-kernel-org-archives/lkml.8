Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F94FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 04:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E89C2072D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 04:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YGCpuY4p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbgHTEzd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 00:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgHTEza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 00:55:30 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA210C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 21:55:29 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y6so492723plt.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 21:55:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GRp8cTUZBPo/wu89k8h8epcnL9DHpVbjZCAKx3RrQgQ=;
        b=YGCpuY4pBMHxmfFxopytOMMcB4y0x5jZmWAn5tHTr6WQO83cY7QCcUTIHjFA0m6AMo
         tJwdhlhX7Ux42xbhGjwhqc+syQa70uLkWCYUBbqTngTCUJeDBP1y2WZQscqfJWgn9BjH
         WHIzs+GR94AUsnwp+iTuSnps/HWIzS+tw0QtS0uO1aClkzYbb8wgCOheRc3dBoi44EJL
         5e+Z8EyM820gy3ugEzx/XipKaVfsVPq6wF5RPtUxcq+rU472Te70vboflFyyAIzO49xL
         +Cu/86gCi3IDElrFXPUF1/G5KY+nzGLDkKZ1yoAG3Om7An+U8JQMCb+AjmxJ6/LDTkDi
         Arjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GRp8cTUZBPo/wu89k8h8epcnL9DHpVbjZCAKx3RrQgQ=;
        b=lNitf4tPstN10o7OiNPZCeDCUWIteuKRPLsDZsSB8vYNeubfWx+SDiVdCf24ivfHnz
         oBCtC8sCzZBU/ln3OxFatDsuQunGOyyjhswYUfYtdMwOD+WI/4Lohj8PdZq5OxowHE6j
         F0617X6UG9vJuNYmXNy29HXwjwiKBJ23LZ1KIiy5puxUMxE/ZwpDvE8oDQIUDS4lmdVq
         eocb/rx9D/D0ndTxPuZr/Ai3P2yBt4+wQua9if6Au5fuw0FJ/AZ+s3S/YAnKbKkmSakI
         Em+lSJ6/zYzopWvz9oPfgcH8/OkGLirVmFf5sa8vEstRUXLy0Biy/YT+TNvh47XtKFqs
         pfRQ==
X-Gm-Message-State: AOAM5306gXnWHsZKWfCCXr33DVxfn52fjGYytQdfrZMlliWkadpxDYDt
        R+76lmbQQJ+PadLVaA11aR0SZA==
X-Google-Smtp-Source: ABdhPJzG08ZecwZe7DwN7GpfesIUWObmPDODV7kFoEhzxl57lAFc+7O9ZvYrzMFwxS5oOXPQZR6f9A==
X-Received: by 2002:a17:90a:6d96:: with SMTP id a22mr974996pjk.165.1597899329192;
        Wed, 19 Aug 2020 21:55:29 -0700 (PDT)
Received: from localhost ([122.172.43.13])
        by smtp.gmail.com with ESMTPSA id x18sm968281pfc.93.2020.08.19.21.55.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Aug 2020 21:55:28 -0700 (PDT)
Date:   Thu, 20 Aug 2020 10:25:26 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Subject: Re: linux-next: Fixes tag needs some work in the pm tree
Message-ID: <20200820045526.rj2qs6uodje4josp@vireshk-i7>
References: <20200820080117.6d7bcf00@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200820080117.6d7bcf00@canb.auug.org.au>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20-08-20, 08:01, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   ceac7fc18ac7 ("opp: Enable resources again if they were disabled earlier")
> 
> Fixes tag
> 
>   Fixes: cd7ea582 ("opp: Make dev_pm_opp_set_rate() handle freq = 0 to drop performance votes")
> 
> has these problem(s):
> 
>   - SHA1 should be at least 12 digits long
>     Can be fixed by setting core.abbrev to 12 (or more) or (for git v2.11
>     or later) just making sure it is not set (or set to "auto").

It came from the author and I failed to verify it :(

Rafael: Do you want me to resend the pull request with this fixed ? Or
something else ?

-- 
viresh
