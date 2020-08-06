Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4840CC4346E
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D3AC22CAE
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lXg8hPY0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgHFFqS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 01:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbgHFFqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 01:46:17 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492D6C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 22:46:17 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id z18so14801420otk.6
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 22:46:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=ZaqiVLeoazR8CQkUYq5gppTrJuQmd0jN3Fkv88tkHZ8=;
        b=lXg8hPY0BmpGcYaRUchxmHWlFW+9e0oKPAB8zBqsFvDUDUFNdgW2oK0pVmG8vYYpK6
         HJmAxj9jttkdlgsVM/cddriqU58ErheTTpQN8wjaneDSCH5TaaOfpWOPc8ArN/0HUO42
         sLQleP56GlPaA2igOPdscQwwfi7wC4286H09lAr0agiItTYgbqojuxiPaCDhokeSHxsL
         YDUlbmMs98MWo7qo0HGDJ4q2bdsuM6QjcGvO+qapxkI9kDwYMnc+n4c4yqKHuCsa773A
         37fUMz2x1/2PDP+ccsKkEGd50GohU0bmKOMcn4R/TN3bXkVwGr6mTdnaQSQse2mp+c2Z
         gW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=ZaqiVLeoazR8CQkUYq5gppTrJuQmd0jN3Fkv88tkHZ8=;
        b=FrkMNM+G9p58iwbsA+B5QWb0q2twe6AJh+7Ng3rmqm/JFXYuQZs8a4M/famoaCR3dW
         Jzq62TLhUQPRpyl5Agra1BiudDLhsC+CWR8snhm0pGfa2xb4Rv/godaHTDlNSYDp+sNi
         KlwOwGTiNuowQgwLEdsliVtgoI/BXkfwFbIV+LMiDv8lebkunJxeJJowxN3zqBZMATxO
         L9yygRPbnMCdw9++td8BCkp0aB1i4PK+bxYHkg/3WerdidDx/RzDzDpP02LO42mki7IY
         +6LBiG1ZLA3P1V4s9YiN7pra/nbxwOZ8ibzNEqkQ4GWHVrxuMLNMLu+vzebnyZZzFNj6
         XyFQ==
X-Gm-Message-State: AOAM531fk0KKRc66kH9aR7gs8cDKdLd3IUKrJNiG3BCsIOD/QOipOiBg
        GtMeoxVg68M9MONngkxWawfpeZcBC+4=
X-Google-Smtp-Source: ABdhPJy5o1IUmeAPs1J1R0jyj3A4334OcHJ6zDgUjb5xy7bS5RNnkj02GoG31GNRl0F1FVxN+w4J/w==
X-Received: by 2002:a9d:38f:: with SMTP id f15mr5915614otf.74.1596692776353;
        Wed, 05 Aug 2020 22:46:16 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id z72sm952656ooa.42.2020.08.05.22.46.13
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 05 Aug 2020 22:46:14 -0700 (PDT)
Date:   Wed, 5 Aug 2020 22:46:12 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH] mm: silence soft lockups from unlock_page
In-Reply-To: <20200727193512.GA236164@kroah.com>
Message-ID: <alpine.LSU.2.11.2008052221440.8716@eggly.anvils>
References: <alpine.LSU.2.11.2007231549540.1016@eggly.anvils> <CAHk-=wgvGOnMF0ePU4xS236bOsP8jouj3rps+ysCaGXvCjh2Dg@mail.gmail.com> <20200724152424.GC17209@redhat.com> <CAHk-=whuG+5pUeUqdiW4gk0prvqu7GZSMo-6oWv5PdDC5dBr=A@mail.gmail.com>
 <CAHk-=wjYHvbOs9i39EnUsC6VEJiuJ2e_5gZB5-J5CRKxq80B_Q@mail.gmail.com> <20200725101445.GB3870@redhat.com> <CAHk-=whSJbODMVmxxDs64f7BaESKWuMqOxWGpjUSDn6Jzqa71g@mail.gmail.com> <alpine.LSU.2.11.2007251343370.3804@eggly.anvils> <alpine.LSU.2.11.2007252100230.5376@eggly.anvils>
 <alpine.LSU.2.11.2007261246530.6812@eggly.anvils> <20200727193512.GA236164@kroah.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jul 2020, Greg KH wrote:
> 
> Linus just pointed me at this thread.
> 
> If you could run:
> 	echo -n 'module xhci_hcd =p' > /sys/kernel/debug/dynamic_debug/control
> and run the same workload to see if anything shows up in the log when
> xhci crashes, that would be great.

Thanks, I tried that, and indeed it did have a story to tell:

ep 0x81 - asked for 16 bytes, 10 bytes untransferred
ep 0x81 - asked for 16 bytes, 10 bytes untransferred
ep 0x81 - asked for 16 bytes, 10 bytes untransferred
   a very large number of lines like the above, then
Cancel URB 00000000d81602f7, dev 4, ep 0x0, starting at offset 0xfffd42c0
// Ding dong!
ep 0x81 - asked for 16 bytes, 10 bytes untransferred
Stopped on No-op or Link TRB for slot 1 ep 0
xhci_drop_endpoint called for udev 000000005bc07fa6
drop ep 0x81, slot id 1, new drop flags = 0x8, new add flags = 0x0
add ep 0x81, slot id 1, new drop flags = 0x8, new add flags = 0x8
xhci_check_bandwidth called for udev 000000005bc07fa6
// Ding dong!
Successful Endpoint Configure command
Cancel URB 000000006b77d490, dev 4, ep 0x81, starting at offset 0x0
// Ding dong!
Stopped on No-op or Link TRB for slot 1 ep 2
Removing canceled TD starting at 0x0 (dma).
list_del corruption: prev(ffff8fdb4de7a130)->next should be ffff8fdb41697f88,
   but is 6b6b6b6b6b6b6b6b; next(ffff8fdb4de7a130)->prev is 6b6b6b6b6b6b6b6b.
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:53!
RIP: 0010:__list_del_entry_valid+0x8e/0xb0
Call Trace:
 <IRQ>
 handle_cmd_completion+0x7d4/0x14f0 [xhci_hcd]
 xhci_irq+0x242/0x1ea0 [xhci_hcd]
 xhci_msi_irq+0x11/0x20 [xhci_hcd]
 __handle_irq_event_percpu+0x48/0x2c0
 handle_irq_event_percpu+0x32/0x80
 handle_irq_event+0x4a/0x80
 handle_edge_irq+0xd8/0x1b0
 handle_irq+0x2b/0x50
 do_IRQ+0xb6/0x1c0
 common_interrupt+0x90/0x90
 </IRQ>

Info provided for your interest, not expecting any response.
The list_del info in there is non-standard, from a patch of mine:
I find hashed addresses in debug output less than helpful.

> 
> Although if you are using an "older version" of the driver, there's not
> much I can suggest except update to a newer one :)

Yes, I was reluctant to post any info, since really the ball is at our
end of the court, not yours. I did have a go at bringing in the latest
xhci driver instead, but quickly saw that was not a sensible task for
me. And I did scan the git log of xhci changes (especially xhci-ring.c
changes): thought I saw a likely relevant and easily applied fix commit,
but in fact it made no difference here.

I suspect it's in part a hardware problem, but driver not recovering
correctly. I've replaced the machine (but also noticed that the same
crash has occasionally been seen on other machines). I'm sure it has
no relevance to this unlock_page() thread, though it's quite possible
that it's triggered under stress, and Linus's changes allowed greater
stress.

Hugh
