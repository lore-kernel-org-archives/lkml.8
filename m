Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B142CC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:07:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E5E6206A1
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593464843;
	bh=luNaPCU/6jbnS0K+V5U2aqJY+/BTW9KAGTO5MmkTewg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qqIQGEjsqThQceWEsLcIzFlkrgj2vXWMm4eukB5K2Tt16vhqwYTfsqfS2911IZnBY
	 Jfr4IMkUwL/xu3APLn0nCKsLd63w0NYc6LJ35ik4FXdVuYM7iTRxhMdP+YqVntEdUt
	 tmOuwI1J+ds/KM5VKD7NDV0xJj5SM6/oNKMxdXdU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390365AbgF2VHW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:07:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:53746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730953AbgF2TKR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:10:17 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D75125598;
        Mon, 29 Jun 2020 16:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593448949;
        bh=luNaPCU/6jbnS0K+V5U2aqJY+/BTW9KAGTO5MmkTewg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xVG63WHkl2xs6+ia1HETs24YSoPxEOtOo15i0bFAo8HQPhr0Anl1yaLLPGXv6teOz
         fFNJADDTapRPEgPSm8b1NGC0958Mp8t6wlOsYCdm4eWlA/3LwvRaVZ2HJVdBnjd7Bb
         8wQc3cho/y49Go37ii4Z0xAIcUtAP++zIf96px/A=
Date:   Mon, 29 Jun 2020 09:42:27 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     syzbot <syzbot+95910cea1a7ad8850a0f@syzkaller.appspotmail.com>
Cc:     bp@alien8.de, hpa@zytor.com, linux-kernel@vger.kernel.org,
        luto@kernel.org, mingo@redhat.com, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Subject: Re: BUG: unable to handle kernel NULL pointer dereference in
 __syscall_return_slowpath
Message-ID: <20200629164227.GB1752982@gmail.com>
References: <00000000000077c48b05a93b96fa@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000077c48b05a93b96fa@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 29, 2020 at 09:31:16AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    4e99b321 Merge tag 'nfs-for-5.8-2' of git://git.linux-nfs...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=116abdd3100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=bf3aec367b9ab569
> dashboard link: https://syzkaller.appspot.com/bug?extid=95910cea1a7ad8850a0f
> compiler:       gcc (GCC) 10.1.0-syz 20200507
> userspace arch: i386
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17020755100000

Looks like ioctl$FBIOPUT_VSCREENINFO on /dev/fb0 striking again.  There are like
20-30 open syzbot reports for this.

See https://lkml.kernel.org/lkml/000000000000ff323f05a053100c@google.com/T/#u
for some previous discussion.

#syz dup: general protection fault in syscall_return_slowpath
