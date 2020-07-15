Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21217C433E5
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 02:22:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDEF620729
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 02:22:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="RJbb5FSy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728115AbgGOCWB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 22:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbgGOCWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 22:22:01 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA7AC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 19:22:01 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id e13so467273qkg.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 19:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NB5VkdcJiOiqkvi9GdDmHtiKnXecniHwA3U0Zar/EsI=;
        b=RJbb5FSyUf9z+6g4s1r5uE8Chir674PlvuH/V9UgTJAuimjkAv7KcWxlw4pw421B4Y
         ZCzfZLGnWA9XL0zDFauyZsARle30TexAJczLPnjG40KR23K7lZGD/b/I6XJNb5hhciOY
         433PibC2uc4PjO5G3lIr5KJhJ6Q60wBenTCBOJ7OpwzfdjAKHmH4gFU2itO53OOI+1lM
         qniBRA6HTKeE+DEWGRWY2vKw7wKQrkUCXsBkd4C81iOL5631sW1bLgZMrFNzo2UC+y23
         /wP/ScBv4EamuEDbK7cQoGDF8I7wi92twB6iE0ZRAw9mW0JF63vZi1B7GyN9zins3ISi
         7s7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NB5VkdcJiOiqkvi9GdDmHtiKnXecniHwA3U0Zar/EsI=;
        b=TAB/03A7fs5p9ob1cUbvZ6HUBdVfRTHC7gK9mW8XiXl/9a86CuKhsZ837i3x2QB54Q
         Ef1jEWAkBROgNBiYxyPrhdF132pKvtCTrKuaZxoJxIypl5EaTiFDpjdpWN2tQSm2Tcx0
         aAF1/aujFs74Nju69tfOijsHlfgZlM7JLxkbidmLBWOSdnE+Gt3kHFbgx1j7wyxYeuMn
         VkGLLuAFjKcIp3nrn5bfiqEfNJLauKVnPkeVGBZExw6xm1rF67RB80dDNOLcEqzLM73A
         b/KAj+7dWq3zGjr9KUQpO7OzM0owEfQFOOGvy0TJmEsAUI7xDuBuzbgZxU6tQqc7SKgL
         mJ1g==
X-Gm-Message-State: AOAM531IiK/uix4fmsLJdUbuoLVykMQtQoL/d3ofDoKT5smtPj04I6av
        LfHMzWFO9gsMRV9oKckLkY/YDA==
X-Google-Smtp-Source: ABdhPJzRXPD1i0Ii1MhhJShUTtAlh2BeRBcqHwD8WR6YWmiupLF/I+F63MitweZ7P0ea6uQGo3cQKg==
X-Received: by 2002:a37:9fc2:: with SMTP id i185mr7298465qke.481.1594779720113;
        Tue, 14 Jul 2020 19:22:00 -0700 (PDT)
Received: from lca.pw (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id d136sm751977qke.47.2020.07.14.19.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 19:21:59 -0700 (PDT)
Date:   Tue, 14 Jul 2020 22:21:53 -0400
From:   Qian Cai <cai@lca.pw>
To:     Oscar Salvador <osalvador@suse.de>
Cc:     nao.horiguchi@gmail.com, linux-mm@kvack.org, mhocko@kernel.org,
        akpm@linux-foundation.org, mike.kravetz@oracle.com,
        tony.luck@intel.com, david@redhat.com,
        aneesh.kumar@linux.vnet.ibm.com, zeil@yandex-team.ru,
        naoya.horiguchi@nec.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/15] HWPOISON: soft offline rework
Message-ID: <20200715022152.GA54790@lca.pw>
References: <20200624150137.7052-1-nao.horiguchi@gmail.com>
 <20200630050803.GA2747@lca.pw>
 <20200714100839.GA1939@linux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200714100839.GA1939@linux>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 12:08:46PM +0200, Oscar Salvador wrote:
> On Tue, Jun 30, 2020 at 01:08:03AM -0400, Qian Cai wrote:
> > Even after applied the compling fix,
> > 
> > https://lore.kernel.org/linux-mm/20200628065409.GA546944@u2004/
> > 
> > madvise(MADV_SOFT_OFFLINE) will fail with EIO with hugetlb where it
> > would succeed without this series. Steps:
> > 
> > # git clone https://github.com/cailca/linux-mm
> > # cd linux-mm; make
> > # ./random 1 (Need at least two NUMA memory nodes)
> >  start: migrate_huge_offline
> > - use NUMA nodes 0,4.
> > - mmap and free 8388608 bytes hugepages on node 0
> > - mmap and free 8388608 bytes hugepages on node 4
> > madvise: Input/output error
> 
> Ok, sorry for the lateness, but I had to re-fetch the code on my brain again.
> 
> I just finished v4 of this patchset and it seems this problem is gone:
> 
> # ./random 1
> - start: migrate_huge_offline
> - use NUMA nodes 0,1.
> - mmap and free 8388608 bytes hugepages on node 0
> - mmap and free 8388608 bytes hugepages on node 1
> - pass: mmap_offline_node_huge
> - start: hotplug_memory
> offline: Device or resource busy
> offline: Device or resource busy
> offline: Device or resource busy
> offline: Device or resource busy
> offline: Device or resource busy
> offline: Device or resource busy
> offline: Device or resource busy
> offline: Device or resource busy
> offline: Invalid argument
> offline: Device or resource busy
> offline: Invalid argument
> offline: Device or resource busy
> offline: Device or resource busy
> offline: Device or resource busy
> offline: Device or resource busy
> - pass: hotplug_memory
> 
> The test seems to suceed and no crash on the kernel side.
> 
> I will just run some more tests to make sure the thing is solid enough
> and then I will post v4.

Great, I plan to reproduce a bit more of the crash below which I am not 100%
sure yet which patchset/patch is the culprit where that LTP move_pages12
reproducer does the similar things.

https://lore.kernel.org/lkml/20200708012044.GC992@lca.pw/
