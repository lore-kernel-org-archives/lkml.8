Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADB68C2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 04:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 831D620757
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 04:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586408027;
	bh=F0WZ4Sq56kp2r2vTrdaMVSwnV01rhP57gkj269JxXuI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=MKbuhgDfes5NHRW3SHJJcl7QaJj4aLFl9eBd1BS5LutWMunioQSMkrIYneauAMDJK
	 uuEQygLZfunDywfpo2RtV7FWPhmnrN1aFJvjhQVdEih8PHrkqgc46VaIieEzzYecfv
	 bGEEn4ijoyOTMgoyy/tgdMaDHCZ4ERJU01QCBKT4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726571AbgDIExp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 00:53:45 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:43863 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgDIExo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 00:53:44 -0400
Received: by mail-lj1-f193.google.com with SMTP id h25so139673lja.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 21:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pKIxs2zRm8OT5XpGNIVtZkNiB0y/6Wwatz3SR/493kg=;
        b=M3rzrXf8/eHi7ET8nMXxx5gyYyNZXr8XRM5XElcbL9uYgSqzUFsyRITiDs2cP3QACa
         X2vBb3j54lhh/qWVj64q1RlLTd8a/iLwfYX435p3ieCor3aDgOTWRJT02f80d7stvV+z
         fG4Zmmnr7nRdXh895Mxr3zKTXfwIwKA8dL0fY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pKIxs2zRm8OT5XpGNIVtZkNiB0y/6Wwatz3SR/493kg=;
        b=keL2h3YarIqnFQLtwGTe9C+VMItIoqvLuwZwVonkF47FUVgYxkR7imm5/7fzHQJF5l
         boCuVoNNt0AG2BC3AyyCfsa5HtDYPbdvUW2FLX1K7hMc04/sNxlf3QSsSXfCihO42feD
         xyDhe7RTcNuBPqLZUmUqlUHfklpyW16o+Lfy0qtZSb/0miscMdghkKBtiVBeA6cJRwzw
         2mizB3GtB9OKG6APqe5cPIgklA4ps24nEZ5xw9tLJJLRF1IjzJKUF2UKvhk4fEDTAQE3
         fXpLp7FKQufXi8DSlLIek8W9jnYtkQVqzr+49WB7oJwEAq2B5qf6xL9NhL4pK3QbnUIZ
         5SzA==
X-Gm-Message-State: AGi0PuYHygvmmZE1hVCO1Z4juc207lqaVktou0a8p2nzOxbVp68Twfd/
        ZhABAsE6jpunZ7uSosBdJtR2jWE1TPo=
X-Google-Smtp-Source: APiQypKYV3f8fLn/e0jcDtv4THyf5RVDzlO6wENogvlBzK2kQtFKZv3cmaKd+NqZjhiJiBMJ6C3YqQ==
X-Received: by 2002:a2e:6c0a:: with SMTP id h10mr6735240ljc.195.1586408022813;
        Wed, 08 Apr 2020 21:53:42 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id u1sm743487ljo.65.2020.04.08.21.53.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Apr 2020 21:53:41 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id w145so6903592lff.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 21:53:41 -0700 (PDT)
X-Received: by 2002:a05:6512:14a:: with SMTP id m10mr6567600lfo.152.1586408021187;
 Wed, 08 Apr 2020 21:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200406110702.GA13469@nautica> <20200408151214.GA30977@nautica>
In-Reply-To: <20200408151214.GA30977@nautica>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 Apr 2020 21:53:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjdwUbCfaMnXRrctDD_ftBRJwbH+x3GtSOJyR1Gtm=HXA@mail.gmail.com>
Message-ID: <CAHk-=wjdwUbCfaMnXRrctDD_ftBRJwbH+x3GtSOJyR1Gtm=HXA@mail.gmail.com>
Subject: Re: [GIT PULL v2] 9p update for 5.7
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 8, 2020 at 8:12 AM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> v2 of monday's pull request. The commit date is just now, but that is
> just the documentation patch I applied, there is no code change since
> the last version.

Note that I had already pulled your previous request, I just inquired
about the behavior.

I now pulled the doc update too.

            Linus
