Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DF2C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 04:35:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D0AB20578
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 04:35:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sAI2u2w5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726204AbgHaEfl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 00:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgHaEfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 00:35:39 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F5E0C061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 21:35:37 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id w186so3620059pgb.8
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 21:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=icspKIQ1PkNAJTsI1t63T7zqqLLvN0pfo9ohQKHwF/s=;
        b=sAI2u2w5PWSlX52FmcryHfAvoeCFTuap75DsHLtQnmiADV733XENBiQs+j4DPt8B2r
         eqfKj+K2Vgh/Uf0+gpZ3cwLUNhsqc5Bcj8277YYxSHaXc7p5nVZFP592pBFt+AdNu1x9
         K7IwET7gDZxdVBK2///6HceZPwhcOk1US/f6Pdj1vWcfRy/5kf5gPErYwzByB/V2bJGt
         Hcfo1EZ2laKftr/LsNfG1I5R6fF9RFciPYaioZu71FrEYOqlIuhUX+5CV3idAl1HTbp0
         Z/MGxGWJFYQu4nmYcKWGfMtAZ3USq1sjYmlwGbEwSA3fH1FqmWIEtfMZLDE3UJhrlil/
         Hi1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=icspKIQ1PkNAJTsI1t63T7zqqLLvN0pfo9ohQKHwF/s=;
        b=Yp1wNWOHaoC0AqaQHuaWIEzKwJHUP7d3F0ts0QNpmX7dV5mC8yTJuk8m7/slpx3mQz
         3mzjXEkhVqYZrS6gNHnyu9zbtNEbHR2+C0ywg//5t22jIHwGxsPKo0LYlx1O3gWnsPtJ
         yfV8+Q/eKZMfh/nSNkPgjb5QTDLxwUqO4PJf903kvgsanWgiXAK9I8khM2aFgOP/trCt
         h5L9C3jnca9vuDo08biZUlpKyaUfOHbWashMX/O4iMvHQjm/B5Yzjc/NfvVmbwOBfEp8
         0MMUGciMPRYP5L4pLrrFKdo2LznpEBj6unFWQjS1WF+ROSSpFp7J+Y4Zy3lWlNgk5EfN
         54nA==
X-Gm-Message-State: AOAM532FYOll3Bx8PJ/ji4rsixJ3DAOyBJHO/f1RUd/F1hTIu6rFQE1D
        GzHbl5A4p+FQn6KHyuo7Cek=
X-Google-Smtp-Source: ABdhPJyHrTxe8NKfMuuY5xgg7xQCcQStiOBRt8sRSbruKNh8bZI1btUWlqDBb+fIrDEMs79eI+f5Vw==
X-Received: by 2002:aa7:95b8:: with SMTP id a24mr7639695pfk.219.1598848536811;
        Sun, 30 Aug 2020 21:35:36 -0700 (PDT)
Received: from Gentoo (sau-465d4-or.servercontrol.com.au. [43.250.207.1])
        by smtp.gmail.com with ESMTPSA id y29sm5840199pfp.141.2020.08.30.21.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2020 21:35:35 -0700 (PDT)
Date:   Mon, 31 Aug 2020 10:05:22 +0530
From:   Bhaskar Chowdhury <unixbhaskar@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Sasha Levin <sashal@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ..and its built and boot without fuss!! Linux 5.9-rc3
Message-ID: <20200831043522.GA32698@Gentoo>
Mail-Followup-To: Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CAHk-=wiD1yujm_WvWLYL7gZsWMvZyWMg1rfU7dWmnYYc3a7Gsg@mail.gmail.com>
 <20200830234659.GB8670@sasha-vm>
 <CAHk-=whBtfMQDm9YRzSG7xCvVKx6YMScJ-_P+=hCT31op-CVig@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
In-Reply-To: <CAHk-=whBtfMQDm9YRzSG7xCvVKx6YMScJ-_P+=hCT31op-CVig@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On 16:56 Sun 30 Aug 2020, Linus Torvalds wrote:
>On Sun, Aug 30, 2020 at 4:47 PM Sasha Levin <sashal@kernel.org> wrote:
>>
>> Is it possible you've forgotten to push? I don't see the tag/5.9-rc3
>> commit in your repo.
>
>Indeed. Thanks for noticing. Fixed,
>
>           Linus

Something trivial for your eyes!!


[    3.218031] sd 0:0:0:0: [sda] Attached SCSI disk
[    3.225776] md: Waiting for all devices to be available before autodetect
[    3.226313] md: If you don't use raid, use raid=noautodetect
[    3.226722] md: Autodetecting RAID arrays.
[    3.227221] md: autorun ...
[    3.227519] md: ... autorun DONE.
[    3.396336] EXT4-fs (sda): recovery complete
[    3.414304] EXT4-fs (sda): mounted filesystem with ordered data mode. Opts: (null)
[    3.416040] ext4 filesystem being mounted at /root supports timestamps until 2038 (0x7fffffff)
[    3.416733] VFS: Mounted root (ext4 filesystem) on device 8:0.
[    3.422032] devtmpfs: mounted
[    3.445402] Freeing unused decrypted memory: 2040K
[    3.530217] Freeing unused kernel image (initmem) memory: 1604K
[    3.530871] Write protecting the kernel read-only data: 26624k
[    3.535134] Freeing unused kernel image (text/rodata gap) memory: 2040K
[    3.536869] Freeing unused kernel image (rodata/data gap) memory: 908K
[    3.537595] rodata_test: all tests were successful
[    3.538160] Run /sbin/init as init process
[    3.716064] tsc: Refined TSC clocksource calibration: 2194.918 MHz
[    3.716766] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x1fa37202099, max_idle_ns: 440795206796 ns
[    3.717452] clocksource: Switched to clocksource tsc
[    3.769061] EXT4-fs (sda): re-mounted. Opts: (null)
[    3.769727] ext4 filesystem being remounted at / supports timestamps until 2038 (0x7fffffff)
Starting syslogd: OK
Starting klogd: OK
Running sysctl: OK
[    5.019294] random: crng init done
Initializing random number generator: OK
Saving random seed: OK
Starting network: OK

Welcome to Buildroot_Linux
Bhaskar_Thinkpad_x250 login: root
# uname -a
Linux Bhaskar_Thinkpad_x250 5.9.0-rc3-Gentoo #1 SMP Mon Aug 31 08:00:07 IST 2020 x86_64 GNU/Linux


~Bhaskar

--UlVJffcvxoiEqYs2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEnwF+nWawchZUPOuwsjqdtxFLKRUFAl9MfgoACgkQsjqdtxFL
KRXghAf/aT484AINKRTmc4AUD0rXXezr5c/+F0jn2DCSKGvG/oIjbwxov1O2ly8E
6ijqHAt3b+7pft8dTiE/U9aLUs1xIXutc7PIgoJQrlUHVGNSYwVD0KZDwy0m7pJB
K5ynbf9UYm0bK/u/05H//7lZwOO71DAqUxBCzoYx+mhsZxFm2O58rdmUVtq2JPe9
d53rLzXwppyvJI8GU6v9A5td8soQwFjvgDr6uQpdV5NTChjdyYjt2RisTVJll2Cn
rU0IjYGpw05iLrU7Jec/rr8uth9sEe01kOXSrfXpMv2JKvzm0gEAjG9kPSgBGu13
+LDT8qOI2BOPeiXVz7TkIuncgjvZeA==
=H0b8
-----END PGP SIGNATURE-----

--UlVJffcvxoiEqYs2--
