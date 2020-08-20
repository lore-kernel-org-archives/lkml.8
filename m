Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0584C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 18:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9734920738
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 18:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="O5SbuHAF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726823AbgHTSAt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 14:00:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgHTSAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 14:00:47 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA1AC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 11:00:47 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id m8so1420045pfh.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 11:00:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=/wa5x3tWumll3tJWqVpkUlIl5h1FhpMpXXXF7R1rXaU=;
        b=O5SbuHAFRJEmnF9HkFVw7MmE8KD8Vw+mXRjcSxGAVtXrHeHlMtBeWY8BvkwnszUFi2
         ucL1VXco2cnck1J+EuARc5ydJ6Nf/P0cVUp4L6gCIKqIGyeHdriNjQJ6LBSWQ2nL4cSy
         SffkIojCyJta6U8iakUCxfPRso1fzTAxfSLQpWp/zxuPsTYtbSU8eyNNmDxcVvh1NP9S
         a1GCeFyhotUS0znO6iQ5l3I8SD/t0f5QDW7boXGFI3Bv8KiUC9AWXBcdVVaW5UJ0pvAi
         XXVZOzwPAisOaZR6PDMIGmUBnBOXS2FSw8CQpiz1lz29tjcJjlzYOZu0vTad8mDxgZNt
         8g6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=/wa5x3tWumll3tJWqVpkUlIl5h1FhpMpXXXF7R1rXaU=;
        b=DwSBpvDYRdZjS3pQxul0Ljf69lx5BSok8JVYj611vjyeJZQ92UYFnwkJek3ap/sTiu
         61DYyI8qVVGEDl5oynxFwhcXpgafZ98LgY3yJvQ2ZA5Ea1bS/fwnKE4eSJKifDByqa3D
         if2hzTUo5RwN7lZzniMBHFmB3jVe0D1ptD+mI37vNlAA0ay/dG4yLsZ6MTPzDzSZDg92
         7od+JdkPcFI8gcnviDtaMHUhoDHSBOF5OKWSy7cy+uzoFEW0Gu1j7JYjkkOEJ/Smb2uG
         bP+6S02FVqhis5JEOKNsRh66IQeSKfYckq5W7hqNkcOOuoafhhAnYhQoJ3Pkr9x6yOXR
         flNg==
X-Gm-Message-State: AOAM533Ggd9AS761AtBBYRV5nIXDhgLqh2UrWzg4LN4+a9yDklZ86er0
        V7PWRNpXIo/+Lgg3dctT1Di+SA==
X-Google-Smtp-Source: ABdhPJzGDvPdCvENvuekxJsAl0zqGl3JCa1UKA8m+RUvx0Xz7xgrukvf+1RBmimjWdd8LErSILtALA==
X-Received: by 2002:a05:6a00:2247:: with SMTP id i7mr3105514pfu.217.1597946446560;
        Thu, 20 Aug 2020 11:00:46 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id y19sm3336332pfn.77.2020.08.20.11.00.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 11:00:45 -0700 (PDT)
Date:   Thu, 20 Aug 2020 11:00:45 -0700 (PDT)
X-Google-Original-Date: Thu, 20 Aug 2020 11:00:44 PDT (-0700)
Subject:     Re: [PATCH] riscv: Add SiFive drivers to rv32_defconfig
In-Reply-To: <CAEUhbmW6S2TG14w0smXQ6foZvmSfVvcdYf4kgkLwT9ivXV+m0Q@mail.gmail.com>
CC:     Alistair Francis <Alistair.Francis@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org, Atish Patra <Atish.Patra@wdc.com>,
        Anup Patel <Anup.Patel@wdc.com>, linux-kernel@vger.kernel.org,
        bin.meng@windriver.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     bmeng.cn@gmail.com
Message-ID: <mhng-33055009-35bf-4356-afdc-df546371b795@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Aug 2020 02:29:53 PDT (-0700), bmeng.cn@gmail.com wrote:
> On Fri, Jul 17, 2020 at 12:39 AM Alistair Francis
> <Alistair.Francis@wdc.com> wrote:
>>
>> On Wed, 2020-07-15 at 21:39 -0700, Bin Meng wrote:
>> > From: Bin Meng <bin.meng@windriver.com>
>> >
>> > This adds SiFive drivers to rv32_defconfig, to keep in sync with the
>> > 64-bit config. This is useful when testing 32-bit kernel with QEMU
>> > 'sifive_u' 32-bit machine.
>> >
>> > Signed-off-by: Bin Meng <bin.meng@windriver.com>
>>
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>>
>
> Ping?
>
> Is this patch applied anywhere? Thanks!

Sorry, I must have missed it.  It's on fixes.
