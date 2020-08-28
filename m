Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715B1C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B8D120776
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b1VOAwaH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728174AbgH1TEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 15:04:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbgH1TEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 15:04:41 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20713C061264
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 12:04:41 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id m22so13995ljj.5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 12:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=i+FwVMon+TXlCP0bT0wIJnmyAlxWJeYxAI5c8fUJC3A=;
        b=b1VOAwaHIOnbS1qczfygh05Bp1vDLs14TgryIn2ii8PYjguH24odX1i53SG45Nvcsb
         33wcfJTii+n3nqmYSJ9hwza3xFDPHhLCELKrX/DYUDUWknQabV62H25bROmk9QY4UnSW
         TfJwWF2JI7eP53vZ8yylTQx9p7CIoV8AqwdbgpDo2PiLjeXj/aAMd+lRUSAEWldR0lKR
         R+z9ke7x6xC1ToGafdnAkFslc8kXnOKhPE9ItFe3ShKOmeHWL6nrWYL8rApa8LpP/tPA
         6Q0igPxmUhbXjPGgPoxpFm/+jEIqzWFEnORXJKVXp3hmyK8+vWqYYspWaDbwnRBmNRcS
         Zhxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=i+FwVMon+TXlCP0bT0wIJnmyAlxWJeYxAI5c8fUJC3A=;
        b=PNeZ/3crlZ33GCmMJYRTISu+iDwstgNO8ovNaTK6rshHq+skj9M3CqefWIxPgwqq5E
         q+Zx/Igc742DNP8NbwIvT6vxzaOW39NG1e2mV01UrvmT2dvk+kv/Unj0jm6CGzAjW3HJ
         WhUkbUqOQqyzHqlwXJWQ0LuNvV+xM2Fy832eAjqjhLqFBscNaSzp8qkDXUSCLPpw/5LF
         nO5bhjrhpYtNLi7dCnmotFLyHWa5mY1UGK2Uifxhqa6s00+56OkNp5djgngOAWg/Dd+S
         7MwacLPC/Oe5xezkOeSVWpg571Q5yjBKhI+7lG0rrYlSbxdHgdUAkHH7nmEbykPMqnI9
         RuKQ==
X-Gm-Message-State: AOAM532tsWDIRE2fy0MPkF1zHpKXeDVOmg2mY+xi0dsML+MPu2ecvGAc
        DOoOX8EHUfZ3QVn3ihqZnOYxaAynCZq/G3LNy57T9AI9krc=
X-Google-Smtp-Source: ABdhPJw7OfSxLNM4pqgvFJUPACII/bq07onO/GiBQpYIuAw3I0SYlXXA4BYYdtKfHKYJtv9ebNbS7KKrzIdu0UxUPuA=
X-Received: by 2002:a2e:b0da:: with SMTP id g26mr114940ljl.264.1598641479357;
 Fri, 28 Aug 2020 12:04:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200828085301.78423-1-luc.vanoostenryck@gmail.com>
In-Reply-To: <20200828085301.78423-1-luc.vanoostenryck@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 28 Aug 2020 21:04:28 +0200
Message-ID: <CANiq72no4vv1dX13W8LL6kXj_0ethn0cbUfxM5Nn_Nxag-BrfQ@mail.gmail.com>
Subject: Re: [PATCH] sparse: use static inline for __chk_{user,io}_ptr()
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luc,

On Fri, Aug 28, 2020 at 10:53 AM Luc Van Oostenryck
<luc.vanoostenryck@gmail.com> wrote:
>
> Hi Miguel,
>
> Could you also take this patch in your queue?
> It has already be sent twice but ignored by the other channels.

Yeah, no problem. However, what about all those emails from the test
bot? Is the bot using an old version of sparse or something like that?

Cheers,
Miguel
