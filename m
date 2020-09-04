Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9547EC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 04:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66EFA206CA
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 04:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DQf1WCSb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726245AbgIDEjB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 00:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbgIDEi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 00:38:57 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D368CC061245
        for <linux-kernel@vger.kernel.org>; Thu,  3 Sep 2020 21:38:56 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id c3so306214plz.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Sep 2020 21:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=AKTidWnwKMw/87YvP/dGXFFvii+sZrfhQX2pdgUJdtI=;
        b=DQf1WCSbvh8LYmj1RwJAM4L0XhBwekQFu+N0ulyWtHXptKWrBc+L2xqTlrjd5HhEhA
         KVjTkQBP8cwtzBx7YKImywEPPFQkmci4NSjwUr/Qt8YcnDxekDfTyKn81efv1iEgmXgX
         pYnkSJEvK+ssG5qzqL32QBuqIlP4Iw3X0OlXlZbB0ExyCtylrZDFcnB8PzrYz3MhwLyt
         WXPdPr/oJqEqnSk3Px6R2I61Paysm6hrM4AjMXSdc4XYxaMI8IVarnbnxoiIta2dq2Jb
         emFreT0HlGa1M4SB8fm8E3F/xs86KWYwY2Gmcdra0JeBz4LW/VCg8qOYPJNS5SFaqN6r
         BBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=AKTidWnwKMw/87YvP/dGXFFvii+sZrfhQX2pdgUJdtI=;
        b=Wvny1/WbEnkp0uigrERYQfrpjNjxjsCL7U3nSHo+BpNlPJB/JxRtgrscEhneq457FN
         XLWNvfg0U8Dv2PK7OvI20wf6NGCn+Xr7QLra+QloYg0C6gM3gPU3QtlZ935H2VWYCHd+
         Dyx7czATeOsXp7q7wlW1WekTH6GaxMaKVRQaMdGncW/Vp+4sNNxbEAGv+yn18+sCE/CV
         ZrtTnhN9HHHFuT/QOWGIjrqdzN78L+hJ4r6/KHtE9Eg5mQuF9vm4pSf6i9nLEeIC+N/E
         JeZavto+kzaB/++4DN6Evcjn/AW2CRR+UmdInvu/QVhdJ9RDQz9kiHfBrefjykOo1gzb
         Hirw==
X-Gm-Message-State: AOAM533ZfQltN7boqeQasVDH2W/QDhHL0ZDwxUX8SOYl0TYUuPvClk0D
        THW3xwkpRdb5qFT33MGCQa3xEg==
X-Google-Smtp-Source: ABdhPJxTg37soXGgDTI6jsVCoUh0jZdyWwZdRnirV7gCcasqpJbOVIuYIA43vleVX2nA+Ln5g5brXg==
X-Received: by 2002:a17:902:7606:: with SMTP id k6mr7287372pll.171.1599194335296;
        Thu, 03 Sep 2020 21:38:55 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id f10sm990844pfk.195.2020.09.03.21.38.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 03 Sep 2020 21:38:54 -0700 (PDT)
Date:   Fri, 4 Sep 2020 10:08:47 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     rjw@rjwysocki.net, dietmar.eggemann@arm.com,
        catalin.marinas@arm.com, sudeep.holla@arm.com, will@kernel.org,
        valentin.schneider@arm.com, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/5] cpufreq: improve frequency invariance support
Message-ID: <20200904043847.g4ss3o4uofwujnyk@vireshk-i7>
References: <20200901205549.30096-1-ionela.voinescu@arm.com>
 <20200903133203.GA29370@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903133203.GA29370@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03-09-20, 14:32, Ionela Voinescu wrote:
> Hi Rafael, Viresh,
> 
> Would it be okay for you to apply this series, as the majority of
> changes are in cpufreq? For arch_topology and arm64 changes, they have
> been reviewed and acked-by Catalin and Sudeep.
> 
> Also, please let me know if I should send v6 with Sudeep's Reviewed-by/s
> applied.

No need to resend. Rafael will apply these with the tags.

-- 
viresh
