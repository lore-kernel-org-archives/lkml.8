Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E42C2BA17
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D081248DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 15:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586188450;
	bh=Tmt42dRPHtsPzyR7AAeHLAr0F2bGghbmag67/E+2Iuk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VzNN59kTLaOrNURpi8eECdoMnz6DdRtAFfCPoeD/HNtueAV03HVA1FyhPE8m9rb2y
	 4vAJ7uTimS9DGWrpUbvYlaTcS3i+wzXgkkbM7aNYZU55HTx0c3Krxrv9BVXFCLufEr
	 9lWOrFI5NaQAywU7+0uB1d9ufkxFox5bv5r408Rg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729091AbgDFPyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 11:54:09 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37651 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729077AbgDFPyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 11:54:08 -0400
Received: by mail-lj1-f195.google.com with SMTP id r24so219500ljd.4
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 08:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Npl54g1ItqpAme/2buCJ5Yu5mdmAHuNU9wsDMO3jye0=;
        b=H4p3L21IZ+E6Zf51TcjhGAy5KKt6jEvVABr7zIB8jRl0G2SuDYdEetPYUT+1ZxEWS6
         6DgxrfZ6KnN4+KFuLplobcwfZUamqs9zkVWbAh1hO2ee6JuLvqUGOXWlP1C2HoiCV4Fx
         R0dS7eJj7qE9B5xQZOSWZcZAPWfCpE9O+mXpk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Npl54g1ItqpAme/2buCJ5Yu5mdmAHuNU9wsDMO3jye0=;
        b=m0Wy4+hqlx/p0k72RCzSdgY4pvOTGBJI7bRRJBEe6egM0mv42RX3DYAoIbFRe3Kfzx
         hAV6hocVlIo3c2oUxj/mK47H+0+i406Ztqw1WxE3p4wmzv5w8PDRLqvN1fhUmW606aJq
         dMYxG32pWLvco0wm875pnFkC3HJoOqVVpRCS0Pc0z0RmzzHmeIogSFYe/noSvi9IgGl/
         luB1/MrTvX18xs3R8Rs2HAf4d6lnrqqca+Hak/jwD2u0+ygwQ7cbCTkcSIR5aijKd4t6
         Cvb67LOnQBQuhBXlsmCN4IEwtGmBmG2p8YOj000vrOaxuPybLqRp4fngmZI/G0U1aTHU
         y8vg==
X-Gm-Message-State: AGi0PuZMiMDVo3Obskxl1uQlRXElcySsILNGd5VC4ZHrCq0m1qojXiB9
        fqd9sYaSp4qfLqoeud/llA9DepMWe48=
X-Google-Smtp-Source: APiQypKdmZA6Vg9X0qXYHGF6QIEk7kdh2fg8FSCN8CesDTqIQl58VkpowwSFxJe4Jgf5xvDu//B9QA==
X-Received: by 2002:a2e:9f16:: with SMTP id u22mr12079275ljk.202.1586188445528;
        Mon, 06 Apr 2020 08:54:05 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id a11sm4587711lff.15.2020.04.06.08.54.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 08:54:04 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id i20so200706ljn.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 08:54:04 -0700 (PDT)
X-Received: by 2002:a2e:b4cb:: with SMTP id r11mr12993787ljm.201.1586188444079;
 Mon, 06 Apr 2020 08:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200406110702.GA13469@nautica>
In-Reply-To: <20200406110702.GA13469@nautica>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 6 Apr 2020 08:53:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=whVEPEsKhU4w9y_sjbg=4yYHKDfgzrpFdy=-f9j+jTO3w@mail.gmail.com>
Message-ID: <CAHk-=whVEPEsKhU4w9y_sjbg=4yYHKDfgzrpFdy=-f9j+jTO3w@mail.gmail.com>
Subject: Re: [GIT PULL] 9p update for 5.7
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 6, 2020 at 4:07 AM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> - Fix read with O_NONBLOCK to allow incomplete read and return
> immediately

Hmm. This is kind of special semantics (normally a POSIX filesystem
ignores O_NONBLOCK), but I guess it makes sense for a network
filesystem.

It might be worth a bti more documentation/commenting because of the
special semantics. For example, since you don't have 'poll()',
O_NONBLOCK doesn't really mean "nonblocking", it means "stop earlier"
if I read that patch right. You can't just return -EAGAIN because
there's no way to then avoid busy looping..

                Linus
