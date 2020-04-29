Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C785BC83000
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C856206D6
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 19:37:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cbhpgvq8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgD2ThN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 15:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726423AbgD2ThN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 15:37:13 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEF0C035493
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 12:37:13 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id p25so1553566pfn.11
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 12:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=ALQ9L4ip5teEGArOsIw3F/vjHI6JI+8X3RjJXcvMc04=;
        b=cbhpgvq8Wbr8kre9ifPGoKGhC4tbV/W87QbZoZDbvQ2aK1XpIpamqmE/dMQYSeEuYG
         eIb8Y7C0jmEXHWrIUnY7Ijad0pdoEBodXbQOItW9vxN4yrqKUGMituN7A/ffu/w6ESSm
         RFG/AEDmTalpuKqqc//VHeV3tKflkdNImrpJc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=ALQ9L4ip5teEGArOsIw3F/vjHI6JI+8X3RjJXcvMc04=;
        b=Xjo2sQD86A/S5sWykUN3krK9FLCqauSYXD5hVHz5kgNJAm72N8tb5ked8XmurTZ248
         Z49QgH1lWVp3ITwJeqRk1JqhIMFSASGToheBOpFcZ95E97Plw6nsypu0cLXoy779CnuZ
         nebXXqgge8mp/LVPtQNxFSns0Vj29elT5fp9npUhv6H8b80nx59HyEYdKRej4S9edqOV
         E/jZAM6k2pADpNqHl6w4yUOW/Y5uwSO75fQh1fFmhRIX80a1FVK71LrgPx9SOJAeQZJR
         3NlSB+ZhXRSYyA6qxG9ItxxBpZ8SykzpdeAKvMNz7Zf56ROdWLOMMKxjKJhZSHy/xNwK
         mQ1g==
X-Gm-Message-State: AGi0PuYaeJNxjpPmgDfopFN52jJYangrlWrzDHWrWrt6454/wdxsS+ZN
        jgUEf/cZYc0l3LzP9U7pxyE2FQ==
X-Google-Smtp-Source: APiQypL7rYwKTOTIgKWUVTp0IZ1MV9gTpk2Rq5/Do+A5yp0rEM77W/kD/fBtuMZ6Sg+AkTV4IlCacQ==
X-Received: by 2002:a63:1d4c:: with SMTP id d12mr35525838pgm.247.1588189032757;
        Wed, 29 Apr 2020 12:37:12 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id f64sm83511pjd.5.2020.04.29.12.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 12:37:12 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200429085753.3277336-1-arnd@arndb.de>
References: <20200429085753.3277336-1-arnd@arndb.de>
Subject: Re: [PATCH] firmware: qcom: avoid struct initialization warning on gcc-4.8
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Rob Clark <robdclark@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Andy Gross <agross@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Elliot Berman <eberman@codeaurora.org>
Date:   Wed, 29 Apr 2020 12:37:11 -0700
Message-ID: <158818903103.117437.15808156977430139077@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Arnd Bergmann (2020-04-29 01:57:33)
> When building with old compilers like gcc-4.8, a struct initializer
> can warn about invalid syntax:
>=20
> drivers/firmware/qcom_scm-smc.c: In function 'scm_smc_call':
> drivers/firmware/qcom_scm-smc.c:94:9: error: missing braces around initia=
lizer [-Werror=3Dmissing-braces]
>   struct arm_smccc_args smc =3D {0};
>          ^
> drivers/firmware/qcom_scm-smc.c:94:9: error: (near initialization for 'sm=
c.args') [-Werror=3Dmissing-braces]
> cc1: some warnings being treated as errors
> drivers/firmware/qcom_scm-legacy.c: In function 'scm_legacy_call':
> drivers/firmware/qcom_scm-legacy.c:139:9: error: missing braces around in=
itializer [-Werror=3Dmissing-braces]
>   struct arm_smccc_args smc =3D {0};
>          ^
> drivers/firmware/qcom_scm-legacy.c:139:9: error: (near initialization for=
 'smc.args') [-Werror=3Dmissing-braces]
>=20
> Change this to use the empty initializer extension that
> works with all compilers.
>=20
> Fixes: 590e92809a58 ("firmware: qcom_scm-32: Move SMCCC register filling =
to qcom_scm_call")
> Fixes: 3f951ea627da ("firmware: qcom_scm-64: Move SMC register filling to=
 qcom_scm_call_smccc")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
