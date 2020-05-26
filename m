Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACE4FC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 23:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CEE62078C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 23:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590534472;
	bh=7bSp5bK1gKq5lfmIlc8WNWiBrYRNVDke2Cjb+Arst30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QOWeiVgYZeH8dTXHFBPESGE5JOEnNaT5KT/NPjoQ6MFZM/0HJXkLqyE0pPuv3CmRK
	 pd+o2chZMLAKeMFHXbw9TaruoVmMT8FD90JPjj9F7onvHvq41kyAy/TyLYUk/n93Qs
	 dovxxJJ3CipUai4Kz2pyhvYD9dsr5IGTLPIl6kDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404577AbgEZXHw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 19:07:52 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43253 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389565AbgEZXHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 19:07:51 -0400
Received: by mail-pf1-f195.google.com with SMTP id v63so10868604pfb.10;
        Tue, 26 May 2020 16:07:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dk0pTdJumqtR3muV1AGluDpJHnN6Xn6bW+DtSZAfKr0=;
        b=IkzFS2vpwoOAlm1Egqnm0Apo1RF4+m8cg7Bz6qvlRv53WxCRNDHf1ZEO4Wi5vvL8Cc
         MvoKqmOpIW1AfRaTprFPfdO+LTGn/UQOicmcqxE/Je1kZy0n+E8W8fUjsKl+aq4P8NGg
         mid1e2QWaSSOSWM6kaOGWPdEEl4/AjDXVf9omj7aIZpYq2DL1kvlNGsUasTf2ZswZHs9
         XRsnmc/LZO1KMEy6MDa3WeZO2Xd0KCBFqmR3urmmYgpUZkC6obfxUJ7mpQDv1c++g55C
         LyGjmwtOqGRPrM5h5iWP+iEyAan1pEZ2gHoGEED+oA93aGnID+b72FPPNffBennXCTJY
         2Vow==
X-Gm-Message-State: AOAM533aUSMc7BChubMxBsjxLQeL7ov2W5Kq3KGKa0AH2LgE/I4dFBiX
        rLcgILcvvwRjFDH259/XfkI=
X-Google-Smtp-Source: ABdhPJzkkPUt4SyfXKKm+9knUMsLXjbRdf23jAKflXNLas2Wc+LtlBBxCYDdZqtUl88sfeMgxlVFyQ==
X-Received: by 2002:a62:f242:: with SMTP id y2mr1076230pfl.111.1590534470426;
        Tue, 26 May 2020 16:07:50 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id gd1sm489499pjb.14.2020.05.26.16.07.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 16:07:49 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 3403F41C6A; Tue, 26 May 2020 23:07:48 +0000 (UTC)
Date:   Tue, 26 May 2020 23:07:48 +0000
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
Message-ID: <20200526230748.GS11244@42.do-not-panic.com>
References: <20200526145815.6415-1-mcgrof@kernel.org>
 <20200526154606.6a2be01f@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200526154606.6a2be01f@kicinski-fedora-PC1C0HJN.hsd1.ca.comcast.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 03:46:06PM -0700, Jakub Kicinski wrote:
> On Tue, 26 May 2020 14:58:07 +0000 Luis Chamberlain wrote:
> > To those new on CC -- this is intended to be a simple generic interface
> > to the kernel to annotate when the firwmare has crashed leaving the
> > driver or system in a questionable state, in the worst case requiring
> > full system reboot. This series is first addressing only a few
> > networking patches, however, I already have an idea of where such
> > firmware crashes happen across the tree. The goal with this series then
> > is to first introduce the simple framework, and only if that moves
> > forward will I continue to chug on with the rest of the drivers /
> > subsystems.
> > 
> > This is *not* a networking specific problem only.
> > 
> > This v3 augments the last series by introducing the uevent for panic
> > events, one of them is during tainting. The uvent mechanism is
> > independent from any of this firmware taint mechanism. I've also
> > addressed Jessica Yu's feedback. Given I've extended the patches a bit
> > with other minor cleanup which checkpatch.pl complains over, and since
> > this infrastructure is still being discussed, I've trimmed the patch
> > series size to only cover drivers for which I've received an Acked-by
> > from the respective driver maintainer, or where we have bug reports to
> > support such dire situations on the driver such as ath10k.
> > 
> > During the last v2 it was discussed that we should instead use devlink
> > for this work, however the initial RFC patches produced by Jakub
> > Kicinski [0] shows how devlink is networking specific, and the intent
> > behind this series is to produce simple helpers which can be used by *any*
> > device driver, for any subsystem, not just networking. Subsystem
> > specific infrastructure to help address firwmare crashes may still make
> > sense, however that does not mean we *don't* need something even more
> > generic regardless of the subsystem the issue happens on. Since uevents
> > for taints are exposed, we now expose these through uapi as well, and
> > that was something which eventually had to happen given that the current
> > scheme of relying on sensible character representations for each taint
> > will not scale beyond the alphabet.
> 
> Nacked-by: Jakub Kicinski <kuba@kernel.org>

Care to elaborate?
 
  Luis
