Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7648CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 03:19:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F9BE2073B
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 03:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590549563;
	bh=r0fSWXqa5KJb1mvRxjIjhQ4fZq/3ca2Tu4hvzfrUErg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=V0iOQYiuRLgwSa+Fz64pmt9v5kp+23ljGYAjD+XCCLrnjUuOHzPVhEv++14MBoIZp
	 69pCk8Ibw8xwTjUxKhk+pEfwqwDdth6o7g9WNtvBNTF46KMu/EnmS76yaMr9rypF/L
	 FVF39QLHsIq3gCggqdjlKLG/2vylt7Z+NIoaBcZg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbgE0DTW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 23:19:22 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35792 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgE0DTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 23:19:21 -0400
Received: by mail-pl1-f195.google.com with SMTP id q16so9564965plr.2;
        Tue, 26 May 2020 20:19:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=s1BKNsNjOLcUtv/AvsFQU2yBPI63llFtuSI9Z++rcXY=;
        b=prTuxXXd3V8skITpe+TiD7sFWXlK8gI9Z7vgLkhw3hJlKCMkgrlO3t/FRTkyh+Dyfq
         Yynw4U1ZEh44cMeLIa9xRNUOEgQRHZLmHz9nsWcmO0arz1rjrc7BpUSYAjjdgcnYQmRJ
         v0XoUesBZ8jUm8ZaEc+4rchAjoxtTR8Q3RaKWkwDBjniHPF4ENXD8D7x7tfgGhLwSOzw
         avT88CGoPUufSJpU2x3Klc5bqxBZw9i1JU7pNocEagcSRtxXYLwD7M0ErN9DraaIOLzP
         hR6cNZy6Jpda9vArwQEsaAMvaRftVSrZEGuNWWCODUIcxvriV1fKkb7rIVMUz9BdjS/L
         +IPQ==
X-Gm-Message-State: AOAM532gkJY2S21IUg9YL89qbgTaZQ8D2eBPNu/9t/u4Mo6SMHlfq5cQ
        5QxxdfaEsApg9jHON5JYFdQ=
X-Google-Smtp-Source: ABdhPJxPiuBTiEGp03ZPKGbJP1hp5uzZav3b0+uqraW2RLF4L0e/sp97pDX4C6AOAmTyYBSQ7RrVHg==
X-Received: by 2002:a17:90b:e84:: with SMTP id fv4mr2330480pjb.132.1590549560127;
        Tue, 26 May 2020 20:19:20 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id m2sm751435pjk.52.2020.05.26.20.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 20:19:19 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 20B41419C3; Wed, 27 May 2020 03:19:18 +0000 (UTC)
Date:   Wed, 27 May 2020 03:19:18 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     jeyu@kernel.org, davem@davemloft.net, michael.chan@broadcom.com,
        dchickles@marvell.com, sburla@marvell.com, fmanlunas@marvell.com,
        aelior@marvell.com, GR-everest-linux-l2@marvell.com,
        kvalo@codeaurora.org, johannes@sipsolutions.net,
        akpm@linux-foundation.org, arnd@arndb.de, rostedt@goodmis.org,
        mingo@redhat.com, aquini@redhat.com, cai@lca.pw, dyoung@redhat.com,
        bhe@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        gpiccoli@canonical.com, pmladek@suse.com, tiwai@suse.de,
        schlad@suse.de, andriy.shevchenko@linux.intel.com,
        derosier@gmail.com, keescook@chromium.org, daniel.vetter@ffwll.ch,
        will@kernel.org, mchehab+samsung@kernel.org, vkoul@kernel.org,
        mchehab+huawei@kernel.org, robh@kernel.org, mhiramat@kernel.org,
        sfr@canb.auug.org.au, linux@dominikbrodowski.net,
        glider@google.com, paulmck@kernel.org, elver@google.com,
        bauerman@linux.ibm.com, yamada.masahiro@socionext.com,
        samitolvanen@google.com, yzaikin@google.com, dvyukov@google.com,
        rdunlap@infradead.org, corbet@lwn.net, dianders@chromium.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 0/8] kernel: taint when the driver firmware crashes
