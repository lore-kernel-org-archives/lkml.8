Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D71DDC34056
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA17D208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 19:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="HSImXs47"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgBSTRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 14:17:09 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:44621 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgBSTRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 14:17:09 -0500
Received: by mail-qt1-f196.google.com with SMTP id j23so1036500qtr.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 11:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rANX/Xd0q5oumfVjHme1j9P+031qDgStPNCqoS/CWNk=;
        b=HSImXs472qEzrnVI+WL7Nop5RBlDH02Ti0aEwsTdZ4cSXbYVeBHGUJ469Zly4yC2gR
         jBMOl0dEmEC36yW5IHEYw0JYVWKAnqu8OxEHSMuV/K+joeaLqY3cLHhwcgZsCGoXuMjX
         t8PEhn5xfL7/e2amuMCadASeZa+BmzA8yLgCo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rANX/Xd0q5oumfVjHme1j9P+031qDgStPNCqoS/CWNk=;
        b=QDhwFi7Cww0BgA/QpF2VldfY+b8ZZSs+UIV1syLvWQBJGhfdemO74P4qS30kPE5q/o
         1WfiFfh+TmnfDX7XIPQ6EYaf12ldgJFrnc5MTXCRgn+fVGIdIsAMopRoh0Z+3cSNMUGh
         0RHmTS/kjGeEhTGp7o9U1n36qekT86J7bOGP8tTfpMVxuSWmS1rrzMdwg3D6OlcuIfal
         /X5zl4d6XPoBF1Dxxgav3mt7sc6X1+uXn7XW+CAGcsVZ26WkNp2AUZj8vkTDhB/xEqcm
         5eXX7Dqxe8imhwlsAD4RMK/hrcXre6DT5+dHtF8xhIVUa5Q0Od9/yJtlNeKpsDTES19K
         2SFQ==
X-Gm-Message-State: APjAAAUxUsqP3pP1i8BcMyo0pQbcOLYhn/RbhS2ABW6J5xBFsqh7i7WZ
        L/3C9pfIzqry18DE3AR6PHQ2tg==
X-Google-Smtp-Source: APXvYqzuBiEv0vvgKtn5PNq1EZZbkyC5xuZeib29M2sEV7JjYUoe8S+nrCLA/Pu970K3tyH+0yzpyQ==
X-Received: by 2002:aed:2584:: with SMTP id x4mr23824321qtc.343.1582139826677;
        Wed, 19 Feb 2020 11:17:06 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::37cd])
        by smtp.gmail.com with ESMTPSA id w202sm324923qkb.89.2020.02.19.11.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2020 11:17:06 -0800 (PST)
Date:   Wed, 19 Feb 2020 14:17:05 -0500
From:   Chris Down <chris@chrisdown.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH] mm: memcontrol: asynchronous reclaim for memory.high
Message-ID: <20200219191705.GA1357312@chrisdown.name>
References: <20200219181219.54356-1-hannes@cmpxchg.org>
 <20200219183731.GC11847@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200219183731.GC11847@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko writes:
>On Wed 19-02-20 13:12:19, Johannes Weiner wrote:
>> We have received regression reports from users whose workloads moved
>> into containers and subsequently encountered new latencies. For some
>> users these were a nuisance, but for some it meant missing their SLA
>> response times. We tracked those delays down to cgroup limits, which
>> inject direct reclaim stalls into the workload where previously all
>> reclaim was handled my kswapd.
>
>I am curious why is this unexpected when the high limit is explicitly
>documented as a throttling mechanism.

Throttling is what one expects if one's workload does not respect the high 
threshold (ie. if it's not possible to reclaim the requisite number of pages), 
but you don't expect throttling just because you're brushing up against the 
threshold, because we only reclaim at certain points (eg. return to usermode).

That is, the workload may be well-behaved and it's just we didn't get around to 
completing reclaim yet. In that case, throttling the workload when there's no 
evidence it's misbehaving seems unduly harsh, hence the ~4% grace, with 
exponential penalties as there's more evidence the workload is pathological.

So sure, memory.high is a throttling mechanism if you *exceed* the stated 
bounds of your allocation, but this is about even those applications which are 
well-behaved, and just brushing against the bounds of it, as is expected on a 
system where the bottleneck is at the cgroup rather than being global.
