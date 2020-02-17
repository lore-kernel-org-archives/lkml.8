Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89678C35254
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:31:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F62620679
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 09:31:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581931888;
	bh=mzkGD9potlVszLDz5F8Zdi0Sw4O2EHN6hfiSd4Xu5pg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oe2QkY9DXPPaN2PKQZCjByzQl6ezrXotmM2kv1oGZpwKBDVPkYEuPDabOrlLv9Fkx
	 8xE7909ICQZZbdbf0snv9efUzdNUl2eeuXWTKBJfyOcZU1N+GOsFu/egJpWPjmaoCH
	 I4V4AbdZRC0J0HTzIxgJaObDy9eMn2tRFyNnoeUo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbgBQJb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 04:31:27 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36014 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728773AbgBQJb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 04:31:27 -0500
Received: by mail-wr1-f67.google.com with SMTP id z3so18807780wru.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 01:31:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yfbEgRhj2XNfZTWjJfU4ec0xDbzJVHBVQVyxX2XDVls=;
        b=IoX/dpKQ4bQob6nTOrjiTdKz93oR0Ql9csmtWhXf4CTe8pfCg+I5wOhrOCJtFeHmpy
         jC+d4gP1KWDg+Xr1nRmkw5p4Pm0ZD7Mrxp8VQu0b5akEx30Z8ZMHP8oAYHObBbzjUWZW
         I8xOCUaLlMjLdUPYZAylX0luELkKG72KSbHHCF1IowP92s9uhnnjfzRV6rnz7xiC5jzG
         y+UpxwOctDBiBVDNvb/ac5goIqctz2ENqzeT2Lf24AJ8TUxt97DaB89MSRT4Rw8Tl8A6
         5DpUoZqv5MrBhk9DeOv2fGYLrsj+do/MsQc4OIupCNm0ZU6RY6ft5OL222FRWUfvGo7K
         R+AQ==
X-Gm-Message-State: APjAAAW71zUHa3xbtGmP+hYE4RbUpg7esiJ0JoHiBA9AXBWrqcNg2OVz
        /m8/HXdKZI3K1mEDNWvgJsFeMPiA
X-Google-Smtp-Source: APXvYqxyrOtSEpBxfGCz2utu7Odnr+3Luhc2eVU7hpep9K3tyuBOgKu7P4cmA4CJR7ZT0q7va1X6RQ==
X-Received: by 2002:a5d:5188:: with SMTP id k8mr21017538wrv.151.1581931885780;
        Mon, 17 Feb 2020 01:31:25 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id y1sm111830wrq.16.2020.02.17.01.31.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 01:31:24 -0800 (PST)
Date:   Mon, 17 Feb 2020 10:31:24 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Wei Yang <richardw.yang@linux.intel.com>
Cc:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, rientjes@google.com
Subject: Re: [PATCH v2] mm/vmscan.c: only adjust related kswapd cpu affinity
 when online cpu
Message-ID: <20200217093124.GH31531@dhcp22.suse.cz>
References: <20200214073320.28735-1-richardw.yang@linux.intel.com>
 <20200214085113.GP31689@dhcp22.suse.cz>
 <20200215003753.GA32682@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200215003753.GA32682@richard>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 15-02-20 08:37:53, Wei Yang wrote:
> On Fri, Feb 14, 2020 at 09:51:13AM +0100, Michal Hocko wrote:
> >On Fri 14-02-20 15:33:20, Wei Yang wrote:
> >> When onlining a cpu, kswapd_cpu_online() is called to adjust kswapd cpu
> >> affinity.
> >> 
> >> Current routine does like this:
> >> 
> >>   a) Iterate all the numa node
> >>   b) Adjust cpu affinity when node has an online cpu
> >> 
> >> For a) this is not necessary, since the particular online cpu belongs to
> >> a particular numa node. So it is not necessary to iterate on every nodes
> >> on the system. This new onlined cpu just affect kswapd cpu affinity of
> >> this particular node.
> >> 
> >> For b) several cpumask operation is used to check whether the node has
> >> an online CPU. Since at this point we are sure one of our CPU onlined,
> >> we can set the cpu affinity directly to current cpumask_of_node().
> >> 
> >> This patch simplifies the logic by set cpu affinity of the affected
> >> kswapd.
> >
> >How have you tested this patch?
> >
> 
> I online one cpu and confirm the "cpu" is the one we just onlined.
> 
> If my understanding is correct, this is the expected behavior.
> 
> >Also this is an old code and quite convoluted but does it still work as
> >inteded? I mean, I do not see any cpu offline callback to reduce the
> >cpu mask as all the CPUs for the given node go offline? Wouldn't the
> 
> You are right, I didn't see the counterpart for cpu offline. This is the
> question I want to ask. Seems we didn't handle it at the very beginning.
> 
> >scheduler simply go and fallback to no affinity if that happens?
> >In other words what is the value of kswapd_cpu_online in the first
> >place?
> 
> Some cases may this function be useful.
> 
> If we have a memory node which doesn't have any online cpu, the default
> cpumask is not set. After one of the cpu online, we want to change cpu
> affinity.
> 
> Or we want to add more cpu to the system, we could allow kswapd use more cpu
> resources. Otherwise, kswapd would be limited to those original cpus.

OK, so the usecase is when a NUMA node gains a new CPU which wasn't
there at the time when the node got onlined. Is this a scenario we
really do care about? While not completely impossible I haven't seen
a system which would allow such a runtime configurability. Maybe it
would be simply easier to drop the callback for now until we have a real
world usecase to support it and have it documented.
-- 
Michal Hocko
SUSE Labs
