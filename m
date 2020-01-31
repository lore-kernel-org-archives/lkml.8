Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8BE5C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 18:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F64E2082E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 18:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580495824;
	bh=Y/DXkxdYtT/SiYQ7qtdZnXgaoyULWQTd885QWI0b+v8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=lwjneiAM0zzVJMM9QVhLHp0CSQhlGe6DN9Q1707HCnqmhiI8j+LRD7tlpMPfxVlQV
	 TTDL8vQlLiGS7jYeWy7e0mvDyA6vooClLSO86WXlRHsr+gsbiGMlCX4Djj0IA0btBC
	 MlAVYpkDJGxSNk+Tkcj4eeNduofV9rXUAHnd3PTI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgAaShD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 13:37:03 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46004 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgAaShD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 13:37:03 -0500
Received: by mail-wr1-f68.google.com with SMTP id a6so9781807wrx.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 10:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=OXV92UcuWOio8wUsLVreOblv28BcDDZ/aCq7MZ9L0O0=;
        b=dyBDXys7ffHNsUDuD8glyxvA6du8y/ciqORc6VBmFajxFRhllRCvSTruxF7auG/yVL
         oT4ZZPFRLwWW6M/oDxbO+qP7s9Z2THon72gYtdz4rPz1iAO6XclfZHugrbqZ4S6swYxn
         Bl71rENXgvALNgi0ok7tQyVA3/pEwQdnB/oi9RUJ+DtFLDnlTD5ZB2JmfTBVQ/cc0D1L
         cUMl2lO/njYVOr3glSxk0RouVn/Z6ZgUlqHhFwWMHigjnS+x9odQ1N5fDmBAF57SzshQ
         +I34qoU9qMUaVG8NDKAQ4mttDImRO0nLklkXTccD0AWtia4jWMTrs43RFK8WsMjcmaRJ
         XmPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=OXV92UcuWOio8wUsLVreOblv28BcDDZ/aCq7MZ9L0O0=;
        b=Ys+lm8rX/cKl8xZ90tauc46dBjY3mgqR17KARUQdFh8bhsDNMcFvLiYsQRK72EKWKj
         7XhjRKa8CiIzPV6TftmOrxAZzIj1ayZo69dqUMDH84pOaM4jebBWjSfURgVVWM1h4Grn
         yqo8s9M8YANZothgGNls8xp78Le+L6iA4qWc4NwkaIBTNU7qJdUKJkKSGh0FZ/2O94bv
         kO64yrOoi/JrNY0EqjfL1nKv7prVa9tJORRojSNp5J8XDPnGAtlS/Rvwi347zH9k8rO3
         6HEKDSMZwixOGijWVs3TJn2nipmtIcRNK78nq4Oa862Vr9KPQ7Sc6KVLEeTmPvb817P3
         q21A==
X-Gm-Message-State: APjAAAUNJT+Irxmni76Efs40ruKYqf7oNaIspJ+B/r/r71rcr26bK4Fk
        CcF5MirpYFhWcqgaI+MAZJ8=
X-Google-Smtp-Source: APXvYqxunHtKyXZnuwgeqSaF0W438oP6AcY4tyRkkHHFBkMwLqf7xudNbBrngPJNxgqRxgaowv6eLg==
X-Received: by 2002:adf:e483:: with SMTP id i3mr13216394wrm.215.1580495821710;
        Fri, 31 Jan 2020 10:37:01 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id o15sm12792705wra.83.2020.01.31.10.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 10:37:01 -0800 (PST)
