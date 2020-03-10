Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8757C10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 22:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57C6F208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 22:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583878475;
	bh=+pSRM1EQCR8DzrH/QVX9aPyJfG2OaNF+PzXLVYU+79Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=p5myJHSQjUhO4iB9tPJd2BPn33shJt1/nhdLRbwzOV9xmCBe6yZYpbjVs2AXpoHX1
	 G3PwyG43zLFd8t/5TMaCdey6MLNnX1/eZWBAHVPGcDsq67x2zYZWWaa6ygGSTbjAq+
	 OKMKML9H8EMPztueHtWyFoPSDR4+NOn3+ZRUhclU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727737AbgCJWOe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 18:14:34 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35617 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727717AbgCJWOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 18:14:33 -0400
Received: by mail-lj1-f193.google.com with SMTP id u12so74510ljo.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 15:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A0DJ1QWaOzdShQUNy+Xq2LWv3cgxACTM1sGjd/lAyrQ=;
        b=PE12SCsWX0jtdXlLC7s8SBu/WbwEPg5yee5goR2A9E7eXbONG+zY2j3g8MU5gMY4cI
         gpQVYpf4gr8akr8301HuU4d0RZVExceNqTnoiuhQMQQ+S4LimrjudwbtXD7qVESq+I3Y
         YunNWg0f3xQ13/vVv6+VaMcob/DyVA/vCVF3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A0DJ1QWaOzdShQUNy+Xq2LWv3cgxACTM1sGjd/lAyrQ=;
        b=BE5d2bUNwSQ1hehghrBv/ihTCErLNcOW7Sd7LpuhjJ9/107jcBElkKTq7aezXVhKOH
         YCfj3q56bcz7KZlcB3i0synjatsSRQDaqEGxFfexD22/FUCzxn3TlD2DF5MVGnldJBZo
         fz2wWJTWRrHFp/ykG/vTjfRcIkdPc3tiBwjeZHo8tOa/VKFXuEJuzNoKWlhhpoRO18p8
         UEDH39OhW9dyVdSunyOoHuNoDduUbB+UyeE5NtF3CK6ZJSSKoFeGF7C7paGsbZ+rnvK0
         HJOnfSD1yxsq0+bzuR2ITgQWVhwFnFACcmIbr5jyuKIDsfqUxrZCcdfMue8aD6pPnnMx
         033A==
X-Gm-Message-State: ANhLgQ1USqWZzHaSSyuTId5jG1/OJ72PKQjL5pA3q9GCuCCfpSC1CuQl
        wLFfgglFAvZ/+BXwTEPX+PgIiqWeFCs=
X-Google-Smtp-Source: ADFU+vuCJCX5n1VGTuDHVWtN8O+2TK+JtHYYqxvWcs3mcbzRm3kdyVxqkPUtOowS5Y+9vFA+tM02ig==
X-Received: by 2002:a2e:b018:: with SMTP id y24mr201976ljk.146.1583878471061;
        Tue, 10 Mar 2020 15:14:31 -0700 (PDT)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com. [209.85.167.46])
        by smtp.gmail.com with ESMTPSA id o13sm1519155lfg.90.2020.03.10.15.14.30
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2020 15:14:30 -0700 (PDT)
Received: by mail-lf1-f46.google.com with SMTP id x22so12293786lff.5
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 15:14:30 -0700 (PDT)
X-Received: by 2002:ac2:5986:: with SMTP id w6mr161806lfn.30.1583878469474;
 Tue, 10 Mar 2020 15:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200310144107.GC79873@mtj.duckdns.org>
In-Reply-To: <20200310144107.GC79873@mtj.duckdns.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 10 Mar 2020 15:14:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi=5p6s_BmPAg5EF8Joe5d-6iAjQq6-Le7+xf5Gq-ZTfw@mail.gmail.com>
Message-ID: <CAHk-=wi=5p6s_BmPAg5EF8Joe5d-6iAjQq6-Le7+xf5Gq-ZTfw@mail.gmail.com>
Subject: Re: [GIT PULL] cgroup fixes for v5.6-rc5
To:     Tejun Heo <tj@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 7:41 AM Tejun Heo <tj@kernel.org> wrote:
>
> * Empty release_agent handling fix.

Pulled. However, I gagged a bit when I saw the code:

        if (!pathbuf || !agentbuf || !strlen(agentbuf))

yeah, I really hope that the compiler is smart enough to just optimize
that, but we shouldn't assume that the compiler is that smart.

The proper way to test for "empty string" is to just check the first
character for NUL:

        if (!pathbuf || !agentbuf || !*agentbuf)

which doesn't require the compiler to have a pattern for "oh, I can
test for a zero strlen without actually calling strlen".

Also, wouldn't it be nice to test for the empty string before you even
bother to kstrdup() it? Even before you

Finally, shouldn't we technically hold the release_agent_path_lock
while looking at it?

Small details, and I've taken the pull, but the lack of locking does
seem to be an actual (if perhaps fairly theoretical) bug, no?

                 Linus
