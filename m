Return-Path: <SRS0=EnQK=B5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C968CC433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 16:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95F7B20888
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Aug 2020 16:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=vt-edu.20150623.gappssmtp.com header.i=@vt-edu.20150623.gappssmtp.com header.b="zi70vTmI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgHSQo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 12:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgHSQoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 12:44:00 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB67C061757
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 09:43:57 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id x6so11579999qvr.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 09:43:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vt-edu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:in-reply-to:references:mime-version
         :content-transfer-encoding:date:message-id;
        bh=0FKn00QVGSGZGvzzGq5zZbshXD6THMt1eiRTK0I5NyA=;
        b=zi70vTmIohlONEz0RTLrpFHIpywb+ao+U/kjAvC3hlajYODpIRd8EFitZhDyWHUz8U
         JtnQU5XTTCAFSIOG4J9n+4x6jC7yqXLCiaRjS1dWYLFJ4TtMIKtWA/GRgNF9+3B+bfvZ
         nSuVaXoEeITbkEQ5uUiAlNQXwNHW99z5OfYdZuBKpnaUfHMEzCYilSWkTo0/UPBtsrWp
         EQV82Esr/LrFdekqPQpYBgCAQ40JBFFrXUwhurtzk7/hOBPqWxKr0uKwgbG0721vAQF3
         uIWa6vxsqMdzcSccC7zLoICFfLV425ZnQVeC/p2dCXDxf2+9+Cjok+bTaMhSqVw5zORi
         0Qrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
         :mime-version:content-transfer-encoding:date:message-id;
        bh=0FKn00QVGSGZGvzzGq5zZbshXD6THMt1eiRTK0I5NyA=;
        b=aNlzikfsfrS569RekyaQHwG1+XKJ1a1Q0yI8EwsNzsLvsB14h/qLCITNWQoqbS66rC
         7dOe1VGjzkICe9Ez/f3FA+dFjeFretSs9viyNpGvm7SM30YAc/2p970OgRomQGN/BYC1
         u6XpPyNDq/6QoM4c9J6Rc/tQjQB2HNhlgQY0nYVTlVLBDG+JckouPF6zTkzBDim+V85b
         BXmdfyi5XsZsKDpZteL3CcRJKsAMlXeo1iQNGt0dtkL1Oo7TZWEdPIOJ57TOrN5I03mP
         jPUGtfE9kuqs4Dhv/6LpcSBSd0u6OvsNOXDmN122CVGZH+/kxTtR/BLYay0CycE2qw8H
         gVyA==
X-Gm-Message-State: AOAM532TCNoc9bgal2mlsdGIdGBsDjry/NLTvKMC2K9UWAxrbZXXc0QU
        Ib8kBYMeqiU78W21qV13WTRmng==
X-Google-Smtp-Source: ABdhPJyw6CQHRMMPCXk2F8RdHZtjVhvrN5o3Qthobt3zaRLyJNvR6hGklLAYBCpwMW3EFXPUXkkWbw==
X-Received: by 2002:a0c:e1c6:: with SMTP id v6mr24840269qvl.45.1597855435073;
        Wed, 19 Aug 2020 09:43:55 -0700 (PDT)
Received: from turing-police ([2601:5c0:c000:a8c1::359])
        by smtp.gmail.com with ESMTPSA id o39sm28681329qtj.0.2020.08.19.09.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2020 09:43:53 -0700 (PDT)
From:   "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To:     Greg KH <greg@kroah.com>
Cc:     Muni Sekhar <munisekharrms@gmail.com>,
        peter enderborg <peter.enderborg@sony.com>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: Scheduler benchmarks
In-Reply-To: <20200819104254.GA41946@kroah.com>
References: <CAHhAz+inPwKYx_4qaujQ=bGG9twashiuqLhQQ-+vgHWF7FLhRA@mail.gmail.com> <20200818143633.GA628293@kroah.com> <CAHhAz+hG5kS5rhph4SaSLOEc5PgcSOTPWpiANLNpwotY9Zy6qQ@mail.gmail.com> <20200818171457.GA736234@kroah.com> <CAHhAz+ggd4DPFfWPB+h6Obkjebf5mv5cV6307oKEkEYMhAB3wQ@mail.gmail.com> <20200818173656.GA748290@kroah.com> <CAHhAz+hi9rh5w8hNyas0RkO4WwZXsSNh5g0nS710NSr6-ntioQ@mail.gmail.com> <84362b8b-971f-fb89-115d-41d2457c24fd@sony.com> <CAHhAz+iC_F5w5EoZP8-dBNm+DV0uNMva6Mr2uBdmZtejL1OH-w@mail.gmail.com>
 <20200819104254.GA41946@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1597855432_10889P";
         micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date:   Wed, 19 Aug 2020 12:43:52 -0400
Message-ID: <135393.1597855432@turing-police>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1597855432_10889P
Content-Type: text/plain; charset=us-ascii

On Wed, 19 Aug 2020 12:42:54 +0200, Greg KH said:
> Look up Spectre and Meltdown for many many examples of what happened and
> what went wrong with chip designs and how we had to fix these things in
> the kernel a few years ago.

And I'm sure that nobody sane thinks we're done with security holes
caused by speculative execution... :)



--==_Exmh_1597855432_10889P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBXz1WyAdmEQWDXROgAQLvYA//Zid3mkIQtxFpwWwthIpN8HcojKM7Z2T2
oY5BiorcBXMPsBYbsHQwP6b+07rHu6O5SDGQ/x62cS7CyrvbO7bdBhOdqp52zPpr
E70nhNcTnk73nJhw/s/JzxvdlfCTvBAw2JcASZ1ySU2fobeKAfm0CVnphtVZJT/i
3yOGQIuPL6fsycHJyiyLn5zGkFxIH/XtmB743hsUZUpEYfCbdGoAJaxrcI0jpAnj
mO4uzsryTtcS84d2o0xiHViR3tC8v+J0Qayv5Tm+e8zgzsDXukjsxMc1efqCaWON
NVhno9tUAq8AtE2JVHNpgNpgWU39+H0/rhvlTRIIBN+S+zM1G/tne9FeCPJSX8A3
nw9WYnqcLR/j3OTO0sv91w7EhLHxE+IJa3bNN8Xr2+dDmG3eULd1wYAK8a891QzL
jkKzxvAJFhan/IV3Szrp+d/8LwlQMxGiKx8PQjAREFwAZgMI1c5AFAzQf+weAm6A
o/Fp+22xQJ/2cuam5AXrPNkmRNG33rOWdRoIc6JV6MW1uKXBWQ8pfOfpeVzK0Cy+
Mvuk8S44zoCORLt+ExO0kGUmNX33SbsPhCI4Badcv8qzQ1zsF8T1sH7ZBhxCXzme
aGXI3DRkyxQD/3eFkLNzV4cpYKTb5gf8VS1QDoVGhOMepyz73TZLENHr71Ri9KYt
pCcVMLn6+Tw=
=NfwL
-----END PGP SIGNATURE-----

--==_Exmh_1597855432_10889P--
