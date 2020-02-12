Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D834C352A3
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 02:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0581620842
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 02:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581473327;
	bh=PrKh7omHj2RciaVbVhAmrjW9Vdd7zZlRNnLqzKtRfew=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=mZHhfOpM77YETnMFASIoIV7puEyFugwzILYznX9lJbnxf628zb7vBiiHfOKZdp0hU
	 N7kpuPZ3fMxXBZd3xdB6ycUtOW5aFS7NHE8ovxs00qVrVVUKHMmBaz4FAJAqZDsFhB
	 vjACqdAQAzZpq7zxaFMXImuXeCxxxWx/+D/TTgfY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgBLCIq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 21:08:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:54266 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727761AbgBLCIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 21:08:42 -0500
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C401120842;
        Wed, 12 Feb 2020 02:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581473321;
        bh=PrKh7omHj2RciaVbVhAmrjW9Vdd7zZlRNnLqzKtRfew=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D4UB4QUpIMywmyY9YqTYSDsy6Tl3vPCB6/pbWBKMGzJQaBrUQVbLSTyq6VtFPMl0P
         X/JYrLEViCYWWnIjZXVEh5azSRguvlwCEySadHCC7KpNAR0EN24hTx30kAcr95Tktp
         W8r4xSJqk6VLscMJF72JkITzARQisYUQIyu3OSeI=
Received: by mail-qk1-f178.google.com with SMTP id z19so601866qkj.5;
        Tue, 11 Feb 2020 18:08:41 -0800 (PST)
X-Gm-Message-State: APjAAAWYKA9qdEYaXtTT6xK9fbzWX6Wsi6j/caXXCWQRzkGDnKkjxDKY
        OGTL9t3odKRJ4Z9oLGL0oFsDneOK+sagpdgu6g==
X-Google-Smtp-Source: APXvYqwpb2C+Cwuil3TlZnXwOPTq6EEGKlyg0Jw5Gq9SMUiA0SZqxNJHFPzh0nk1B8fdCrHEGntw42mWREArhwCpbEA=
X-Received: by 2002:a37:5347:: with SMTP id h68mr5397468qkb.393.1581473320956;
 Tue, 11 Feb 2020 18:08:40 -0800 (PST)
MIME-Version: 1.0
References: <20200211142614.13567-1-paul@crapouillou.net> <20200212020707.GA29808@bogus>
In-Reply-To: <20200212020707.GA29808@bogus>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 11 Feb 2020 20:08:30 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+3fWUaMhbrJ5m2sDLC8wK-L0PysCyCe7Eje0VzPTcqvA@mail.gmail.com>
Message-ID: <CAL_Jsq+3fWUaMhbrJ5m2sDLC8wK-L0PysCyCe7Eje0VzPTcqvA@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] dt-bindings: Document JZ47xx VPU auxiliary processor
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        "open list:REMOTE PROCESSOR (REMOTEPROC) SUBSYSTEM" 
        <linux-remoteproc@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 8:07 PM Rob Herring <robh@kernel.org> wrote:
>
> On Tue, 11 Feb 2020 11:26:09 -0300, Paul Cercueil wrote:
> > Inside the Video Processing Unit (VPU) of the recent JZ47xx SoCs from
> > Ingenic is a second Xburst MIPS CPU very similar to the main core.
> > This document describes the devicetree bindings for this auxiliary
> > processor.
> >
> > Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> > ---
> >
> > Notes:
> >     v2: Update TCSM0 address in example
> >     v3: Change node name to 'video-decoder'
> >     v4: Convert to YAML. I didn't add Rob's Ack on v3 because of that (sorry Rob)
> >     v5: - Fix 'reg' not in <addr, len> pairs
> >         - Add missing include to devicetree example
> >
> >  .../bindings/remoteproc/ingenic,vpu.yaml      | 77 +++++++++++++++++++
> >  1 file changed, 77 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/remoteproc/ingenic,vpu.yaml
> >
>
> Please add Acked-by/Reviewed-by tags when posting new versions. However,
> there's no need to repost patches *only* to add the tags. The upstream
> maintainer will do that for acks received on the version they apply.
>
> If a tag was not added on purpose, please state why and what changed.

Disregard this, you did say why.
