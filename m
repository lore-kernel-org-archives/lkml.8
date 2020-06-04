Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3960CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 04:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10337206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 04:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591244488;
	bh=seZ4l17UAhJmDjcYLmBb3+WsxXCHmTGoBsmLJEsIK9s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=tacCF8Mt5QRPjRZHf5KzgP6oyb1XOS+nr528bClbLHvHBqIjKqY95gv/mdILnghr4
	 0t+EEiPBq5P5H+ft3xhfBYnBNoTAdvCnTvnA67KRDyhCrreMUIccB/1GlSxKzNDH+z
	 JvSJ25ki9ixtzX7UGMZNSPHF4rbYVB0sBce34PFM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbgFDEV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 00:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726146AbgFDEV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 00:21:26 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC1F3C03E96D
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 21:21:25 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id c11so5548735ljn.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 21:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ibr/VZbLMyGb+zMg+GN++bmNBEQgeGmT6g5ZXwd388Q=;
        b=Bn2WBvA5Ql6NayGRsHsky2PmoWV+IQEfrXN+hAq6GtSpeTQnBbkK5YEo6Hz8rIFW2K
         8leA8oDfXoNMH7aqRARky+w4XxdyY/I/orySzXcl4QzN8H29WpFFD3TPfEXpAjIdyqIT
         cR/9LY+nQvxxUamLToaC8aWuO4cMoZE6mkOqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ibr/VZbLMyGb+zMg+GN++bmNBEQgeGmT6g5ZXwd388Q=;
        b=kdFYdEvm5ZAB5RI6Q+jKJ13eECNAK3rxOGsC8IP3Ur/LcutaceSO1JJlEJ//B95Hfk
         UXAKgNP0EVVzvQtY8UAbHjZ/JYd96JkVG6yHlr/3EvvdB46W7SYmGdsZ2a65LLXLxMgV
         SaK00Cb1OowF/0cJcoTUKpQl2I7WTYkbcU8yryLZ9/Yn/5B+Xq3zOFI07MWvo1Lsmsbj
         I1Sz9vryVfPWPGe2mmnKvic2Ny/VNXSbaEjdii1NsxXgfj37rM3hnpHSgfVhHwM9SpgG
         WVgvaXE260qoMnAEcQER7VLoN9TAkLscw6GsNojnAzpXBqTijhPsa+uniRW+Gi0PEFiG
         zEYQ==
X-Gm-Message-State: AOAM531NAf308u6XnwWtYC7G3QDOILN9oxEWa90wF4z3nyx1nX5wgTLY
        Xv/yQ4C+qJ12GXLcm3gTq1SPiF8yxFQ=
X-Google-Smtp-Source: ABdhPJwz9IEDf4jq4yzTECCLHKXlU/x9MCDvJ3Zg9+f1sQvGJ3UNGGnjhRYdiJ0+qx5L8C6HQ61g1A==
X-Received: by 2002:a05:651c:1022:: with SMTP id w2mr1237147ljm.262.1591244484066;
        Wed, 03 Jun 2020 21:21:24 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id j12sm938136ljg.15.2020.06.03.21.21.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Jun 2020 21:21:23 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id n24so5491026lji.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jun 2020 21:21:22 -0700 (PDT)
X-Received: by 2002:a05:651c:2c6:: with SMTP id f6mr1085967ljo.371.1591244482555;
 Wed, 03 Jun 2020 21:21:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200603100559.2718efba@coco.lan>
In-Reply-To: <20200603100559.2718efba@coco.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Jun 2020 21:21:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg0=J7VXoEL0eCNmguyj-z7G-iByHcUV02nrmw10GCZ3A@mail.gmail.com>
Message-ID: <CAHk-=wg0=J7VXoEL0eCNmguyj-z7G-iByHcUV02nrmw10GCZ3A@mail.gmail.com>
Subject: Re: [GIT PULL for v5.8-rc1] media updates
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 3, 2020 at 1:06 AM Mauro Carvalho Chehab
<mchehab+huawei@kernel.org> wrote:
>
>   - The atomisp staging driver was resurrected. It is meant to work with
>     4 generations of cameras on Atom-based laptops, tablets and cell
>     phones. So, it seems worth investing time to cleanup this driver and
>     making it in good shape.

Hmm. It causes a warning for me:

   drivers/staging/media/atomisp/pci/atomisp_v4l2.c:764:12: warning:
=E2=80=98atomisp_mrfld_power=E2=80=99 defined but not used [-Wunused-functi=
on]

which is a bit annoying.

I can see the FIXME's there, but the warning still isn't acceptable.

I'll add a fixup commit. I was going to do it in the merge itself, but
decided that was a bit too subtle.

               Linus
