Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D766AC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF18B207E8
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 12:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="Vba3/YBp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbgFRMht (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 08:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729051AbgFRMhq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 08:37:46 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F2F3C0613F0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 05:37:46 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f185so5488517wmf.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 05:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OgZomFoj/7toYCBCKWRo7nq/kYdKAWeXt05LtEajY3k=;
        b=Vba3/YBp135F4zjZnb2RedWXF2lwu1lFFL34CLaNpxPjPTPlt0UR472eYi5S4YZ1Wx
         Z0rDK+6Hs9d3o0cUOdxwi2SS36Jq5bWlnav7DNmZNgJpcMQ+D8caGFIGg/ORh0SmmPxl
         k69/g/gWD8TgMCYkGiY2Wz/GRty0LMQ/SrbXk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OgZomFoj/7toYCBCKWRo7nq/kYdKAWeXt05LtEajY3k=;
        b=QbtLU0O9SNJ+midHajtm5Ag4+c6enVNwRCroG/5Kh90Ny6X+thZYhOHLS0iyOZGDr+
         GaEe44xIynsquRdcpFebVG1yEGuRw8TBUV+C0dsWtcj7v+XDhbn5DwLrKkni+C3IkGBZ
         +ubyNSSso0Ny7r89rNtt7xqLPv+6taQbOKfJQBxJHp38zUDl8rEwDsG7xm0x7qvr6Nv7
         Rr4DJ1+9NzZ9Xym//2okbZj8YPBMODgzJPsQcjUE3vBz1u+qhb8EybIuywJj7y78AJsp
         8znhhGFQ5crq2fK6w04uXA4ATCa5/5YZrTBZX0eSVObToPBuDf8ZCYFTHH76wkRYGHo+
         4Y2Q==
X-Gm-Message-State: AOAM5313iWSlpusAFIXY1bzpohq+49o2AdP537K+Z6Oq3mk+GO9kLa0S
        2V0+BmmfS6WM+44+O9bH/l2c+w==
X-Google-Smtp-Source: ABdhPJzFoWSkp2MqAS0xx92RSUWbWQ0U7Z92SQ/MTtOdoN5z3gnxoKRC/r81z8qHIYMjhulYtZARyw==
X-Received: by 2002:a1c:4143:: with SMTP id o64mr3734793wma.157.1592483864725;
        Thu, 18 Jun 2020 05:37:44 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
        by smtp.gmail.com with ESMTPSA id t82sm2586962wmg.10.2020.06.18.05.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 05:37:43 -0700 (PDT)
Date:   Thu, 18 Jun 2020 13:37:43 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
        Michal Hocko <mhocko@kernel.org>,
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
Message-ID: <20200618123743.GA694719@chrisdown.name>
References: <20200521095515.GK6462@dhcp22.suse.cz>
 <20200521163450.GV6462@dhcp22.suse.cz>
 <CA+G9fYsdsgRmwLtSKJSzB1eWcUQ1z-_aaU+BNcQpker34XT6_w@mail.gmail.com>
 <20200617135758.GA548179@chrisdown.name>
 <20200617141155.GQ9499@dhcp22.suse.cz>
 <CA+G9fYu+FB1PE0AMmE-9MrHpayE9kChwTyc3zfM6V83uQ0zcQA@mail.gmail.com>
 <20200617160624.GS9499@dhcp22.suse.cz>
 <CA+G9fYtCXrVGVtRTwxiqgfFNDDf_H4aNH=VpWLhsV4n_mCTLGg@mail.gmail.com>
 <20200617210935.GA578452@chrisdown.name>
 <CALOAHbBp7Ytd-Hta9NH-_HJtVTAsR5Pw2RYrVScp7PPezCEv2w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CALOAHbBp7Ytd-Hta9NH-_HJtVTAsR5Pw2RYrVScp7PPezCEv2w@mail.gmail.com>
User-Agent: Mutt/1.14.3 (2020-06-14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yafang Shao writes:
>On Thu, Jun 18, 2020 at 5:09 AM Chris Down <chris@chrisdown.name> wrote:
>>
>> Naresh Kamboju writes:
>> >After this patch applied the reported issue got fixed.
>>
>> Great! Thank you Naresh and Michal for helping to get to the bottom of this :-)
>>
>> I'll send out a new version tomorrow with the fixes applied and both of you
>> credited in the changelog for the detection and fix.
>
>As we have already found that the usage around memory.{emin, elow} has
>many limitations, I think memory.{emin, elow} should be used for
>memcg-tree internally only, that means they can only be used to
>calculate the protection of a memcg in a specified memcg-tree but
>should not be exposed to other MM parts.

I agree that the current semantics are mentally taxing and we should generally 
avoid exposing the implementation details outside of memcg where possible. Do 
you have a suggested rework? :-)
