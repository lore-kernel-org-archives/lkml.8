Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEBB2C2D0B1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 12:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ED4F2084E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 12:30:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pftp3HPW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727159AbgBDMaM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 07:30:12 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:36807 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727148AbgBDMaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 07:30:12 -0500
Received: by mail-vk1-f193.google.com with SMTP id i4so5100816vkc.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 04:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fBxb8ipzgRQ+TPw0PfltDu/6A8Y/sJwOnRag8CswWiQ=;
        b=pftp3HPWFrzJ+nM082RVEP/3qxqGrCrrK63HgxZatNhHJMQt4swrhizc6zxRaMif/Y
         68MEqB/3xmL7bnMCXkIDVy1s70kEISAp7/DxndS64RxliiDeJaPayvbZTd7rLnsXUffI
         TcdQEwiuZykgI3odG8um786U0m7zR8BoZJ0TlGFCt6GLVe9AmffcCgYX8B1BPn1Tpv1i
         bkpWBCFGAQ7N6T+Jd2+etjSuts4n/eg+eq23HaSu41jbUJFTz8gVFBPQepZksDel2PSs
         G4L7fAtaKe7OJFSjENVVnY/4AiDGlxWs+x26QUfOdgTbnIc9xYPsQZXhgXxdS2TyPmlC
         uMLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fBxb8ipzgRQ+TPw0PfltDu/6A8Y/sJwOnRag8CswWiQ=;
        b=UcO+db651GIJBFnc2jM6e4NncQX6xM5KowtzGOZ/LitwgcNI3WpA8hoUGgzJj0nih0
         AxnudIKMh37t/yf4hdjay6/rYSO/Pyv1ok9gHn7gtkJjb+WIc3CVxOPbmwZirV7luziW
         XmabcapHkkiM+lltyK3Ng4cVF8GSbPfyGWi9RSlHzrkXQ17j8KZeVne1s2C0eVYrZJLm
         Bj+JsV1JZdNSlJ4bgqtO2wGEHW2+sSGEK+IzvBlootNPhdJCrGMfbUCubBIJnm/PZrjq
         9/ZKtT7K3ybZqQYi3DfFkpUEWE2OptlkwRc5HCGp0D+TmO5yQVGZ1xbwZ/k02+jq9y+S
         okPw==
X-Gm-Message-State: APjAAAX0l7vsunMQk3wRvubh8TfH542Dmzk2QFAViBokhR3o5C/TJeT+
        DkBzUA6AuWcZg+wlr+WHARKWnnkjzQlZXGITlm1d+Q==
X-Google-Smtp-Source: APXvYqxYGFqnJQo7zKASrHj0432bv9Emj2fu3sw1yKpzLrKSeqw4SjD1C/fS2qFnfju3rbOTUHqFJn5eaw1Ppq9t95c=
X-Received: by 2002:a1f:914b:: with SMTP id t72mr17403010vkd.101.1580819410057;
 Tue, 04 Feb 2020 04:30:10 -0800 (PST)
MIME-Version: 1.0
References: <1579602095-30060-1-git-send-email-manish.narani@xilinx.com>
 <1579602095-30060-5-git-send-email-manish.narani@xilinx.com>
 <99fd3904-37fa-f070-f7ac-e1dcb5bf43de@intel.com> <0d7e7a44-91dc-baef-5dcf-4ff683e98581@xilinx.com>
In-Reply-To: <0d7e7a44-91dc-baef-5dcf-4ff683e98581@xilinx.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 4 Feb 2020 13:29:34 +0100
Message-ID: <CAPDyKFosDoABbHaoEtyay-uMKpq6QXsoby631gK-1f6iAS0mgg@mail.gmail.com>
Subject: Re: [PATCH 4/4] sdhci: arasan: Remove quirk for broken base clock
To:     Michal Simek <michal.simek@xilinx.com>,
        Manish Narani <manish.narani@xilinx.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>, jolly.shah@xilinx.com,
        rajan.vaja@xilinx.com, nava.manne@xilinx.com,
        tejas.patel@xilinx.com,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Feb 2020 at 12:42, Michal Simek <michal.simek@xilinx.com> wrote:
>
> On 03. 02. 20 12:31, Adrian Hunter wrote:
> > On 21/01/20 12:21 pm, Manish Narani wrote:
> >> This patch removes quirk which indicates a broken base clock. This was
> >> making the kernel report wrong base clock of ~187MHz instead of 200MHz
> >> even as the measurement on the hardware was showing 200MHz.
> >>
> >> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> >> State: pending
> >
> > Huh?
>
> It shouldn't be here. It is internal patch labeling.
> Manish: Please send v2 with all lines you got and remove this above.

No need for a resend, I can fix this before applying, which will be
when rc1 is out.

>
> >
> > Otherwise:
> >
> > Acked-by: Adrian Hunter <adrian.hunter@intel.com>
>
> These patches requires firmware changes. Feel free to take it directly
> via your tree. If you want me to take it via arm-soc tree please let me
> know.

Thanks, I pick them up via my mmc tree then.

Kind regards
Uffe
