Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53505C2BB55
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 07:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2620320753
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 07:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ONMTUtxD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbgDJH3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 03:29:04 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45048 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725839AbgDJH3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 03:29:03 -0400
Received: by mail-qt1-f193.google.com with SMTP id w24so832417qts.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 00:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Fp4kHLta6ZgyzAdMRrwqjvqnCNaMnOLJwog4i1Ni3k=;
        b=ONMTUtxDuiccw4fzD/0N/48iQgXvRiaZsq3i8CKsQktOIikk2rF9mNM+MiN1ng5pO4
         bsTyXbsatmp4t9tj1gftdN1Uj081H9qv03b93tQcmPRTOuXo7ivIBj5LETU7dq5iNnTL
         nfEKNW36UJrVkkRhJz4ccwT6h77vKAujJhgXsB6sTiFcYYNTLvOKEfaMhnRmS0UtiSfA
         DtDi/zvOnERz2+4SsmnwcLmxEguHKcZnJtgnjmH80oQPZWL6yFtrNdom+k6O7TpLc7yd
         4L/n6txrcaFs0Oen1soYK0aEmv3GU11TI+xVmsD7hQiGFadeN+O+uUExq30CzRWnYshp
         XHtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Fp4kHLta6ZgyzAdMRrwqjvqnCNaMnOLJwog4i1Ni3k=;
        b=d+A2E38FcKhb9tk4N8F5g1y6xUgjiNV11aTIJDBaoMcxswfF3KCdJFUyEUU/X0BCs3
         ofzHR45n/37C8scEwemGQDaJWX8xZzGnxEUDNC53Ytl73ryxfLfacmZGXs39Ke8tB3S8
         n2xpVZfaPqkU9meElmoxaplkyuRerFYUwJ/YiZ0onX9E2o+6bSroFfg3IYR9b0j7XZnx
         5pj+wDemrsQ2/D2G88UOz5K+uBjLoVU0XdRimHaU8AFuegnwirYSoQ+x+7h69cgdCWZB
         od1wFh8u8xQzTluGtqZq8nNXQnvLbaqKtr25brCkdwtZGhKVAXzqKdwziSZsVAFqoIGi
         92Gw==
X-Gm-Message-State: AGi0Pubwqqwih99Gh94Xnlww00thlEo9DcLBNbOJitApDS2yLT311FuN
        KtpC0d/es3VK+E72abs79BdRcnw1IR0t35ed1nTs/ygYATYahg==
X-Google-Smtp-Source: APiQypKgexf1MRhqFtGwGLtyDFygeWcyBxQLuAy1Yt2jgWfPBQNFN7i7rTc2h0FfRwURoicccMa82rMzWhtTl0NKjXo=
X-Received: by 2002:ac8:3581:: with SMTP id k1mr3290521qtb.50.1586503741490;
 Fri, 10 Apr 2020 00:29:01 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000a3376f05a2ea8c22@google.com>
In-Reply-To: <000000000000a3376f05a2ea8c22@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 10 Apr 2020 09:28:50 +0200
Message-ID: <CACT4Y+ZfP7zDOOCksy=NY161ddiKiOzsSty1JfA8+JaP1zacUw@mail.gmail.com>
Subject: Re: net test error: BUG: mismatching fuzzer/executor system call
 descriptions: ADDR vs ADDR (2)
To:     syzbot <syzbot+564b4e9875b107591b55@syzkaller.appspotmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 10, 2020 at 9:19 AM syzbot
<syzbot+564b4e9875b107591b55@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    aa81700c macsec: fix NULL dereference in macsec_upd_offloa..
> git tree:       net
> console output: https://syzkaller.appspot.com/x/log.txt?x=15cff49fe00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8c1e98458335a7d1
> dashboard link: https://syzkaller.appspot.com/bug?extid=564b4e9875b107591b55
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+564b4e9875b107591b55@syzkaller.appspotmail.com
>
> Warning: Permanently added '10.128.1.4' (ECDSA) to the list of known hosts.
> 2020/04/06 18:39:32 fuzzer started
> 2020/04/06 18:39:33 connecting to host at 10.128.0.26:41717
> 2020/04/06 18:39:34 checking machine...
> 2020/04/06 18:39:34 checking revisions...
> 2020/04/06 18:39:34 BUG: mismatching fuzzer/executor system call descriptions: 670a1e865c0bc7d60e9886acf4666ee3677e346e vs f787d115f9efa49fdd59261850f5c05f43fbe327
> syzkaller login:

This is now fixed with:
https://github.com/google/syzkaller/commit/2f886fb32cd97875de4a67dfb04c90d925b7d73d

#syz invalid
