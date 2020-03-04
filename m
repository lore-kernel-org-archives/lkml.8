Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
	HEADER_FROM_DIFFERENT_DOMAINS,HK_RANDOM_FROM,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E63FC3F2C6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 02:42:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5117620866
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 02:42:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nVFh8gi7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387554AbgCDCmG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 21:42:06 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39702 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387397AbgCDCmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 21:42:05 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so324781plp.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 18:42:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0gnzUT6IfMkAevkPG6epW/0WW8fFX/S7HOzubTrdA+s=;
        b=nVFh8gi7N77XyRa+b63fYk+I0vUvemTDtUd5kSi2V/DAsh0HIkXMm2G7QPnEknsEuU
         AewvPoJmlX3zPpdVnF4UNBM8bDjV10nYjpEasiLm92k/I15EiIPdpx2mhwfGesyJL4hh
         iTSJpf28PySMw9AyfGfppFxfEGhZ7DTFC7OqvLogUEuPKs2GLHFTKw7/thmBLWxZIPXA
         hb7PfokEpMBXDZoPkg4qxFo35/LDVDwXJP6jwLFha8GyuFZOQLim2pdfTlvadRePhDWY
         U6ZKW8gzvamzf86U3vO8jmVHyZzvMzaajP+qu8FdDSQdj/QRHzGayCRDY7Fzl6o625fp
         +C3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0gnzUT6IfMkAevkPG6epW/0WW8fFX/S7HOzubTrdA+s=;
        b=oJJ0kbhgL/v/Ni89X//osKe/bLSYS7spW41Gije01tw1rN3u0G0pqtzGVHYwvm5LT+
         TVk4+zctDSMmmuN/gcO2Nab3iAoTmalz9eRmbCPalH7EF/LDtdR1po+9AoyTLVt8qOvJ
         vo8EDvEuw684D8iaT91FSu8ENNbiIIGSYq2zZwd/gRuiBb5aTp5TgcxR0ddmV93V1Ukh
         w7WWyhNR8cq8lfCwuTfbB9o1TTkPKp0qtQNThPuhNk65X0/2qxr2qFqvUfom5Gbh8wQN
         rFESQTGDceVKvA9y4dmzqzbKh/g6yoX5TQOrLyTAKZbbrkBuBBRTUH1lvfJtq211kAIU
         GP8w==
X-Gm-Message-State: ANhLgQ0Atn5E/gE1GRm1u0pGMT6sbykKCvlrgxiqGZP9IF/hDxjtgpvE
        GVE/FUkLdidqJuDmK2WGDpWxxB7AbTpEJcWiaUU=
X-Google-Smtp-Source: ADFU+vvsJSXksvOHwF2Z5jx7XbZeF5IkgdGQtpqkIcGOMQXX3UZJiunOWG6yBfioCy+TibzaTkQ9lN+XnNK7gz4UjNQ=
X-Received: by 2002:a17:90a:d205:: with SMTP id o5mr699361pju.46.1583289725111;
 Tue, 03 Mar 2020 18:42:05 -0800 (PST)
MIME-Version: 1.0
References: <20200304004112.3848-1-afzal.mohd.ma@gmail.com>
In-Reply-To: <20200304004112.3848-1-afzal.mohd.ma@gmail.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Tue, 3 Mar 2020 18:41:53 -0800
Message-ID: <CAMo8BfLxQ_zmTSPS1En7BxCXORKh3wBK2KnKoUBDFVgOufuEGQ@mail.gmail.com>
Subject: Re: [PATCH v3] xtensa: replace setup_irq() by request_irq()
To:     afzal mohammed <afzal.mohd.ma@gmail.com>
Cc:     "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Chris Zankel <chris@zankel.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 3, 2020 at 4:41 PM afzal mohammed <afzal.mohd.ma@gmail.com> wrote:
>
> request_irq() is preferred over setup_irq(). Invocations of setup_irq()
> occur after memory allocators are ready.
>
> Per tglx[1], setup_irq() existed in olden days when allocators were not
> ready by the time early interrupts were initialized.
>
> Hence replace setup_irq() by request_irq().
>
> [1] https://lkml.kernel.org/r/alpine.DEB.2.20.1710191609480.1971@nanos
>
> Signed-off-by: afzal mohammed <afzal.mohd.ma@gmail.com>
> ---
> Hi Max Filippov,
>
> i believe you are the maintainer of xtensa, if you are okay w/ this change,
> please consider taking it thr' your tree, else please let me know.

Sure. Applied to my xtensa tree.

--
Thanks.
-- Max
