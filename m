Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673F7C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37CE32065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 18:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589479701;
	bh=xuYDa7Wzcdgi1q9QmCW2AcEVXuZ3sqBi7uZDUOUk33k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LVI0BUC/pDb5ETPRoZe/CiXU8cwZ0laXbBwMo8WbIvn8wm7piXkwEcNgMadtTYWfn
	 1OY226DGNu4XbqxjjULTtN+57l0LuljaIa5yjaQpXB560Rq/R5B4xvxXCq0vq+0V5Q
	 Vt3oAIih+U8pVGBikGqELDRmfaedgf+IGKGZ+sFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgENSIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 14:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726073AbgENSIT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 14:08:19 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51136C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 11:08:19 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id r17so3430455lff.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 11:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iR/FrKJ5o9ZJUcI6oDUu5nuQF8FuXexxHEQI4n/t63A=;
        b=bdTCXJX5zV5x1sZtiFkfr8j0MKRemAUTGPweeIaxXM5y14yyF5FABO/Ry9tIQcSJ6t
         DBCeIMQp5CccUk/j7F8B8uzTHl65tDxuGlxIGvr2CO03hMPyaLx7AQZJNrwK2jK2eOVj
         P1BYkK274Yzxew9F9BjILsdbpqHT96wikAQHU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iR/FrKJ5o9ZJUcI6oDUu5nuQF8FuXexxHEQI4n/t63A=;
        b=SiGgbnd/b2vFsGp7Hm07BEbSKFbx4+ss4rbr7SMn98JSa0SwzUsE7bk0Hx/Q2cfTnV
         t5VvgoVHVZbDiJYxTaV3yvFqIBwI1tBou8r28Kyu/J2x0Ly8BDwEKz2Y4jvUgX2/RHhe
         iI7Ouk6mwmg46vWxQc3t/SQQ+H9Du+8OZtyQaiCOvqe/ybwklf533G934Vx0Gdh0m8hf
         QzkwyB8O9GGo76eXffQrlIPwwj6RRd+qT5TDJWhctm8kos2h9lqQr/xIFmfe5DgcML1Y
         iUMequUUiHHKElsqK/lh0Gw6vpaDniih0RwYzR1V1orX557YdYuMZlUs30bZS+V54cXi
         JmuA==
X-Gm-Message-State: AOAM530YcCKWzR4UGg4L20hV0NhuCqXVpUnz7OnpI4f6TWygrlcA3GMJ
        CzMFflu+9F59sTjs7235PbJV9HdhMfU=
X-Google-Smtp-Source: ABdhPJybPsjY0xzELBBVvW5CAxnMe14HCpCxGjo7hOq0N0zQr5uFgqDI2Gl2mQ8iv0U09C2H0BTdug==
X-Received: by 2002:ac2:46c1:: with SMTP id p1mr3911625lfo.25.1589479697306;
        Thu, 14 May 2020 11:08:17 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id l18sm1875746lje.19.2020.05.14.11.08.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 May 2020 11:08:16 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id v5so3397810lfp.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 11:08:16 -0700 (PDT)
X-Received: by 2002:a19:ed07:: with SMTP id y7mr4134573lfy.31.1589479695915;
 Thu, 14 May 2020 11:08:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200514170451.1821723-1-christian.brauner@ubuntu.com>
In-Reply-To: <20200514170451.1821723-1-christian.brauner@ubuntu.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 14 May 2020 11:07:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjpb-h9Z6O6o_7GkqCV1N-qQhagVJxpYZurYQR+eLkuEg@mail.gmail.com>
Message-ID: <CAHk-=wjpb-h9Z6O6o_7GkqCV1N-qQhagVJxpYZurYQR+eLkuEg@mail.gmail.com>
Subject: Re: [GIT PULL] thread fixes v5.7-rc5
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 10:05 AM Christian Brauner
<christian.brauner@ubuntu.com> wrote:
>
> This contains a single fix for all exported legacy fork helpers to block
> accidental access to clone3() features in the upper 32 bits of their
> respective flags arguments.

I've taken this pull, but I really think the minimal and more
straightforward fix would have been to just make do_fork(),
kernel_thread() and clone() change the flags field from "unsigned
long" to "unsigned int".

I don't see why that wouldn't have fixed things, and it would have
been simpler and more obvious, I think.

Doesn't matter, I guess.

                   Linus
