Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43058C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:42:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 190D320842
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579272134;
	bh=VZ5uMbxtpl0Luid9wrzbmKMBISeWWuZxMe/dI7xXvIU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cI8N+u+M9dVDo+FqrobWntMfW8MJn+3Cj1w96zVueERKA2AphgY71afPrwx4gev5a
	 3+GYJ9TV+9U+3Doxh7Yno2yF/EFH02cPtcp0KNe4CqaUEzFPn/1XW8ERDGG3lb/0AP
	 AIEv1SlKr/xOieobYwOTrZs5tOl5dqWTTIZSPGb0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728826AbgAQOmN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:42:13 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55179 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726951AbgAQOmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:42:12 -0500
Received: by mail-wm1-f65.google.com with SMTP id b19so7662881wmj.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jan 2020 06:42:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=l27XSLEjKU6VgUcqOxsElndg8dMBGVxtgq+CYtFeIUE=;
        b=bWvYjIhEw5xy4EOQNaVZ2aDDwjypGGUNtC1FjVwGPwgPakNHLdj7F8OJv4jYg0ATGr
         me04FZIPj9PfCAV00RndbbmFoW5UKguRbHCZDRuwSr2pYf610pxu3a/Un/exCWDNSpFP
         rk+cseu+Gi5G0bw89J/vwtSqAt35J7DvmPPdRYpi/FjBDA1P4wi0WQS/vHVTpEoX1VfT
         zQvjxJV9BTEIYH2u2hBRhH3oOkP0cZjlQMGFHbcwGWg0jdjafAuqBjc58kDR/fPeJCnM
         RQCwje/o7hHaTWMZBWpDMoPUMbVCxJAq/tRmU65g7DMsnRrSWE6OshxAIClkHTlqqd+G
         AsYw==
X-Gm-Message-State: APjAAAXn1tP+/ryeSCD+Gi0j7VzYuQjoRneokqXp7OLiB7rsUpzat//l
        mgoVLimY9FKJsiC8xMw2Lrk=
X-Google-Smtp-Source: APXvYqz9INtJU0vNFZwKtzerxh/Rz1AUnLX3c27DJwAYUrHysG0T14s9u7AKy/MfBbNIxRshtMWX0w==
X-Received: by 2002:a7b:cb0d:: with SMTP id u13mr5042513wmj.68.1579272131058;
        Fri, 17 Jan 2020 06:42:11 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id a1sm34307416wrr.80.2020.01.17.06.42.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 06:42:10 -0800 (PST)
Date:   Fri, 17 Jan 2020 15:42:09 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        sergey.senozhatsky.work@gmail.com, pmladek@suse.com,
        rostedt@goodmis.org, peterz@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v4] mm/hotplug: silence a lockdep splat with
 printk()
Message-ID: <20200117144209.GA19428@dhcp22.suse.cz>
References: <d7068679-e28a-98a9-f5b8-49ea47f7c092@redhat.com>
 <6BED7E12-CC3B-4AED-ACC8-F3533D3F3C70@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6BED7E12-CC3B-4AED-ACC8-F3533D3F3C70@lca.pw>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 17-01-20 07:40:15, Qian Cai wrote:
> 
> 
> > On Jan 17, 2020, at 3:51 AM, David Hildenbrand <david@redhat.com> wrote:
> > 
> > -> you are accessing the pageblock without the zone lock. It could
> > change to "isolate" again in the meantime if I am not wrong!
> 
> Since we are just dumping the state for debugging, it should be fine
> to accept a bit inaccuracy here due to racing. I could put a bit
> comments over there.

Sorry, I could have been more specific. The race I was talking about is
not about accuracy. The current code is racy in that sense already
because you are looking at a struct page you do not own so its state can
change at any time. Please note that the zone->lock doesn't really
prevent from the state transition because that applies only to free
pages and those are obviously OK. So this is not really different.

The race I've had in mind is a when a parallel hotplug would simply
hotremove the section along with the memmap so the struct page was a
complete garbage.

-- 
Michal Hocko
SUSE Labs
