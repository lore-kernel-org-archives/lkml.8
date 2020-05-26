Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC617C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 22:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8851A20899
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 22:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="C1icVNWR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404331AbgEZWdP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 18:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404210AbgEZWdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 18:33:13 -0400
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A62D5C061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 15:33:13 -0700 (PDT)
Received: by mail-vs1-xe41.google.com with SMTP id v26so12764885vsa.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 15:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q7eDCCK4vdx707QDXrWS+1CkYlUEqymIqdCtA3mJzxA=;
        b=C1icVNWRmb8X5j1ahyM4t4ZSYYBo4O04SjVYSIyUCcm+ZHuao35XwDs7rGNdezKWLs
         mohrSjpLZkSxyR8oT0MiAgsV03RqFuZZm2OSKPCKuRZo7x2uLBu8VrSuMGOPZ5Uib6Cs
         mJ5Ddreo0FAxxF2VAOqQr/bUHkPnS8nLfDgqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q7eDCCK4vdx707QDXrWS+1CkYlUEqymIqdCtA3mJzxA=;
        b=qKyrccr6/TAXYOhGUoFyypUlqW59hvBa+25/XiKtX+SIn0OKyqNHiA6FSC2OPtY0PX
         LVnGLsLLDqM67zHD+OWRz8DR7vqp/5hgP+o2Hky69zlw8Q1gUBkV8CtEDlZtqdXnNNap
         gGEgxG82FVxUE90MUUlGmUY3CvkEpyJV6FROpa/chQLlhM9Mik45JxcRoe1qj5jDh8XB
         dfrA0Vnm5Rckv3RWxsBxkYelsAdb/5+s7EY3iChgoXiPZ/OlmM1OVtwCTj/XoEDlRuIv
         m6R/z1jm2edJJmj3Kczohf9mSa+L11DhQPk5+kcbnrmu38lAUjpJCnd5OhPsHZ2TUq4p
         eFvQ==
X-Gm-Message-State: AOAM530/iNfQGY/bAoOvjYQ8tFzMXbup87u9wKy82oEjILIB8jfxQ+g4
        gbTHdaeJG0TGxayll+PDvg8iowxevDA=
X-Google-Smtp-Source: ABdhPJyFDWrgp4o7vg8fzzVYxj8uiWFNiDmYs/rxAV00J498wfgbfMTFreNTjOZYh7rIQF9uPMADgQ==
X-Received: by 2002:a67:1843:: with SMTP id 64mr2659330vsy.99.1590532392654;
        Tue, 26 May 2020 15:33:12 -0700 (PDT)
Received: from mail-vk1-f169.google.com (mail-vk1-f169.google.com. [209.85.221.169])
        by smtp.gmail.com with ESMTPSA id i189sm110955vkc.16.2020.05.26.15.33.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 May 2020 15:33:12 -0700 (PDT)
Received: by mail-vk1-f169.google.com with SMTP id z3so5429552vka.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 15:33:12 -0700 (PDT)
X-Received: by 2002:a1f:a24e:: with SMTP id l75mr2903768vke.92.1590532391679;
 Tue, 26 May 2020 15:33:11 -0700 (PDT)
MIME-Version: 1.0
References: <20200522113341.7728-1-srinivas.kandagatla@linaro.org>
In-Reply-To: <20200522113341.7728-1-srinivas.kandagatla@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 26 May 2020 15:33:00 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XFk=itx782nmBxEdpCwFgXGjZCSfW_SgjQhEdR5G2rLg@mail.gmail.com>
Message-ID: <CAD=FV=XFk=itx782nmBxEdpCwFgXGjZCSfW_SgjQhEdR5G2rLg@mail.gmail.com>
Subject: Re: [PATCH] nvmem: qfprom: remove incorrect write support
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     srini@kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 22, 2020 at 4:34 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> qfprom has different address spaces for read and write. Reads are
> always done from corrected address space, where as writes are done
> on raw address space.
> Writing to corrected address space is invalid and ignored, so it
> does not make sense to have this support in the driver which only
> supports corrected address space regions at the moment.
>
> Fixes: 4ab11996b489 ("nvmem: qfprom: Add Qualcomm QFPROM support.")
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  drivers/nvmem/qfprom.c | 14 --------------
>  1 file changed, 14 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
