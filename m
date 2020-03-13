Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06228C2BB1D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:37:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB8D3206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 14:36:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eId94T6a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726594AbgCMOg6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Mar 2020 10:36:58 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:36036 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgCMOg6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Mar 2020 10:36:58 -0400
Received: by mail-lf1-f45.google.com with SMTP id s1so8078266lfd.3
        for <linux-kernel@vger.kernel.org>; Fri, 13 Mar 2020 07:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=mgh/LtawAyvtzo4cEDEYIHcPGiQwM8KZegFqOkKa+BY=;
        b=eId94T6axz3/a2w6OrytW+1TJV06pQ6vCwYZc7fT1UDsv0xse5UukW+83WS19sxUF0
         h5GyfS7fZE6Fw/zZF+n8v7Ee/2pq6zhTixijCSI4DIc23tUiGy9fFSIJV2LV0VbqUFQr
         1b2dTBt587iHOvXIZRSPEQz+PkH40xvLtIAtkHZeqUqsMJD27f0PgPjRkZwQytPYz5jF
         f+hOK53jia9RMUFJqfv+Vq/PpMWZDlNXI9oiuywpfH8Vjqc4KLYJE71F4UK52LWsw3c+
         /wKML9ELR41LCt41AidEfttjpdxUf4NwR1KvV9Pl4Vybc8bzfRl7s5M0qe0ht3bRaZud
         UElQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=mgh/LtawAyvtzo4cEDEYIHcPGiQwM8KZegFqOkKa+BY=;
        b=tr7+yNm5tgRBVvVtDoXS9wQ8CZwl8RNXkCSIW4fC0WmR+vaPxKm7eg4dbJl83EkSTz
         dN/ZrHBpqe0uiZaSC7kxbugGLJ4XjvkFG0P3I8PsFvvasILmaukVE1bN6gpTuu7FNjo0
         RGM2F3KV+FX/Dhp7FLAUyuqjZzUPJ3U5qeKQeH4QTaH8/rctMBDkuK2ruGsJgO3PJYZM
         ZYinY6aiDyvIsVbm6lejY+mzZHX/pCIpkcnE51+Q98SxRDitwYPSX/e9xT13A8UpZ8G3
         nNoBBXGc2/akRz4MYa1WJv/5pGybDQQxBqqFqhOMDzuEDkS7HtcmvIFTjM6TXpC8erKC
         SKvQ==
X-Gm-Message-State: ANhLgQ1kNmGx+UIk9ba8Tr1JsKu3yZSCJeVtvn9lBQHsYXtt+NrZZoTk
        uD9QaBc2ZSMOl1ivm+E9ULLc09LF8lRH9csDSWxW627NntMf9g==
X-Google-Smtp-Source: ADFU+vtpi7SjAlNDkLzhS+6D+P783QQKHNf3Rqik1y/mFUVrj4WEJxPwQ3nUjmXyNDd/1759jAKsuhXafhkRvGazGQI=
X-Received: by 2002:a05:6512:3188:: with SMTP id i8mr9084499lfe.26.1584110215584;
 Fri, 13 Mar 2020 07:36:55 -0700 (PDT)
MIME-Version: 1.0
From:   Naresh Kamboju <naresh.kamboju@linaro.org>
Date:   Fri, 13 Mar 2020 20:06:44 +0530
Message-ID: <CA+G9fYvTmoge3esSO-gDU=jLwun-f8hs9-CgXUdGaysVge21Hw@mail.gmail.com>
Subject: =?UTF-8?Q?include=2Flinux=2Fbitfield=2Eh=3A131=3A3=3A_error=3A_call_to_=E2=80=98=5F=5F?=
        =?UTF-8?Q?field=5Foverflow=E2=80=99_declared_with_attribute_error=3A_value_doesn?=
        =?UTF-8?Q?=27t_fit_into_mask?=
To:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     lkft-triage@lists.linaro.org, elder@linaro.org,
        "David S. Miller" <davem@davemloft.net>, kuba@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following error noticed while building linux-next kernel modules
for arm64 with CONFIG_ARM64_64K_PAGES=3Dy

# make -sk KBUILD_BUILD_USER=3DTuxBuild -C/linux -j16 ARCH=3Darm64
CROSS_COMPILE=3Daarch64-linux-gnu- HOSTCC=3Dgcc CC=3D"sccache
aarch64-linux-gnu-gcc" O=3Dbuild modules
#
In file included from ../drivers/net/ipa/ipa_endpoint.c:10:
In function =E2=80=98u32_encode_bits=E2=80=99,
    inlined from =E2=80=98ipa_endpoint_init_aggr=E2=80=99 at
../drivers/net/ipa/ipa_endpoint.c:544:11:
../include/linux/bitfield.h:131:3: error: call to =E2=80=98__field_overflow=
=E2=80=99
declared with attribute error: value doesn't fit into mask
  131 |   __field_overflow();     \
      |   ^~~~~~~~~~~~~~~~~~
../include/linux/bitfield.h:151:2: note: in expansion of macro =E2=80=98___=
_MAKE_OP=E2=80=99
  151 |  ____MAKE_OP(u##size,u##size,,)
      |  ^~~~~~~~~~~
../include/linux/bitfield.h:154:1: note: in expansion of macro =E2=80=98__M=
AKE_OP=E2=80=99
  154 | __MAKE_OP(32)
      | ^~~~~~~~~
make[4]: *** [../scripts/Makefile.build:268:
drivers/net/ipa/ipa_endpoint.o] Error 1

ref:
https://gitlab.com/Linaro/lkft/kernel-runs/-/jobs/470723504

--=20
Linaro LKFT
https://lkft.linaro.org
