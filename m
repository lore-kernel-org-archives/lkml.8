Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80DCCC10DCE
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 06:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55FD924677
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 06:35:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxSAYlGC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbgCJGfA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 02:35:00 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44359 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbgCJGe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 02:34:59 -0400
Received: by mail-pl1-f194.google.com with SMTP id d9so5034135plo.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 23:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bGWhlBnTQCg9+tiKpri2VWMC+y1op1Nt19f6ZhKfJYA=;
        b=GxSAYlGCXeh43hPNRDPHqDFdspD0YDrMVU2NIgVXwKJtapFOATDRQ0R/nqQw40fTkj
         kzOfk+wx9BggRwzKU2SV/YqTWl3N/qtAkkN6wQq2nYhfSFe1LexX03KojL5sq+K3qTcx
         TM4O9JbkAmtoSm4y/XVnxB0EKhMfe7GKpBF5eOAs1vtVQz7f4sYcXzfxGzTyIoRtyDdu
         hWP1XBNVU1Fvu7I+szxaociVb8JpEpGno/Lb+rzkuSnsJP7EZMk77NcYSwJTgPJyV7pO
         6v9U/sDvQ9ecbJytSGvwnAkCmfiUPpTLkCuOoUNh5WJbG6ThoXm13ilfqcX2ViDOsEH6
         EZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bGWhlBnTQCg9+tiKpri2VWMC+y1op1Nt19f6ZhKfJYA=;
        b=GvZWgIosGK2wO0nNn/X4Sw8G0swmH/y1mgpBc3E5c3EmqGbgQ3vifedNsN/t4regXM
         wAT7BAt2So8cmVvHQZmT94tNRPkwwvqMfHlyhEALE7WA+wrKRI7RujwjDz4vnVF7hYqX
         +FtVkZeyGgL6gS/vakHvplLlYydomKuj7hcOXaOrUz7RcbprdeS74k+qC0rbhsZEPaCn
         Er4NHHy/rPr06oGS1MralTtNi+fyg98STCyjyt83iabE4fmSTwQljOS0xdTeVqOZ8xCm
         nwOryJcmeXFDgqnVojU7hnF86XQVHWMv4JmiS89+jH11bIRwFTBQM8xU6371AaDT2X6a
         a2Zw==
X-Gm-Message-State: ANhLgQ3fHwzxlp6j5m23mMBEx+qWnIJtG1Bk47CX329bG9SpfAFDH9vM
        NnEnt/Fc/394tWqvHvKdJ5szKy+X/N1UHO2qmWA=
X-Google-Smtp-Source: ADFU+vsh2DTPbuDRsemIdTyt+pljDxJrkb9G1oGyBBc2JnwQGWDQ48zTeNg0Ii3dC/Nrzr0jhM5tkg05/xZyknk2mk8=
X-Received: by 2002:a17:902:8647:: with SMTP id y7mr19292031plt.224.1583822097536;
 Mon, 09 Mar 2020 23:34:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200310045925.25396-1-masahiroy@kernel.org>
In-Reply-To: <20200310045925.25396-1-masahiroy@kernel.org>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Mon, 9 Mar 2020 23:34:46 -0700
Message-ID: <CAMo8BfLLacwcBOhZfkuRziPOYbRzUHRf+BjVo_tV1r6xJZ7+4Q@mail.gmail.com>
Subject: Re: [PATCH] xtensa: remove meaningless export ccflags-y
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 9, 2020 at 10:00 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> arch/xtensa/boot/Makefile does not define ccflags-y at all.
>
> Please do not export ccflags-y because it is meant to be effective
> only in the current Makefile.
>
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>
>  arch/xtensa/boot/Makefile | 1 -
>  1 file changed, 1 deletion(-)

Thanks! Applied to my xtensa tree.

-- Max
