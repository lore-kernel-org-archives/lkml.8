Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9F69C35DF0
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 00:14:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE1F820838
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 00:14:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cwjjB8VV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgBYAOT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 19:14:19 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37709 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726651AbgBYAOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 19:14:19 -0500
Received: by mail-oi1-f196.google.com with SMTP id q84so10838142oic.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 16:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GZtmbSEgUmBA2cOgkuRpY+h9XbrXRgH0ndQIFRZmJ38=;
        b=cwjjB8VVG8XrJHr+9SEk59Jg97OlI73g/1W+hi/ky5xqv970/1C1XiAom2PD2PpLlg
         LdSsMUOe2CelKaeX76Shd1EAfnXlOeF+FYFyuoXZ10Olfto9EiXkoMm0tGHoKDv/tQOy
         kImfGPxJ08+5yri7sO6xsIMJniJTAg5sw3mO1zn3soZ8YMxwhoKA3Z+wIgucL1dn/jiQ
         A80GsJml5bRUrFSGKbq/A/MTdkhprhOWaXBvOZ6NEOeGV1g+/IvES68k2MW04/Xr9NJ+
         JlW1lyZ6UT2SkaBba5Qp5brJ7CBxbR54fQ2KT8ILx4VdDIt+VSaQlCnQefzgODfuZbyr
         w7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GZtmbSEgUmBA2cOgkuRpY+h9XbrXRgH0ndQIFRZmJ38=;
        b=oVdWmn1U1g/FVPpxbgS3drbVBJtXLY5QZW9pwryJy7Lx60AiwfOWpNnW2pVH2O1CJE
         pysn2+kcOLtDTNpiuHsLN3kYxsCWs/Zwvj2GYN2j2fpnT3vsI3N9VvAFHVivrqNQgetd
         GDc2/C4/SJ60NIhoAKXJCMrkOQKrIwOSyjnwggBH2ziiDLRec6lsQhBP8lykEimc0HKe
         1+q8Kv+RhCf+VJKh9H0FuZHOpnAin1wlDwF1SbBbf7LF7wzAe0V52j6wkUEIhYqh9tUH
         4XyCZS51E+4F2vWO5FB3c6rpfkBnoATdzdG2ZRrFUoirJf4UI7iRO8wK9ud3djVM9t9X
         zHKw==
X-Gm-Message-State: APjAAAUjfZVswFy3N+v5qwTY6q9vKz/lWZ5tjTB3CDqODrhD33MMY3hz
        DW4U7PDrKLapO01ji06w6HQfRn5TBk2BWcyIRPXny+FW
X-Google-Smtp-Source: APXvYqzsDX7BHdCV5vm2RuqNmJjUPSdFrnJPn1LX8SDfKwKqUUphTqyN7w7FRi0e9tlsvwDFCvuFTUG2RmHNvqX3in0=
X-Received: by 2002:aca:c0c5:: with SMTP id q188mr1270836oif.169.1582589658269;
 Mon, 24 Feb 2020 16:14:18 -0800 (PST)
MIME-Version: 1.0
References: <20200220060616.54389-1-john.stultz@linaro.org> <20200220124927.BB33124670@mail.kernel.org>
In-Reply-To: <20200220124927.BB33124670@mail.kernel.org>
From:   John Stultz <john.stultz@linaro.org>
Date:   Mon, 24 Feb 2020 16:14:07 -0800
Message-ID: <CALAqxLVFHCJfKbDaSC38MMsi_zbn-61Kz4AumxEXv+cCp69Xjw@mail.gmail.com>
Subject: Re: [PATCH v2] usb: dwc3: gadget: Update chain bit correctly when
 using sg list
To:     Sasha Levin <sashal@kernel.org>
Cc:     Pratham Pratap <prathampratap@codeaurora.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>, Yang Fei <fei.yang@intel.com>,
        Thinh Nguyen <thinhn@synopsys.com>,
        Tejas Joglekar <tejas.joglekar@synopsys.com>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Jack Pham <jackp@codeaurora.org>, Todd Kjos <tkjos@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2020 at 4:49 AM Sasha Levin <sashal@kernel.org> wrote:
>
> Hi,
>
> [This is an automated email]
>
> This commit has been processed because it contains a -stable tag.
> The stable tag indicates that it's relevant for the following trees: all
>
> The bot has tested the following trees: v5.5.4, v5.4.20, v4.19.104, v4.14.171, v4.9.214, v4.4.214.
>
> v5.5.4: Build OK!
> v5.4.20: Build OK!
> v4.19.104: Build OK!
> v4.14.171: Build failed! Errors:
>     drivers/usb/dwc3/gadget.c:1098:12: error: `remaining` undeclared (first use in this function)
>
> v4.9.214: Failed to apply! Possible dependencies:
>     Unable to calculate
>
> v4.4.214: Failed to apply! Possible dependencies:
>     36b68aae8e39 ("usb: dwc3: gadget: use link TRB for all endpoint types")
>     4faf75504a7d ("usb: dwc3: gadget: move % operation to increment helpers")
>     53fd88189e08 ("usb: dwc3: gadget: rename busy/free_slot to trb_enqueue/dequeue")
>     5ee85d890f8d ("usb: dwc3: gadget: split __dwc3_gadget_kick_transfer()")
>     70fdb273db37 ("usb: dwc3: get rid of DWC3_TRB_MASK")
>     8495036e986b ("usb: dwc3: increase maximum number of TRBs per endpoint")
>     c4233573f6ee ("usb: dwc3: gadget: prepare TRBs on update transfers too")
>     e901aa159dac ("usb: dwc3: gadget: fix endpoint renaming")
>     ef966b9d3353 ("usb: dwc3: gadget: add trb enqueue/dequeue helpers")
>
>
> NOTE: The patch will not be queued to stable trees until it is upstream.
>
> How should we proceed with this patch?

Sorry, I only see this change as critical for 4.20+ kernels (where it
started biting folks), but I'd defer to Felipe if he'd like to see it
go any further back.

thanks
-john
