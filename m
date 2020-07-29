Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75AEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B51002076E
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 08:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="W/NNhbO1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgG2Ii6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 04:38:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726737AbgG2Ii6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 04:38:58 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33AEC0619D2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 01:38:56 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id t6so11505459plo.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 01:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=HbtJE63+eO8A7hJIYpadhjS7rkPV5HGagSVTfU+DbFQ=;
        b=W/NNhbO1UHWwgBubTrG+vvCvJWc3ROwi3sun459A2CESXYwYFM9TussMxojmXwp6RP
         BddeN0djhDJlRYMsXk1FpzwXIOSFQCST/Jxp3NfHEmSuliDqGq+RO62ZgCjv/I4kZDTy
         LiJV6QOGKrhLhxhlJCSEdzatM2lEg2G4SJ0fk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=HbtJE63+eO8A7hJIYpadhjS7rkPV5HGagSVTfU+DbFQ=;
        b=J6JDaAYOi7rPF9qW/96RuDQthCg/a4YWZO7ey6xYc3TR8kEkela1NSjthaOgGInMyJ
         3ni/8M2fcTKFm0FF5V3BEGsOE97oP9J0w4V2CJHqC76hTPfXVm6+xM5zASS3dN+2jIzs
         PJf0nQ1az5/qyDsk5XN7Ki8a9iNgJXIzjCbIIzlsml6gCCIb/MpzWxKe6cTISa6Ipz5N
         weNI59bjxkEEaRAoVxbEd7rcqaLPTKQI0xzVwbQTswxDQnOwlbCHioPbCvJnAvGOX9tp
         2mrmq8Mf5980GP5Vg1EwnKO8OZpu/WiF8rZUT4HypbFFRVGPTkgOA48K1jajCCxjkTuj
         YuXw==
X-Gm-Message-State: AOAM530Y5JjXA8Yi0FaQAUpbxKU74qZd+AnPznw+IdA4A7xZ3uCN5NUE
        E/H2FwJ2SVVbXOdTdGX0quGIxQ==
X-Google-Smtp-Source: ABdhPJydymo0wEUaSrTPX7MFw0FkDuVjogsdoOwK7zJwZa3jI6qPQwQePOSbT+8zQ7E9z43dmd+qvg==
X-Received: by 2002:a17:90a:1f81:: with SMTP id x1mr7911944pja.115.1596011935538;
        Wed, 29 Jul 2020 01:38:55 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id c9sm1394247pjr.35.2020.07.29.01.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 01:38:54 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200728170317.v2.4.I9bf713a86d6076b44441ef5f534f9c240271699a@changeid>
References: <20200728151258.1222876-1-campello@chromium.org> <20200728230520.2011240-1-campello@chromium.org> <20200728170317.v2.4.I9bf713a86d6076b44441ef5f534f9c240271699a@changeid>
Subject: Re: [PATCH v2 04/14] iio: sx9310: Remove acpi and of table macros
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        kbuild test robot <lkp@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
To:     Daniel Campello <campello@chromium.org>,
        LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Wed, 29 Jul 2020 01:38:52 -0700
Message-ID: <159601193272.1360974.2787015814101675037@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Campello (2020-07-28 16:05:10)
> Avoids unused warnings due to acpi/of table macros.
>=20
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Daniel Campello <campello@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
