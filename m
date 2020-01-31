Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8916FC33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 06:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4692082E
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 06:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580453013;
	bh=CZYvrQWyDOYKguyxI15/yjPFCQVOG0t9Fxb6iSoSfqI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2Hn0e0ys/6wZfDkn1fn9UA7pMzLlb/izulyQJ98l4cxCJ/p4nlYQVgatJHpsKGuq/
	 GZcxpPriQkCMjNBvi6X33vFXOfR9STQBrJpAMzQXok5VrVo1LMWR8vYGOMQUNE1GWu
	 Fuhn+uYnA9LdJzwlg1k5b9AC9baKGHs6SKIraghE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgAaGnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 01:43:32 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45807 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgAaGnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 01:43:32 -0500
Received: by mail-wr1-f66.google.com with SMTP id a6so7219481wrx.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 22:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=8p4qE6ifkN9u5luLlc5PPEhUo7uti+2D6sa+aGx2WPM=;
        b=ES0f0iW44b3+TMWrymbT4CFWqgLrj/Ku5TfNTpOYQtd7MdHUBoRa9b05JjGcvUwxw3
         DGI3CtBNONbI29LN7y/gHNUpBikLiMAQQ7iRX79QgRhGN9kx330tiHwRNXi6briwka5u
         rJgvziykVkV7gsn2vVO/bX46yf0OSiI7Z5jLDoTm4LI9Fb03ZbGBKPZtr+lA+eMgqsFU
         DMTMcTevp0tPLvlmfiUiKhe9mlxtumWgE9g/Vb5BS3amSouNHVS/D9pECDmX5SWCCDzO
         MeykeFZqBpTNWroxyEHWw9PRJfb8gBHwJjMILxsnZ5Zq89AWGnWL71LOniphwtS6AuxE
         wenA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=8p4qE6ifkN9u5luLlc5PPEhUo7uti+2D6sa+aGx2WPM=;
        b=WkM/5IEkiAAN59hnguVVrzGYw/uExbA5+cVsOyvHuLfpm9dU3hN/TfXVRaYu5HrwJR
         RjFIhWjc5khdbMWZ70G0kMkrNWh7NCwjrg3jAMdPBgDErSsWiDqHCpjzxmqM0eB32faw
         TsPU1Jw8ODNvdDp1XJRdxL/irjvH6+/IQOlaPemXEm/OPsTStMwF7q3NSZo28/4KOdLX
         LT/oUS+gFcN5GkMN6h672hDsCAoyUfJCQODIMVyBekgjT7vY0E49hxWStX5Y6lKATBb2
         86b36zZg6WURPNJ6/N99o2HWUpdfrUrpwJ2GjHuGyy+mo8JyAXX8MJJRLbiPbNggU+Ax
         E3dg==
X-Gm-Message-State: APjAAAVbWLd/8QJUesfMVfft4ex7UfSlJd+HxGoZDDpUkmjN8wTqZB3p
        Ge+Vxk9YQiaj1/hktDQMp3E=
X-Google-Smtp-Source: APXvYqx7M24GaSUQMNiexPi/fx9edxK/zBmKjevzdteMfzihXd45RO5/rqMvIP7+Q+TL5iqWN5xccw==
X-Received: by 2002:adf:ed04:: with SMTP id a4mr9078387wro.76.1580453010295;
        Thu, 30 Jan 2020 22:43:30 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id f189sm10194177wmf.16.2020.01.30.22.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 22:43:29 -0800 (PST)
Date:   Fri, 31 Jan 2020 07:43:27 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?iso-8859-1?Q?J=F6rg?= Otte <jrg.otte@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>
Subject: Re: 5.6-### doesn't boot
Message-ID: <20200131064327.GB130017@gmail.com>
References: <CADDKRnANovPM5Xvme7Ywg8KEMUyP-gB0M-ufxKD8pw0gNwtFag@mail.gmail.com>
 <CAHk-=wjOXE4cqFOdtSymYnMMayZq8Lv7qDy-6BzCs=2=8HcoBA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wjOXE4cqFOdtSymYnMMayZq8Lv7qDy-6BzCs=2=8HcoBA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Thu, Jan 30, 2020 at 9:32 AM Jörg Otte <jrg.otte@gmail.com> wrote:
> >
> > my notebook doesn't boot with current kernel. Booting stops right after
> > displaying "loading initial ramdisk..". No further displays.
> > Also nothing is wriiten to the logs.
> >
> > last known good kernel is : vmlinuz-5.5.0-00849-gb0be0eff1a5a
> > first known bad kernel is : vmlinuz-5.5.0-01154-gc677124e631d
>
> It would be lovely if you can bisect a bit. But my merges in that
> range are all from Ingo:
> 
> Ingo Molnar (7):
>     header cleanup
>     objtool updates
>     RCU updates
>     EFI updates
>     locking updates
>     perf updates
>     scheduler updates

If I had to guess then perhaps the EFI changes look the most dangerous 
ones from these trees - but in principle most of these trees could 
contain a boot crasher/hang bug.

> but not having any messages at all makes it hard to guess where it 
> would be.

To improve debug output:

Removing any 'fbcon' options in /boot/grub/grub.cfg and adding this to 
the boot options might improve the debug output:

  earlyprintk=vga initcall_debug ignore_loglevel debug panic_on_warn 

So for example if the relevant kernel boot entry in grub.cfg looks like 
this:

  linux   /vmlinuz-5.3.0-26-generic root=UUID=1bcxabe3-0b62-4x04-b456-47cd90c0e6x4 ro  splash $vt_handoff

Then editing it to the following could in principle produce (much) more 
verbose boot output:

  linux   /vmlinuz-5.3.0-26-generic root=UUID=1bcxabe3-0b62-4x04-b456-47cd90c0e6x4 ro earlyprintk=vga initcall_debug ignore_loglevel debug panic_on_warn $vt_handoff

If this produces more output than just "loading initial ramdisk..' then a 
photo of the hung screen would be sufficient, no need to transcribe it.

> A few bisect runs would narrow it down a fair amount. Bisecting all the 
> way would be even better, of course,

Agreed!

If compiling full kernels for bisections takes too long (for example 
because the .config is from a distro kernel) then running "make 
localmodconfig" to create a config tailored to the currently active 
modules will cut down significantly on build time.

Also, a warning: if the normal boot log contains spurious warnings then 
the new 'panic_on_warn' option will cause additional trouble on good 
kernels.

Thanks,

	Ingo