Date:   Fri, 31 Jan 2020 19:36:58 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     =?iso-8859-1?Q?J=F6rg?= Otte <jrg.otte@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: EFI boot crash regression (was: Re: 5.6-### doesn't boot)
Message-ID: <20200131183658.GA71555@gmail.com>
References: <CADDKRnANovPM5Xvme7Ywg8KEMUyP-gB0M-ufxKD8pw0gNwtFag@mail.gmail.com>
 <CAHk-=wjOXE4cqFOdtSymYnMMayZq8Lv7qDy-6BzCs=2=8HcoBA@mail.gmail.com>
 <20200131064327.GB130017@gmail.com>
 <CADDKRnATVt9JjgV+dAZDH9C3=goJ5=TzdZ8EJMjT8tKP+Uhezw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADDKRnATVt9JjgV+dAZDH9C3=goJ5=TzdZ8EJMjT8tKP+Uhezw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


(Cc:ed Dan and Ard)

* Jörg Otte <jrg.otte@gmail.com> wrote:

> Am Fr., 31. Jan. 2020 um 07:43 Uhr schrieb Ingo Molnar <mingo@kernel.org>:
> >
> >
> > * Linus Torvalds <torvalds@linux-foundation.org> wrote:
> >
> > > On Thu, Jan 30, 2020 at 9:32 AM Jörg Otte <jrg.otte@gmail.com> wrote:
> > > >
> > > > my notebook doesn't boot with current kernel. Booting stops right after
> > > > displaying "loading initial ramdisk..". No further displays.
> > > > Also nothing is wriiten to the logs.
> > > >
> > > > last known good kernel is : vmlinuz-5.5.0-00849-gb0be0eff1a5a
> > > > first known bad kernel is : vmlinuz-5.5.0-01154-gc677124e631d
> > >
> > > It would be lovely if you can bisect a bit. But my merges in that
> > > range are all from Ingo:
> > >
> > > Ingo Molnar (7):
> > >     header cleanup
> > >     objtool updates
> > >     RCU updates
> > >     EFI updates
> > >     locking updates
> > >     perf updates
> > >     scheduler updates
> >
> > If I had to guess then perhaps the EFI changes look the most dangerous
> > ones from these trees - but in principle most of these trees could
> > contain a boot crasher/hang bug.
> >
> > > but not having any messages at all makes it hard to guess where it
> > > would be.
> >
> > To improve debug output:
> >
> > Removing any 'fbcon' options in /boot/grub/grub.cfg and adding this to
> > the boot options might improve the debug output:
> >
> >   earlyprintk=vga initcall_debug ignore_loglevel debug panic_on_warn
> >
> > So for example if the relevant kernel boot entry in grub.cfg looks like
> > this:
> >
> >   linux   /vmlinuz-5.3.0-26-generic root=UUID=1bcxabe3-0b62-4x04-b456-47cd90c0e6x4 ro  splash $vt_handoff
> >
> > Then editing it to the following could in principle produce (much) more
> > verbose boot output:
> >
> >   linux   /vmlinuz-5.3.0-26-generic root=UUID=1bcxabe3-0b62-4x04-b456-47cd90c0e6x4 ro earlyprintk=vga initcall_debug ignore_loglevel debug panic_on_warn $vt_handoff
> >
> > If this produces more output than just "loading initial ramdisk..' then a
> > photo of the hung screen would be sufficient, no need to transcribe it.
> >
> > > A few bisect runs would narrow it down a fair amount. Bisecting all the
> > > way would be even better, of course,
> >
> > Agreed!
> >
> > If compiling full kernels for bisections takes too long (for example
> > because the .config is from a distro kernel) then running "make
> > localmodconfig" to create a config tailored to the currently active
> > modules will cut down significantly on build time.
> >
> > Also, a warning: if the normal boot log contains spurious warnings then
> > the new 'panic_on_warn' option will cause additional trouble on good
> > kernels.
> 
> It's bisected.
> The first bad commit is :
> 1db91035d01aa8bfa2350c00ccb63d629b4041ad
> efi: Add tracking for dynamically allocated memmaps

Thanks a ton, that's very useful!

I've Cc:-ed the EFI gents who are developing this code, maybe they'll 
spot the bug.

Thanks,

	Ingo
