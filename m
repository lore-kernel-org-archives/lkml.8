Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C36C433EA
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A70EF20714
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 14:17:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="bJZ16ap+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728845AbgGUORx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 10:17:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbgGUORw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 10:17:52 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8216CC061794
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 07:17:52 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id lx13so21833836ejb.4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jul 2020 07:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=92B9Cr8GU+Q5NgJRD18dkOQr+Iz15oRaXg+fWztZRyA=;
        b=bJZ16ap+pQMf7ty/juukMn4SocAmm/ff1ygm7N0ZhctiTX7Ns9EKRvJFGiWSYr6Fae
         MsLGWGopirywHezMYylNS3uCobm9k23Lu1ehcGBHC7UAgBWqRN2J7FceziM5zoLy3S5G
         nffshkNWk9HRgb8P+dihyPwG9xY0ajeCk1dpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=92B9Cr8GU+Q5NgJRD18dkOQr+Iz15oRaXg+fWztZRyA=;
        b=hGmIstVhigfpHk6EmwAYaZTeIcnCvwVU1f2TY4CTbtKz4orttqsulhVRn4+2I2kEUC
         ipgJ+MQS4KIq1DBcFxstb6uD34dMX8olGaoXJCA64LruVKTGd3r4ftlxUNM+uwe3yQ7r
         ZSkrVuwM8TgpbyhPIfIbawZws2Adl/DIqcqzWgomaHS+HGDNH1eCFVE1WQ6VHZafYrmB
         Xeived83Rtys6ZzyBU3G7ccDsnrIW7EJN7RL6clecEXB43j57UgfOUYsIj2g5xcSVPTY
         0jZzEw5P4goIg1v3NRuEiy42k2Kj1DEehFR2HFqLQ7CAeI1bDo0ItWYo+QY9XCOk2VGf
         Qc/Q==
X-Gm-Message-State: AOAM5330hX7n/afY4bW5X1WDDY7jVAwMIiwvHojDrn07zHDW/crrQgiQ
        kCo0PB+GyZ7X0H5RfYsjTbUW86sdlH+hQg==
X-Google-Smtp-Source: ABdhPJyccHcLc9w0tbdjL2+q9etH/eT/z0pNkYnnAk8OzzAk4DWaXSVGwWP1HddfI+2gNfO3RmPNWg==
X-Received: by 2002:a17:906:f907:: with SMTP id lc7mr20435966ejb.143.1595341070869;
        Tue, 21 Jul 2020 07:17:50 -0700 (PDT)
Received: from localhost ([2620:10d:c092:180::1:70f9])
        by smtp.gmail.com with ESMTPSA id cw14sm17469727edb.88.2020.07.21.07.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2020 07:17:50 -0700 (PDT)
Date:   Tue, 21 Jul 2020 15:17:49 +0100
From:   Chris Down <chris@chrisdown.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
Message-ID: <20200721141749.GA742741@chrisdown.name>
References: <20200721063258.17140-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200721063258.17140-1-mhocko@kernel.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I understand the pragmatic considerations here, but I'm quite concerned about 
the maintainability and long-term ability to reason about a patch like this.  
For example, how do we know when this patch is safe to remove? Also, what other 
precedent does this set for us covering for poor userspace behaviour?

Speaking as a systemd maintainer, if udev could be doing something better on 
these machines, we'd be more than receptive to help fix it. In general I am 
against explicit watchdog tweaking here because a.) there's potential to mask 
other problems, and b.) it seems like the kind of one-off trivia nobody is 
going to remember exists when doing complex debugging in future.

Is there anything preventing this being remedied in udev, instead of the 
kernel?
