Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88589C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B21C207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599071257;
	bh=DETywkfZCVtkkUUM6ap6SVctxaJtbjfC7H7SCPWvdxo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YfCRymv2IMpGL9sxUBWOyoHT7EDQNo0SLkAFkYWHvuXnbPkAj1/p+Z2+jmbHpGypM
	 4xbumYV/EF4A192jQMuOhy8IbTSFBcQiWjmwpnqvWW2BMvqvsLf8HE/yULLlQxsKjx
	 wqUlYlUQQsi3Qs30rRA2TqPxAuls5SPhSrvB0JMg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgIBS1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbgIBS1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:27:34 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6640C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 11:27:33 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id a15so355159ljk.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 11:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z6I0gofzLwArpC9CQ8lKOD/LoW6ktlk0OSBFVSWMzlc=;
        b=b9rO7lav1hRdO25h2/k4WJpIcdR3s9JWnsi6rlPcBqQmfi+M/FzSgBmM4WmT600bsX
         Aml+MhPOC+qa86ChFvFjU2nPWdJjTZB/wuEmwXaqFLDuuCabexXfXjqvQoQhYZkjrp4s
         TmVObtmfAsUs3TvRokytqepl/DdT2H54lzc0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z6I0gofzLwArpC9CQ8lKOD/LoW6ktlk0OSBFVSWMzlc=;
        b=fXv/NTD76VUOoJDfhaHvEqZchY2QelLyXXKxCyI+b4pmPOqus+VeXG4vGU36f7t2BG
         WfMPrdTNk8Agr8cH9zvPDTjE5haW3NMN67sQie8edgp1RejfIa5ZQIwGFAsdvLPOUh3t
         ybCAB7udhZC5372j4T+VJJzraYa6BgRo3RF90uAdjdxzl9fBXHEcPip/m3yjaUJR+8xA
         KDZPRE8Ur80Kq//D3xCG+XRQRYtWBNNrDXjLBzx9f0Y2qzT6Pgh75K80GsrNIv51jfzB
         GmUT1FO01fWhdw8ODIMAZ2A14AUyMVOdPu9Cg8e9gfHUBf3jnr5OW+OYYMI0lqxBsd6o
         T+kg==
X-Gm-Message-State: AOAM533jbOF4bFyemvTBOH6Fs8FnD4Qt+fBNkS73qUDJ5IifCUxq3sMz
        hNxiow1eo8oL13nzAzJt2jn8s8buCUJTuA==
X-Google-Smtp-Source: ABdhPJyN3SbF2Ey1czKJrGKxd3V8oifcvAY50y3SDzIITU4ld4xicU4kagf/pvAmntXnLFmFhG5JDQ==
X-Received: by 2002:a05:651c:124e:: with SMTP id h14mr3725396ljh.384.1599071251526;
        Wed, 02 Sep 2020 11:27:31 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id w26sm87003ljm.30.2020.09.02.11.27.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 11:27:30 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id k25so292693ljg.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 11:27:30 -0700 (PDT)
X-Received: by 2002:a05:651c:104c:: with SMTP id x12mr184552ljm.285.1599071250062;
 Wed, 02 Sep 2020 11:27:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200902085513.748149-1-leon@kernel.org> <20200902085513.748149-2-leon@kernel.org>
 <CAHk-=wiOJ4H=YFO8+EumOcrciQgeKXY1Z92jdqY8OQdprPXkbg@mail.gmail.com> <20200902174600.GK59010@unreal>
In-Reply-To: <20200902174600.GK59010@unreal>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 2 Sep 2020 11:27:14 -0700
X-Gmail-Original-Message-ID: <CAHk-=whG7MPx0_6S8ATd4yRPtwKTThDNtbKQDQARHbaPp2H1Wg@mail.gmail.com>
Message-ID: <CAHk-=whG7MPx0_6S8ATd4yRPtwKTThDNtbKQDQARHbaPp2H1Wg@mail.gmail.com>
Subject: Re: [PATCH rdma-next 1/4] gcov: Open-code kmemdup() to work correctly
 with kernel and user space pointers
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 2, 2020 at 10:46 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> Definitely my explanation is wrong, but it was my interpretation of
> "BUG: KASAN: global-out-of-bounds in kmemdup+0x43/0x70" line. I saw
> that the failure was in memcpy() inside of kmemdup(), so I changed
> from memcpy to be copy_from_user() and it solved the KASAN warning.

But the actual patch attached to that explanation *doesn't* use
copy_from_user().

So your "changed from memcpy to be copy_from_user() solved the KASAN
warning" explanation makes even less sense. Because that's not at all
what the patch does.

             Linus
