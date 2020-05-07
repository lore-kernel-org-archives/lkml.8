Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1199BC4724C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:58:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E585C2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="JHyNVkG+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgEGM6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 08:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725903AbgEGM63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 08:58:29 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CF57C05BD0A
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 05:58:28 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id r16so5276239edw.5
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 05:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JhXYcpwKf2XpGZELWtHA1frK/acuUyPFrjCaNoc2FRk=;
        b=JHyNVkG+93UuLQKtfOniky75gTXR//TNux3FixdF8PnLgOw9/dy6zBIhm248HfGnCl
         90JDM8VELNhrd5z34reDxxxJNI3ibPs/qJy1Nw0lwklQiEwVDZt7Zia9HH4BLqFdSIn/
         LkXmpaioVzgbR/RCZdp5Y+LC9SGlIu69v97t2YKM1qv4uk4DRq4PTzk9nZ8nrn3TQvUf
         +kDkattSiHnljhbNJdSBG/ipnDep7QQRc9enZF8bfUYqttNxFQ1GBsqE4BnmI0qkEVnG
         RUQsD0Zb2jWXYAPCK5Cs6oXrn6Pdl06KLdgVGGK/YzDF5KRCCWhDti6+uxGXzQh9tY1s
         fKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JhXYcpwKf2XpGZELWtHA1frK/acuUyPFrjCaNoc2FRk=;
        b=dg71aPqXQdTSpIPd66/ehwIUrJn/gALq9w1/ViOtIl7NjNCsFgxNA1sgS1IDXC4ESk
         28PeSpnju4P91p17lYLoZ2JGZhFr3j+kJUunbLags+U92PerRkeik+B4F01IQOGi9lYa
         7pvRbQ7iIPjtuPkhIbdFCa9kplDP5Ud4JWieI3FrUbdM7WCIIUt6MOGntOqMM3dEKfkC
         hH00/wZU5y72xClhYTdwIIfNu1hmydDNqb0C3Qg1h3RRrNiH1MspTedA8skhH4LDfjCj
         fVBRUUA2WOlt+RRjs05U0DjoOMy/5cukCmrgX+HrfjryUnDgbjd5LOVrqgijapKM+MjP
         qLCw==
X-Gm-Message-State: AGi0PubxKni/JEvbn+rovF6OlVh4fFi1T5GOc+rxOIn/Fvdo56J+enqp
        9RGmEcdodKnq2YnKGvHBpHr0QpPUKyxycL6yXT2KbQ==
X-Google-Smtp-Source: APiQypJW23seoNUjQ9Cjb9iCJOyGQrSpBnxCRp+l1gSYgC9RrkDJ7cqjnZwF8iBU8cJartiNHh3Pvba2heWCxCMCrFA=
X-Received: by 2002:aa7:cfc3:: with SMTP id r3mr12143634edy.342.1588856306666;
 Thu, 07 May 2020 05:58:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200506211523.15077-1-keescook@chromium.org> <20200506211523.15077-4-keescook@chromium.org>
In-Reply-To: <20200506211523.15077-4-keescook@chromium.org>
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
Date:   Thu, 7 May 2020 08:57:50 -0400
Message-ID: <CA+CK2bCu8eFomiU+NeBjVn-o2dbuECxwRfssNjB3ys3caCbXeA@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] pstore/ram: Refactor DT size parsing
To:     Kees Cook <keescook@chromium.org>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Rob Herring <robh+dt@kernel.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 6, 2020 at 5:15 PM Kees Cook <keescook@chromium.org> wrote:
>
> Refactor device tree size parsing routines to be able to pass a non-zero
> default value for providing a configurable default for the coming
> "max_reason" field.
>
> Signed-off-by: Kees Cook <keescook@chromium.org>

ramoops_parse_dt_size
parse_size

Are used to parse flags, and max-reason properties, so the "size" in
their names become outdated. How about:
ramoops_parse_dt_prop
parse_prop

Otherwise it looks good.

Thank you,
Pasha
