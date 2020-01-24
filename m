Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37CFFC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 15:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0A59020709
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 15:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PkQyoXHR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730996AbgAXPLl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 10:11:41 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37351 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgAXPLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 10:11:40 -0500
Received: by mail-wm1-f68.google.com with SMTP id f129so2031984wmf.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 07:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MSzP1nd3Kx7vqywPp/7dbG7LJqsHWNmVUH7rdmRZlsg=;
        b=PkQyoXHRsVemhUe8B3wM2zzk7+xwN6OAx1TCiUF8l7X7+Jkc+0tdr0gA/10Lci+Ahd
         1EqMTOGp6F1eloojVizeqiAcruwIc458ZPYmyE90xF2GILWzqnqMPocalexRNTZt7MjO
         Bc28VK86QDyNmH61Csn5CQ80VkV9e8MhjHMgYWBiIU3QIUjgtx6VTRXfGigL1HH7LXXG
         BRpDYL3OxNbaktw9fi7uKFCAQVaPGY0eXHmrb6OZ6oOquZGWvZDre1Od4XMHESA2v6u0
         SF23fDIG2Du4HogPNmfF/xdofQdv3l67Zpzszxi5J5t6/qaF1wS5o+gNI+uXVxhJGVck
         AF0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MSzP1nd3Kx7vqywPp/7dbG7LJqsHWNmVUH7rdmRZlsg=;
        b=qmxXRSD5SF4jNIMQPjzbVNmgwtMaLrjo1ujiVYkZvhWKAqTXZOQmXWupzvZj0sW8nc
         t0QqJxaMeTVbHRZhlgsjbCrlvrDrLjRHp8hW8ZM+OeiLzk/fPz4PUq4YevKgewLtuuO2
         jNLRrvBn/ZPdfYbh5d5vYWzKUXvL6dFAyC5VSDtmilC763/k5GzODCmOsB2BD5s9koXD
         MMkHauBQtbEgusDTHmJiUdKJCdcyKXhWUbzd5C+E0LG4+BCyF5rPJf8GITUbSoR5pOCt
         TJUzrWKbTQsoQdvBHgJJsQM7qqPxfjVfqsvFIpJ8CPT/shg4R8mgwmtdAgI4NwmN1CxC
         1PGg==
X-Gm-Message-State: APjAAAWwu3ELrqHCVrcXmyxIJk/GENWNbwfbdR6cavk0hxZcOwCwcHK3
        ofmNuSjT02a/QzGjk2lnkcXaHg==
X-Google-Smtp-Source: APXvYqw6UxJDrFMRJMkWe2BNZvRd9O9oDldxc/xQ52qDwaZiCwxDtawacqgBkV37GnbU7Jf0rwTaeQ==
X-Received: by 2002:a1c:6755:: with SMTP id b82mr3548042wmc.127.1579878698529;
        Fri, 24 Jan 2020 07:11:38 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id o2sm6401901wmh.46.2020.01.24.07.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 07:11:37 -0800 (PST)
Date:   Fri, 24 Jan 2020 15:11:34 +0000
From:   Quentin Perret <qperret@google.com>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        adharmap@codeaurora.org
Subject: Re: [PATCH v2 1/3] sched/fair: Add asymmetric CPU capacity wakeup
 scan
Message-ID: <20200124151134.GB221730@google.com>
References: <20200124130213.24886-1-valentin.schneider@arm.com>
 <20200124130213.24886-2-valentin.schneider@arm.com>
 <00aa64e8-5e75-181e-a4f4-72c2ac64081c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00aa64e8-5e75-181e-a4f4-72c2ac64081c@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 24 Jan 2020 at 14:14:47 (+0000), Valentin Schneider wrote:
> If we fail to find a big enough CPU, we'll just fallback to the rest of
> select_idle_sibling() which will pick an idle CPU, just without caring
> about capacity.
> 
> Now an alternative here would be to:
> - return the first idle CPU on which the task fits (what the above does)
> - else, return the biggest idle CPU we found (this could e.g. still steer
>   the task towards a medium on a tri-capacity system)

Sounds reasonable to me.

> I think what we were trying to go with here is to not entirely hijack
> select_idle_sibling(). If we go with the above alternative, topologies
> with sched_asym_cpucapacity enabled would only ever see
> select_idle_capacity() and not the rest of select_idle_sibling(). Not sure
> if it's a bad thing or not, but it's something to ponder over.

Right, I would think your suggestion above is a pretty sensible policy
for asymmetric systems, and I don't think the rest of
select_idle_sibling() will do a much better job on such systems at
finding an idle CPU than select_idle_capacity() would do, but I see
your point.

Now, not having to re-iterate over the CPUs again might keep the wakeup
latency a bit lower -- perhaps something noticeable with hackbench ?
Worth a try.

In any case, no strong opinion. With that missing call to
sync_entity_load_avg() fixed, the patch looks pretty decent to me.

Thanks,
Quentin
