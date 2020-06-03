Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A63AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 06:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF5A220825
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 06:02:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KQSJhsWb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgFCGCK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 02:02:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:35356 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725823AbgFCGCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 02:02:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591164126;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=o6jcKEk2mcNih81oO7ze2OIDsY31roMJVUEa+DK3JW4=;
        b=KQSJhsWbuJxwK8sR+YKrV5au+UwrU4/bluQFJ1JHjhq/prhUAzF+UpJC5T0BJne+Ldt2eM
        cHCC2P5P+TNCjZuty4GkzoQ2fs5A4B7yn3j1AlWNFdk7ARsXzc93EChCnVtGkteNJLCEQQ
        FRgW1CmPGPOWhUCk9PlmL8UYhV38NCI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-3rHZStFCO0Kx-cPVcdM1OA-1; Wed, 03 Jun 2020 02:02:02 -0400
X-MC-Unique: 3rHZStFCO0Kx-cPVcdM1OA-1
Received: by mail-wm1-f70.google.com with SMTP id g84so455313wmf.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 23:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o6jcKEk2mcNih81oO7ze2OIDsY31roMJVUEa+DK3JW4=;
        b=IEtNkoLzQFsFi7Bw/qKCa2HLBmsSfb4TrGxZ286rmXiTZDDPZIQWJEwQc4EcIqgh5h
         qBRzNvhDPv3bfupapvk7YcttoD0J8eh8qYK8OrunItBLDp9A/+mD1YuVVq53Fg2W2KtY
         WuY9HAz3LI5TkvR2P2MS2/IpXs0/gLUWFuWLTjO9ou4mEBjE3hmAO8bviYFflv2eGwjA
         ZJzns1IIY28IDF6c7IHMnUGNymMhU6pnbQ7+6kATofG+x05l3vmP59sCoR5Pg/+CMATe
         5A6hrAWvphVJTaMyWcqhh+2zJxe4jlzXvANtDF+zTBcGgbAfhS8/mj3atDtNb95gOOVV
         E+Pw==
X-Gm-Message-State: AOAM530krBliWr9++ADTUQl25A1buebP8gEcPgrJLZyfa5H7sFA+2tad
        Y/gEX5XfB+E7vmlmrau6D6eaMaX2MNDlwOewEoML5pgg9qLOSN0sAI3QDF4Ad73wCXer6+/3XIA
        J5kWC2fE6Q1mXpGJ/moHlQGxD
X-Received: by 2002:a1c:f003:: with SMTP id a3mr7045174wmb.119.1591164121029;
        Tue, 02 Jun 2020 23:02:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxXl+sofUHZk+VbvLWmhyqHx7h7DWb02lQ/P8NQ7EV8iW/Kg++HMCXfoH3XtMI929I9Wym9Mw==
X-Received: by 2002:a1c:f003:: with SMTP id a3mr7045163wmb.119.1591164120841;
        Tue, 02 Jun 2020 23:02:00 -0700 (PDT)
Received: from redhat.com (bzq-109-64-41-91.red.bezeqint.net. [109.64.41.91])
        by smtp.gmail.com with ESMTPSA id k16sm1608442wrp.66.2020.06.02.23.01.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 23:02:00 -0700 (PDT)
Date:   Wed, 3 Jun 2020 02:01:58 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jason Wang <jasowang@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH RFC] uaccess: user_access_begin_after_access_ok()
Message-ID: <20200603014944-mutt-send-email-mst@kernel.org>
References: <20200602084257.134555-1-mst@redhat.com>
 <fc204429-7a6e-8214-a66f-bf2676018aae@redhat.com>
 <20200602163306.GM23230@ZenIV.linux.org.uk>
 <CAHk-=wjgg0bpD0qjYF=twJNXmRXYPjXqO1EFLL-mS8qUphe0AQ@mail.gmail.com>
 <20200602162931-mutt-send-email-mst@kernel.org>
 <CAHk-=wgYu+qk15_NpUZXwbetEU5eiWppJ=Z_A6dCSCWKxCfDfw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgYu+qk15_NpUZXwbetEU5eiWppJ=Z_A6dCSCWKxCfDfw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 02, 2020 at 01:43:20PM -0700, Linus Torvalds wrote:
> On Tue, Jun 2, 2020 at 1:33 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > Hmm are you sure we can drop it? access_ok is done in the context
> > of the process. Access itself in the context of a kernel thread
> > that borrows the same mm. IIUC if the process can be 32 bit
> > while the kernel is 64 bit, access_ok in the context of the
> > kernel thread will not DTRT.
> 
> You're historically expected to just "set_fs()" when you do use_mm().

Right and we do that, but that still sets the segment according to the
current thread's flags, right?

E.g. I see:

#define USER_DS         MAKE_MM_SEG(TASK_SIZE_MAX)

and

#define TASK_SIZE               (test_thread_flag(TIF_ADDR32) ? \
                                        IA32_PAGE_OFFSET : TASK_SIZE_MAX)


so if this is run from a kernel thread on a 64 bit kernel, we get
TASK_SIZE_MAX even if we got the pointer from a 32 bit userspace
address.



> Then we fixed it in commit...
> 
> Oh, when I look for it, I notice that it still hasn't gotten merged.
> It's still pending, see
> 
>   https://lore.kernel.org/lkml/20200416053158.586887-4-hch@lst.de/
> 
> for the current thing.
> 
>               Linus


Maybe kthread_use_mm should also get the fs, not just mm.
Then we can just use access_ok directly before the access.


-- 
MST

