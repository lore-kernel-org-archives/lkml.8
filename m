Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0D0C33C99
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 04:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC4F52077B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 04:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uLOBwf7g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731425AbgAJEwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jan 2020 23:52:03 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33976 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731405AbgAJEwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 23:52:02 -0500
Received: by mail-oi1-f196.google.com with SMTP id l136so862955oig.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 20:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vlinJQxreNW0LgSHPxKHqjPCjfftwQydPg4qaMBMqAY=;
        b=uLOBwf7g0tzyDtdRmJRecwzNi4gLs3YTVmGXZmuRK9t1bycyxTxEcT03f4Jj1XQU1n
         tU71/YmmsbvP2dVbyJlKdq/z8kBEcDa+MApxrUQcJe712ZFbqLL9NZqAB7khQLox+MwC
         Dm7qxfPPx3STpsOgA2YA1SpXGETkF32KxpBM9JnSUO7V9RH2A8vlcSz+sRiJNcDPDXK4
         b3jNsTFfT2yb0m+Hge1nb0q0Vxm9kEs9jjOePC9dklTQ9mxQFqn/1zaiMpK3x9y/9xrX
         VDc7YjSoAkGAxcelOrtEajhYF2GpwhrFEpt3RzaZY6V05Xb2ACtMhSvpfWkIS5ahOwuc
         2liA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vlinJQxreNW0LgSHPxKHqjPCjfftwQydPg4qaMBMqAY=;
        b=I8x+BmsIfNUrUS1VbPqkO/XBsqxgVIK3+sDbHcYChXQ7YJ1s0XPTuUA39pXMUx5JuS
         B+t5g24IRbJ3KEsSXFW3Tkx+I2hv4SwiByxCwgTFo3dgX4lLGMp45ZvShu1JgjehSV8Z
         z3htKwYZKx6tzMCJ2nfYvDX5JbxphkoyUNcvyQc8Av9JGset0LC1DD6wXhFi+KhmI4ii
         Ox+qvd0mNOLBLd613yWifXQDa6+dHKk8//rbJmJujoNdtouAwqUn7pIXD++p5esBC3ru
         bcXwKSYdbO/aM0KoLQy5V5ZV/Ii8e4koNgLAjP3xvFS5fTQat27FWQe4Nqfd37gGTs7X
         T7Bg==
X-Gm-Message-State: APjAAAX+8yZoTYSnBrXQb7IZ+VupdsTWC7y9Y9Z44EVRITb0mcehO7tq
        26ItTtlcmM2w9JIvHCr2Ljg5VWG/Yu1UZ2rGZPI=
X-Google-Smtp-Source: APXvYqzMKoLVp5l6PZowKodtclvYtR6R33nF6mAg+foENgKXM9Ziv54vxfZlM/u1CC23hIWvj4i3c8R5GG8UoDeeSgk=
X-Received: by 2002:aca:3cd7:: with SMTP id j206mr842019oia.142.1578631922395;
 Thu, 09 Jan 2020 20:52:02 -0800 (PST)
MIME-Version: 1.0
References: <20200109225646.22983-1-xiyou.wangcong@gmail.com>
 <CAHbLzkr=P38zJMpNVtw9oKMT65hwq6ie85h-fRi7rpZyf4A71g@mail.gmail.com> <CAM_iQpWvrR9cVA31tD7Mvx0yTN=NDXQ-NMYStH9UB3Rb6WzmeA@mail.gmail.com>
In-Reply-To: <CAM_iQpWvrR9cVA31tD7Mvx0yTN=NDXQ-NMYStH9UB3Rb6WzmeA@mail.gmail.com>
From:   Cong Wang <xiyou.wangcong@gmail.com>
Date:   Thu, 9 Jan 2020 20:51:51 -0800
Message-ID: <CAM_iQpWr2HLkW=ZSjZmiOpJyUG7T1QaWQOSW7vi34hqd2L4Bmg@mail.gmail.com>
Subject: Re: [PATCH] mm: avoid blocking lock_page() in kcompactd
To:     Yang Shi <shy828301@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 9, 2020 at 5:01 PM Cong Wang <xiyou.wangcong@gmail.com> wrote:
> I tried to dump the process stacks after we saw the hung task
> with /proc/X/stack (apparently sysrq is not an option for production),
> but I didn't find anything useful. I didn't see any other process
> hung in lock_page() either, all mm-related kernel threads were sleeping
> (non-D) at the time I debugged. So, it is possible there was some place
> missing a unlock_page() too, which is too late to debug after the hung
> task was reported.

Never mind. I found the process locking the page, /proc/X/stack apparently
fools me by hiding page fault stack. :-/
