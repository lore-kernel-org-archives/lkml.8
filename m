Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4542DC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:00:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 184C0214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 15:00:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YHyQ/xBU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727914AbgHZPAf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 11:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728058AbgHZPAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 11:00:09 -0400
Received: from mail-vs1-xe44.google.com (mail-vs1-xe44.google.com [IPv6:2607:f8b0:4864:20::e44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F08ECC0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 08:00:08 -0700 (PDT)
Received: by mail-vs1-xe44.google.com with SMTP id j188so1106311vsd.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 08:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5cIrV1+eukb/f7OdTc7tq6XgEUP4mZGFJru/50URUMY=;
        b=YHyQ/xBUhtFHvOrFF3UrWSkOcu/b+WObqZLusFpr+CAy9aLKPqx2nl3/R1G55PM5rM
         Ut5WswiLQokx9h9jrbq3Ek908ApWEOUrVxg/RQb9Yp5moKaOCMirA5eND+GlAGyDqj0c
         4NlIbZzFtrOxh9pAwhk/GLNjPCbwB6FvBpQGM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5cIrV1+eukb/f7OdTc7tq6XgEUP4mZGFJru/50URUMY=;
        b=mPzLnYbl1WS+QzvgRtJs69d+sI9rM/P3yhy2i4Pi1KqYwWJg+3tj+eRS+UPYzGKLKL
         zaMVyNlPs6ZutbNsbY5Fpy7RNdJHM0SRYey4IM+1swWRXxkCLKtX4ryqQQL7Ns0VSvrr
         R9A8hviZ1mxu/KZ1NiD6WR+spQgGdvF9HEhGBWjTfeRaI6jvSrg4vSifPFvBdQoxNAaQ
         5jgjgGiF8FmeoVIttve7apkN6p6aIU6kWlDdvhbs7jPvoZNEh06F/2bfv5yPdubQk7qx
         YSW+IF+/IqnU+XA6FvDVhnp0Pehsz5R8ljmog0UoXb5o+Ymc9A2ihAY++K3FLKDe0SRG
         dbig==
X-Gm-Message-State: AOAM533FFFC9zAvOzl29jRRJKGVq53c1mIJHw8On1XOUvTDlPXnJv3yY
        xDKOSY2bDbhCwzn/yulQjJtTob628k9lHQ==
X-Google-Smtp-Source: ABdhPJzi6J4H4+32wTOVEgNJru1BiSYCN2wkhTZToSj6wAE8tGL7+sqPpfbnurzdw9vJDwVwV1723w==
X-Received: by 2002:a67:8c06:: with SMTP id o6mr9680349vsd.200.1598454006510;
        Wed, 26 Aug 2020 08:00:06 -0700 (PDT)
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com. [209.85.221.171])
        by smtp.gmail.com with ESMTPSA id q74sm417570vkq.31.2020.08.26.08.00.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 08:00:06 -0700 (PDT)
Received: by mail-vk1-f171.google.com with SMTP id 186so496288vkx.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 08:00:05 -0700 (PDT)
X-Received: by 2002:a1f:fc02:: with SMTP id a2mr9424339vki.65.1598454005234;
 Wed, 26 Aug 2020 08:00:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200709082024.v2.1.I4d2f85ffa06f38532631e864a3125691ef5ffe06@changeid>
 <20200826145011.C4E48C43387@smtp.codeaurora.org>
In-Reply-To: <20200826145011.C4E48C43387@smtp.codeaurora.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 26 Aug 2020 07:59:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uu4dnzeTB+DfecO5uZSJWjq4qbi4=Uwgy-QwPphLApBw@mail.gmail.com>
Message-ID: <CAD=FV=Uu4dnzeTB+DfecO5uZSJWjq4qbi4=Uwgy-QwPphLApBw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ath10k: Keep track of which interrupts fired,
 don't poll them
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath10k <ath10k@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Rakesh Pillai <pillair@codeaurora.org>,
        Abhishek Kumar <kuabhs@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 26, 2020 at 7:51 AM Kalle Valo <kvalo@codeaurora.org> wrote:
>
> Douglas Anderson <dianders@chromium.org> wrote:
>
> > If we have a per CE (Copy Engine) IRQ then we have no summary
> > register.  Right now the code generates a summary register by
> > iterating over all copy engines and seeing if they have an interrupt
> > pending.
> >
> > This has a problem.  Specifically if _none_ if the Copy Engines have
> > an interrupt pending then they might go into low power mode and
> > reading from their address space will cause a full system crash.  This
> > was seen to happen when two interrupts went off at nearly the same
> > time.  Both were handled by a single call of ath10k_snoc_napi_poll()
> > but, because there were two interrupts handled and thus two calls to
> > napi_schedule() there was still a second call to
> > ath10k_snoc_napi_poll() which ran with no interrupts pending.
> >
> > Instead of iterating over all the copy engines, let's just keep track
> > of the IRQs that fire.  Then we can effectively generate our own
> > summary without ever needing to read the Copy Engines.
> >
> > Tested-on: WCN3990 SNOC WLAN.HL.3.2.2-00490-QCAHLSWMTPL-1
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
> > Reviewed-by: Rakesh Pillai <pillair@codeaurora.org>
> > Reviewed-by: Brian Norris <briannorris@chromium.org>
> > Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
>
> My main concern of this patch is that there's no info how it works on other
> hardware families. For example, QCA9984 is very different from WCN3990. The
> best would be if someone can provide a Tested-on tags for other hardware (even
> some of them).

I simply don't have access to any other Atheros hardware.  Hopefully
others on this thread do, though?  ...but, if nothing else, I believe
code inspection shows that the only places that are affected by the
changes here are:

* Wifi devices that use "snoc.c".  The only compatible string listed
in "snoc.c" is wcn3990.

* Wifi devices that set "per_ce_irq" to true.  The only place in the
table where this is set to true is wcn3990.

While it is certainly possible that I messed up and somehow affected
other WiFi devices, the common bits of code in "ce.c" and "ce.h" are
fairly easy to validate so hopefully they look OK?

-Doug
