Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB67C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 19:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7924A20855
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 19:30:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tfz-net.20150623.gappssmtp.com header.i=@tfz-net.20150623.gappssmtp.com header.b="aRuBjBtf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbgHPTaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 15:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729688AbgHPTag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 15:30:36 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72B3C061388
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 12:30:35 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c15so12817807wrs.11
        for <linux-kernel@vger.kernel.org>; Sun, 16 Aug 2020 12:30:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tfz-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e0fU4VrqgZlTgwb4wRJnx5ZqxP+E94HxLzwK2cUn8RQ=;
        b=aRuBjBtfZr5au/mqaUr6qu4OjMSiJUdP7VIISIQTUUBlgts7MESDv0nEvlMnw91QMs
         T84O3kdAYAFn/LFeMoiYKLXrpbQD4DVEEIY2M09APJjpNONd7OkZBTBj6vwOAyDC1kMA
         hnIDEvpJ1PJ6XsFJ49fSB63z5Vi3KXLDFOxW3mq/Ir3tHVK/HJJck4lVFrECLVAYZyzR
         hpF8AiTOCXhR3zvAYMAhfMdeG/RPh9cMpCAz5zj9mZA9s2nAaZE9Ut/Idaqxvu295T6f
         Ri/QWSRpROECHS7Ob7FsQuoELa0TMJAflxPvPyZPdsMHoT7EuZYX5VMZXnz3yziDfVTC
         IWlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e0fU4VrqgZlTgwb4wRJnx5ZqxP+E94HxLzwK2cUn8RQ=;
        b=d9RhJ5PTKUHBFciil9aBez60dStPsJuAiaFx5hjSlH2CJLZMatN2E+SvMfgn8zqWyv
         YnOauvNusSy/QDyAJbC0KZbwKTJurQR3V1XRXb5Ryz2vKowab2ECnUzvOB8FZl3EzzQV
         3JNi4kb7jkHUzlVoftxySJrGh200yxYN1Ld1IIkiWI0RkUC+OFP/f0yH1StoU4WOOceH
         uZ7NCsn+i8ccLo//Cs3048SLbG1455IyS9EcAD07cLjKA6q0kU0XZL2q8TLOp3BtEPA1
         PF7HzYaeySrYWnGVrfbQDJpKrO2OkjkTkzxfs7OxnB/FcI5xirVlOOM1k8p9PZMaCsSG
         H4Cg==
X-Gm-Message-State: AOAM5302E2K2zaD6LUhapOy3aainW/dA28+FRDhcSFIzg91Dym8YrKvs
        AHIQasjVkMx8gu8VnLbDhA/TPc+OvXOKeWRdMmoRQAqig6LBjMoO
X-Google-Smtp-Source: ABdhPJxNkrRRHn9VpN+44nPTclpKSsDITviwHA8cNDXLcS2RsmPd+jX7VEQQAPjG6X7ESHUZ0zXUKvaaNA4yeKqT/k4=
X-Received: by 2002:adf:a102:: with SMTP id o2mr11600431wro.319.1597606234590;
 Sun, 16 Aug 2020 12:30:34 -0700 (PDT)
MIME-Version: 1.0
References: <20200815182344.7469-1-kalou@tfz.net> <20200815182344.7469-3-kalou@tfz.net>
 <7c910594-b297-646e-9410-f133fd62a902@gmail.com>
In-Reply-To: <7c910594-b297-646e-9410-f133fd62a902@gmail.com>
From:   Pascal Bouchareine <kalou@tfz.net>
Date:   Sun, 16 Aug 2020 12:30:23 -0700
Message-ID: <CAGbU3_=HQKHOzy_sq+gkLs-QDsQ4OmALbitaCvTp1hxVzAr_vw@mail.gmail.com>
Subject: Re: [PATCH 2/2] net: socket: implement SO_DESCRIPTION
To:     Eric Dumazet <eric.dumazet@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 16, 2020 at 11:15 AM Eric Dumazet <eric.dumazet@gmail.com> wrote:
>
> 1) You also ignored what would happen at accept() time.
>
> Please test your patches with ASAN.

Ouch, I will look into it - thanks for pointing that out & 3/

>
> 2) Also, why is that description specific to sockets ?

fcntl on struct file was deemed too intrusive - as far as fds are
concerned, regular files and pipes have names and local processes to
match against anyway
we're left with mostly remote targets - one example was to preserve
target host names after resolution (alas, I don't think there's a
clean flow to hook that transparently)
