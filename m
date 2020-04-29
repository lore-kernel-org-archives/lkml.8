Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBDE7C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:35:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 978792085B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 12:35:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5TyUZV+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgD2Mfo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 08:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726781AbgD2Mfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 08:35:43 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE59DC03C1AD;
        Wed, 29 Apr 2020 05:35:41 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id 18so1018349pfx.6;
        Wed, 29 Apr 2020 05:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6lD/kQN+2/noO6l676D/crTQxbfBilzk74je4uWi+RE=;
        b=D5TyUZV+K2dz48gCCRMuv18HfmOtvNgOmPvURzvzzAGjW2uTy21G07/Bs1fTMlOdkK
         JqGQ9YYuoQGNdBV77/HGXcu5sBoHLkAjB6S4sQk08CONbupRhmSbmkG8DavGRpfJeW2Y
         3JtlSEy/xIcOYz0iY0pQ6RVSYw3fZC8vJnxNaA6bDijigfozEBfbU2uSp/5QEMhYZqMu
         b9A8gd9Ib8RHurG/anB84s8coQvM167UEhkBTwQZzI0eJs1tw23zjfYzwMLE4uKF859E
         Bn6XWs+j0NI0iVG/5QEiDU+s3NwafiQj/YkurkB2CWm2ArDgs1PAPp24W2v3sHBGqR0h
         /s4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6lD/kQN+2/noO6l676D/crTQxbfBilzk74je4uWi+RE=;
        b=uTvD15gm7lj7IWnhHap5J+bu6qD5ugUZC/tGXP8OKnJl+elazhWdk52mzYke45PIqJ
         1SWNRwK/zck1PvaOOTJNEtTTNPrmQQfWtQ/8NM/0W0pl63OG60OUz0OxamHEEg0sag2O
         +ViIwYDR4i0UPzkegpM0IqrTf/RPdhE4uvpQcpWc+rIFiaN7QcBmUdhim7Zf+DJWhGaT
         I6mUQi1Jfn/KbqSC0rCZGV4MJFm9dYoWFEq11Kx3EHw7JxlghJrbageZi0crLRldxWVE
         lT1KRr2EREcK8n5FdxKKaliUeWYzij63faubWLcE9HkBaDnYz3s0ie/D/sx7pXQi4ofc
         hffw==
X-Gm-Message-State: AGi0PuaB9MAeYQpY2nuDkIEAaFBY+Lq7iBG26Qgb72Nsb5hU8qQ6pBDP
        aMji9st5dIAiB6GzwM6kGi+riAc2+qGH6Zf68PQ=
X-Google-Smtp-Source: APiQypJj05CXAFhrRSaM+IwEVCVJ4x2Uo4Oh4UHcvxMGhUsVIcNQwnmranc+vMIzihioZkfSAOJlAmUY+iX9Vg5pRzw=
X-Received: by 2002:a62:5ec7:: with SMTP id s190mr33747269pfb.130.1588163741365;
 Wed, 29 Apr 2020 05:35:41 -0700 (PDT)
MIME-Version: 1.0
References: <1588150780-53718-1-git-send-email-wangxiongfeng2@huawei.com>
In-Reply-To: <1588150780-53718-1-git-send-email-wangxiongfeng2@huawei.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 29 Apr 2020 15:35:34 +0300
Message-ID: <CAHp75VfmGQx=+pips170Wmw0ACAQ40NJTLcVTZaMrv3LrL1LHw@mail.gmail.com>
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Remove always false 'value <
 0' statement
To:     Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc:     Henrique de Moraes Holschuh <ibm-acpi@hmh.eng.br>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Thinkpad-acpi devel ML <ibm-acpi-devel@lists.sourceforge.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 12:06 PM Xiongfeng Wang
<wangxiongfeng2@huawei.com> wrote:
>
> Since 'value' is declared as unsigned long, the following statement is
> always false.
>         value < 0
>
> So let's remove it.

It's bogus. The warning here doesn't tell anything useful, so doesn't the patch.

-- 
With Best Regards,
Andy Shevchenko
