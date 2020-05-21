Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 326CBC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10F54207F7
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 15:02:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="SPCXhfg+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729923AbgEUPCS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 11:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729481AbgEUPCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 11:02:16 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 075E9C061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 08:02:16 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id j21so9233621ejy.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 08:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=L4UDchNoiuDX4tkUCL0dxdfAR6sFJ+v5DRcDTgeiOEA=;
        b=SPCXhfg+nCTAzglbOSxpGGWlT4LbcyT5ov7iVCRWlOjDg9vw3QGDFNbTOWFcM0RhsX
         2AiHhCFhMdO1ch6CMvgSCrtXVOLUYItHW4m86skN7YWl+QEHjVJ3hnwozUyrpbPbXJg9
         3AqRr6E5qlhw697AgVjHizpUyQ1BeM3NRaHuE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L4UDchNoiuDX4tkUCL0dxdfAR6sFJ+v5DRcDTgeiOEA=;
        b=mP2qggLnLwYnW4xb52talzF1YmgpyOhxhfN9FuqAMzHa8dXbcQUrvD8sTH2IYL/YHY
         Vi32yboD+ke8ytIAGbpE7Dpcou9JbDhdWZN7bdzRw0EMvpnN7i6DSRidKoZhlGf7xg8q
         XEnP9ld2P9udcxEnW4TK/o3ZGTk57FiYcTA4b50egdoQIt9WCoDSGuhBUO5ifPowLlU+
         GmHyrBnnyTh+lLrl5upKqBtEQJcxnWR8MqjD0oHEj0jhv7Tb28vhveK267ZULxwpfamU
         FlvGMRYyIxXmBH4Gp2kH1kxQBlLAgirocQX7vtg5o9IblU91hd4MtDXdzhKlcJPNfhbn
         DFzg==
X-Gm-Message-State: AOAM532/3AigIx8XM6eHHUattnPNoz/1laUUZKCH9K4x+7O3gt0PjFNP
        XgxyPlCFXSOrihBw22cGFM+oSA==
X-Google-Smtp-Source: ABdhPJz9snmtL4cGAURMbIiXEL18i41r6OCNFzdUZ/CRozM3v9OQUHLgtHyT9Dr6Nh1pnbBanYWl0w==
X-Received: by 2002:a17:906:2e0e:: with SMTP id n14mr3803821eji.545.1590073334624;
        Thu, 21 May 2020 08:02:14 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:4262])
        by smtp.gmail.com with ESMTPSA id b3sm5198656ejq.52.2020.05.21.08.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 08:02:13 -0700 (PDT)
Date:   Thu, 21 May 2020 16:02:13 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH] mm, memcg: reclaim more aggressively before high
 allocator throttling
Message-ID: <20200521150213.GH990580@chrisdown.name>
References: <20200520143712.GA749486@chrisdown.name>
 <20200520160756.GE6462@dhcp22.suse.cz>
 <20200520165131.GB630613@cmpxchg.org>
 <20200520170430.GG6462@dhcp22.suse.cz>
 <20200520175135.GA793901@cmpxchg.org>
 <20200521073245.GI6462@dhcp22.suse.cz>
 <20200521135152.GA810429@cmpxchg.org>
 <20200521143515.GU6462@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200521143515.GU6462@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko writes:
>> I have a good reason why we shouldn't: because it's special casing
>> memory.high from other forms of reclaim, and that is a maintainability
>> problem. We've recently been discussing ways to make the memory.high
>> implementation stand out less, not make it stand out even more. There
>> is no solid reason it should be different from memory.max reclaim,
>> except that it should sleep instead of invoke OOM at the end. It's
>> already a mess we're trying to get on top of and straighten out, and
>> you're proposing to add more kinks that will make this work harder.
>
>I do see your point of course. But I do not give the code consistency
>a higher priority than the potential unfairness aspect of the user
>visible behavior for something that can do better. Really the direct
>reclaim unfairness is really painfull and hard to explain to users. You
>can essentially only hand wave that system is struggling so fairness is
>not really a priority anymore.

It's not handwaving. When using cgroup features, including memory.high, the 
unit for consideration is a cgroup, not a task. That we happen to act on 
individual tasks in this case is just an implementation detail.

That one task in that cgroup is may be penalised "unfairly" is well within the 
specification: we set limits as part of a cgroup, we account as part of a 
cgroup, and we throttle and reclaim as part of a cgroup. We may make some very 
rudimentary attempts to "be fair" on a per-task basis where that's trivial, but 
that's just one-off niceties, not a statement of precedent.

When exceeding memory.high, the contract is "this cgroup must immediately 
attempt to shrink". Breaking it down per-task in terms of fairness at that 
point doesn't make sense: all the tasks in one cgroup are in it together.
