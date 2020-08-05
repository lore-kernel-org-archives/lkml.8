Return-Path: <SRS0=MXgo=BP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B9F1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 18:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3707C21D95
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Aug 2020 18:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596650694;
	bh=fZuQ51RUJD63ksMrmW891icCVCacHJ5MjhYmzudWyGs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=OGirsMvcgS1TQ1MJ0eyTRfYBoUykLHzUVD6ZpeaG5eRsL47m7uSjlvlv81lsOD1Ys
	 ChfgkY9qMT7H0Ca00RI/z4pUInMO+M+Pebtvle5TGQD+FPSyyb6L0NW893gVDcOgnE
	 TjFUCkeK1HKMcwXpoOYeO3zZL5HIhUlyoqLjGvDQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728434AbgHESEw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 14:04:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729158AbgHESCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 14:02:03 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66DEC061575
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 11:02:02 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id t23so25215874ljc.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 11:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i6O0Je/DALynD8xrcy5F8ovIlpP2BIIuUrwkKTqZEB0=;
        b=TwuFz2Csj8S8tUXG01UOeW7C+pBdX/X5QDikPbQzn5Kqk/HmRDlnzqmYtwm0wssMfA
         gZLb0FsZS8pej72cSFjZaCsvm3Q4AMV35e9TANq4fHh1wTeb4XYJPJxX/1tDKv8HMsyW
         A7HULq4It/ZbgyWzZA3KFCar/TC7JUMoY/Vng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i6O0Je/DALynD8xrcy5F8ovIlpP2BIIuUrwkKTqZEB0=;
        b=SUW6TItD6/dAPUuVUMKA5e4NH4reew1KvAJHsuojcal+eXyxOxZyO/GEDd9Zx3jCQ3
         LC8h8SSKPa/S5aMM89nK8FztXJol0+d0Kn647PtHJwvxfjPasr/cPjJC7HZI8ckYp2Jy
         1FhlbkbyEAGpIACK6L670uL4DTRwR3DfGtKV0+F5H8BY+Sl0UI9Db4E8i1FGgGZdzOts
         O7FPqAVNTEPOMTujgcDWFrFbum5eRSN2/9UPDpnZc7Dw3rbyi8GGOIWhfw8h9+Ty0QXK
         KRrKeT1JDBZ14WCRshny/SgqlYEii0RrwEPMr97h+1bJKVFrvkfghdfyfMSTnZ/G0lpH
         LA5g==
X-Gm-Message-State: AOAM532RkgDovUgrwulXlDQFw8oN43juWAdgn3EZ+B9D5sGQm3/GN+9O
        7psJO0C0dzVMmgXQhQGFZdTVKwsXp3M=
X-Google-Smtp-Source: ABdhPJwDi+Sjo+Nyi8vEVohaS5EH2jkO9r80LQL6fVXl3tjCZ8ZOGVtJTyezU8atKI7g53hc0xsY0A==
X-Received: by 2002:a2e:9913:: with SMTP id v19mr1860871lji.292.1596650518731;
        Wed, 05 Aug 2020 11:01:58 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id z22sm1413444lfb.93.2020.08.05.11.01.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Aug 2020 11:01:57 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id x9so48760481ljc.5
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 11:01:57 -0700 (PDT)
X-Received: by 2002:a2e:7615:: with SMTP id r21mr1889320ljc.371.1596650516525;
 Wed, 05 Aug 2020 11:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200805153506.978105994@linuxfoundation.org> <CA+G9fYv_aX36Kq_RD5dAL_By4AFq=-ZY_qh7VhLG=HJQv5mDzg@mail.gmail.com>
In-Reply-To: <CA+G9fYv_aX36Kq_RD5dAL_By4AFq=-ZY_qh7VhLG=HJQv5mDzg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Aug 2020 11:01:40 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj1bhyhuJbA5_UbqAnbjqA_hSrmZFqCQrhJ=44P--T4vQ@mail.gmail.com>
Message-ID: <CAHk-=wj1bhyhuJbA5_UbqAnbjqA_hSrmZFqCQrhJ=44P--T4vQ@mail.gmail.com>
Subject: Re: [PATCH 5.7 0/6] 5.7.14-rc1 review
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marc Zyngier <maz@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>, patches@kernelci.org,
        lkft-triage@lists.linaro.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux- stable <stable@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>, Willy Tarreau <w@1wt.eu>,
        Grygorii Strashko <grygorii.strashko@ti.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 5, 2020 at 10:39 AM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> [ sorry if it is not interesting ! ]

It's a bit interesting only because it is so odd.

> While building with old gcc-7.3.0 the build breaks for arm64
> whereas build PASS on gcc-8, gcc-9 and gcc-10.

Can you double-check that your gcc-7.3 setup is actually building the same tree?

Yeah, I know that's a slightly strange thing to ask, but your build
log really looks very odd. There should be nothing in that error that
is in any way compiler version specific.

Sure, we may have some header that checks the compiler version and
does something different based on that, and I guess that could be
going on. Except I don't even find anything remotely like that
anywhere. I do find some compiler version tests, but most ofd them
would trigger for all those compiler versions

Or is there perhaps some other configuration difference?

             Linus
