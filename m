Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D05DC3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 12:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E309620665
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 12:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EYn3+pq1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgB1Mw4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 07:52:56 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45224 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgB1Mw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 07:52:56 -0500
Received: by mail-pg1-f196.google.com with SMTP id m15so1469640pgv.12
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 04:52:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LLJFIPckd1xHQQqmcacgnVgcHhCyLy6UDC2qqofSmdQ=;
        b=EYn3+pq1/4zwaewIxfogpCXCQE/gXuWhWoMgM20ZXP92fx9eoJps9jl+eeJAqyhvlp
         GgaYr5/OixNCIcK9dmEFtvBgxKaSllfHHkluoGUEAZUuBJ1z5CTGHLpmfvEaFBLtNxUb
         Yo+x+VduI9oaNHnwMg3GMdnBYfzyIEP3qThlF4fByh2D1ZAl8J4zvSFMRMeHq3ODOF5n
         Uh39EjKVQaN+VMP/m4e0OuaGTZs7Bj+wilCBLp4Hn/v8Q9C9xL0ZS//lf/dM4P2b2vpR
         DVOYb87oBI9DmrUB1SH6ljNFtoSGSICi0MJGii67FXLWGfbHdPB9IRfzmV9gPqe8iNFo
         pt4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LLJFIPckd1xHQQqmcacgnVgcHhCyLy6UDC2qqofSmdQ=;
        b=ZTl1p9LpdbujvOsfCqHeCPCvxJ4lf//Z8s7K/IrT5KK+NuvsqpFkaoXL7N/b9t9DdH
         iP4cunfWKqcTacvpO1E0dc90e3p/wpfC2GB9c+vIeWE7iExiG2gl+LAIWRXhNpKePG6s
         L5PmepBb6pouQsKa5hLYd0Ce17xusc1zKs0fQungIQqnpV6bzex3+aWsowRydH2LW6jV
         dtWBeE1ye0tbu/2ORCVssxtJVEMEsvOXRplOU0k86NVBWX06gK8Fm1HcPsSrqrXnIktM
         LRKojH4ZImlEGbhWNA0jpN0ZSjrEA/s7zIy9itWsa3SqLWBmNDTPNfLv5MG5rytpESjJ
         YczQ==
X-Gm-Message-State: APjAAAUkqW66eGayQpcYiyDIOyjpmUynybeHHM0gyq8qlm0XxF2JJAQ1
        M43C5NOliAC1qvzxPl0FdVHmbcwf/33Z1HzUH8CoZQ==
X-Google-Smtp-Source: APXvYqwBetfHP4u0UNKR6OIIGPMsBN54kOZKmtQkEbTasMC2tvzDA28ZV2hcmrlTq4CCoWjo95FL0UVJspX+xDfxhpU=
X-Received: by 2002:a63:a062:: with SMTP id u34mr4604347pgn.286.1582894375143;
 Fri, 28 Feb 2020 04:52:55 -0800 (PST)
MIME-Version: 1.0
References: <00000000000040573d059fa2474f@google.com>
In-Reply-To: <00000000000040573d059fa2474f@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 28 Feb 2020 13:52:44 +0100
Message-ID: <CAAeHK+xhwwZopXhRjPgfxNrWbvpforBQ+ea4VjznBTszVSAFDg@mail.gmail.com>
Subject: Re: BUG: bad host security descriptor; not enough data (1 vs 5 left)
To:     syzbot <syzbot+52be5a94ed1c3d6bf9ce@syzkaller.appspotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 28, 2020 at 1:50 PM syzbot
<syzbot+52be5a94ed1c3d6bf9ce@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    d6ff8147 usb: gadget: add raw-gadget interface
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=159c5d29e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=90a3d9bed5648419
> dashboard link: https://syzkaller.appspot.com/bug?extid=52be5a94ed1c3d6bf9ce
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12c172c3e00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1461ee65e00000
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+52be5a94ed1c3d6bf9ce@syzkaller.appspotmail.com
>
> usb 1-1: config 0 interface 0 altsetting 0 has 2 endpoint descriptors, different from the interface descriptor's value: 4
> usb 1-1: New USB device found, idVendor=13dc, idProduct=56fc, bcdDevice=40.15
> usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
> usb 1-1: config 0 descriptor??
> hwa-hc 1-1:0.0: Wire Adapter v106.52 newer than groked v1.0
> usb 1-1: BUG: bad host security descriptor; not enough data (1 vs 5 left)
> usb 1-1: supported encryption types:
> usb 1-1: E: host doesn't support CCM-1 crypto
> hwa-hc 1-1:0.0: Cannot initialize internals: -19
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> syzbot can test patches for this bug, for details see:
> https://goo.gl/tpsmEJ#testing-patches

#syz dup: BUG: bad host security descriptor; not enough data (4 vs 5 left)
