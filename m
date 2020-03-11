Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54139C0044D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579A9206E7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583964167;
	bh=R2ukKVtGqJhnC1ilGWgY4/Zl2rEDFE7kX01YX4vtHmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=TEDy3zmR3fVglFijnWToW0goYcftLVEryEveJEOrqGWi0RKAMmqIUhon9/kJM0X+5
	 er7v9XfVdi+/1Sh70ORwBEwt/ccpzb6lwwJCI5jNn8kj9VXdTBvwucrwME0a7FFa5E
	 TgZex6Ak2hl6QzSRnmaV3EVPDYE5cBVIORnEhnYg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbgCKWCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 18:02:46 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:37094 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729223AbgCKWCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 18:02:45 -0400
Received: by mail-pg1-f181.google.com with SMTP id a32so1083838pga.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 15:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3iE2aDq3GTpvrSPuFDVQi35URZrSY5lu16FU58AXYfg=;
        b=FpIFqf52l4N0Bk/gaxJ14yLDj94qCfKyrcTpcFNDiURdFNH0NC/dnSCXnb38EFA773
         y2NhcaRzUDo+YFDy+PdU8XIH6nV7zEfPq4943R3UKpoFa79ze6YFdL9SsZRkBIPhPfUa
         mv4AD1GrmzS0MHSZmORWkG+sQ8koe5Nzan6dEWhXo5SrcohWY0jDN3R1gHDoJLpE0f2P
         YEUgYoI9ZdMvgW6I9gJRx2L5ruWyQfibF5wN5bkpgvtK1+WEh9pUhHtq4hkzDizBqY95
         nLozpnJGhD7q/vhRKbKF7dkog4oXh37yfubqAFxD32DAQWX/RSr9HtporoowTU9PDaTr
         H2UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=3iE2aDq3GTpvrSPuFDVQi35URZrSY5lu16FU58AXYfg=;
        b=UDVpGkSFAmhSiJEGIwPES3xodIRPbEiSu3TQZh6kI1YMEIeWAPXButTGKqESS1Jxn2
         TkhgA8GZ1mJrjkguAr5UUzhXlPNMywV9TaZWnM7RW5KM1OweoUGrIE65IvR5A8dSQ0nH
         pg+fkEMV8iSoIDGwrg/lc935FVvanjhIaM7FkekIepqY3U+ElRVWRS5+KhmMVcfxczAy
         XEnbWSxDk9Ni1qV33MKkIH90OZUbvYEmUx+ipffKPdEm4kWmq0S7YJMqRdLWHERixxUu
         KVktNVecyp5tKH5tvHXSMhzBz32kj+zlPm4B0mTUJKCO90T/TwNAIzBLN6j/usOVFSG/
         MnjA==
X-Gm-Message-State: ANhLgQ0bwwW6n4mtL4fME9yH6GFtVmTSY5lV/IwB+Td5h9mJOcHrhowf
        61UPGNkG5HVpsItzFTszdNMRby8c
X-Google-Smtp-Source: ADFU+vtmGxg9TwVB1VBj2GMpXmCb7ujUpMkxwfLzu1g/Ntf3tf2h6zt1i1H7Sa8ZUQsRk15Ro/Sr7Q==
X-Received: by 2002:aa7:9906:: with SMTP id z6mr4997401pff.112.1583964164216;
        Wed, 11 Mar 2020 15:02:44 -0700 (PDT)
Received: from google.com ([2620:15c:211:1:3e01:2939:5992:52da])
        by smtp.gmail.com with ESMTPSA id c18sm50034963pgw.17.2020.03.11.15.02.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 15:02:42 -0700 (PDT)
Date:   Wed, 11 Mar 2020 15:02:41 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Dave Hansen <dave.hansen@intel.com>, Jann Horn <jannh@google.com>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Daniel Colascione <dancol@google.com>,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: Re: interaction of MADV_PAGEOUT with CoW anonymous mappings?
Message-ID: <20200311220241.GA252592@google.com>
References: <CAG48ez0G3JkMq61gUmyQAaCq=_TwHbi1XKzWRooxZkv08PQKuw@mail.gmail.com>
 <20200310184814.GA8447@dhcp22.suse.cz>
 <CAG48ez2pNSKL9ZTH-PQ93+Kc6ObH6Pa1vVg3OS85WT0TB8m3=A@mail.gmail.com>
 <20200310210906.GD8447@dhcp22.suse.cz>
 <cf95db88-968d-fee5-1c15-10d024c09d8a@intel.com>
 <20200311084513.GD23944@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311084513.GD23944@dhcp22.suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 09:45:13AM +0100, Michal Hocko wrote:
> On Tue 10-03-20 15:48:31, Dave Hansen wrote:
> > Maybe instead of just punting on MADV_PAGEOUT for map_count>1 we should
> > only let it affect the *local* process.  We could still put the page in
> > the swap cache, we just wouldn't go do the rmap walk.
> 
> Is it really worth medling with the reclaim code and special case
> MADV_PAGEOUT there? I mean it is quite reasonable to have an initial
> implementation that doesn't really touch shared pages because that can
> lead to all sorts of hard to debug and unexpected problems. So I would
> much rather go with a simple patch to check map count first and see
> whether somebody actually cares about those shared pages and go from
> there.
> 
> Minchan, do you want to take my diff and turn it into the proper patch
> or should I do it.

Hey Michal,

It would be great if you could send it.
Thanks.
