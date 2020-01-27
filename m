Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62691C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 17:22:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35D8924658
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 17:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580145728;
	bh=RVZ2l3lpsRgpxdvGkybC0vCIdsPp3qw5HxU7do98MqY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=lSPjsyCKSSA0BOtxzOHh/Fa/5iyviFoWZfMFWWs0LhQGc8tI28vdb5ExaDwylJ57s
	 AqsDM01NfR9mxf28Xz15gQNXOoRfs7uNfMhmirg06QebVIL1D4ZDAiC9th5FJJ4+fb
	 krx0nayN0lmA3QHh37kar4rJttwMNY0SHKwm3zLs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgA0RWH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 12:22:07 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:41561 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725828AbgA0RWG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 12:22:06 -0500
Received: by mail-lj1-f193.google.com with SMTP id h23so11605233ljc.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 09:22:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fZe1yZ3PHNUYD2UiPBWxtrrKJaJtr9K8bpkbKE3JKOM=;
        b=B+ZZlChxyvMPwtZpmxxua0yGz4gt2aSlLbEHvlg83J/3+F80bQmLxN4vKD93rhEGCn
         PAfHcDMXISyxcb0SurwqyqZ6aTt1ZOVF0Q+mOL6aVGAPVMaAIuXQniyANoLPE80cS+dB
         2O4kSYhWApV8XCrf/ewej3KkKHmjVHQXmk2rA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fZe1yZ3PHNUYD2UiPBWxtrrKJaJtr9K8bpkbKE3JKOM=;
        b=PLinELf6csGZFZiM/Jmof8Yir35DEFREKYoyriiSGNWHxYeQm53vcGltJBJUPyuRAN
         kqzhbEfvl6bpC81xuBWLugpOeErAflmDdXEksLcqg9m2iGtpg3nr3xdsygNnB8vGHId3
         PdlcizRwAjvUs8HR6vMCaHHbMycte1Rq0hgzHPV1xCBi//cRBuhln4Lq+3dy0jTGqtgJ
         KlH4byl8Yvm6whInGNhuTgoSEuNJVQ4K2c19nVpXx7QUDPCBEgODwaTDPiFttDEKUEwi
         1uqpz+NkVkkC99nN1u484gLluTZ7WmlSTTPtQjhGjFjEe5DiBTrr3plI4ftMwdFwd9eI
         X8Og==
X-Gm-Message-State: APjAAAXo6WZ92WtzynJuq9mXTXz5e36cV6QD3TDEacLv7H81qn+CO01C
        kiFL3iywHTC29KOgP6BNyFauGDRe/aM=
X-Google-Smtp-Source: APXvYqxQbbw0dDqBqmDbmIh6gnZSFubcHDVBtjoTWsg4oRdd5NhwV2sqQtzHDqJdbzAUsRhiZ3uQ+g==
X-Received: by 2002:a2e:9842:: with SMTP id e2mr10810592ljj.293.1580145723649;
        Mon, 27 Jan 2020 09:22:03 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id z22sm8494819ljm.24.2020.01.27.09.22.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jan 2020 09:22:02 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id b15so6781346lfc.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 09:22:01 -0800 (PST)
X-Received: by 2002:a19:c82:: with SMTP id 124mr8658523lfm.152.1580145721226;
 Mon, 27 Jan 2020 09:22:01 -0800 (PST)
MIME-Version: 1.0
References: <20200127113903.GD24228@zn.tnic>
In-Reply-To: <20200127113903.GD24228@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 27 Jan 2020 09:21:45 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgedtBiFok8twm499FmNCJ6icWdG7Deb7f4jcDYS4Y_Lg@mail.gmail.com>
Message-ID: <CAHk-=wgedtBiFok8twm499FmNCJ6icWdG7Deb7f4jcDYS4Y_Lg@mail.gmail.com>
Subject: Re: [GIT PULL] x86/microcode for 5.6
To:     Borislav Petkov <bp@suse.de>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 27, 2020 at 3:39 AM Borislav Petkov <bp@suse.de> wrote:
>
> please pull another boring branch this time around:

No problem with boring, but I'm trying to figure out why one of your
three pulls had a signed tag, and the other two didn't?

Is it just that the shared tip tree doesn't use tags, or what?

             Linus
