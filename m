Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C0EC433E3
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:25:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B27320720
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 15:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594394757;
	bh=E7bi5cy3w25+v+ynNxQyZalJkXNksuEnqKkt/DxyBoM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=aZMEy5aVD5xFniQqkpOTmL5VxMp+zqRxs3vcBuW/1541b4axsToYl4/wwcy7K0LOV
	 RyFKIer4FAvIpDSkQYDXMMOtsaHXmx/1ySYJwP3P9X/fIZasnsBbCXPBH1SeVcKbng
	 b20YV3XPl2rXO+68Wmd3xNDHXPFVoMySIuvyEgG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgGJPZ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 11:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbgGJPZz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 11:25:55 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31E5C08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 08:25:54 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id k17so3435505lfg.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 08:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XI4AkRHvZrR0Ew7WpXi3OZzQZHVgyOG0so02CQsEE3M=;
        b=Mak2sf3wWVCDN414GX6oHTPld7bJlpmLqrG6bZhvvHH5T1znpXb6u3eHn8BmbMVF+Y
         ds/EyWXY0dD4gBcMZ/gDxgBnK2vyamBCukZjC5DfW83iNLTqsavE5ce6GoriDZi9axdj
         QYdrRPQcQGcNIl30F45Lsgp9hSW8E0/NOQjY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XI4AkRHvZrR0Ew7WpXi3OZzQZHVgyOG0so02CQsEE3M=;
        b=hFIy2NnunWI02Q5qJv9P8oOivy53XjqaM2App8IpsYWwjCYNKIprELO+fjT18OsGvA
         uOLKYExeq28BIDMvRGBkdfpxBCxLszF4+JXjtG8LzZjH9jykeuuMdnwGqyl2tSW4pJdy
         XPo3+Ub/kZ0qBWzSZ4qv+lOxZhJXCrv+Ar+fIiaGBidbjgWBw793Jhcn5tc+CJ6xHxqw
         p+bgpEGPO4BIiWfV1+zvYZVAaow535zsCHyJu4nGM0C1cDSZ5lZonDkVPrB7+vIi3w0x
         ZagcudZya8+zgyLo47879dC5hMoI15xrWM05MRhvqihne+OUDfSoEzNV+FlxaB76m0s7
         OPYg==
X-Gm-Message-State: AOAM5323VZm8Lgs75jyKdP7UA0G/ByQAZTVEUQOWR/bzdyai2mN9AOIt
        2Sab4QbELFqG0DHwHWCw8vrb/ZTGgHs=
X-Google-Smtp-Source: ABdhPJwGKR2dUJGG5OrrSsAjUxrfeYuyDrqgSpAv+wGL5KnsjmXKhQtInR2iCZiLmTMVPCui9cF+tw==
X-Received: by 2002:a19:14e:: with SMTP id 75mr44137601lfb.7.1594394753068;
        Fri, 10 Jul 2020 08:25:53 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id h14sm2004128ljb.53.2020.07.10.08.25.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Jul 2020 08:25:52 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id q4so6941564lji.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 08:25:52 -0700 (PDT)
X-Received: by 2002:a2e:9b42:: with SMTP id o2mr39413534ljj.102.1594394751710;
 Fri, 10 Jul 2020 08:25:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200710135706.537715-1-hch@lst.de>
In-Reply-To: <20200710135706.537715-1-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 10 Jul 2020 08:25:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjGjwtgYJvLOd5aO2dWyPsC-6ED2Hthoxm1Eerf-Ahd-w@mail.gmail.com>
Message-ID: <CAHk-=wjGjwtgYJvLOd5aO2dWyPsC-6ED2Hthoxm1Eerf-Ahd-w@mail.gmail.com>
Subject: Re: clean up address limit helpers
To:     Christoph Hellwig <hch@lst.de>
Cc:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-riscv@lists.infradead.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 6:57 AM Christoph Hellwig <hch@lst.de> wrote:
>
> in preparation for eventually phasing out direct use of set_fs(), this
> series removes the segment_eq() arch helper that is only used to
> implement or duplicate the uaccess_kernel() API, and then adds
> descriptive helpers to force the kernel address limit.

Ack. All the patches looked like no-ops to me, but with better naming
and clarity.

           Linus
