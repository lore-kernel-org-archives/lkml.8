Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 735E3C433E2
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4294B207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 17:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599068323;
	bh=KlV02z6S2xgqGsrziNdl5zoh9YB7F4+EIBkqv87ROCU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1froKqwfgzrdFQ2S/zeIN1R8KoOCIC573x9/4V1kBaJGTZoJa6YX1+ift2ENBdZ1B
	 llYmJ8k3L/ry+T0HL8HqpM8tupah0UoqejWtO+96JZ36K9HOPEqaqOilYWfRp1FzlF
	 LyPR3mg5ij2rEtIPJ3GVTaj2jgB54nmCD5vbVKJM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgIBRim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 13:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgIBRik (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 13:38:40 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283B3C061244
        for <linux-kernel@vger.kernel.org>; Wed,  2 Sep 2020 10:38:40 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id a15so172638ljk.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 10:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bAvdft8+S1rZVb+XWy3BCqgxnHRNNa2SDfjHvpH4oWM=;
        b=A3VsMK5sVlaPbroGUMy0HC1Urc/X3LNKds2FtWEhJmFKYfhGz6/jva069NPpmlKRl+
         IcL/zalYcCFdZEGiS9JJ/qFBvcNfPk9LP5FvWE8w0TYOpAUzyr4eeRk19c0ahMW4KZmM
         NS405TTlkh3+F1YpyKnRnGkamw0XOxqS/vAyo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bAvdft8+S1rZVb+XWy3BCqgxnHRNNa2SDfjHvpH4oWM=;
        b=eT//QMbE5aUTSIMUYZBPaMlqIMln6BiLTaTNvSSNQD9dIlUzpP9AjlvAlWU9vmbya1
         MTSVEqH9CWABKPb870lkBnnXsXhghiMv0VLJYnGhvGW9G8Fz2+NfEblwLvm8sYwM41p/
         EItBYvUt1ec41wROIw6fnB+RFp3qI1NY1EHGPBMb0S1zEaQLg1iu4hW3Vd9eA0yUFVwG
         lFp+xfVToHz1wqHCbhWoqtYifLCbdeqDnCAh8Rz8O85Zc5Meqy83fPlF/DM9Grrx3p/Z
         irRu1w4mfKy7FxPH7nYqRiJCLyMWBt6G4+83toE//scqg4pDRqEr5haGOdPXtZoIKP49
         oTTw==
X-Gm-Message-State: AOAM533yWAKzwhdDXWQPIwT7rnQiWQbfnx99Mhb/rWUOx1l5SE10F8Y3
        pmmas3GVnh1QLTCTFKKSo/wjNHYCfyg+qw==
X-Google-Smtp-Source: ABdhPJxqQc+f2m3rXKZn4JNaElDEWf4x4vhCpr4xzFJURBeTi8ViYlpPoGZVr7GwOBfDiQhe/uNFCw==
X-Received: by 2002:a05:651c:1392:: with SMTP id k18mr1573665ljb.445.1599068318199;
        Wed, 02 Sep 2020 10:38:38 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 25sm53277lji.130.2020.09.02.10.38.36
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 10:38:36 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id w11so271870lfn.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Sep 2020 10:38:36 -0700 (PDT)
X-Received: by 2002:a19:7904:: with SMTP id u4mr3838509lfc.152.1599068316104;
 Wed, 02 Sep 2020 10:38:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200902085513.748149-1-leon@kernel.org> <20200902085513.748149-2-leon@kernel.org>
In-Reply-To: <20200902085513.748149-2-leon@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 2 Sep 2020 10:38:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiOJ4H=YFO8+EumOcrciQgeKXY1Z92jdqY8OQdprPXkbg@mail.gmail.com>
Message-ID: <CAHk-=wiOJ4H=YFO8+EumOcrciQgeKXY1Z92jdqY8OQdprPXkbg@mail.gmail.com>
Subject: Re: [PATCH rdma-next 1/4] gcov: Open-code kmemdup() to work correctly
 with kernel and user space pointers
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Peter Oberparleiter <oberpar@linux.ibm.com>,
        Leon Romanovsky <leonro@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Colin Ian King <colin.king@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 2, 2020 at 1:55 AM Leon Romanovsky <leon@kernel.org> wrote:
>
> The kernel with KASAN and GCOV enabled generates the following splat
> due to the situation that gcov_info can be both user and kernel pointer.

I can't parse the above explanation..

> It is triggered by the memcpy() inside kmemdup(), so as a possible solution
> let's copy fields manually.

.. and I don't see why copying the fields manually makes a difference.

Can you explain more?

             Linus
