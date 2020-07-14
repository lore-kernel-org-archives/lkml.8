Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD07BC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B760D208FE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="CQJLmeA+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728160AbgGNMpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgGNMpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:45:07 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E683AC061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 05:45:06 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id y10so21634531eje.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 05:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y1I0HAegT4r/446CzgZG+DkAzDcM+MzQfjx73vwQdRM=;
        b=CQJLmeA+xaZZtJF5b0Wo0lD5+aCoZG1R80srNwsCUjS76gLGuxfUW4TWyhqjgQ7ver
         SPR896yyEgiAOZBSYYcMMtrRuMKty152p9lVN1GuCkKIwX1fLqDjELomw5gPGQcHjxJL
         /QQLP2+0F4wJo1q8ejn97Hzff4QxDGsVczbuw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y1I0HAegT4r/446CzgZG+DkAzDcM+MzQfjx73vwQdRM=;
        b=SsZzP0uEj6oFEf2cwExeupUNim1pmCulDGnZaQZmNBr60HG4rzkXnE2Ax3o1fVCViM
         e9sq4iOjRT/7k8KfXERKW7iuPQTB6KMo8YpfUDEbPFEfjOi6chwaBUeVBFGgzAJGxLwu
         oNXRjMBEuRkNYx87ON1B+26TaBdenhwGih1k4fsljNScTvXIXX04vK6mYJFTuhaJT20w
         ypxuGpj1RTz71t7Euaozls7Guh3wzrTA0ISHemKyHD82Z3c4LO8uyyshbNuXfHfqf9QU
         /TDjjaIgLz8KYhM7kT1fYE8BcJc0Zd+MQw0ZjY2tevMiHDiE4sdN5eDqXku+i/jHsJsb
         izhw==
X-Gm-Message-State: AOAM530Jmscj+gtAlaWja2jsOr3J8HzwgHU2RIkG125PfC9gExxB0tjY
        gVf57no4S4x3V/aMzhnb0mlv+ltbqisIQkIo30DioQ==
X-Google-Smtp-Source: ABdhPJzgPCDFfwq8iNZU/sqh44HMtCTq9RHyO/4YCVra0P+Tw+3f+dR5jwQ//Ejs/ZWSUL9JourMwf9sQGQL8is3i7U=
X-Received: by 2002:a17:906:1c05:: with SMTP id k5mr4174938ejg.320.1594730705729;
 Tue, 14 Jul 2020 05:45:05 -0700 (PDT)
MIME-Version: 1.0
References: <2733b41a-b4c6-be94-0118-a1a8d6f26eec@virtuozzo.com> <be5341bf-6631-d039-7377-2c0c77fd8be3@virtuozzo.com>
In-Reply-To: <be5341bf-6631-d039-7377-2c0c77fd8be3@virtuozzo.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 14 Jul 2020 14:44:54 +0200
Message-ID: <CAJfpegtHkZPky_rvBhtgpWrSZdzhWNw0YLiH4C_GHm9TdChs=w@mail.gmail.com>
Subject: Re: [PATCH] fuse_writepages ignores errors from fuse_writepages_fill
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-fsdevel@vger.kernel.org, Maxim Patlasov <maximvp@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 25, 2020 at 11:39 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> fuse_writepages() ignores some errors taken from fuse_writepages_fill()
> I believe it is a bug: if .writepages is called with WB_SYNC_ALL
> it should either guarantee that all data was successfully saved
> or return error.
>
> Fixes: 26d614df1da9 ("fuse: Implement writepages callback")
> Signed-off-by: Vasily Averin <vvs@virtuozzo.com>

Applied.  Thanks.

Miklos
