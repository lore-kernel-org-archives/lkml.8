Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8999C34047
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:54:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3D8D22B48
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 18:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582052044;
	bh=8iTTgbNMqPWasH5TX/yI/YgmsPPCAjZU28vIghYMb6o=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ICKNY1VSLAmdkcSnxX4hyyfqi4X+bR8qC7jYa72Gyi9YmaHB12LBVY5HGBAnsSU75
	 aJt4rYGIQ/PBplcAJrgL9JvH1ckzn+a/rA2BcM++fVzkwyWMyP0ixYifzeZYB/nWQX
	 UAf7XyEdhujKnDjFCfeCLeqtTDCub1CHtSFVn4+Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgBRSyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 13:54:03 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:42350 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726427AbgBRSyB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 13:54:01 -0500
Received: by mail-lj1-f196.google.com with SMTP id d10so24222941ljl.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 10:54:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gInmCZBr53UYRN/0yNo3xgcN+xMMFqgmTLh6dxUQ8E4=;
        b=QlbEHSRfkbu7KS+THYfLYq63FliUeh77hmRjUROQFp94gIFTzMuzUhxH0VcrEPWC37
         yJf+X25qCjCpYArPLbxLXcRp42Pd1jfikvfZEA2NJnIKHwC5rNGfxmsKVeUYcU314FvM
         7tU+JcTTL1VwCcjNBZZ3j3BM0KB+XtlR77//4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gInmCZBr53UYRN/0yNo3xgcN+xMMFqgmTLh6dxUQ8E4=;
        b=W89XN9nzxzSq8yHyoeKtTwtR6OhhbI8maAILHJDCGFwGM92YwZ34sFTv0RheXHg5aX
         AbOBNTX7MYBuCpBnT9tREQmgbtPHSvoJ1BGn3D58Uo9KXmXp72NiMyC1DCEAcVGXOBtG
         kLrVRVyenzAr2QU3FIjWywcpIHZbeBJ8AF1DcUnnSYZ0ceAH13X+ZSm5ATiRh/v7iSDC
         tiDqp/qYTXKvnCJmIbOzSQoxH0Wp14j2uEl1cSdnjh9NtOX9ceqLTd+ZloqHlRHVtSew
         Ic03aRTVW+stUPSfru96aNhfolp3pmBs4Y5KSXxmHqS+WnoFNh2dcfsHJl6/GQqoxHwZ
         PqgQ==
X-Gm-Message-State: APjAAAXlf50X/JS//dDXOrrOXwFi6aeD4bM0IzznC//wT0jfHIADGbcl
        Yizfmjd2h9r6+Go4cowHeb+xr7B0PGo=
X-Google-Smtp-Source: APXvYqy+LwHorGv83D4PGfIgRTF/+4FllhOrsHfGZQhIJH1WGNxnCHciNRGsxwe7b/7ohV+LERTJoQ==
X-Received: by 2002:a2e:9ad8:: with SMTP id p24mr13130435ljj.148.1582052038916;
        Tue, 18 Feb 2020 10:53:58 -0800 (PST)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id q17sm3124115ljg.23.2020.02.18.10.53.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2020 10:53:58 -0800 (PST)
Received: by mail-lf1-f50.google.com with SMTP id y19so15295504lfl.9
        for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2020 10:53:57 -0800 (PST)
X-Received: by 2002:ac2:456f:: with SMTP id k15mr11156468lfm.125.1582052037344;
 Tue, 18 Feb 2020 10:53:57 -0800 (PST)
MIME-Version: 1.0
References: <20200214154854.6746-1-sashal@kernel.org> <20200214154854.6746-542-sashal@kernel.org>
In-Reply-To: <20200214154854.6746-542-sashal@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 18 Feb 2020 10:53:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjnbNRd-3+R5c8L6rS63cF14dDANup7uddak_bO2nfQZg@mail.gmail.com>
Message-ID: <CAHk-=wjnbNRd-3+R5c8L6rS63cF14dDANup7uddak_bO2nfQZg@mail.gmail.com>
Subject: Re: [PATCH AUTOSEL 5.5 542/542] pipe: use exclusive waits when
 reading or writing
To:     Sasha Levin <sashal@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 14, 2020 at 8:00 AM Sasha Levin <sashal@kernel.org> wrote:
>
> From: Linus Torvalds <torvalds@linux-foundation.org>
>
> [ Upstream commit 0ddad21d3e99c743a3aa473121dc5561679e26bb ]
>
> This makes the pipe code use separate wait-queues and exclusive waiting
> for readers and writers, [..]

Oh, and since I didn't react initially, let me react now that Andrei
found a bug here: why was this patch auto-selected for 5.5 stable in
the first place?

It wasn't really a fix, and there's no Fixes: tag or stable tag in
there. Yeah, there's a reference to an old commit, but that one isn't
even a kernel commit.

Yeah, the performance improvements are quite nice if you hit the case
this matters for, but still..

              Linus
