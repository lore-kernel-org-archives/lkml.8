Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BA7C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 06:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A151520756
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 06:13:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaWQFKFZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgHJGNh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 02:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725849AbgHJGNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 02:13:35 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C25C061756
        for <linux-kernel@vger.kernel.org>; Sun,  9 Aug 2020 23:13:35 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 9so6583178wmj.5
        for <linux-kernel@vger.kernel.org>; Sun, 09 Aug 2020 23:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=dBeGb9NKFozCmuSADydRWnA8ktG5DHCOdPcf3Ab7zbk=;
        b=IaWQFKFZ2ADDCEFn60SrAlV1GkczDvUoHXUswVAQcRSnzM3EUy6tQrrhNspEWOcKzl
         r/x6hDdgUcDWJMEffU3YGiHm8gH11F/+obYTYCBfwyrQsjv9O8Of1tJnUKp73sku5PNZ
         fT/VBJBm3YCgrmzGMpmThR9dF05pTxJvYghudGbBAh3hxxb9c1XQH/K2OoC2A9XKBvzl
         ciI833LeiYD6tC8qRSG5H240pdm9h0j4J5ZVSIBUnMtgc1bfwvHkwWHuaMkEFmT2YQfp
         wmREKcu1P+yMq39aPUMQLj9GF4JqGSpuxR1krQMdxrYatlIEztwPrs+R1adZEH5GqnO0
         7+zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=dBeGb9NKFozCmuSADydRWnA8ktG5DHCOdPcf3Ab7zbk=;
        b=VZMsG2+kWTQ0Fm3R5d6mEBIoxJkGfR0D0Tmo0ZJCi81VFeL5a+VuT+gY5LnM9dFPo5
         ZTHcRHOI77h2WOUCN9Mcn73grgrL1vEodxvd1j1FRW5sEDO6nTw0pOaB8ReGhYkRKx7X
         ZM3oGlKUA4wCR9k5tiHR2l9a4oAVLzaFY6pdR9z0FIQ8YU4BAwX7vEcRfJh4to9Xupsr
         uWt9jjzC5m17MbvAnS5hh/g8u3Ep4/kUiikUTYSmMMURXstr2evWIF5WoSiHUwbB1pbd
         +kBE7+Dqv8LTyazSKMGlBx+25dNFQg7VFFoni6Cqe6m8RAjsXWW7FVjiYk0h0pW9Mrh4
         LU7A==
X-Gm-Message-State: AOAM533VWVp/qb19RAbVxpfrMe+lWcDAT0Lp55565s5mVduTldji5Hnh
        nzGwKfocQucUBwW+M3DcAc8=
X-Google-Smtp-Source: ABdhPJxyOoKihVDCn7j/AdhD2AU1CP7dqumRfftRRTs2o9STUzFq4gvZo5L+Q/csBkS1+q7Qjg4LGg==
X-Received: by 2002:a7b:c7d5:: with SMTP id z21mr24658947wmk.145.1597040012358;
        Sun, 09 Aug 2020 23:13:32 -0700 (PDT)
Received: from localhost (dslb-002-207-138-002.002.207.pools.vodafone-ip.de. [2.207.138.2])
        by smtp.gmail.com with ESMTPSA id t133sm24328936wmf.0.2020.08.09.23.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Aug 2020 23:13:30 -0700 (PDT)
Date:   Mon, 10 Aug 2020 08:13:24 +0200
From:   Oliver Graute <oliver.graute@gmail.com>
To:     jason.hui.liu@nxp.com
Cc:     anson.huang@nxp.com, aisheng.dong@nxp.com, catalin.marinas@arm.com,
        will@kernel.org, linux-imx@nxp.com, linux-kernel@vger.kernel.org
Subject: Re: arm64: imx8qm: tlb SW workaround for IMX8QM
Message-ID: <20200810061324.GA66637@archlinux.localdomain>
References: <20200427082348.GA98329@archlinux.localdomain>
 <20200427130328.GA101181@archlinux.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200427130328.GA101181@archlinux.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/20, Oliver Graute wrote:
> On 27/04/20, Oliver Graute wrote:
> > Hello,
> >=20
> > is this nxp software workaround already proposed to linux community? can
> > someone point me to the discussion if available.
> >=20
> > https://source.codeaurora.org/external/imx/linux-imx/commit/?h=3D3Dimx_=
5.4.3_=3D
> > 2.0.0&id=3D3D593bea4e36d8c8a4fd65ef4f07fb8144dab2de1c
>=20
> sry for the broken link. Here the right one:
>=20
> https://source.codeaurora.org/external/imx/linux-imx/commit/?h=3Dimx_5.4.=
3_2.0.0&id=3D593bea4e36d8c8a4fd65ef4f07fb8144dab2de1c

this patch is not applicable anymore since next-20200713. Is there an
updated one?

Best Regards,

Oliver
