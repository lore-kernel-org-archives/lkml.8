Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E38C3F2D1
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5FA222522
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 18:34:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="Az2s3X85"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgCESe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 13:34:29 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40789 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbgCESe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 13:34:29 -0500
Received: by mail-wm1-f66.google.com with SMTP id e26so6820669wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 10:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wJ+dZCI2bt1Xd92Q8gcINy/Mjz00mboTvZOgg2MiZ/Q=;
        b=Az2s3X855Yee9bmXQu46ijVabcCPfzqRWC0fXIWABql9qvdRJREScafWu3/RuhgSZu
         j4zu1EG9DYlfH1ymfLDTZX07SiFFS4XIvrkPVnNZt41vphnMSbVDpEJJ5ssq1hWz3/L/
         xc3wSL5sORqcP4T1T/bEHP3MxEhe85fLbf6ZQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wJ+dZCI2bt1Xd92Q8gcINy/Mjz00mboTvZOgg2MiZ/Q=;
        b=XPh7cGJklqG2qYDhdyLMt+YaeZZNT1dxniDQH3o0toLB/noN7w3mJgKdn84yBVwekQ
         icXv+gdCDT9rSexyZLICC5fDz/YtYLiZKEbomvkt8MUyUEHCnu6A7i7GMCRstBTT6klq
         fPa2pB2dxXzZd9Vcw87yhCN8S9WBXIkmcsCdGp14wcyHzgITA64OPhwVTyQsE0t7hVKi
         N+/OlbPQ4P/2li72xtz6apjwkyWNevyLYrAq2YzdhlomtWcHiSIGzQWWO6wOroa/k1Ms
         r7GVbU2PyqbYlBxJwcWEpyXQMFOMMi5ghGOQCZHctyzsC6erFRJIjwdFUFHfiIF+IWcp
         lYSQ==
X-Gm-Message-State: ANhLgQ2pMuJAYCmPtDb5TlfF7k3g4cGLY99QInIDCqduTtuns23uZOSs
        DdxHqJ0BNYWhJylRPmX8afAmAw==
X-Google-Smtp-Source: ADFU+vvQkILMu/20lzgmWDM1ZZQvdG4mimL+9eMS9uDilaKhzhTYYE9iHYxOxeEPWCHv0qyCCN2hFg==
X-Received: by 2002:a1c:7c08:: with SMTP id x8mr102447wmc.71.1583433267434;
        Thu, 05 Mar 2020 10:34:27 -0800 (PST)
Received: from localhost ([2620:10d:c092:180::1:6808])
        by smtp.gmail.com with ESMTPSA id l4sm47313781wrv.22.2020.03.05.10.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 10:34:26 -0800 (PST)
Date:   Thu, 5 Mar 2020 18:34:26 +0000
From:   Chris Down <chris@chrisdown.name>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Michal Hocko <mhocko@kernel.org>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] mm: Make mem_cgroup_id_get_many dependent on MMU and
 MEMCG_SWAP
Message-ID: <20200305183426.GA752201@chrisdown.name>
References: <20200304142348.48167-1-vincenzo.frascino@arm.com>
 <20200304165336.GO16139@dhcp22.suse.cz>
 <8c489836-b824-184e-7cfe-25e55ab73000@arm.com>
 <20200305160929.GA1166@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200305160929.GA1166@cmpxchg.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Johannes Weiner writes:
>I would ack a patch that adds __maybe_unused.
>
>This is a tiny function. If we keep it around a few releases after
>removing the last user, it costs us absolutely nothing. Eventually
>somebody will notice and send a patch to remove it. No big deal.
>
>There is, however, real cost in keeping bogus warnings around and
>telling people to ignore them. It's actively lowering the
>signal-to-noise ratio and normalizing warnings to developers. That's
>the kind of thing that will actually hide problems in the kernel.
>
>We know that the function can be unused in certain scenarios. It's
>silly to let the compiler continue to warn about it. That's exactly
>what __maybe_unused is for, so let's use it here.

Yeah, this is exactly what I was trying to express in the first one[0]. The 
fact that this patch came around a second time, as expected, just solidifies my 
concern around the waste to human time.

I would also ack a patch that adds __maybe_unused.

0: https://lore.kernel.org/linux-mm/20191217143720.GB131030@chrisdown.name/
