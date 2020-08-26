Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 268C6C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 00:18:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E07432074A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 00:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598401082;
	bh=xXaAEJ0AEr+5jikBS0er1PNhtLBu2gg0MrzTQd1zC6U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=tUKeFA4M6h6zgdXiuM+J6gZnGXITbuGxqt3eQ/q+Fv7toseA35xLtbfcrNxrbBAjk
	 dBIYh4rqfMR/vnDelqSEf03RY3iC4dREKgg4yC0ccE7sPk8sSn/+KyfsEaEVvA280M
	 vdCrQLL6Gy6/+612elxjZWzZaUsDbofzTN6RZFrA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgHZASA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 20:18:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:37960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726570AbgHZAR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 20:17:58 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3283920738;
        Wed, 26 Aug 2020 00:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598401077;
        bh=xXaAEJ0AEr+5jikBS0er1PNhtLBu2gg0MrzTQd1zC6U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GziKgOjQuNTLiyQzSE8/pAtRGOGqyQr6ck2qKh0HhXFhtXBYiRHAXd/C/O1AcGrlv
         Yok3Cajmqe878dcLJAkRzbvcd5F0Orqy0K0cO7c7kSRL8utpGhM2Im4QDCwrO2N9SO
         NCqN28JRSjdqUDGa5u5y54AS+w2grsvS59zcpE2A=
Date:   Tue, 25 Aug 2020 17:17:56 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Kieran Bingham <kbingham@kernel.org>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        John Ogness <john.ogness@linutronix.de>,
        Baoquan He <bhe@redhat.com>, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2][next] update gdb scripts for lockless printk
 ringbuffer
Message-Id: <20200825171756.830d5895eb40d2dded2803ae@linux-foundation.org>
In-Reply-To: <20200825123542.GU4353@alley>
References: <20200814212525.6118-1-john.ogness@linutronix.de>
        <20200821080813.GM4353@alley>
        <d81e8b0d-fa7f-1da1-671f-0541b94ad349@siemens.com>
        <a5f4c178-9b3c-6ccd-9ea1-24d8fdc13273@kernel.org>
        <20200825123542.GU4353@alley>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Aug 2020 14:35:42 +0200 Petr Mladek <pmladek@suse.com> wrote:

> Andrew, would you mind when I take the three gdb/lockless-printk
> related changes via printk tree to avoid synchronization problems?

No probs.  If such patches turn up in linux-next I just drop my copy.
After checking that the patches fully match...

