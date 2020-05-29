Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F65CC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 02:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09C212075F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 02:04:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CB8UJu43"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404781AbgE2CEt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 22:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390805AbgE2CEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 22:04:47 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D49C08C5C6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 19:04:46 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id w20so560788pga.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 19:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LL/jvqQlSfNLPZ0wfLwjnZyalyTmqHTub54bRD3jbnQ=;
        b=CB8UJu43uLR+k80X1p0YZ9wcwqpXFIp4VKgWFtq1wfSf5yBA86r8kcWfxk2/wGwPFf
         R68/mqP6pQ024kpfNyySiA7+ISmOeIe+DkTDJYzjgAqJk9jrNmA03/SN56eC2ul+C+aM
         NoNeWf60hTtE7gEczG80K2ezDUc4RUceIbw3OgvIoUVG8UNngJpiiTXzHWGXb2MssrTv
         MKswTNXx2oIkkeLOl9hdnVnxZS5UnZ+f6k78vr/ygq0/fBSN3NVlmnsP2dWijbeakwtt
         /sduFzESsJOKOdRRVZm3PER+yZygU73bAdvp5jkNtNTi9gb9v/JwNk/EHiugFGzgniN/
         midQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LL/jvqQlSfNLPZ0wfLwjnZyalyTmqHTub54bRD3jbnQ=;
        b=DnOSFUeJ8UxX8paxyjQSx9cesfZm/bXLNTk0pIfAZpyinyqZ2kpjeZg+QRb7RA2WMZ
         XlomuQ6o3H5n82a6J4GA2jiZBcZ46XTJjUymX+MNSgkKIyPv0Q0T0c9u/UKPW6/f2czg
         Gt7iPQmqqe4h25OGLo96mPRY852PprzonMtPlRiuB0tLYzZk1EC/UPEKsWj/Drj/gd53
         G0h2QlhQP9/1uiZmynnorKlCu2/EmB725IrCqgpP0dmRn9eHjlt0brN/cRADePOiHzU1
         Bs/HB7277VQqwBHODcVZrd5dTns/SD+WdSQHsOfgL1U7NOj1Ems8BMxdG8AWK56nSiiw
         gbyw==
X-Gm-Message-State: AOAM530NmXhqGi2/XGmTqX7cBUNliAMIvEsAl+Z+/UgEDWXdGYEupMQ8
        sZ+oos2uY4aA3qDqBe4j1UQ=
X-Google-Smtp-Source: ABdhPJxYKd9G2iMUvq8h6/VFZyECUotvwOyFG6LXUPPS7iZIRlv0J4GKSMkKoV7U7VL/1QFoms8DXw==
X-Received: by 2002:a63:ea42:: with SMTP id l2mr4235540pgk.198.1590717886358;
        Thu, 28 May 2020 19:04:46 -0700 (PDT)
Received: from localhost ([2409:10:2e40:5100:6e29:95ff:fe2d:8f34])
        by smtp.gmail.com with ESMTPSA id q44sm6842027pja.29.2020.05.28.19.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 19:04:45 -0700 (PDT)
From:   Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
X-Google-Original-From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
Date:   Fri, 29 May 2020 11:04:42 +0900
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH] twist: allow converting pr_devel()/pr_debug() into
 printk(KERN_DEBUG)
Message-ID: <20200529020442.GA526@jagdpanzerIV.localdomain>
References: <20200524145034.10697-1-penguin-kernel@I-love.SAKURA.ne.jp>
 <20200525084218.GC5300@linux-b0ei>
 <20200525091157.GF755@jagdpanzerIV.localdomain>
 <f02a71bc-0867-be60-182b-10d7377b2b04@i-love.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f02a71bc-0867-be60-182b-10d7377b2b04@i-love.sakura.ne.jp>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (20/05/25 19:43), Tetsuo Handa wrote:
> >> On Sun 2020-05-24 23:50:34, Tetsuo Handa wrote:
> >>> syzbot found a NULL pointer dereference bug inside mptcp_recvmsg() due to
> >>> ssock == NULL, but this bug manifested inside selinux_socket_recvmsg()
> >>> because pr_debug() was no-op [1].
> >>>
> >>>   pr_debug("fallback-read subflow=%p",
> >>>            mptcp_subflow_ctx(ssock->sk));
> >>>   copied = sock_recvmsg(ssock, msg, flags);
> >>
> >> The NULL pointer deference was found even without this patch.
> >> This patch would just cause that it will manifest itself on another
> >> place. What is the benefit, please?
> 
> It would help localizing the bug in this specific case.
> 
> It's not only about %p, even %d can crash kernel or leak sensitive
> info (if it happens after-free/out-of-bounds/uninit). Overall it
> increases code coverage and allows to catch more bugs earlier.

I don't know. Relying on random pr_debug()-s that can be added or
removed any time. oops backtrace should help with that. You are
not going to add pr_debug() all over the kernel, are you?

	-ss
