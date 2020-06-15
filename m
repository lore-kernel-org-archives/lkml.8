Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35631C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFE602078A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592239194;
	bh=6/U87RsqukwiOYF4cYCU+xUnJ7CuWABq/8Lbgo9CtRc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nvtzy5RcTOtXx2qnBNHKxjdXTnk5BSVpWmAkQU9r3/4a893VnbSbFc4Iz2ocDQHd9
	 MaOfOtcWtafLKmZrakr1vNT4RlITNEGq8KsPh38OXK4fXZRBphlGhRE1mZyECy7Xuk
	 fwtS+jfzD/3pjiZkt/9tNwheNIfo3LxDWJPtWljo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730909AbgFOQjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:39:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729949AbgFOQjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 12:39:51 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32C5EC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 09:39:51 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id d27so5369662lfq.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 09:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Cx2AztWHzzxrSgmq+Me98oVJt/pCqP1GcYCCJga1v3o=;
        b=hYqsrzQyaCq1kQgp0spHAppAk0hS2j5g++6SYxCLxYxJXAmMfKqTQ18qJkn1C27/AG
         eJGDl4TDVRdRqRzTxahAgnZfaGDf0lo3JVIvuqg2IKhggaqVKPMvCx5tTM7h4m+tvAMI
         wN5LBnLvHufylZ12CACwK78MI49zcsJYaDln8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Cx2AztWHzzxrSgmq+Me98oVJt/pCqP1GcYCCJga1v3o=;
        b=QuJUrG28lghUiRlwe4r0yNqDFaU6HXtJCxy4ZwGcq+VfkQ1B7zn5upf9SIZFKkWFGZ
         o8IWSuVZPsE4uJGV+aPqN0Nqi345c2yx5q7MtBZNgA57od5GqtAH3T3LppCoDr8Ww7WF
         pzKCfSNVg1tEwrBNFyHsjm1/5QtnqXWEp8UL+nonEfMJnSm+1RljL3noAl5GtSB/jE5N
         ChSqx8crFF44kbes/xHVKKx2Y7gs25DwOLftaKmgH0c3FZyErQfthNavR4J81Z4bYVzS
         DQzhNpY0+oHfgnVcs/NOYAX7aw7mRtH0ZdAHTbX3xVK1d8uoIuwIXEaz0+HZ9P0YaWW1
         dlxQ==
X-Gm-Message-State: AOAM532PF+22/EZtTBhd4WfotyzafVYQ+iJe1b2qPWdNnHEdiavAHArW
        fL7jcpbgIRQZoGQHRRTOAG9T5XCY0to=
X-Google-Smtp-Source: ABdhPJw2xDF310x/RONiUOmwF2g5oOW7aMYjtrni+60YLiUD940y7HNYQILqhZTqfbYivtD8bGq5yQ==
X-Received: by 2002:a19:381a:: with SMTP id f26mr1708342lfa.110.1592239189217;
        Mon, 15 Jun 2020 09:39:49 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id c8sm4636825lfc.46.2020.06.15.09.39.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 09:39:48 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 9so19970555ljv.5
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 09:39:48 -0700 (PDT)
X-Received: by 2002:a2e:974e:: with SMTP id f14mr12917365ljj.102.1592239187960;
 Mon, 15 Jun 2020 09:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200615121257.798894-1-hch@lst.de> <20200615121257.798894-6-hch@lst.de>
In-Reply-To: <20200615121257.798894-6-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Jun 2020 09:39:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=whfMo7gvco8N5qEjh+jSqezv+bd+N-7txpNokD39t=dhQ@mail.gmail.com>
Message-ID: <CAHk-=whfMo7gvco8N5qEjh+jSqezv+bd+N-7txpNokD39t=dhQ@mail.gmail.com>
Subject: Re: [PATCH 05/13] fs: check FMODE_WRITE in __kernel_write
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 5:13 AM Christoph Hellwig <hch@lst.de> wrote:
>
> We still need to check if the f=D1=95 is open write, even for the low-lev=
el
> helper.

Is there actually a way to trigger something like this? I'm wondering
if it's worth a WARN_ON_ONCE()?

It doesn't sound sensible to have some kernel functionality try to
write to a file it didn't open for write, and sounds like a kernel bug
if this case were to ever trigger..

                Linus
