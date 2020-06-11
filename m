Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 944B4C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 19:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 744B8207ED
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 19:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=android.com header.i=@android.com header.b="fG2f7RD3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgFKTr2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 15:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgFKTr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 15:47:27 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B37C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 12:47:27 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id r2so7749395ioo.4
        for <linux-kernel@vger.kernel.org>; Thu, 11 Jun 2020 12:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=android.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JrOL277zrafU33/T667ymrrO3F/cxCPQRMCQNDYvGqU=;
        b=fG2f7RD3K1uLCT3H1yUOpg/2k4gTC2W3mclS+KruzZt5IZ8lrz2QNyiktefCjJCZer
         IAl+Lq34Z/HHUGdBerEenMW/ivdayxYDc9Yauqpr2rEAP3jlg5x4pxiusA7qqYSRVdj8
         YzXHF8ccWhwatXkvfTMln8+D89ENDSsoaVSPIZE9e7BDvr4SYpG7nTFdYSszyWRkg8VG
         jxzN0nrZv4uKypUeYaYIeDMIY0tjpfM3EmPVgVe3hQaLvD36yqWAD6rc7xn0INXS4j7D
         1SxxCVAlL1MZf+8V6pRRaplT2JuItr8L/9pPWSJZkNdOAY84Wq5z8fJVAbEZUsipC/0+
         HBVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=JrOL277zrafU33/T667ymrrO3F/cxCPQRMCQNDYvGqU=;
        b=MAfiSzFJyPuUZK3MJ0Hv3BPwIt40u9Tfam/fAUg2WiBwUkdtwCQmKgItTzdcbuXJHj
         g4V7+0v25C6h+ipPJIaQ7J/nETi8TjzX1kJGASy1dvEYOi+WnPqIt+vupJ7NlXnyG3tw
         LRtkvAvnFooKQxm72ia6L8TBPqlNA36hDZ5la3VRby/Nnbf6bC4iIveRbSTktZcD9QGf
         mBjinmq5Xg13X3By54a0P5qYzljJm6UPq5NgAWWtqJNFnDyCtYEU9fd8huffRIgXXgUi
         XKMnBTSt1VmpT8Bpzap4fZsOfbdQRKn6vhqvN4HWNzuG65vaGaJFm4Xr3v/AW8G5p0/G
         W7Ew==
X-Gm-Message-State: AOAM531pxEBKC/KCDOCkAqkB/wcSwZWXRvHaRK4r1xJ0EMoQY381eCMa
        Ru/CZOXfBYwfzyKjly++V3Q4wg==
X-Google-Smtp-Source: ABdhPJyguEAJSNVqVHBd5o79x1osBKISIm+KzMiBu7vz9h0p37SZp/IFjJg8utwvzTplNWH74B8djA==
X-Received: by 2002:a02:ce8a:: with SMTP id y10mr4861586jaq.136.1591904846868;
        Thu, 11 Jun 2020 12:47:26 -0700 (PDT)
Received: from ?IPv6:2603:9001:e08:d902:1d3d:b900:272a:b9ed? ([2603:9001:e08:d902:1d3d:b900:272a:b9ed])
        by smtp.gmail.com with ESMTPSA id 13sm1983056ilg.24.2020.06.11.12.47.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jun 2020 12:47:26 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] lib/vdso: use CLOCK_REALTIME_COARSE for time()
From:   Mark Salyzyn <salyzyn@android.com>
In-Reply-To: <878sgt1jo2.fsf@nanos.tec.linutronix.de>
Date:   Thu, 11 Jun 2020 12:47:24 -0700
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        Chiawei Wang <chiaweiwang@google.com>, stable@vger.kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7147FC30-F9B4-4261-B2C1-08688A4E0D2B@android.com>
References: <20200611155804.65204-1-salyzyn@android.com>
 <878sgt1jo2.fsf@nanos.tec.linutronix.de>
To:     Thomas Gleixner <tglx@linutronix.de>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jun 11, 2020, at 12:34 PM, Thomas Gleixner <tglx@linutronix.de> =
wrote:
>=20
> Mark Salyzyn <salyzyn@android.com> writes:
>> From: Chiawei Wang <chiaweiwang@google.com>
>>=20
>> CLOCK_REALTIME in vdso data won't be updated if
>> __arch_use_vsyscall() returns false.
>=20
> Errm!
>=20
> # git grep __arch_use_vsyscall
> #
>=20
> Aside of that update_vsyscall() updates CLOCK_REALTIME data
> unconditionally. No idea what this patch is solving.
>=20
>> Cc: stable@vger.kernel.org # 5.4+
>=20
> This # 5.4+ is pointless. You really want to add a fixes tag which pin
> points the commit which introduced the wreckage.
>=20
> But thats moot as this is not fixing anything not even in 5.4.
>=20
> I assume this was developed against some Frankenkernel which has a =
messy
> backport or a snapshot of some development version of that vdso stuff.

Yes, problem code was removed with =
52338415cf4d4064ae6b8dd972dadbda841da4fa not applied.

4.19 back port without time namespaces, chip vendor using =
__arch_use_vsyscall to solve a chip errata.

>=20
> Not that I want to know, but please make sure that something you send =
my
> way makes sense on sane kernels.
>=20
> Oh well.
>=20
> Thanks,
>=20
>        tglx

Sorry for your troubles.

Sincerely =E2=80=94 Mark Salyzyn

