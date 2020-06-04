Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BECBCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97B67204EF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 17:47:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591292876;
	bh=hy+3xDuqCbqk3TJpDx0DpX17hTJm6msjJx8MXUi7K8w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=nBef1i0c0AvpCjCRsdeB2Tnl9tbcdlg5hwxmzXGKTvVxzzsAWMlaiAOQXs4F8vsTu
	 Pct51t/Q/Pl7KdJzjujfS1mMjA5+gJufeuCWiJd8i5X4LA9peWiidLXVgwFOVczGC4
	 aSOHh1RBLHajZx5LnsjOfoOaJfhJrHJjAXvc2+BE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730255AbgFDRrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730053AbgFDRrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 13:47:55 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3963C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 10:47:54 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id x27so4125370lfg.9
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 10:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nDxVRnmNfiahvBHfdilSj3UT2s2FPsvV9ID8lODpa4Q=;
        b=Lm1X79tNTv4QznYSL5D5S1XUiLEyklVkM9WYq6HnIY9gA4EBagpmRWlJMibEBhBwJc
         cg9VK/adAQCw3M/k2FbSrM6KvuN5rqOp/aKFPLjCsVz5jYVnG4l3MP6TT3p+I38XBSds
         +ge0tTEliQZr93Kny7soGj2k92/6ZzT/mNJR4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nDxVRnmNfiahvBHfdilSj3UT2s2FPsvV9ID8lODpa4Q=;
        b=XPsXUEh31iNcbzGvT1oOmXpw+3puagz2o0TBoXK3C3ZQunkRsaZQOIOWRyMXk9h7f9
         oWkXbK5YcAaxHTsqYamYl4fwiKGFw4plyuQz20SFTO5P3OLVTBln9sKlb5dtOjab/8ik
         +m/k24EbUxcVMmHUfOUUTp/pbyMh1KEVEayCpKqOMS6Y7Wx1UR2ErKWE7QAXEX2ctNXK
         mLFXifWb/Ib6Ufxs80XPj6IZ/nlZLCYLn9u5HHLT5QCq+GrPOeChAyMfprvieUkKQdoZ
         Hr50vnJT0jZAmmW/sS4LAtNDl+pw6x2pwz5Ny+R58F3+K2kyMRs/2bqXB6ozyIoDthlS
         MIJQ==
X-Gm-Message-State: AOAM530oH2357FJNEFJseQqiGetROf9cRiGho+1rnosh+G8DIOhhWgtF
        W93IBLM1HMsN7ILlHPy2QMm4Nc40uvE=
X-Google-Smtp-Source: ABdhPJwUcBg20sv1BMiNK+xjujABK9kl1EU8KfxgWAaSxWLFvheK2xBVwol+F8h5YbSWRdavkaRJMQ==
X-Received: by 2002:ac2:4886:: with SMTP id x6mr3171628lfc.198.1591292873111;
        Thu, 04 Jun 2020 10:47:53 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id t19sm69600lft.47.2020.06.04.10.47.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jun 2020 10:47:52 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id z18so8354216lji.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 10:47:51 -0700 (PDT)
X-Received: by 2002:a2e:b5d7:: with SMTP id g23mr2537789ljn.70.1591292870888;
 Thu, 04 Jun 2020 10:47:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200603090429.GN3714@dell>
In-Reply-To: <20200603090429.GN3714@dell>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 4 Jun 2020 10:47:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgUg1v5hJ0D-tGnY4-YM2za+jtGQ2r2DG0Bq6OOxnMtHw@mail.gmail.com>
Message-ID: <CAHk-=wgUg1v5hJ0D-tGnY4-YM2za+jtGQ2r2DG0Bq6OOxnMtHw@mail.gmail.com>
Subject: Re: [GIT PULL] Backlight for v5.8
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 3, 2020 at 2:04 AM Lee Jones <lee.jones@linaro.org> wrote:
>
>    - Convert to GPIO descriptors; l4f00242t03

I'm impressed by that completely nonsensical device naming scheme.

I had to look it up because I thought that line might have been line noise.

I know some manufacturers and tech people have "issues" with naming,
but I thought it was mainly just DRAM chip manufacturers that used the
output from /dev/urandom to generate names.

Ass a few special characters, and it would make for an excellent password.

           Linus
