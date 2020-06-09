Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486C9C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 21:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F6B720737
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 21:34:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O9m+8l7H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728101AbgFIVek (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 17:34:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727001AbgFIVeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 17:34:36 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91D3C05BD1E
        for <linux-kernel@vger.kernel.org>; Tue,  9 Jun 2020 14:34:36 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id k2so1943897pjs.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jun 2020 14:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HJ2FmoydfaL6CDGwbH52Ge0Wrl30zawrfmow1nUj2c0=;
        b=O9m+8l7H1EoW8OdCL5uN79CKNtr5vtgiar0rElEwg0GXCXRMa/HpByf5nP6I02kE1x
         HRTZ/aWeF8EkuhsLaUqsZcXBOm0zRzWopDAZ3aMKTgI+Zpu7E5yRdMi891ViTEtGIk+e
         vXgBDm+gEq1gyMFT1zuuVTMpRGm4guxKp1L6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HJ2FmoydfaL6CDGwbH52Ge0Wrl30zawrfmow1nUj2c0=;
        b=AdAf5gMdmGMc0f+jzg/6XN6Mdb3AUdPsbY2gXrzWaGmVJmAkEqrOhE5amxhw2TJMdi
         UPr4X3QVRqTnlKHRHupN9pRwDvK8XrDMNU/bicDjNizToEmilExKUbqZPXj4ykmjtCWu
         mvGOF/Zrdg8/3fXYbb/Bw7DQKBD3gxrrNR+TY7llGm9KcuO+TXjHHOaV7Kl169zhYpW5
         lH+O8zzTTiO3UcZ72N+6eFiEAmrSXy93r+V6k1nWywLN7wWuVlQsJ4vGl17ydLtSOWv1
         keeQBl87MrO2R6aeKUe0MaFi1/cwBFkzhi4f1wkByDWOA5s7b2kjYrQAKRAH4q6uE4nl
         HJgg==
X-Gm-Message-State: AOAM530fXA+ubblxXr36G+YtQ4pNpIJ5uD44fbowKMogJLtO59eaU7gB
        vUOd+v1hIVwPYJGxe0pGqy2PHQ==
X-Google-Smtp-Source: ABdhPJzVdGugeSY+f/v7H2CcczWDHeTj5Wba8lDwrArZhrGFec0z3F0kB6ZTvyimrS+fuO4LK33e/A==
X-Received: by 2002:a17:90a:e2c4:: with SMTP id fr4mr6901141pjb.32.1591738476398;
        Tue, 09 Jun 2020 14:34:36 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z20sm9280968pgv.52.2020.06.09.14.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2020 14:34:34 -0700 (PDT)
Date:   Tue, 9 Jun 2020 14:34:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Michal Kubecek <mkubecek@suse.cz>
Cc:     netdev@vger.kernel.org, David Miller <davem@davemloft.net>,
        stephen@networkplumber.org, o.rempel@pengutronix.de,
        andrew@lunn.ch, f.fainelli@gmail.com, hkallweit1@gmail.com,
        kuba@kernel.org, corbet@lwn.net, linville@tuxdriver.com,
        david@protonic.nl, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        mkl@pengutronix.de, marex@denx.de, christian.herber@nxp.com,
        amitc@mellanox.com, petrm@mellanox.com
Subject: Re: [PATCH ethtool v1] netlink: add master/slave configuration
 support
Message-ID: <202006091358.6FD35CF@keescook>
References: <202006091222.CB97F743AD@keescook>
 <20200609.123437.1057990370119930723.davem@davemloft.net>
 <202006091244.C8B5F9525@keescook>
 <20200609.130517.1373472507830142138.davem@davemloft.net>
 <202006091312.F91BB4E0CE@keescook>
 <20200609205303.z3kfoptj7w2jpnts@lion.mk-sys.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200609205303.z3kfoptj7w2jpnts@lion.mk-sys.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 09, 2020 at 10:53:03PM +0200, Michal Kubecek wrote:
> The same IMHO holds for your example with register states or names:
> I believe it is highly beneficial to make them consistent with technical
> documentation. There are even cases where we violate kernel coding style
> (e.g. by using camelcase) to match the names from specification.

Yup, when I saw the original patch it wasn't clear this was matching a
spec. I haven't been arguing for the $subject patch since Dave pointed
that out, and am now trying to shape what the general guidance should
be.

-- 
Kees Cook
