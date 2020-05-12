Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 961CBC54E8B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 766A6206CC
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 13:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHo71XNf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729952AbgELNEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 09:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725923AbgELNEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 09:04:04 -0400
Received: from mail-vs1-xe42.google.com (mail-vs1-xe42.google.com [IPv6:2607:f8b0:4864:20::e42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9F0C061A0C;
        Tue, 12 May 2020 06:04:04 -0700 (PDT)
Received: by mail-vs1-xe42.google.com with SMTP id l25so7774518vso.6;
        Tue, 12 May 2020 06:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WYYWk5B2Zk3TwldAUzCtTJK0glo/7kNcHTQydLAHm5E=;
        b=cHo71XNftzYCde+bfpfj3O5Me55d/CAF5uoY/3V6E4gXpR2DbAJUqHnB3U2PoAuPXf
         +jvSQcMEWbRTS89iqGm064nmezHp+7/wF5uH3tyUkSc4R5pkcDKPIYbrYDbNaQxOjKxj
         2Xl32Yq45X+snmh1X8CFrneUQu61MsPP5TfmRhdCdlbhcPQ6ZfjEqVDuVwX73I5HcoJz
         arzItnlRTzilZiKhUB/QYi0gSGwCbjQ7vMkte8LXU113pdTcZ4UA3fS2Kz4LKUad4boU
         CqMIy+MiXQhYJI3/cVd4ve/e8vid87Xl86l0Xg8M0kLqwsXVK53thEdrIyKWZi/8X3ZU
         AvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WYYWk5B2Zk3TwldAUzCtTJK0glo/7kNcHTQydLAHm5E=;
        b=HMzdlE+SlXmcDRrRBr3AFghw4T/mt39zzVcn3G0+P4boMVpiQWNs7b1xkg7fC58oxq
         PRhUCe26YNQwNEIMdlKGpVtZ+nctqIkp8ghPTh72x0lRPY+tP6TNXFBZEvLV/F5nyjiS
         TlxuVZrNRxO5qAMbfx564O8/iLNjmxtSo8wUhyx0yG6R0I1pwUbR5wyn2fIZn+Plls+i
         PPLYvvtEeSygFgYa9PT8mcySsNFUc9tp0Pq1GLAPbV1Ww8LaQHYf5lQeHuTVCjCFW+JP
         vj54v6wcIT6RsomyJeRTZQvAybAzfr8XjEW6Jbgm/J/BC6drZ/BsI6Nm9enDfiQ0KHCV
         KvDg==
X-Gm-Message-State: AGi0PuaIV8t9dWT34k1mRajBpqGkg4p+zgh1O4CLhhwCF2LsjH7LTHsj
        D8Zr6uKFFbq1vY22CWOXREcwj/HnzRouSEDKZ8Q=
X-Google-Smtp-Source: APiQypJ4NEstWoq9lkMhuVta2nDgCif74eH1N9G3xJwYqz8c5+2f0vuiPACHvfsMZLwR/GXfTW7+fce+ImJb3qkLZhE=
X-Received: by 2002:a67:c482:: with SMTP id d2mr16214320vsk.37.1589288643312;
 Tue, 12 May 2020 06:04:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200428141459.87624-1-weiyongjun1@huawei.com> <CACRpkdZ++vYw8LAiNUv6AXQ0QTh+W9vSL0_w2AR-GNNd=GH7FA@mail.gmail.com>
In-Reply-To: <CACRpkdZ++vYw8LAiNUv6AXQ0QTh+W9vSL0_w2AR-GNNd=GH7FA@mail.gmail.com>
From:   Emil Velikov <emil.l.velikov@gmail.com>
Date:   Tue, 12 May 2020 14:01:24 +0100
Message-ID: <CACvgo51t+LdpRuFw-uXgbstpHMRrgMt3s62mFsyO37OHjuWJNw@mail.gmail.com>
Subject: Re: [PATCH -next] drm/mcde: dsi: Fix return value check in dev_err()
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        David Airlie <airlied@linux.ie>,
        kernel-janitors@vger.kernel.org,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Tue, 12 May 2020 at 12:49, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Tue, Apr 28, 2020 at 4:13 PM Wei Yongjun <weiyongjun1@huawei.com> wrote:
>
> > In case of error, the function of_drm_find_bridge() returns NULL pointer
> > not ERR_PTR(). The IS_ERR() test in the return value check should be
> > replaced with NULL test.
> >
> > Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
>
> Patch applied! Thanks Wei, sorry for the long delay.
>
It would be nice if of_drm_find_bridge and of_drm_find_panel were
consistent - either return NULL or an ERR_PTR.
Otherwise the next person using them is likely to get it wrong.

-Emil
