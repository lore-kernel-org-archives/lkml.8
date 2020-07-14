Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB52C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21A8022AAE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 19:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594755307;
	bh=UWgfM4J1k3ptLf5eHBkwUzBGsbhcDzwpWX/DvrDrCGI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Dj6Qyd6dPk5T//xySbhr14nmgKebfub1A8MhqPoUmfmahVTSzKuI5tK+Tj+B7OiPA
	 5IvAHFVLjK3B1OGN2pFyX5HiB8oA/ZXS8p+CT2f/3Z0NJGeEdwp/8QWC9dlqStq12U
	 17ai+4V2uxAi9HmCGOVoF93bFkx+4xoaSOaFJMSM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729532AbgGNTfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 15:35:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728768AbgGNTfF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 15:35:05 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC54BC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 12:35:04 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id b25so24978102ljp.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 12:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TmvrJI/J3yG66g6pPz5Il+RcCg67c3v/jT1iQASKlcc=;
        b=KIYXfollvDwZIWSi8MBvzI16dhsw+y4zL9hnXlh1UD0SE8cjPtPzh3zCIWaf7usmKY
         sJIPvwRi57eB+/xJI+6JaFihnvlQfFnptYDDF1G9FGiSyn3r0SxvQFRYD3v6hzm4/QTE
         v64cADt8D/wtG1AQ2083itD+hTnNb9/mL5p7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TmvrJI/J3yG66g6pPz5Il+RcCg67c3v/jT1iQASKlcc=;
        b=Z58vQOg//nsmUU7zQOP1xwUPlZjB2h02Zko1bJWkVnDqPljy2UOsoRnQ8ZKqr/0TkV
         NzBujEoygaJSmDVAFIYNGpcquJdag2gsLd2oV+FOBoKRqHB7+rlr3A1+rR8fe8zKSfLE
         8hYSKK4el8Ts6PhssA9fsFM009ayjvEoWhGjAcUcB/qLjCa/1lJRGsLJoyVvJsCSR7V2
         Qs8awhen0zZM4IrzVcVyulcHYKnRagQhuIRWoQjuFnVu6VW+ZYBMsjLd4sK/A9VTBoMQ
         3MTbhnarKCrOTsuQrVS/cBf4/1NYGEzSvDk4ReiaeUyBsc1HlWoWLWbyabsm+V0kf6gZ
         xp0w==
X-Gm-Message-State: AOAM533fiyu1aJHUxXXqBzzeLrgQuyZmAd/kYVgzco/zy/UsXUIOTBtg
        enYyVesTE9QeCIM2Kmacu1LQvmBJeOA=
X-Google-Smtp-Source: ABdhPJxu+JkHL89co3sKA71u49FAq/0LNySvRORcRi8fR6PdZF6DHnytYXxeiS84ShQF/+mn3MQkbw==
X-Received: by 2002:a2e:81a:: with SMTP id 26mr3142876lji.460.1594755302987;
        Tue, 14 Jul 2020 12:35:02 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id i3sm2391ljj.64.2020.07.14.12.35.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jul 2020 12:35:02 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id s16so13039928lfp.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 12:35:01 -0700 (PDT)
X-Received: by 2002:a19:8a07:: with SMTP id m7mr2908470lfd.31.1594755301618;
 Tue, 14 Jul 2020 12:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <20200714190427.4332-1-hch@lst.de>
In-Reply-To: <20200714190427.4332-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Jul 2020 12:34:45 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgxV9We+nVcJtQu2DHco+HSeja-WqVdA-KUcB=nyUYuoQ@mail.gmail.com>
Message-ID: <CAHk-=wgxV9We+nVcJtQu2DHco+HSeja-WqVdA-KUcB=nyUYuoQ@mail.gmail.com>
Subject: Re: decruft the early init / initrd / initramfs code v2
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Song Liu <song@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-raid@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 12:06 PM Christoph Hellwig <hch@lst.de> wrote:
>
> this series starts to move the early init code away from requiring
> KERNEL_DS to be implicitly set during early startup.  It does so by
> first removing legacy unused cruft, and the switches away the code
> from struct file based APIs to our more usual in-kernel APIs.

Looks good to me, with the added note on the utimes cruft too as a
further cleanup (separate patch).

So you can add my acked-by.

I _would_ like the md parts to get a few more acks. I see the one from
Song Liu, anybody else in md land willing to go through those patches?
They were the bulk of it, and the least obvious to me because I don't
know that code at all?

              Linus
