Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C30CC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 20:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14A712072D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 20:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Up+yuEpB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbgHVUOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 16:14:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgHVUOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 16:14:32 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DCA8CC061573
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 13:14:31 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id i26so4629483edv.4
        for <linux-kernel@vger.kernel.org>; Sat, 22 Aug 2020 13:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b3S7oC1Twn6qwXgk96qofdNf+3p8VebwTcX/dFv2iHs=;
        b=Up+yuEpB5QPjIBwhbe0qEEQdm96yXGMJbLrdrnzZVujZKXwYvFMimR8SX2Td6P+sgt
         GXXFaap6/SIv66pClr8Pc+K96hTjWJNDFJyRvo6cywkgs6VwsUYNS7WSXwXLtaVHlhgF
         GaX2Pmt0DZLdzipOlcItCADOL5abG5A0FhgYE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b3S7oC1Twn6qwXgk96qofdNf+3p8VebwTcX/dFv2iHs=;
        b=TLu/C3+Ptz40naXSbd4fc4ym11K/LjBCEvXXRJl2bk4CnHGDhOOj4zBizYabFQbMed
         QZdMhRqa789PEmQLwz1+lVO2atl4PluH2IaImtFXrh/Gt6Gf2KjolICoGabsiEVOMylZ
         qRQs2PpRUXFEvCSA5k94Na7LU0/zIcpD8BRZVoT0SfrHaOByRW4ZZ1Wnwhp3jYEWlMnD
         AcVWoKVLdI13fwTzrEb0H+dRUZqQXTmpSX/FfhaopK01+lBs+MhX2m397z77MpNunhT3
         HfAobKtGICjWUmRf9HgmAxqXxYVkLMsri1QVPCGjjzGglmab+PSkSXsZHADQUTYo9lpz
         ABBQ==
X-Gm-Message-State: AOAM530AU1LNjNmSzge5Uf7hD8oDPOvenDCJfnF1OK+RY4B/kRumH59k
        2e6b5rW/sEop4GT85x/YGpQOLoHCe8BZhOKVS3zdeA==
X-Google-Smtp-Source: ABdhPJwPf2hRNUhR7uuAqiiHV40WfBxtCrtceR0pSDIA9ysl7cfqK1Q7F7vFdn6VkhcrGXmyNFNckDQuSyUYPUt/fpg=
X-Received: by 2002:a50:e809:: with SMTP id e9mr8625270edn.133.1598127270246;
 Sat, 22 Aug 2020 13:14:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200821165221.32267-1-mmayer@broadcom.com> <20200822115636.GA19975@kozik-lap>
 <CAGt4E5t-GCPdU_W9U=627o5Xtx_MybFEM254FZF2HZ6VYPr7bg@mail.gmail.com> <20200822164619.GA24669@kozik-lap>
In-Reply-To: <20200822164619.GA24669@kozik-lap>
From:   Markus Mayer <mmayer@broadcom.com>
Date:   Sat, 22 Aug 2020 13:14:19 -0700
Message-ID: <CAGt4E5t=xNnOHAK3JM9kUGzGqbysDCsW5YmEXzVF9OBSUgPECA@mail.gmail.com>
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

On Sat, 22 Aug 2020 at 09:46, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Sat, Aug 22, 2020 at 09:40:59AM -0700, Markus Mayer wrote:
> > On Sat, 22 Aug 2020 at 04:56, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > >
> > > On Fri, Aug 21, 2020 at 09:52:21AM -0700, Markus Mayer wrote:
> > > > We would overrun the error_text array if we hit a TIMEOUT condition,
> > > > because we were using the error code "ETIMEDOUT" (which is 110) as an
> > > > array index.
> > > >
> > > > We fix the problem by correcting the array index and by providing a
> > > > function to retrieve error messages rather than accessing the array
> > > > directly. The function includes a bounds check that prevents the array
> > > > from being overrun.
> > > >
> > > > This patch was prepared in response to
> > > >     https://lkml.org/lkml/2020/8/18/505.
> > > >
> > > > Signed-off-by: Markus Mayer <mmayer@broadcom.com>
> > >
> > > Your Signed-off-by does not match From field. Please run
> > > scripts/checkpatch on every patch you send.
> > >
> > > I fixed it up, assuming markus.mayer@broadcom.com is the valid email
> > > address.
> >
> > No. I have always been using mmayer@broadcom.com since it is shorter.
> > That's also what's in the MAINTAINERS file. Please change it back. I
> > accidentally used the long form for one of my e-mail replies which is
> > where the confusion must have originated.
>
> I'll drop the patch then. You need to resend with SoB matching email.

Oh, I am starting to see what's happening here. This is new and
apparently due to some changes with the mail server setup on our end.

I have this in my patch file:

$ head 0001-memory-brcmstb_dpfe-fix-array-index-out-of-bounds.patch
From 6b424772d4c84fa56474b2522d0d3ed6b2b2b360 Mon Sep 17 00:00:00 2001
From: Markus Mayer <mmayer@broadcom.com>
Date: Fri, 21 Aug 2020 08:56:52 -0700

Sending patches like this used to work. Clearly our SMTP server has
now taken it upon itself to rewrite the sender e-mail address. I
wasn't expecting that. Let me look into it. Sorry for the hassle. It
was not intentional.

Regards,
-Markus

> Best regards,
> Krzysztof
