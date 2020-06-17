Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFEEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85DDD20734
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="d+J+aw6Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgFQOJH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 10:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgFQOJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 10:09:05 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14907C0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 07:09:02 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id h5so2499499wrc.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 07:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q/YL4Tzx4ADMiyqvj4Ve2wziFTGT/p0DVcYFG6HXk08=;
        b=d+J+aw6Zm5XRvlxRf1UGsdkDdw/4mdWlAseuLVRmjuRl77imTs8xnEwfCx3+/GfmIn
         bikdBwRjyQV2FhPxZDoxaryjSxXvxqhpXbUEuGGRJ6XKTOw9aHhfZNDGhlxVfd4s8+dB
         zPJBHP+Y5JfMrXFtfl1BiiRwc2CLhSP1/aSVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q/YL4Tzx4ADMiyqvj4Ve2wziFTGT/p0DVcYFG6HXk08=;
        b=OLj7c5ofJru+CKYsUfVeWLQj3i3Si9ibY4LekgR8LXyUupFBvISwjQUcsPKyxYJaPL
         BDwyE6InEJQux6+opzWN81dazlxTmeX8ZIvZ3qHN1mcQGdi7c0MPku6BHQxnYLetXjoW
         OMt82E3vnEW17lZqnm3D5E3FNnYa3IS1l5bNemETIO0Q4DeZLnrb9SNIsGOtNpT9CnEH
         1CI9klMFkRS9HoKNQm7NcaerItH1hlT1H3tpkBUZuzfKj1ttXRC7rjFQDlQLi01lp+2C
         0LXNAwpzW05s+TA7k/KjPgSeYDzm1dPHlvqIoVAE0jkyjgMYKaTWrVVAh03WR7aycqYX
         3zdw==
X-Gm-Message-State: AOAM530svbC1tN+BSPjYSbkXQMMtmmFXXjBD7pxxdWMMg7v/KUh0XJLY
        5EUdRWiTdQWWqjoXLzga3UDnQA==
X-Google-Smtp-Source: ABdhPJzL0eIzzTI+SzZBoqt3/b7Xundx14ukkyOPthT2L2+/VFT7bPwecalJL/jau7TXAMBO1wA5IA==
X-Received: by 2002:adf:fd48:: with SMTP id h8mr9338191wrs.226.1592402940724;
        Wed, 17 Jun 2020 07:09:00 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id o6sm33035118wrp.3.2020.06.17.07.08.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2020 07:08:59 -0700 (PDT)
Date:   Wed, 17 Jun 2020 15:08:59 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        "Linux F2FS DEV, Mailing List" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, Arnd Bergmann <arnd@arndb.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Chao Yu <chao@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Chao Yu <yuchao0@huawei.com>, lkft-triage@lists.linaro.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Cgroups <cgroups@vger.kernel.org>
Subject: Re: mm: mkfs.ext4 invoked oom-killer on i386 - pagecache_get_page
Message-ID: <20200617140859.GB548179@chrisdown.name>
References: <20200519075213.GF32497@dhcp22.suse.cz>
 <CAK8P3a2T_j-Ynvhsqe_FCqS2-ZdLbo0oMbHhHChzMbryE0izAQ@mail.gmail.com>
 <20200519084535.GG32497@dhcp22.suse.cz>
 <CA+G9fYvzLm7n1BE7AJXd8_49fOgPgWWTiQ7sXkVre_zoERjQKg@mail.gmail.com>
 <CA+G9fYsXnwyGetj-vztAKPt8=jXrkY8QWe74u5EEA3XPW7aikQ@mail.gmail.com>
 <20200520190906.GA558281@chrisdown.name>
 <20200521095515.GK6462@dhcp22.suse.cz>
 <20200521163450.GV6462@dhcp22.suse.cz>
 <CA+G9fYsdsgRmwLtSKJSzB1eWcUQ1z-_aaU+BNcQpker34XT6_w@mail.gmail.com>
 <20200617135951.GP9499@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200617135951.GP9499@dhcp22.suse.cz>
User-Agent: Mutt/1.14.3 (2020-06-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko writes:
>and it makes some sense. Except for the root memcg where we do not
>account any memory. Adding if (mem_cgroup_is_root(memcg)) return false;
>should do the trick. The same is the case for mem_cgroup_below_low.
>Could you give it a try please just to confirm?

Oh, of course :-) This seems more likely than what I proposed, and would be 
great to test.
