Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D925C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 00:17:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8833720748
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 00:17:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IObDWche"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgHGARF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 20:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbgHGARF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 20:17:05 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAD1C061574
        for <linux-kernel@vger.kernel.org>; Thu,  6 Aug 2020 17:17:04 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id z22so393323oid.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Aug 2020 17:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Gavykd+2vLnnt2gGTk57614KtJDYsrx6V5k98Xln/dI=;
        b=IObDWche80BL+i/Hy1JFZbDBC+NYVmdN9bS6OAXybp5hIVAQDv8ff2N2bUx9z0fljr
         /TZVX9AH7C1Qw+qSqCcjKZPL+ZwEiPb9VA8d5PfvZZf2YUOcQaBDbBmodzmDMYAzJPMo
         3/O75ciRa2VKkXTs9ZmDIKfWpyW22xKErZlrx70XXIiakb/8oCpJYYl24zen4QtwZbNZ
         OsDDLurOEA/9I4TgOJRYnRxHa5bHaHUOJLlFTI/j/XsCTCcz1R8pVp44u70WQixFuoB8
         mKbhpuCPS777TpPh4GJtDxKr3CQSSpiq0lbOrY5bJagmOOhQv5cVJe15+dwjtXXcmZte
         oiMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Gavykd+2vLnnt2gGTk57614KtJDYsrx6V5k98Xln/dI=;
        b=aEn36Jl4TeBpWCyO1r0/t6J4rNM9azBhPMqMjrz1Pycyp6Vlxfu9ai1qSh6C5k5iMv
         RPnBYJLOiewvf5omWGM3w64My6hJBm3g+1zhR1caQWz4QRI5ad9yookNOUiJDZWTtsRz
         oB9w1tHpRTwIs6eXQ+KcJJrxZhDsM36qeBuPmrwzZE1GiLCzWm+Gabe1ak6GKu7NoAT1
         YgI1kSNbbVZ1pWtr5v/WzDO+/iaH+XqqZJ2zJH+CEd2pOSy2QPJ4y0RzDygaRZk14Fe0
         9oAbThrsIjYO/7MLUew4TteKq6HoblUDaMnOajdODg3012JdA+J327LfH8vEJmvCaNG/
         cV6w==
X-Gm-Message-State: AOAM5302jBdjHZLdkc58n4VXKLbdXG0/3Ey25BPFBRFpm3QihcQHvYAr
        gHWl+x43gTHKF0p/W1ugdSCIUQ==
X-Google-Smtp-Source: ABdhPJzwoQWfF2OdbIP3ePfaQRSJCq8Dx8PimODb4RWpey1V9QbDgcy7WisG0HXyGyl7gmQFWCEz4A==
X-Received: by 2002:aca:4d12:: with SMTP id a18mr9473883oib.82.1596759423766;
        Thu, 06 Aug 2020 17:17:03 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id j37sm1495429ooi.2.2020.08.06.17.17.01
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 06 Aug 2020 17:17:02 -0700 (PDT)
Date:   Thu, 6 Aug 2020 17:16:31 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Roman Gushchin <guro@fb.com>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        kernel-team@fb.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm: vmstat: fix /proc/sys/vm/stat_refresh generating
 false warnings
In-Reply-To: <20200806233804.GB1217906@carbon.dhcp.thefacebook.com>
Message-ID: <alpine.LSU.2.11.2008061714440.12038@eggly.anvils>
References: <20200714173920.3319063-1-guro@fb.com> <alpine.LSU.2.11.2007291902340.6363@eggly.anvils> <20200730162348.GA679955@carbon.dhcp.thefacebook.com> <alpine.LSU.2.11.2007302018350.2410@eggly.anvils> <20200801011821.GA859734@carbon.dhcp.thefacebook.com>
 <alpine.LSU.2.11.2007311915130.9716@eggly.anvils> <20200804004012.GA1049259@carbon.dhcp.thefacebook.com> <alpine.LSU.2.11.2008051913580.8184@eggly.anvils> <20200806233804.GB1217906@carbon.dhcp.thefacebook.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Aug 2020, Roman Gushchin wrote:
> 
> Hi Andrew,
> 
> it seems that Hugh and me haven't reached a consensus here.
> Can, you, please, not merge this patch into 5.9, so we would have
> more time to find a solution, acceptable for all?
> 
> Thank you!
> 
> Roman

Thanks, Roman: yes, I agree that's the best we can do right now - Hugh
