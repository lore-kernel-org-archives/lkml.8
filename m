Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4C71C433E1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:12:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AAF79206F6
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 12:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eT+JTyiB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgGGMMF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 08:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgGGMMF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 08:12:05 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3CD6C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 05:12:04 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id h19so49629625ljg.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 05:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IlSwOCm4Yp4QhEp+fKcUAnUUasXB3VYf9UjEjYZIcf8=;
        b=eT+JTyiBhq+2XdI8p40JGaSsQrdp5ZNpLgc0mhjRML5RRc/IKoAEKbkF2CEpMua7Bc
         lMnnmBCmD190tIdUlRwSQxS/OwFF2PpjTgUAovzzEgQ4mrKhHXVDRLerJgPsWNBLz05w
         q73+4+hrdLYAFuWGvxPr6Ugijz7JL+m3VgD6vPHoMBXpdkV/7STnczv5kMTMYnoegwl/
         eQ9PVHiWJbdMx10G4oU1CZEhU4c5LENDqllqKHdqTruHI32ZTwKomUssWXARt5k/6eq6
         Y5vItHM1TQnZZ/kXBbzXmBkEBXfWRri+/TToF8OzdjNUjf/7zdnPYJUpf8pvWyqmKxjh
         rjFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IlSwOCm4Yp4QhEp+fKcUAnUUasXB3VYf9UjEjYZIcf8=;
        b=ubdGgp7tdAB3QRazKa44u8/D5j7neC66nvKCjQcQ+2rREOGCjCaTe7bQ4rKce06xGM
         6pYXwhAjxXiJ3553zdPsmutxi7zeeKRh+oIuFuiS7m7e1HIeipqu7NZxfr54RM8+jzKt
         qitz0BXLXCBBVgZ0Lh1+M8zB68oew6FUt0h3C8CiTFnoUZBGzJwuU02reRj/R3jbDogJ
         lDeTSlhTBoG46GxkW+tHUDVxtam4rZ9vq68Ue/o2vlXzeuAwz2AoX8wyLtZ05nfVNWVi
         rHVzoeVMc/cA65Oun3u5GGh5jT3C+250l00BE8sOBV7st78gfkhOQmZk0aqom5mXETro
         Oi9w==
X-Gm-Message-State: AOAM533cxDjybLC9HbxzMbXTzI40CBTrwId11sQmc1YT6NQij1hM+Dgo
        npUzdGbXJ2sQEg+390dhlsCzg6GUoWXZAZ3OjYh4oA==
X-Google-Smtp-Source: ABdhPJz7SCvAFX6JRt8uMLfBbogC74fZ5d+SCUDXGDmAGrc551BoRJMrunZrfurzNe3Vtggyg7VkXsU/c8EBx5QNxOk=
X-Received: by 2002:a05:651c:1291:: with SMTP id 17mr28926806ljc.286.1594123923145;
 Tue, 07 Jul 2020 05:12:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200622083432.1491715-1-lee.jones@linaro.org>
In-Reply-To: <20200622083432.1491715-1-lee.jones@linaro.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 7 Jul 2020 14:11:52 +0200
Message-ID: <CACRpkdbco3Us2aFS7bXj=W2dPK3-KRonix1dPcGariLptUsLJA@mail.gmail.com>
Subject: Re: [PATCH 1/1] ARM: dts: ux500: Supply nodes for the other 2 AB8500
 PWM devices
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 10:34 AM Lee Jones <lee.jones@linaro.org> wrote:

> As per 'struct mfd_cell ab8500_devs[]' there are not 1, but 3 PWM
> devices on the AB8500.  Until now, each of them have referenced
> the same Device Tree node.  This change ensures each device has
> their own.
>
> Due to recent `dtc` checks [0], nodes cannot share the same node
> name, so we are forced to rename the affected nodes by appending
> their associated numeric 'bank ID'.
>
> [0] ste-ab8500.dtsi:210.16-214.7: ERROR (duplicate_node_names):
>       /soc/prcmu@80157000/ab8500/ab8500-pwm: Duplicate node name
>
> Signed-off-by: Lee Jones <lee.jones@linaro.org>

Patch applied!

Yours,
Linus Walleij
