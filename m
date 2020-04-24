Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D4D3C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 18:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C5432075A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 18:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587754032;
	bh=3DnuD4Zl9wa8w/vDHbLj6+0pA+nXALn2i2YRRevApPc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=GFaoWyLFrQS0SV33mP/eZwdGsppD7ZqatRblVAVPFlxYyE0jGrrsuBOc6LIx9Lj7x
	 qGUWxpHg3DjSI2c1O03YsnW4eGCLiNivyU306codGM1nxY2paEq1PHg2JCMYw8Iru+
	 ijQXmq84C/NE36OnAcjLNBkl7CY/pAhKmtx1MAI0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728990AbgDXSrL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Apr 2020 14:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727031AbgDXSrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Apr 2020 14:47:10 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834D7C09B049
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 11:47:10 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id l11so8549468lfc.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 11:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4xGKLkYDrbkxXaPDoAGMclBp7ffRJ6EszDQ3T54v3nc=;
        b=MwEjKDGJj1MODwKnNzA+vLKGg1thtRHT3e3U4LHSFK+h9wYouw58019uyy6/KEmGky
         24VnGgQr1b7rgt9D8CYnPjqHNk/6kz2e+VairFXVurg4X02ZtnTJl3DNdjL89KBLASEH
         jDDJT1LRGx4BfhkYMobF+P34B+Sx/MgLFiZjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4xGKLkYDrbkxXaPDoAGMclBp7ffRJ6EszDQ3T54v3nc=;
        b=CQ5qLZm7sOQN1aNHN87pWkfjL1rFH/Q82f9PIbxZdL1J+TKvGym00WHaB6e9sGhpGs
         5FAC+5+rqd34cUJAB9vux4Aw4flEL4u6/KPn37jBTgDpqj+2h6QGSv2rb9LzFEoz2wVV
         mXuc667i+JBv6jIsQPUYQ5JLAMz+YN9GavllTw2smECUmC3jxJht8gidT6rzmLWJ9sLx
         z98NT1R6Xcg6uPwQY5a6gIBfMPITZpuLciupXC/4kvlLPeo8611KzUhDsY06UCY0YnZx
         /feC/6F7l27mH5sRjsI1DbjSZ4pdIgSok5EU8pXQfchJz9PHoaTipq0B5DZ0n7r5x3H8
         RR9A==
X-Gm-Message-State: AGi0PuY/hkZ4T5j5nWqcSJKC2qKwVbEj3r26BRch7vy/gEhWrqf3Vq/l
        BA5LI/JhmOpANvrloYEXwPyboyY5bm4=
X-Google-Smtp-Source: APiQypIBXSMCd+4z4ZSs1qmKNqqhjJ3Sx17B/vu8OfPFqbTcLaDN95hTDjDhfzwh3kpVyzbCidKwJQ==
X-Received: by 2002:a19:4204:: with SMTP id p4mr7189707lfa.111.1587754028421;
        Fri, 24 Apr 2020 11:47:08 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id x24sm4925395lfc.6.2020.04.24.11.47.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2020 11:47:07 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id e25so11028055ljg.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Apr 2020 11:47:07 -0700 (PDT)
X-Received: by 2002:a2e:9a54:: with SMTP id k20mr4968653ljj.265.1587754027148;
 Fri, 24 Apr 2020 11:47:07 -0700 (PDT)
MIME-Version: 1.0
References: <20200419141057.621356-1-gladkov.alexey@gmail.com>
 <87ftcv1nqe.fsf@x220.int.ebiederm.org> <87wo66vvnm.fsf_-_@x220.int.ebiederm.org>
 <CAHk-=wgXEJdkgGzZQzBDGk7ijjVdAVXe=G-mkFSVng_Hpwd4tQ@mail.gmail.com>
 <87tv19tv65.fsf@x220.int.ebiederm.org> <CAHk-=wj-K3fqdMr-r8WgS8RKPuZOuFbPXCEUe9APrdShn99xsA@mail.gmail.com>
In-Reply-To: <CAHk-=wj-K3fqdMr-r8WgS8RKPuZOuFbPXCEUe9APrdShn99xsA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 24 Apr 2020 11:46:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg9RQ4rc-TmiP0-rdGPGje2uAX5aWh+=pFhfVdKq=u+aA@mail.gmail.com>
Message-ID: <CAHk-=wg9RQ4rc-TmiP0-rdGPGje2uAX5aWh+=pFhfVdKq=u+aA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] proc: Ensure we see the exit of each process tid exactly
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Alexey Gladkov <legion@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexey Gladkov <gladkov.alexey@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 11:02 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
>  [..] even a "double cmpxchg" is
> actually just a double-_sized_ one, not a two different locations
> one

Historical accuracy side note: the 68020 actually had a CAS2 that was
"two different locations".

Maybe somebody else did too.

            Linus
