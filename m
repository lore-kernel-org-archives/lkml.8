Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44454C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 23:42:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E48C120672
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 23:42:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XMPdvNue"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbgIHXml (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 19:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbgIHXmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 19:42:40 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2C78C061573
        for <linux-kernel@vger.kernel.org>; Tue,  8 Sep 2020 16:42:39 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id o20so483317pfp.11
        for <linux-kernel@vger.kernel.org>; Tue, 08 Sep 2020 16:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=eMOiJpHtFtKakMysopXvdUXf6Ey6S8XzJcpKEXF+UkI=;
        b=XMPdvNueNy5Mw0EVTj1jo2i6yWrdGtPdxF80B9LN6j5ePhv5tGbKQG8tS6CoyXfvak
         IIKjHGyT2UjhA91g2TfnCgqW4Rvf0LLq5HypwLKornW+bmD99kvgt1BS/bB0PH9C5qVF
         HPtTkPs0rYnwKpg+UPKr5h7kYgZVivAROlVb4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=eMOiJpHtFtKakMysopXvdUXf6Ey6S8XzJcpKEXF+UkI=;
        b=hEMPHnlCpzWISrltIXM7WPex04/Zb3tgs0XPCJBg2AEJNQD85Ji/+cufEJNaO4qyCk
         V3kGY0gY8NwWq7D/FTvE3sXTqX3/l1hLbu2O05JlxKCXCcrrEKhMtrxELrsih/Xx1Pjd
         bICDmOaWUEsWyIJRjiN6hFUCXSt/MG66zczXq6mgy0IG2MqGrP7NFIovEPEHYxhXdJo+
         c8nW7u1gU1LGRFCG56nwCM6Tcrp2gdej+A20DpS40j2SKkSgBPK350ohzjpkI6ruFJW8
         MD9gjIFuvpGUq1zLR1OZIgBFmCG9L/aD0UgMDplzNIoVsmklJ7iZ2vXr9KscpwggSi4V
         b7wA==
X-Gm-Message-State: AOAM532LuAJ7gnNPEJ7CvCBLJOgayz06ZWI6bVOCPfjmqpf9+5AGWHsI
        sjqbW7/tRX9mSvFF8VA4M6TG1A==
X-Google-Smtp-Source: ABdhPJxgBv1cW1PoOumcL8FFZLU9cgOsJLl8SUUN2m6ZrIVziQbshuuKUDDc1Q3iS58MLHQCbgA1jw==
X-Received: by 2002:a63:754:: with SMTP id 81mr825522pgh.435.1599608559253;
        Tue, 08 Sep 2020 16:42:39 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y203sm495466pfb.58.2020.09.08.16.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 16:42:38 -0700 (PDT)
Date:   Tue, 8 Sep 2020 16:42:37 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] samples/seccomp: eliminate two compile warnings
 in user-trap.c
Message-ID: <202009081633.CC35635@keescook>
References: <20200901083903.2083-1-thunder.leizhen@huawei.com>
 <20200901083903.2083-2-thunder.leizhen@huawei.com>
 <973a1752-7609-bac9-758a-1a977e6fb1f0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <973a1752-7609-bac9-758a-1a977e6fb1f0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 09:33:06AM +0800, Leizhen (ThunderTown) wrote:
> On 2020/9/1 16:39, Zhen Lei wrote:
> > samples/seccomp/user-trap.c is compiled with $(userccflags), and the
> > latter does not contain -fno-strict-aliasing, so the warnings reported as
> > below. Due to add "userccflags += -fno-strict-aliasing" will impact other
> > files, so use __attribute__((__may_alias__)) to suppress it exactly.
> > 
> > My gcc version is 5.5.0 20171010.
> > 
> > ----------
> > samples/seccomp/user-trap.c: In function ‘send_fd’:
> > samples/seccomp/user-trap.c:50:2: warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
> >   *((int *)CMSG_DATA(cmsg)) = fd;
> >   ^
> > samples/seccomp/user-trap.c: In function ‘recv_fd’:
> > samples/seccomp/user-trap.c:83:2: warning: dereferencing type-punned pointer will break strict-aliasing rules [-Wstrict-aliasing]
> >   return *((int *)CMSG_DATA(cmsg));
> >   ^
>
> Doesn't anyone care about this? Or is it that everyone hasn't encountered this problem?
> Why do these two warnings occur every time I compiled?

Hi!

I think the samples have been a bit ignored lately because they have a
lot of weird build issues with regard to native vs compat and needing
the kernel headers to be built first, etc.

That said, yes, I'd like to fix warnings. However, I can't reproduce
this. How are you building? I tried x86_64 and cross-compiled to i386.

-- 
Kees Cook
