Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE83AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D7AC22BF3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 13:40:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o1nG60uw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgGTNkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 09:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbgGTNkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 09:40:12 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09364C0619D2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 06:40:12 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id z24so20253414ljn.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jul 2020 06:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2TqGaXLm1LJjNwD7BWd5nhWoW5T2uB1q67xa8MHwR3Q=;
        b=o1nG60uwcHnTfy0TS2+LttQH6srPzrE5epdZJTdvwS4hM04a/5yT7RcAlxdCpbMtB3
         yQvv7WH6G+LocxRPe8k6PBJoK/pvzZ1uN6RgnwvM2XEx+IM2HbvgD4Rt8sVLFhAdVCNA
         R5Mcpz7NqlHG1sQE1CMs1uyAVGTfD5IhapoyRd0c1oGt8idD1OmAc3lFKmpdpOtg5mgJ
         lGIAb7o5oTW23BPAwDiqIHM6WzhVOnSdVv175/qWrtpIXD0xgo220e+NP2Qp3qF7Fqsz
         t4K+eL6rmzhtgSfji4lyCnh8ALa+1Q5v9u+kRO6fjY0Z+xkPGNtyIU+kTueQresiqIt5
         QV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2TqGaXLm1LJjNwD7BWd5nhWoW5T2uB1q67xa8MHwR3Q=;
        b=YQIVWmM31wFig0BSv5a16rzvTcOVi6xii/zPxiML6MQPNfqhBivTsuvZkChz8HHaGA
         NhfyMSPMfL7yQkKGWm7hfpjSFw7sJXcjT3rCcbj+SrEnj6qVYjuS23OzgXwhlgsnjOew
         ugT0tvNnx+VFiNeimKA6FSWMqP84TW1f47TVwAAafMJREV9lyCQxsU5VTFeUiYqnvBAh
         /oEUTPfhtEIfiz+2/St0hg4Ac7rwZu/sefHsP+MGQKu1+Iw3A+q+4Nou7tvGanpzOMKK
         sKykpRf/uePM/X+mAd0Uf9A6HZbtD4dSf5JCBor7BP2QewRgfSBUdkkXTY7vh3h3RhnC
         Z1wg==
X-Gm-Message-State: AOAM532ll0LTuLbfMGlbUboGMvWKfZ0a/ccNMk1q12pPkg4Z5bCDPNRv
        k/0j92DqYyY9bKSHcmwZl1eF/4KnNRIFrCcMuNepZw==
X-Google-Smtp-Source: ABdhPJxsGScXp2ry3GuYVsKjsKyaCSkJk8FuHP5mvQ3dEZmQQwYdfTaLyEcMQlgVIHgPJkhPC51SVKPWJsvLAcY3TWE=
X-Received: by 2002:a2e:9c3:: with SMTP id 186mr10705432ljj.293.1595252410517;
 Mon, 20 Jul 2020 06:40:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200716212317.GA17754@embeddedor>
In-Reply-To: <20200716212317.GA17754@embeddedor>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 20 Jul 2020 15:39:59 +0200
Message-ID: <CACRpkdY25NXNzAZhV6v9aQC7hUnxbMoniyYK=QMmVi6GJnG5dw@mail.gmail.com>
Subject: Re: [PATCH][next] pinctrl: single: Use fallthrough pseudo-keyword
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 16, 2020 at 11:17 PM Gustavo A. R. Silva
<gustavoars@kernel.org> wrote:

> Replace the existing /* fall through */ comments and its variants with
> the new pseudo-keyword macro fallthrough[1].
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
>
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Patch applied. Nothing controversial about this.

Yours,
Linus Walleij
