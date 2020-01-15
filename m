Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58173C33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 08:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E62C2467D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 08:37:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579077443;
	bh=vwDGuNgtDIv6S0vDWDMQjC6oMFNoa4nimWiCM1wLWuY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ir1WehUp9j9TEx7Aykxc/YdippyY/lbUCCowdFSFlkKwLAJDuYAfj7y9Y0lHj7EIG
	 iE6BlQb9reOItSfHVYtxMF2v8nESeDeLhOkdx4Wobds6CKXKl9sKeuuzhLNpND8dZe
	 5nC2ld9s0ivXWd5iL/tw0K3fakOIZfutgqHfZ2MQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729061AbgAOIhW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 03:37:22 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50897 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728897AbgAOIhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 03:37:21 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so16853834wmb.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 00:37:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Fa1u1mzbBVRR4hSMwwOshanE1/Dom8+1F1uqjIUrlBM=;
        b=JCPe6GA5fZRXDdbZQDCR45ySeWhZZe6t0cfr583N1emBsPfNCCcCyikVRVgMVyVU69
         SJtILkif+Evj00q/AP76W9JBExpBROILpnnE1Djs4JlleAov+93exyl3vWXbmgBwLodj
         9UjriI4/BpC/tKdT1czDWJMH2xCIgrwgoRUzC243nYW7YjJ3WQdm8mBhStqYwmNcmEGr
         PuixbkOloc/BptCUCiO/862wbOiPcKE6Lld3uunuHXRPYF42lj58pMpd60oFmv2Q99pH
         ACX2upiBj8PgWYdiACpsoxXzmuHTNtoefXVKSWmSQ7xuAr65zk1kgM1lmbtUC8iDylHr
         xuHQ==
X-Gm-Message-State: APjAAAVPL8ZE5SoXtxJBJtJS2YfF7vO6KaG4TZ8tSgLHJHMnw/+zSvGD
        vKLCTWv1Azfa2n4JanVKVNM=
X-Google-Smtp-Source: APXvYqxZsZXyn1rU5N3YvRWQFpcmEe3gM65E1CuC45FdUSKSvo4EJPLbmdIUa9PyShd15skfegz6fA==
X-Received: by 2002:a7b:cfc2:: with SMTP id f2mr32224195wmm.44.1579077440227;
        Wed, 15 Jan 2020 00:37:20 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id h17sm24267663wrs.18.2020.01.15.00.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 00:37:19 -0800 (PST)
Date:   Wed, 15 Jan 2020 09:37:18 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        sergey.senozhatsky.work@gmail.com, pmladek@suse.com,
        rostedt@goodmis.org, peterz@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/hotplug: silence a lockdep splat with printk()
Message-ID: <20200115083718.GV19428@dhcp22.suse.cz>
References: <20200114210215.GQ19428@dhcp22.suse.cz>
 <D5CC7C52-1F08-401E-BDCA-DF617909BB9D@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <D5CC7C52-1F08-401E-BDCA-DF617909BB9D@lca.pw>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 14-01-20 16:40:49, Qian Cai wrote:
> 
> 
> > On Jan 14, 2020, at 4:02 PM, Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > Yeah, that was a long discussion with a lot of lockdep false positives.
> > I believe I have made it clear that the console code shouldn't depend on
> > memory allocation because that is just too fragile. If that is not
> > possible for some reason then it has to be mentioned in the changelog.
> > I really do not want us to add kludges to the MM code just because of
> > printk deficiencies unless that is absolutely inevitable.
> 
> I don’t know how to convince you, but both random number generator
> and printk() maintainers agreed to get ride of printk() with
> zone->lock held as you can see in the approved commit mentioned in
> this patch description because it is a whac-a-mole to fix other
> places.

I really do not understand this argument. It is quite a specific path in
the console code which cannot allocate any memory or use locks which
depend on the allocation via a lock chain, right? So how come this is a
whack a mole?

Also any console that really needs GFP_ATOMIC to write something out is
just inherently broken so it should better be fixed rather than
worked around.
-- 
Michal Hocko
SUSE Labs
