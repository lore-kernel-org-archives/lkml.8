Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811D5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 06:59:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44D7D207FC
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 06:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hIUgXPa7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390052AbgFYG7o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 02:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389958AbgFYG7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 02:59:43 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA2FC0613ED
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 23:59:43 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d66so2606111pfd.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 23:59:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=h3cJifZz1u8LBc/y30E1modeSB1/pxO5mM8WcMl5ag0=;
        b=hIUgXPa7R+lsDLQ6W455cRmyzlZMJSCyD649EBCHTUfbq4cROvPHlO3utX9dP1uY6L
         TDn6yWLvYVwItyWCrTz0symu1Hp40iPYSmNgRqySCeDHGiqiKRKOrZp/OHyNKCOwPAIv
         cO+g0PMeDLYS3c7G/YfGzqqPoZhss325oz0+0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=h3cJifZz1u8LBc/y30E1modeSB1/pxO5mM8WcMl5ag0=;
        b=H+Myyov+VjOhSlqGvcbTN1BWLILGWXU2HLb2qef5EzBlknzDitKNDU0D2ydBcFzU8Z
         zdvF+ac3WXHudsVVLl16xg5+pz+PDHrxklUT6us9/08ikXojpeUaQ2Ejn+B+PHl8CwaU
         nP7mIECTTKdbSvAH5TOgn0DSCBznqVna748qRt1x05sazkD8p9f//BeFcS00zNmZou3S
         dScdFknkQjZATj+bZQA9CU8VPeuA43qPdjeNgIqND1CUluNQ81e4ncWfw0eif4x/Lq7D
         YBUTKFrQxc4O0j/NcRaTnf1QbKcxjWC6tQeEd5aHfAdRC437toG7D8oxgL3vkMXvGD1U
         ZLFA==
X-Gm-Message-State: AOAM5331ADsq2TU99Z9Ca3A22zEdDNTXW9VJdPvvLOUbXz+pmgGhVWLJ
        eKGoz3uLHA/tx91bzmnHutL/e5E4ZBA=
X-Google-Smtp-Source: ABdhPJyDXfB/vfATD45LCtZwbIvnX9Ky1w2z2exmM0w4aKL5HLtHcZfvv0hqfh3i1EC7be25yqvHZA==
X-Received: by 2002:a63:7c56:: with SMTP id l22mr24439286pgn.127.1593068382595;
        Wed, 24 Jun 2020 23:59:42 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id 21sm4250390pgy.20.2020.06.24.23.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 23:59:41 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20200621083315.883209-1-christophe.jaillet@wanadoo.fr>
References: <20200621083315.883209-1-christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] kernel/cpu_pm: mark 1 function as __init to save some memory
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        bjorn.andersson@linaro.org, dianders@chromium.org,
        gregkh@linuxfoundation.org
Date:   Wed, 24 Jun 2020 23:59:41 -0700
Message-ID: <159306838110.62212.10303992077632246358@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Christophe JAILLET (2020-06-21 01:33:15)
> 'cpu_pm_init()' is only called via 'core_initcall'.
> It can be marked as __init to save a few bytes of memory.
>=20
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