Message-ID: <20200527031918.GU11244@42.do-not-panic.com>
References: <20200526145815.6415-1-mcgrof@kernel.org>
 <20200526154606.6a2be01f@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
 <20200526230748.GS11244@42.do-not-panic.com>
 <20200526163031.5c43fc1d@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526163031.5c43fc1d@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 04:30:31PM -0700, Jakub Kicinski wrote:
> On Tue, 26 May 2020 23:07:48 +0000 Luis Chamberlain wrote:
> > On Tue, May 26, 2020 at 03:46:06PM -0700, Jakub Kicinski wrote:
> > > On Tue, 26 May 2020 14:58:07 +0000 Luis Chamberlain wrote:  
> > > > To those new on CC -- this is intended to be a simple generic interface
> > > > to the kernel to annotate when the firwmare has crashed leaving the
> > > > driver or system in a questionable state, in the worst case requiring
> > > > full system reboot. This series is first addressing only a few
> > > > networking patches, however, I already have an idea of where such
> > > > firmware crashes happen across the tree. The goal with this series then
> > > > is to first introduce the simple framework, and only if that moves
> > > > forward will I continue to chug on with the rest of the drivers /
> > > > subsystems.
> > > > 
> > > > This is *not* a networking specific problem only.
> > > > 
> > > > This v3 augments the last series by introducing the uevent for panic
> > > > events, one of them is during tainting. The uvent mechanism is
> > > > independent from any of this firmware taint mechanism. I've also
> > > > addressed Jessica Yu's feedback. Given I've extended the patches a bit
> > > > with other minor cleanup which checkpatch.pl complains over, and since
> > > > this infrastructure is still being discussed, I've trimmed the patch
> > > > series size to only cover drivers for which I've received an Acked-by
> > > > from the respective driver maintainer, or where we have bug reports to
> > > > support such dire situations on the driver such as ath10k.
> > > > 
> > > > During the last v2 it was discussed that we should instead use devlink
> > > > for this work, however the initial RFC patches produced by Jakub
> > > > Kicinski [0] shows how devlink is networking specific, and the intent
> > > > behind this series is to produce simple helpers which can be used by *any*
> > > > device driver, for any subsystem, not just networking. Subsystem
> > > > specific infrastructure to help address firwmare crashes may still make
> > > > sense, however that does not mean we *don't* need something even more
> > > > generic regardless of the subsystem the issue happens on. Since uevents
> > > > for taints are exposed, we now expose these through uapi as well, and
> > > > that was something which eventually had to happen given that the current
> > > > scheme of relying on sensible character representations for each taint
> > > > will not scale beyond the alphabet.  
> > > 
> > > Nacked-by: Jakub Kicinski <kuba@kernel.org>  
> > 
> > Care to elaborate?
> 
> I elaborated in the previous thread

No you didn't.

> and told you I will nack this, 

That's all you said.

> but sure let's go over this again.
> 
> For the third time saying the devlink is networking specific is not
> true. It was created as a netlink configuration channel for devices
> when there is no networking reference that could be used. It can be
> compiled in or out much like sysfs.

Perhaps I didn't get your email but this clarification was in no way
shape or form present in your reply on that thread.

> And as I've shown you devlink already has the uAPI for what you're
> trying to achieve.

I read your patch, and granted, I will accept I was under the incorrect
assumption that this can only be used by networking devices, however it
the devlink approach achieves getting userspace the ability with
iproute2 devlink util to query a device health, on to which we can peg
firmware health. But *this* patch series is not about health status and
letting users query it, its about a *critical* situation which has come up
with firmware requiring me to reboot my system, and the lack of *any*
infrastructure in the kernel today to inform userspace about it.

So say we use netlink to report a critical health situation, how are we
informing userspace with your patch series about requring a reboot?

  Luis
