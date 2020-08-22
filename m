Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9216FC433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 16:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EEC420825
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 16:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="IodUKUnL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728539AbgHVQlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 12:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728434AbgHVQlN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 12:41:13 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A120C061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 09:41:12 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id a26so6280516ejc.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 09:41:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AhjqY97AoWkQgYESUD46V2nsOC+4EZ57hmZaFOzwIbY=;
        b=IodUKUnLIwBv0HIMyYHKCjao2nTjh9hM85YuDG4UUjKT4EQmfixFfTFosilNFKiRvC
         +ABAWFTz4nJ6M8/7k437Gzr3T5f/XAQDzEhGL3YtGYxMNevNYIibsa+jdu7YLtzOpBjV
         U/Ronn411gKLTk5LfF+4xKAc+5Vm7fSJJJGhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AhjqY97AoWkQgYESUD46V2nsOC+4EZ57hmZaFOzwIbY=;
        b=EhfawgmtBNH6OD9oyKAVD7Lnny79QcxthtB/EZUvnE04C+YsAI8ShQxLzYPyCNVblG
         A965mLmG05mA6ldh/72IV1ErOzI+RfUKHueIoOpOYIzfIPGrWibykcGaX2mkN6ZWwmu+
         iataZm9Z1p3JQcXasfhbj5kp27zlIp+unlrsZIe7qOs7GiXZytT2kTrsHU+Wm1Ra5K4k
         KnVOOmkKYAK+LZLK1KB5rdszaUmL6dL+PFJY0fdrEC0oUzfBf6jjjL/VSemexVE8/iZt
         U+BaS19mPoaBaqcKUZItUYiUalrK4D0llJGUs5u6yaqmW1VqnOe8FDLw/OiWdXnlSual
         sGHQ==
X-Gm-Message-State: AOAM532zMIkBwILlPdGNf6zfl2kuZvEYbtIApbV2TIBXbv82OdEg1F9Y
        i67Z9TKMDovSbtkXrUpGh4uRUpP6tc42jf1miNsouw==
X-Google-Smtp-Source: ABdhPJyY9q2q2oZ0+KzR/Bg4i9fFGZ9vT9L6pj53zJrTgcmxuCNaVnYEaM4v+QPJYnc8/dN3n8X4IIYmRIlKRvjmkv8=
X-Received: by 2002:a17:906:ca4f:: with SMTP id jx15mr8233418ejb.449.1598114470840;
 Sat, 22 Aug 2020 09:41:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200821165221.32267-1-mmayer@broadcom.com> <20200822115636.GA19975@kozik-lap>
In-Reply-To: <20200822115636.GA19975@kozik-lap>
From:   Markus Mayer <mmayer@broadcom.com>
Date:   Sat, 22 Aug 2020 09:40:59 -0700
Message-ID: <CAGt4E5t-GCPdU_W9U=627o5Xtx_MybFEM254FZF2HZ6VYPr7bg@mail.gmail.com>
Subject: Re: [PATCH v2] memory: brcmstb_dpfe: fix array index out of bounds
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Colin Ian King <colin.king@canonical.com>,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM Kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Aug 2020 at 04:56, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Fri, Aug 21, 2020 at 09:52:21AM -0700, Markus Mayer wrote:
> > We would overrun the error_text array if we hit a TIMEOUT condition,
> > because we were using the error code "ETIMEDOUT" (which is 110) as an
> > array index.
> >
> > We fix the problem by correcting the array index and by providing a
> > function to retrieve error messages rather than accessing the array
> > directly. The function includes a bounds check that prevents the array
> > from being overrun.
> >
> > This patch was prepared in response to
> >     https://lkml.org/lkml/2020/8/18/505.
> >
> > Signed-off-by: Markus Mayer <mmayer@broadcom.com>
>
> Your Signed-off-by does not match From field. Please run
> scripts/checkpatch on every patch you send.
>
> I fixed it up, assuming markus.mayer@broadcom.com is the valid email
> address.

No. I have always been using mmayer@broadcom.com since it is shorter.
That's also what's in the MAINTAINERS file. Please change it back. I
accidentally used the long form for one of my e-mail replies which is
where the confusion must have originated.

> > Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> > ---
> >
> > Changes since v1:
> >     - Added link of the coverity report to the commit message.
> >     - Added Florian's ack.
> >     - Removed second "const" from get_error_text() return type
>
> Florian was so kind to provide you with necessary tags - Fixes and
> Reported-by. Always include them on resubmit of patches.

I missed those. Thanks for catching it.

Regards,
-Markus



> Thanks, applied.
>
> Best regards,
> Krzysztof
>
