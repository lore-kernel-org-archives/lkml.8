Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6A3CC433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9740D2065C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 19:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QA45me19"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732938AbgG1Tlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 15:41:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732919AbgG1Tlw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 15:41:52 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E7D1C061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 12:41:52 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id m22so12649765pgv.9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 12:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=xAePtirog7IdAkYtDEnGYm+mRDcMeWjIOobv7EO/fls=;
        b=QA45me19PRN1AgIAcLPLUA2SmlfniO5PQjw90UuxM7WPdwz/L21Dd5QxYOdb2o9lRm
         FWgB10mj9BiYopMriQGrhFy537beytEtIJV6UReeJZqiMGlrZCZW5xgBeMIJ9wPNDYq+
         fYlfopXPkdJus7HYEgBDJeELtKrObkFjgL8UI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=xAePtirog7IdAkYtDEnGYm+mRDcMeWjIOobv7EO/fls=;
        b=Y7k8PVAF1hxNX+o0y7KDHBgSRApwOWWg43CjpCLQoI6OQaHj+6YA8SJbTPfmU0TVz5
         2ekV5gEHgEWgvqufw7Nh78ml8H6voAR/2hbLITL/7W3qnAJedOfIU/YIy5+4pV3tmAV5
         VDk7r5Zl+69zXm497uJlBZfMTNO2F8ugscrE4S+UDIr8cPmZwI9h1dkT3hF0nRWyMt/V
         J/xnppHO5mfUSsjADYrHJ1THtVUjlSz9h0W7G+hlIjArizm3mtPHXHG8tDENS4onpCXs
         64/kqbSVV+VJourdPcCu6WSZ19Hjxdr1aBmxOQ1hU74DdGwEOILR6JXwojwS7DWU87cD
         4kTQ==
X-Gm-Message-State: AOAM532ee7I+ERmZ6nEW/tv1gF+f4sjabR+yQyWvmG2awaCHXi63mQdd
        1jM2LpaeGAijQbXvG9sQBRXyiw==
X-Google-Smtp-Source: ABdhPJzw51teMkWyg/WSmUU/bmh78ycTkcPSDZmlOnRd5qRngoSAQqxe6niWrK4452ghk+zFg59GqA==
X-Received: by 2002:a65:6644:: with SMTP id z4mr26754018pgv.391.1595965311946;
        Tue, 28 Jul 2020 12:41:51 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id q17sm22182504pfk.0.2020.07.28.12.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 12:41:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200728091057.12.Iacab204f4164af12fa47206b98505bfbf8770cf3@changeid>
References: <20200724183954.1.I2e29ae25368ba8a72a9e44121cfbc36ead8ecc6b@changeid> <20200728151258.1222876-1-campello@chromium.org> <20200728091057.12.Iacab204f4164af12fa47206b98505bfbf8770cf3@changeid>
Subject: Re: [PATCH 12/15] iio: sx9310: Miscellaneous format fixes
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
To:     Daniel Campello <campello@chromium.org>,
        LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Tue, 28 Jul 2020 12:41:50 -0700
Message-ID: <159596531010.1360974.12485399142709122883@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Campello (2020-07-28 08:12:55)
> Miscellaneous format fixes throughout the whole file.
>=20
> Signed-off-by: Daniel Campello <campello@chromium.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
