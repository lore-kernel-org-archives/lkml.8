Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02265C2D0EF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 11:52:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAB7221D7E
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 11:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZH3Cus2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgDRLwn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 07:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725857AbgDRLwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 07:52:43 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0053EC061A0C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 04:52:42 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id n6so1368219ljg.12
        for <linux-kernel@vger.kernel.org>; Sat, 18 Apr 2020 04:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7eUmf+WAv2BLj9CEZReyNvDx/uAPXOhPuyN7gz7wHH0=;
        b=CZH3Cus2LkfjaOt4XF865pu2YA0kkcMclN3YmCk1rDG8pEIL3GtW8dxoupVGnWYTQX
         BrhgwiUiSH7EK5xFtiG/9YxRSRXyml800hQJPm9bffhXke4cNTMSSk5oqKsgTl8ykCtx
         qkrrZ5O28gE6pTZ/I0cKsZfrQm47ugAcqtaeMhjeXt1QM4wyW2n+YT2TCA90gc8p0TYC
         FVGEIuLUGZXIMFrgx7Ix7YsvhMJ7koysvh7ZAIKpCbQO6zbfwpNaY3YWXqVAcIvbTitY
         prvMR6h3U1nM6TfwMb6f8rJ/qNy+brRaP2HzMnOFwpw8hZG8kLgh9WsoqzAalcxCgSpB
         qBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7eUmf+WAv2BLj9CEZReyNvDx/uAPXOhPuyN7gz7wHH0=;
        b=qua2ZgyYWYvy3B/5Mffg2F9o46ETteubakJT+ffloaRDuMQlP8ytVz9os03NAFnPhq
         PV1P/NeGuzCr0N7ClWscNYBBQP/XaGJhfiw5bLECmmuZZtNFeLvUegxJ1rgYWckaS2rv
         LgKUqL72reytkl+DJXOLkD+EVHJH3+Z6XDhU0DX6z4hl6QcCxEDsatvMRZQ59zJkJXau
         kSBDIOTw9UIwDqyHAuRzAiPFRm9Y5maL8CTQAQLG8Xj3ClCutD9gZcjdux6ZY3OGZUgn
         tNKQsfzt69RdoqbYAqmp3kA3n8HsKc29CGncF8Md7/als/iz1O9QygP1ANS/AS0W5B4L
         5Uyw==
X-Gm-Message-State: AGi0PuZYpf01XAKwXWGFsZZo5IxqOofW5zNsIBWLy6QxcQZ8CIJKRcmj
        5NblabUO3ua/EkU+fYdl0Iyi73aIIZA0NU8xhlU=
X-Google-Smtp-Source: APiQypIoPOXthoeugdi2zbrZ1A+Rq6NhiFYpvl45kWI24oANIkiGjf895Deal92RFjEJ8qVQrAoKRRJg1vDl2o9ZuJo=
X-Received: by 2002:a2e:a584:: with SMTP id m4mr4704366ljp.194.1587210761489;
 Sat, 18 Apr 2020 04:52:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200409001352.225135-1-irogers@google.com>
In-Reply-To: <20200409001352.225135-1-irogers@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 18 Apr 2020 13:52:30 +0200
Message-ID: <CANiq72mPwDD4UWP4bWzasMiiU2Y3khQLEeGsDHPQsaLs=hbCvw@mail.gmail.com>
Subject: Re: [PATCH] clang-format: don't indent namespaces
To:     Ian Rogers <irogers@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ian,

On Thu, Apr 9, 2020 at 2:13 AM Ian Rogers <irogers@google.com> wrote:
>
> This change doesn't affect existing code. Inner namespace indentation
> can lead to a lot of indentation in the case of anonymous namespaces and
> the like, impeding readability. Of the clang-format builtin styles
> LLVM, Google, Chromium and Mozilla use None while WebKit uses Inner.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Picking it up for -rc2/3.

Cheers,
Miguel
