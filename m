Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01ADDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 19:40:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2F8C2072A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 19:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596138023;
	bh=9TIarbXctsbPRRHQi8BPudo/EBYNuhhC1WxpVc5ZfVw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ipDYwxFQLpu6khQX4sRKkt6jere6nyvSjPACKp9w87z1jddpygv+/rK6sXAnR+v3C
	 xgpDRgrnN/r0NnhnTWMfwN6pQfitl+/M+M0RzKrqCGQaj+bPPv9wwIen5UijQfuuju
	 VBU4w//aaXNJHd3CmrZwMyQsqSr7QGKqpN/2UJ88=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730558AbgG3TkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 15:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgG3TkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 15:40:21 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51A41C061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 12:40:21 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id b25so30126815ljp.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 12:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nwS1WXlHYD8R7/Po5RR2AJ9MqxwjuerbxqTJ3KWqi4g=;
        b=V5HqAGApydfFG9KiW7z3vCiPLD8rE8XqYUXS1HXfpOfZWnJn3j1tkp7hydkQzKzw3c
         M98ta58iJWqnVhE6opCk1WORmqCfMrFl0Z8nS++AqzhCcKFa5utSxZtqVv6bkIhW6bkK
         5OwGpW5yjEt+7rTvLWK9+MrUWWPuWjwael5mQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nwS1WXlHYD8R7/Po5RR2AJ9MqxwjuerbxqTJ3KWqi4g=;
        b=jbyO9ToW2seQi4ol7kZxAjNfvElzi1Ic/pVlZxAuBuLsYAFwvBx5WAKE6l2iEuVO2n
         lVBOaW1zGwvC6aZu/ohq1ZCV7XDQZzbU8KNpVuyaiaLZ9jteMo0OpTovrI01YaIXm5vi
         u/yPShkPFuH8KbYtFAEkpMJJGhy2cb3x/kytLEv/VJwWAf6SPlrpf6PvAiTH3tja94qw
         s4iigPLpPZR/L89RlKLOisAjxClik2qD3WfUEZZ1CRnFuBDtAcxrPMP6nJONYq5iZlFo
         vs4CDHXnwXl05dlSaP/F7qwBbx6dnFizBaz1Z6WkX2vql2lzvQp64ae3Cuy2G121DKRq
         2k/Q==
X-Gm-Message-State: AOAM531j+5eNnk843LjlQLL19Dv47qxYdXobq7UYlNr5Bz16/5zgoAil
        dq8/B/p1HumoZEA1gjqLrQK20rbynVc=
X-Google-Smtp-Source: ABdhPJy+UNjPLHmJJKunBatvyK6+BnHM1pGAb0KNtY27U5eTXqDFD6NLC/kusy1nvZFgLQzSfDBoHw==
X-Received: by 2002:a2e:3311:: with SMTP id d17mr363653ljc.13.1596138019378;
        Thu, 30 Jul 2020 12:40:19 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id s1sm1225233ljj.96.2020.07.30.12.40.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Jul 2020 12:40:18 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id w14so281163ljj.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jul 2020 12:40:17 -0700 (PDT)
X-Received: by 2002:a2e:991:: with SMTP id 139mr311332ljj.314.1596138017250;
 Thu, 30 Jul 2020 12:40:17 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYvSyXnfGmK1FLRtraWWre7QjUoGE_qiwM8XPUBXjnudWA@mail.gmail.com>
 <20200730211522.1ea3561f@canb.auug.org.au> <d23eba90-ee2c-efe0-0cb6-88e99fb22e54@ti.com>
 <CAHk-=whn8OB-QbxpffK=Lhh6Mhj+Y2ALFZ1asCgtnQOnmQgWUw@mail.gmail.com> <7b0c0f44-f56d-5e71-cf86-dbdea190267a@ti.com>
In-Reply-To: <7b0c0f44-f56d-5e71-cf86-dbdea190267a@ti.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 30 Jul 2020 12:40:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=whX7gPBn+jthX8bbfz9kU+0CbYwTxbASwPRCZ1bhVqrOw@mail.gmail.com>
Message-ID: <CAHk-=whX7gPBn+jthX8bbfz9kU+0CbYwTxbASwPRCZ1bhVqrOw@mail.gmail.com>
Subject: =?UTF-8?B?UmU6IGFybTY0OiBwb2ludGVyX2F1dGguaDo0MDozOiBlcnJvcjogaW1wbGljaXQgZGVjbA==?=
        =?UTF-8?B?YXJhdGlvbiBvZiBmdW5jdGlvbiDigJhnZXRfcmFuZG9tX2J5dGVz4oCZOyBkaWQgeW91IG1lYW4g4oCY?=
        =?UTF-8?B?Z2V0X3JhbmRvbV9vbmNl4oCZPw==?=
To:     Grygorii Strashko <grygorii.strashko@ti.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Emese Revfy <re.emese@gmail.com>,
        hsinyi@chromium.org, Will Deacon <will@kernel.org>,
        Willy Tarreau <w@1wt.eu>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 12:05 PM Grygorii Strashko
<grygorii.strashko@ti.com> wrote:
>
> FYI. Below diff seems fixes build:

Thanks, I'll do that instead, it looks like the right thing to do regardless.

Mind sending me a sign-off for it (and commit message would be lovely
too, but I can make something up)? Yeah, it's just a one-liner, but
let's do this right.

Thanks,
            Linus
