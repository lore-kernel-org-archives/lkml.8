Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D69B9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 16:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B36F20737
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 16:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591721353;
	bh=JsT12WSvXhDryXhjex3aGi124e+fMsXrg8XGx3UU+ag=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=pThlHE1oeHU2fZ4R7je9nmTePqPrEzdFy+rkxD9R22PauEEb53MbC1vlyebu55Gm0
	 M+uZWXH+bSdFRzvweNUIvI9wzMZ6McvD/uB9H1yHEweX2yDcBgtl2cEG+rVHwB+2rn
	 9+2xgWR6JTOYsxG9mXjQzBtqKIwvVfdfPaaUqtOk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731127AbgFIQtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 12:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731061AbgFIQtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 12:49:08 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3201FC05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 09:49:07 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id n24so25908787lji.10
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 09:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v+eZVpWI+1D9dHZQUKIk/y34wQFtqgnbT/JoaV292xs=;
        b=StMmkfoaPXkHKNIC++KAQhXjLtVDtWTNmiwfWeKs2x3DGD5m+CKz8gZnONJopQM1qP
         Y9pXiegRmflg0Cz8lA4b3rWwvJiD8EU4smcIoU+Vy4LSD02Nyaf8sgWWRaZkCTI+qJOJ
         mAoVVBJMY1T/6RmRBaNU6DQPPmW/Z85XwUq3o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v+eZVpWI+1D9dHZQUKIk/y34wQFtqgnbT/JoaV292xs=;
        b=MaJlblJhKhZlnXHVCzWtRCxTBAWZm+TeM/UU10NJvc1X5VEGL3yHfpvVWMyHEtNsXc
         t1+vrcU5D1NHdFPwaECvwldEY97qG2k6WhXXmAumcFCMORxlivMN7Ny6PxOF0DyekBAL
         qo5WviBVgCTy4EzbrO/w3WjW5dC6GmKSm90eCtVLLRPT9qdcj0kpNWOeZ7b1xpudxDtJ
         AedEsJzOfjUkL2ZJEWRtQ02t2QlIFpWO4M+2rG8Zrd0uSxftB94lUifVNxivB7+KwmWI
         8ip1SVEkcODXR6+1Kp3dhZeUxmHF1aYZrJyq45lCAbMWyCFluEkkSTq1VEBgTi150iUN
         44Jw==
X-Gm-Message-State: AOAM532yxHq6HSMC+TQ/79dGjg8tSKWgGSr9eaPSJz++/wI4vhBGOI5a
        5ur638xSs0xoudnoZh61+dajQlSaKG8=
X-Google-Smtp-Source: ABdhPJxB8WY30MGB1mBVkuWrNflOi7BfDVnpKSliSOZkl1aJL614vvJ4VPaU9o+KL16p0Pi1fyNiWw==
X-Received: by 2002:a2e:9e88:: with SMTP id f8mr11491070ljk.193.1591721344108;
        Tue, 09 Jun 2020 09:49:04 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id 193sm4415025ljj.48.2020.06.09.09.49.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2020 09:49:02 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id c17so25914002lji.11
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 09:49:02 -0700 (PDT)
X-Received: by 2002:a2e:97c3:: with SMTP id m3mr14630049ljj.312.1591721341985;
 Tue, 09 Jun 2020 09:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=whQt69ApMkZF8b2Q2idMDgPpPETZeeOuZg59CrOO4025w@mail.gmail.com>
 <20200428091149.GB19958@linux.vnet.ibm.com> <20200428123914.GA27920@redhat.com>
 <20200504164724.GA28697@redhat.com> <20200609153020.GB17951@redhat.com>
In-Reply-To: <20200609153020.GB17951@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 9 Jun 2020 09:48:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgOkWaEwCNunc4_WXF_SLJZSeNEnstvHha9n82iLYpyCA@mail.gmail.com>
Message-ID: <CAHk-=wgOkWaEwCNunc4_WXF_SLJZSeNEnstvHha9n82iLYpyCA@mail.gmail.com>
Subject: Re: [PATCH] uprobes: ensure that uprobe->offset and ->ref_ctr_offset
 are properly aligned
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Guo Ren <guoren@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Jann Horn <jannh@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jens Axboe <axboe@kernel.dk>,
        Security Officers <security@kernel.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Ananth N Mavinakayanahalli <ananth@in.ibm.com>,
        Naveen Rao <naveen.n.rao@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 9, 2020 at 8:30 AM Oleg Nesterov <oleg@redhat.com> wrote:
>
> Looks like this patch was forgotten...
>
> Should I resend it?

I guess I'll just take it directly, since it was triggered by me
complaining anyway.

I had hoped it would go through the usual channels.

                Linus
