Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A17B5C0044D
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 09:07:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77FB920674
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 09:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584349620;
	bh=lbJ/NxU6AE7SYcGhYuLd/rTGUR1Kq1ijNc5lUU5J+Qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=OsmOz/rKDbhgDsrGugPJJ4IZA6t5Fz2xoHm1Ascvq13sC4aq0QBm51pG/mZL42iS5
	 7uReCyaqGQKVgOH5bwNAv9+5mMRyrhWOqJJ00i2DHF72OzZqQrbiNjPq4JKJK0eLXY
	 OX4TUJbNNS+9TAZ3lpFQlytNqOQa8rRdqxp2gOXM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730330AbgCPJG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Mar 2020 05:06:59 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37839 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730152AbgCPJG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Mar 2020 05:06:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id a141so17053282wme.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Mar 2020 02:06:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Eia2N/xoriWTxgPunD084+bbaPhpeo+lfldsdFtSAnI=;
        b=CS4i9wXk9PSWHxVi3+ybUDYn+DBiqjVk9HhS64TYyorfMmF+7aVCSv56IsBbEMVQwv
         LRJfLONB4lg0NRW0hHOosvQSwkzsh65ZBahwXZTVN2N7s3H+4ogC0HjLc6V+GYvpRvq7
         mMIH6g34tY9ALCPtI3vah7Ic6W3XxF7r7AyWKXb7ibLDwzoOWHH9mbkah+vXzGkmGhxO
         dcyxy+d/ETUCjZLjoHDuV6z7iirQ0BCcFr2AGrXO4rRzFK1d6Pms1l+USGQRQiYWIwqE
         lDrExCdLCkRi6sUMRTddhtzwgG5cZ1A2rgYDfCgXPNqufFjSD9OHvGlOHAkSnVOAjGMa
         JRkw==
X-Gm-Message-State: ANhLgQ1NjY5Wj95LcFhyGoxON9DGfGgoV+3KhgA5oqT9F2DYhvMdvq3k
        HV2tgw7WCs18OqbABLSY+Qw=
X-Google-Smtp-Source: ADFU+vtWeEHQfTqTCceANDY21DeDfSr1E66N0BzW2u0PvcijS9Xo2cHFyYaR8gANISu8rCi+ihQx5A==
X-Received: by 2002:a1c:f204:: with SMTP id s4mr22977836wmc.127.1584349615207;
        Mon, 16 Mar 2020 02:06:55 -0700 (PDT)
Received: from localhost (ip-37-188-254-25.eurotel.cz. [37.188.254.25])
        by smtp.gmail.com with ESMTPSA id m17sm11793854wrw.3.2020.03.16.02.06.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2020 02:06:54 -0700 (PDT)
Date:   Mon, 16 Mar 2020 10:06:52 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Sachin Sant <sachinp@linux.vnet.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Mel Gorman <mgorman@suse.de>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev@lists.ozlabs.org, Christopher Lameter <cl@linux.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>
Subject: Re: [PATCH 1/3] powerpc/numa: Set numa_node for all possible cpus
Message-ID: <20200316090652.GC11482@dhcp22.suse.cz>
References: <20200311110237.5731-1-srikar@linux.vnet.ibm.com>
 <20200311110237.5731-2-srikar@linux.vnet.ibm.com>
 <20200311115735.GM23944@dhcp22.suse.cz>
 <20200312052707.GA3277@linux.vnet.ibm.com>
 <C5560C71-483A-41FB-BDE9-526F1E0CFA36@linux.vnet.ibm.com>
 <5e5c736a-a88c-7c76-fc3d-7bc765e8dcba@suse.cz>
 <20200312131438.GB3277@linux.vnet.ibm.com>
 <61437352-8b54-38fa-4471-044a65c9d05a@suse.cz>
 <20200312161310.GC3277@linux.vnet.ibm.com>
 <e115048c-be38-c298-b8d1-d4b513e7d2fb@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e115048c-be38-c298-b8d1-d4b513e7d2fb@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 12-03-20 17:41:58, Vlastimil Babka wrote:
[...]
> with nid present in:
> N_POSSIBLE - pgdat might not exist, node_to_mem_node() must return some online

I would rather have a dummy pgdat for those. Have a look at 
$ git grep "NODE_DATA.*->" | wc -l
63

Who knows how many else we have there. I haven't looked more closely.
Besides that what is a real reason to not have pgdat ther and force all
users of a $random node from those that the platform considers possible
for special casing? Is that a memory overhead? Is that really a thing?

Somebody has suggested to tweak some of the low level routines to do the
special casing but I really have to say I do not like that. We shouldn't
use the first online node or anything like that. We should simply always
follow the topology presented by FW and of that we need to have a pgdat.
-- 
Michal Hocko
SUSE Labs
