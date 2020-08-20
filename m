Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 429F0C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:27:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EA5D20738
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 12:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597926465;
	bh=k8bHNWPEvo8AEqebY8y2/WT7UgwuSqcajPAFIHA45aM=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-ID:From;
	b=s0dSnfwPJl1nMUfGhsRZ599t1gsXeA9pNEF6on9Bf8zXrxN7kdz4euRQECpkZOmzj
	 S+OQL6aqtUQuo+oDGWEprmNzceFKxhHXqE472vGBY/wrpgqP5XilK7r9G4mDhV0j9/
	 Kmfc84O/ihn+6Q72e4vja3UlELgXFXu6sBGxR2Dg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729453AbgHTJwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 05:52:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:33086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729872AbgHTJv6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 05:51:58 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB7ED2078D;
        Thu, 20 Aug 2020 09:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597917117;
        bh=k8bHNWPEvo8AEqebY8y2/WT7UgwuSqcajPAFIHA45aM=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=dTL5NQR/x6e3RqXFaRPGx9zUtnOwtdtSB/9GlC1z2H5M+Lnp3rf2Lpq5qkOajhQZL
         hcbYhFjzGcHaDmKJLNPV2aheslT2/aIJsqe4wO/CZWSc9pySpd1aW38cwmkoNtz+Wv
         xbEowmOQVT5fTeSXpp5kkNG+RC5mFxTRtBvrFMUw=
Received: by mail-qt1-f171.google.com with SMTP id s16so743059qtn.7;
        Thu, 20 Aug 2020 02:51:57 -0700 (PDT)
X-Gm-Message-State: AOAM531jPxBC39Lb0YgviNypwnP3iqsO4cLIKuwhnttfk1G39PtRuhYr
        YNh4cys+auVh8jMY3DaVClclFRyJ7vJHIxG9cew=
X-Google-Smtp-Source: ABdhPJzhapaxSj4V8NhsKO88U5UOzo8ejbnz1E/FhRIpVkbie7D2Zb4ypv7T7anhTEDZxHMKp8nG6pWRn2Bf+vaXCns=
X-Received: by 2002:ac8:5354:: with SMTP id d20mr1950917qto.120.1597917117096;
 Thu, 20 Aug 2020 02:51:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0c:efc2:0:0:0:0:0 with HTTP; Thu, 20 Aug 2020 02:51:56
 -0700 (PDT)
In-Reply-To: <20200820091619.460392380@linuxfoundation.org>
References: <20200820091612.692383444@linuxfoundation.org> <20200820091619.460392380@linuxfoundation.org>
From:   Johan Hovold <johan@kernel.org>
Date:   Thu, 20 Aug 2020 11:51:56 +0200
X-Gmail-Original-Message-ID: <CAMgPeKX54WqE0Wc56u6W3M2JwttV=E7sBKmM5eRa5_Mu7m+okg@mail.gmail.com>
Message-ID: <CAMgPeKX54WqE0Wc56u6W3M2JwttV=E7sBKmM5eRa5_Mu7m+okg@mail.gmail.com>
Subject: Re: [PATCH 5.8 137/232] USB: serial: ftdi_sio: fix break and sysrq handling
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This was never intended for stable as it is not a critical fix and has
never worked properly in the first place. Please drop this one and the
preparatory clean ups from all stable trees.

Johan
