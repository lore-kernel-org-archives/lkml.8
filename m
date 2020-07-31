Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC246C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C46BA208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 18:39:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SxedLiBl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387922AbgGaSjD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 14:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387676AbgGaSjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 14:39:02 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39289C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 11:39:02 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id w2so16463909pgg.10
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 11:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=2MAGMbg0u4EzY9Z9l4p+/acHke17WcznMZEaZyHXEcc=;
        b=SxedLiBl70jRZgMjL09LTz6KF3exiMTYiXug7VW80+AgMWc1+ohGWOj4p/CTBnW88j
         VtLRgmjdCcSbDPVnYwXnwfz0j8MrqU8Z96m2WJXxrb3Ve8rQY3VtEXxYxGriQV8ImRPf
         f3+K0ZX79JmFoW6M+sucgPGtQZDeKamLl1UYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=2MAGMbg0u4EzY9Z9l4p+/acHke17WcznMZEaZyHXEcc=;
        b=L0rtS5JeGiAoYy2vi7hNZHkb1Gz53B1kkmIh7is+yGweK3Sq5ZDUtytlZbDGi6tDSa
         UL58I+m36FU/zyjLAYu0A1bOrpa6is3zcouwSDrpKPB4mOFwI60odbs74f/fj+eQIzxo
         KmggVvXvMa8a/4aMTyxJDOFwG40a13MknCb1tAmjX/xYveNCuLVbZtBYPShokIy6cOhq
         AloFTLYu2aE6ex2fjlDVuUhaDx/Wtuj3e98oIM5sYLJqD54OaKag0R7pZDRTVKObgMLy
         ztbtfyCAff1t/JE+ZjhJLU24+2XXrXWPSTKNxrUzgiL2/AMNnVciCvqG7bq/s00yoswG
         zO0w==
X-Gm-Message-State: AOAM531tQftIDCq/YoK/T6asxeMLMF2R8aFUNbTwvSFSaDV9LKl5k/nF
        WZpY83eijQftd0R1JLkGV2n4og==
X-Google-Smtp-Source: ABdhPJwI+LOAoUwufpDS1NBdQDOdWsw1Fztrf8oLaj5V5undVeTE3iPXqrAKC/mNToSSt1hvcG6sqA==
X-Received: by 2002:a65:410b:: with SMTP id w11mr4854064pgp.65.1596220741843;
        Fri, 31 Jul 2020 11:39:01 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id io3sm9583665pjb.22.2020.07.31.11.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 11:39:01 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200731104555.v3.8.Ia205f0b0363bf663db7704026b5b7036b9748c56@changeid>
References: <20200731164853.3020946-1-campello@chromium.org> <20200731104555.v3.8.Ia205f0b0363bf663db7704026b5b7036b9748c56@changeid>
Subject: Re: [PATCH v3 08/15] iio: sx9310: Use regmap_read_poll_timeout() for compensation
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org
To:     Daniel Campello <campello@chromium.org>,
        LKML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 31 Jul 2020 11:39:00 -0700
Message-ID: <159622074025.1360974.832515607486478547@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Daniel Campello (2020-07-31 09:48:45)
> Simplify compensation stage by using regmap_read_poll_timeout().
>=20
> Signed-off-by: Daniel Campello <campello@chromium.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
