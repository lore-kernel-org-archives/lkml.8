Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357E3C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF740207DA
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 22:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590185652;
	bh=dZ2ofCb1NwJTEisd3Gt+KD09zvkyEqg1+EsbaKVb+bo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pkMH8U+xPJvrxbTNxhYkSGUYcYpRxjs8Uf1/e/07gVnkTb+7u7ATElNyFpOGUhd6C
	 BN+IJEDSIhdEAHJPJJdWVH57GdopypVVJg2KDE7OJ/kL4iB0FvsnSSjF0xSnX+ejfb
	 Eq7HtZ6XzrzUtLEg8f/GtLiM/MUWb806editWr1w=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731133AbgEVWOL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 18:14:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:44430 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731069AbgEVWOK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 18:14:10 -0400
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3CC5720757
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 22:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590185650;
        bh=dZ2ofCb1NwJTEisd3Gt+KD09zvkyEqg1+EsbaKVb+bo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Uxg2at5JwYa8vu1eMsU0iU8rLuHwvV0N4Pvq1l7oUVsM/cxge4KV3pNuiIdd5lt8+
         JfIfY+LfvzNehIYCo2iTWYBpyIf5bimfINcSeHCQ7s6qIiZnHjPIm+vWuwTd9xhCeI
         5Tr8Ae+CYInRZ/W0EpluUmFv7uVYkfQw3hKRefJI=
Received: by mail-wr1-f45.google.com with SMTP id s8so11650956wrt.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 15:14:10 -0700 (PDT)
X-Gm-Message-State: AOAM530/kjH4L7GAiTP/HNm/k4ldD/332uVEd9axoSvqFOoKvT8nv0gc
        dyRTOkHJ5XEIlxKEZOpf2ZWr9MMbpx5g6d0ZSgK3ZQ==
X-Google-Smtp-Source: ABdhPJyQRqTKHMvUQikfAIDsNa4fGOYa2s+WPFIcSr0XxADi8+I4Xe9tC05a92awxIAm1oEJSQfR+mn9fYld6MlVR5A=
X-Received: by 2002:adf:fe45:: with SMTP id m5mr4813269wrs.257.1590185648719;
 Fri, 22 May 2020 15:14:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200522204738.645043059@infradead.org>
In-Reply-To: <20200522204738.645043059@infradead.org>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 22 May 2020 15:13:57 -0700
X-Gmail-Original-Message-ID: <CALCETrV7GYg5V5dgM9BToc6RAqpcjRdoZoeXbnrTKTqjBfft6g@mail.gmail.com>
Message-ID: <CALCETrV7GYg5V5dgM9BToc6RAqpcjRdoZoeXbnrTKTqjBfft6g@mail.gmail.com>
Subject: Re: [RFC][PATCH 0/4] x86/entry: disallow #DB more
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 1:49 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> Hai, this kills #DB during NMI/#MC and with that allows removing all the nasty
> IST rewrite crud.
>

This is great, except that the unconditional DR7 write is going to
seriously hurt perf performance.  Fortunately, no one cares about
perf, right? :)  Even just reading first won't help enough because DR7
reads are likely to be VM exits.  Can we have a percpu dr7 shadow
(with careful ordering) or even just a percpu count of dr7 users so we
can skip this if there are no breakpoints?  We have cpu_dr7, and some
minor changes would make this work.  Maybe replace all the direct
cpu_dr7 access with helpers like dr7_set_bits() and dr7_clear_bits()?

Also, I like raving at DR7 :)
