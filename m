Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D24C433E7
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C10EF207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 18:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599071116;
	bh=hoTEA9IclXXw81ojMq1jInQ0uhRGmJXYd7BI8K5Jevs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DO3cqKUYoPH8BK9yRC1D2bBtXXjdczYmoIOWF09nMzC8dgPpFOtBxHLrOzRMlGOOp
	 SWsmbq65XDrZQYsOTIUtH3G14IxyfuwC7+fZe8FY11nI8yAxHZv6pjVvX2+wM1CVSz
	 Z+tD8mbBcMEKDpWfrWXFlmShwDK4E0nsN46Gspbg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727977AbgIBSZP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgIBSZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 14:25:13 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD06C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 11:25:13 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id q8so334380lfb.6
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 11:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qq6lOJXdTNHbCKD63q8flb9FOe7Odau0iyUw+8m0/WI=;
        b=B8XHNw1QbnNShaAQJLHQ3mIa0IDWpUwtg/9wQwKuwPcP06AzprNWwQXffHET33lCHA
         VqCUSSdK/RlJSLWMdVl4XjO3Pbk8zPEARffsxmr5O5ExjjkLBvOMy8WdcVj95gigBeCL
         CPEN1axLQt5qNCoNJPJgwZR486FuluLhWtfIs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qq6lOJXdTNHbCKD63q8flb9FOe7Odau0iyUw+8m0/WI=;
        b=YyxonSOh0MmlSFoiWnrv6iTV+a45SOMzE3KO+rkzaVaEAcEt/6lJRSam7r5kzQD+nQ
         kFZFnulqTw3aCTY6Knpf4DR8wru007LMxhKHEZ+j4M34J0GAumHn3oBfTawqmqvSeAgo
         x3NL3kusG1+TcamPE2wYuiWJdbBbSF24VxaFXqk+yEHa/LwtC+kZlf4yRsq9zn37I5Kn
         bxR1H2vLAX3EcxOTf07rb3BatHXlKpkckxtJ0K5kayz2vRJcsmwbnjreRlCUy6m2Bu0F
         /CCv4d8ctpToJoDiPP109BYcXgHpI0aSLBDRjY0AvTwPBFSOoSVoxDGc2NlSMuIvBPqo
         7hpw==
X-Gm-Message-State: AOAM533KaVyVAcUymwhQ5h7uyffQfVE0hFmntaTVPOtHbS2Erlpf0DQG
        VXvO7WXPNERx2K6dv+neSK77pceqDrMiww==
X-Google-Smtp-Source: ABdhPJw8TEsrm23jk17zp5eZEV0NfsjEzS5ou/IvrEjPSVlu89meKTLQLuCU0JOK3HBXlWOCTD+grg==
X-Received: by 2002:a19:614b:: with SMTP id m11mr3905207lfk.6.1599071111297;
        Wed, 02 Sep 2020 11:25:11 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id w6sm79320ljj.121.2020.09.02.11.25.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 11:25:07 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id 12so313049lfb.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 11:25:06 -0700 (PDT)
X-Received: by 2002:a19:c8c6:: with SMTP id y189mr3951504lff.125.1599071106406;
 Wed, 02 Sep 2020 11:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200902085513.748149-1-leon@kernel.org> <CAHk-=whURzFKdBsoHCVsy4VU-cmAKBQEhkiS8Y8TQ9nRgAbP8g@mail.gmail.com>
 <20200902175241.GL59010@unreal>
In-Reply-To: <20200902175241.GL59010@unreal>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 2 Sep 2020 11:24:50 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj6Wi7MTAMDWqcnp+cpDWvT-+o5-MEbuxJjzBkFKpfpPg@mail.gmail.com>
Message-ID: <CAHk-=wj6Wi7MTAMDWqcnp+cpDWvT-+o5-MEbuxJjzBkFKpfpPg@mail.gmail.com>
Subject: Re: [PATCH -rc 0/4] Protect from GCC garbage input in GCOV
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 2, 2020 at 10:52 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> Are you suggesting something like this?
>
> diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
> index 3110c77230c7..bc0e355f64aa 100644
> --- a/kernel/gcov/Kconfig
> +++ b/kernel/gcov/Kconfig
> @@ -3,7 +3,7 @@ menu "GCOV-based kernel profiling"
>
>  config GCOV_KERNEL
>         bool "Enable gcov-based kernel profiling"
> -       depends on DEBUG_FS
> +       depends on DEBUG_FS && (GCC_VERSION >= XXX && GCC_VERSION < YYY)
>         select CONSTRUCTORS if !UML
>         default n
>         help

Yes. Except please don't mix it up with DEBUG_FS. Just add a new
"depends on" line. They are separate issues.

              Linus
