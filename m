Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 235EBC33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 06:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE44E20721
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 06:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ky2J0zDZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731654AbgAJGjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 01:39:07 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44817 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731455AbgAJGjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 01:39:06 -0500
Received: by mail-wr1-f66.google.com with SMTP id q10so640690wrm.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jan 2020 22:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jJLJHTUES5IjRBTc4xVBz1voCqcu532N0f/7D6D8Y7I=;
        b=ky2J0zDZHNXmqgWESU1Pp3b9SsOdOCW7HFDfO70Qz2N2wHr19GBPSensIxSKJySwmD
         QRVYr7j4WgIsX2bHjRsnTljXU4lsWS8nymXGl18Ed/KOzJteY1DDwRLLgePqFrkE68As
         ZrNZj4/IebkQEp6v7DJ3i5sRBUUpuh4keRtpx9GKEpz3rIdxfupopoa2ftM24WdolwP5
         2IoNa5Bd8kE+kb9sXQuh9PAIcxUndIr8P+mctWXNIGycJ/fe12JkWV4pM8UNZXkCg+Mb
         hrrUkIzzta16kijgT1dEGHFxAHhB6t6Fj2+0jLPMeQun7Qu81luziV5La6JTbMwwCwRT
         eabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jJLJHTUES5IjRBTc4xVBz1voCqcu532N0f/7D6D8Y7I=;
        b=rOc7tI95xZ5oVPB/rrTlDC9sFeQVaNLlrY8xGfRInuBsTiFzPYJ6LHyuFow45uj9HF
         rx4chth7DqjynLhqZV4wMVCmMYMPOVbLmjXi0jp5Ubdyt9m+49BtX5Uk1baM8fxYYidO
         OZTml0ORmaHmnT0+9ibvBuwxoMBp2YxgiVKkYcpbaTI/7b5EcCihyLej66mTZXdaf2qy
         OsBbG3bDUeOiSdc1KuczWyCPWqHpRsHI0rE7TpQhSxi+o3bnzwufDmgWjmTsYktnC+0M
         0xH8g0WrbBteOga5v+xvFIRW91lbmX4PS4nWPOLtE81aZWkiJqVnnEI+RhwLS/MA2KKO
         tN6Q==
X-Gm-Message-State: APjAAAVcKDZfPFLJYwjzw/OiIICVOXFdmfLPEbZrut5XqHMF3dSqk+10
        snUfAbgylUMYn0FfIn2b58+KWlyNfE0Cra0wsMK70Q==
X-Google-Smtp-Source: APXvYqzoaQGbJcLNuCDV67r3l8nzCxvYVGBYWWSum55y+HtleypgahLB71qCaO35ZJ10RIkRTNqZsFGz7T258gkuaMA=
X-Received: by 2002:a5d:43c7:: with SMTP id v7mr1522692wrr.32.1578638344524;
 Thu, 09 Jan 2020 22:39:04 -0800 (PST)
MIME-Version: 1.0
References: <1573449229-13918-1-git-send-email-anshuman.khandual@arm.com> <238c9810-dcec-7f4b-7bcb-a339f1f8aaad@arm.com>
In-Reply-To: <238c9810-dcec-7f4b-7bcb-a339f1f8aaad@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 10 Jan 2020 07:38:53 +0100
Message-ID: <CAKv+Gu9tw8UK15DwGN4J8hH5amJ6QEM1RmY5Q2_eoGLLTFNmbA@mail.gmail.com>
Subject: Re: [PATCH] efi: Fix comment for efi_mem_type() wrt absent physical addresses
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Jan 2020 at 07:11, Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
>
> On 11/11/2019 10:43 AM, Anshuman Khandual wrote:
> > A previous commit f99afd08a45f ("efi: Update efi_mem_type() to return an
> > error rather than 0") changed the return type from EFI_RESERVED_TYPE to
> > -EINVAL when the searched physical address is not present in any memory
> > descriptor. But the comment preceding the function never changed. Lets
> > change the comment now to reflect the new return type -EINVAL.
> >
> > Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Cc: linux-efi@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>
> Hello Ard,
>
> Just wondering if this patch is getting pulled. Dont see it either
> on linux-next or the following EFI tree.
>
> git://git.kernel.org/pub/scm/linux/kernel/git/efi/efi (efi-next)
>

Hi Anshuman,

Thanks for the reminder. It is queued now

-- 
Ard.



>
> > ---
> > Changes in V2:
> >
> > - Changed comment for efi_mem_type() instead of the return type per Ard
> >
> > V1: (https://lore.kernel.org/patchwork/patch/1149002/)
> >
> >  drivers/firmware/efi/efi.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
> > index 77ca52d86e30..47b0bf7a2b7f 100644
> > --- a/drivers/firmware/efi/efi.c
> > +++ b/drivers/firmware/efi/efi.c
> > @@ -899,7 +899,7 @@ u64 efi_mem_attributes(unsigned long phys_addr)
> >   *
> >   * Search in the EFI memory map for the region covering @phys_addr.
> >   * Returns the EFI memory type if the region was found in the memory
> > - * map, EFI_RESERVED_TYPE (zero) otherwise.
> > + * map, -EINVAL otherwise.
> >   */
> >  int efi_mem_type(unsigned long phys_addr)
> >  {
> >
