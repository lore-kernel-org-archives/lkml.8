Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB3D0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 09:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DA9B206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 09:14:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p4g1le9/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731119AbgF3JOG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 05:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729866AbgF3JOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 05:14:04 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D67BC061755;
        Tue, 30 Jun 2020 02:14:04 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id dm12so8926434qvb.9;
        Tue, 30 Jun 2020 02:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=goGiq75i1r9UL5Bg9QEBSzEo+ZjMGYFQePVSHu+1Wss=;
        b=p4g1le9/ZfF8ilquMjXqNMPvi8RiOh9kTjkToZUu3WyBU++LirvbrgkQ2h6Bpf877K
         cYygMEY+jS7/cpIyNcFb1rQcKtotPZr5PTnakDOxRpMtSjb54dHI31e1N1b/hWSa07r5
         HyefN36kstRQuh6GF3RPPy5+F8KJ3yjqQnSG/dsmh8x4fYTPaHuosfNtJ5yPz3ijeBXs
         hbxpZ9SDS3SW7Qg7t6XO357gC63oKuabATS6UhqWjc35Qm6rs65ZHvJNehPaZoVTR3JF
         Il7X5gOb/qraRnOM887GonIo46XEfKfz+aRm5zk8UIQN7GTbSXWL6InIx51H4VG09t86
         W1DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=goGiq75i1r9UL5Bg9QEBSzEo+ZjMGYFQePVSHu+1Wss=;
        b=XGAxo33HhEnvJUGNXL3f9YVJB2AxK361Zz9CCxQrV0fzo7LQEJ5tT8/akDljchTjbS
         isC+9JKz2OFbdv3EVPXcA0obUO2HzrVTL96xNEY8Kr51AncLRMGmayanh8NxE/wZ0vV9
         BTmR17cxZQmvVsLOFIUw9HdH5dI2lXi8a1BR1b5k75zJXoDQLk4jJeE4EFcBwvhfM6Si
         vUdzLhUr0RRfF7GLWdtTyN3KJvMcp9aD2VTv80D7snU0V3WHBEOsukw1Ur07W75K3N8K
         D8yNHWF8kpbxnqV/DO75fJrPJYuM8fk9lWxVdKqqrEZWxUAQHMIvvuimyk6Omxfm2chP
         E4OQ==
X-Gm-Message-State: AOAM530KQUBS+DCrXGb5BbHf8e0Ng8c1j0sD4HyztvKab9XfM9Fbdoq6
        v1h25EJLjZ2CckLNl951h9P8NZQ1prqBuXIrztA=
X-Google-Smtp-Source: ABdhPJxEorLd2eAYPtaEGcI5F8EpfrHsypfMl7/Fu8I7Xbr0FcWZSr3cSenpQxQD5tD7gaEocYzMslPBrkwzWe8rPTs=
X-Received: by 2002:ad4:42a7:: with SMTP id e7mr19066154qvr.212.1593508443740;
 Tue, 30 Jun 2020 02:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <1591975362-22009-1-git-send-email-christophe.kerello@st.com> <1591975362-22009-5-git-send-email-christophe.kerello@st.com>
In-Reply-To: <1591975362-22009-5-git-send-email-christophe.kerello@st.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Tue, 30 Jun 2020 11:13:52 +0200
Message-ID: <CAFLxGvzfh1Qa_gM9bZAxaoCbO6xCoNdaPN=Ea20Up_zPVgjugw@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] memory: stm32-fmc2-ebi: add STM32 FMC2 EBI
 controller driver
To:     Christophe Kerello <christophe.kerello@st.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, arnd@linaro.org,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mtd@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 5:24 PM Christophe Kerello
<christophe.kerello@st.com> wrote:
>
> The driver adds the support for the STMicroelectronics FMC2 EBI controller
> found on STM32MP SOCs.
>
> Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
> ---
> +       if (!IS_ERR(rstc)) {
> +               reset_control_assert(rstc);
> +               reset_control_deassert(rstc);

Shouldn't there be a small delay between assert and deassert?
Other than that the code looks good to me.

-- 
Thanks,
//richard
