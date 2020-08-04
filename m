Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B72C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:56:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0E3D207FC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 21:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596578186;
	bh=SRdmd+xN7ovkWpPnRNNdWbLFpzSZOmu8zQ4bTDrVSE4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eYXZQzAJC+c/f6M6bg+IQCKPjyjHc9HOh/LQUMlx1yXSM3xcgcEa9qShsk6KL8nqx
	 C8yTq89tovIrsvkWu/3P8UfI1tkw5loCl8TqPLKqOmus1joeQ2L/1OAyXsM9trcQH6
	 N7SfDyZetdUyTUkntWQ0iZfy21MTAaDzVsllaWh0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728205AbgHDV4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:56:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbgHDV4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 17:56:24 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D6BC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 14:56:24 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id w14so15500246ljj.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 14:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KkU0gF9ZbMcP2smDrog0vuh04s3x+0Iwnc2S9k30PE0=;
        b=g8lrvNNXTgORcu6c7FnKi0CvcIJGP9ouvNXdW/aJfHjGil8LBNyjuHpzxEXv/s3gcj
         EO+Lg3mNqT2SoPnLixaokTRfEzDyR7mxf0djFeXZQscaQX53eji8T2tDCLH1RUwFU9JG
         zUtS+V4LOwM+zKTYfPt168mJuADxuVJrElYqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KkU0gF9ZbMcP2smDrog0vuh04s3x+0Iwnc2S9k30PE0=;
        b=Mtx8pNDWjUX5/2iCfb+rZuRkoUbRuwtgYrkLH+uko3Oot8WMDwvLhzaGMNYBQ9CYzn
         SV9ijgNoDwpZ0ctYwRzV/Ax9TRpTuYF73pKEt6+eLnM7EJ/jQbU5QJO2NDN80bsY7SRw
         S4J9MthYfTJbllhnW9bgDcInHJMUZY42V7PbraFoh3B6QKg66u/MVB3qkRCBSwUwPHRh
         eVwG/J7WhS4zPNqHK0KHs+Jslh+uddl5R5WNQwAULW+b0HSQVeOs2QUAq4Uq+qMGnmEL
         aaKPufi98GO6IwWPxDBT3by9Q/PGGO2RG+XtC77xufxAu+tTnHAVUe+iLG/13GmlzMV/
         HpPw==
X-Gm-Message-State: AOAM532WSte46YV+finjkx73tb3fpSJ3kXUzAREam+QFO6u692bINYl/
        9GPJW2Y1Jrcb8hiJRyNCYSUvrjMhd3Y=
X-Google-Smtp-Source: ABdhPJwshVy5Mub10Ti11l6qBF/qWzeEPOn0LfrebdhVHt7WL2GnrRTcgE9OUtOZXFvxedLsIX0CIA==
X-Received: by 2002:a2e:8510:: with SMTP id j16mr6330981lji.196.1596578182438;
        Tue, 04 Aug 2020 14:56:22 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id i7sm6024905lja.130.2020.08.04.14.56.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 14:56:21 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 140so23172727lfi.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 14:56:21 -0700 (PDT)
X-Received: by 2002:a19:408d:: with SMTP id n135mr108165lfa.192.1596578180804;
 Tue, 04 Aug 2020 14:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200804112801.72380-1-christian.brauner@ubuntu.com>
In-Reply-To: <20200804112801.72380-1-christian.brauner@ubuntu.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 4 Aug 2020 14:56:04 -0700
X-Gmail-Original-Message-ID: <CAHk-=widMtiEEcLQQOpiVA=jjKv-bYsA2g+u5eEDY4ecDvikWA@mail.gmail.com>
Message-ID: <CAHk-=widMtiEEcLQQOpiVA=jjKv-bYsA2g+u5eEDY4ecDvikWA@mail.gmail.com>
Subject: Re: [GIT PULL] fork cleanup for v5.9
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 4, 2020 at 4:28 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> This is a series announced some time back (cf. [2]) when we reworked a chunk of
> the process creation paths in the kernel and switched to struct
> {kernel_}clone_args.

You have those refs to [2] (and later [1]), but not the actual links
they refer to.

I just edited them out, but please try to avoid this in the future.

              Linus
