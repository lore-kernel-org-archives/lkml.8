Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 408D1C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1813420853
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 18:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592417496;
	bh=8t+cz0yN10C64D8GNs6qcVMCF9t9chpMmDttvJFb9y4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=fOwE55bruDOun390fx58eTgxjwu0rCpduouMUwfpqrwDkGeBfPsnGbfxCqcwst9dW
	 jupaH/4jhIhpsUUrLF/L74yNuq2YsmLCZ//cg1Ts0yyqe1djRtCuHtdvIENnkW4oRr
	 ScePpf8/bGsMCU4llG13VjKYLqj49JOuhml1Pp/k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726927AbgFQSLf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 14:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726848AbgFQSLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 14:11:33 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1866C06174E
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 11:11:32 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id c21so1891969lfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 11:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1scwiVqFSoQM+nv9fKWp8C+XsxpCl4Oo1wUE/YKx3vA=;
        b=J2B32wbeiJo0WUrv9m9Mnc8Kf7in5IWq90sfyIc1vQCtA88X7S0oEFXhD+7FSOrtpm
         dyFgG+yw+XbrLx+2oZLW7w3Z/36VvxNH1l2h76WmhEyR0BMF3hXrSs45c9x/XwpoatKi
         a2eCeNccM5oUJviBP7m3F2LtFKJB7szJ7/Xus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1scwiVqFSoQM+nv9fKWp8C+XsxpCl4Oo1wUE/YKx3vA=;
        b=qj9FlS1QY9NR6GTUp6euwOUGMjVRk1aQPis5l5mtH/u34msSrfIKBkEkytK9K/oub5
         LJFN0fxfKqIbX9gAFB8KPJPmEeIwGg8iT1u1vpHK0zvZtqeeLHETVG/gKeGJz/TcvqEC
         Ls3H6p6gIeYAOv2Ayh9XvUtt5hJX/IrkPFUbtRUXLLXeB/zSRRu+wKBHASskMn2L0gS1
         V2bUkRFffMwFjmPiL/trs12mUURX/DCnX1rCeysgTGPij5O3nctJLew5kVFJXbsfukks
         YUQA67dPbswAuwGxEcbeHYIz+q/S6Seywe1TTq4/Mf4AZZZSKLtq+AO67X3IvfLG2sQd
         V7gA==
X-Gm-Message-State: AOAM530vriMSuoBH/HoBcojjq5BD7Cj0v9im/o86iNyhn6zIoa6zlWJQ
        bNb9QYtzgMEalPsWijdkMFQWfqOGkYY=
X-Google-Smtp-Source: ABdhPJxXTzuUHCps4iuSIL73lbGtRrHs3uBMFC/QSDP9d/ak4t14H3jdZ0OvmxAXRcJW6ipY4tlXNw==
X-Received: by 2002:ac2:46e6:: with SMTP id q6mr110804lfo.4.1592417491169;
        Wed, 17 Jun 2020 11:11:31 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id a9sm100687ljk.116.2020.06.17.11.11.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jun 2020 11:11:30 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id c11so1881428lfh.8
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jun 2020 11:11:29 -0700 (PDT)
X-Received: by 2002:a19:8a07:: with SMTP id m7mr94624lfd.31.1592417489553;
 Wed, 17 Jun 2020 11:11:29 -0700 (PDT)
MIME-Version: 1.0
References: <20200617073755.8068-1-hch@lst.de>
In-Reply-To: <20200617073755.8068-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 17 Jun 2020 11:11:13 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjrogXehrGA8zymnyhD8OLWu9i7r46BgfuqJ28b9Ke-VQ@mail.gmail.com>
Message-ID: <CAHk-=wjrogXehrGA8zymnyhD8OLWu9i7r46BgfuqJ28b9Ke-VQ@mail.gmail.com>
Subject: Re: rename probe_kernel_* and probe_user_*
To:     Christoph Hellwig <hch@lst.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 12:38 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Feel free to directly apply these patches.

Ok, locally applied to a separate branch, will merge once I've done
more testing.

HOWEVER.

As I applied this, I noticed that we have a lot of code of the pattern

        copy_from_kernel_nofault(&x, y, sizeof(x));

which is just an inconvenient and less readable way to write that

        get_kernel_nofault(x, y);

Also, some of the places that *do* use get_kernel_nofault() seem
questionable, and use a cast on 'x'.

I'm actually a bit surprised that we don't even get a warning for that
horrible pattern that smells a bit like the gcc 'cast as lvalue'
thing.

               Linus
