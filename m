Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FDB2C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 02:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2255720838
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 02:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="fvD9Vkcp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728385AbgHACxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 22:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbgHACxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 22:53:08 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1D47C061756
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 19:53:07 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a5so19560789wrm.6
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 19:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xQw/GDvZAdqgK8PngDZUR70WBhENQwa4VO5dO5VMRYQ=;
        b=fvD9VkcpIpmLGOc0RN16Q3g+MDuB1wAVsNPB1I3qdv6BXascnBQB4/jFZkdPGFNPlb
         Ic2arZ3utbXNqLm5oNcWE388GCL0ou46KCU6Du0kkjr+1cndmEfqqXaeY24F59LG42u3
         IgGAnx1zhThprobHe2gfEmlVlaxeA0GpoVsVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xQw/GDvZAdqgK8PngDZUR70WBhENQwa4VO5dO5VMRYQ=;
        b=XK5Hg/50zYKWRA2Hx8Ru2RZ2Kfy1iPXZgu5Fi9PPGmdHv6TO2vhx6OZ47Bo/9FjeSi
         Wexajq79QcV2hjLLkhYK4Jv4m9gu5++vtY6g8j9aXfiO3GdN3zltlg4Tg+rg6zuXyDWl
         cJaNfuGbAyQ7iXsBiDD8gSt5Ta1SQkOeg1tAD1ULoCQC5qVxH75YZZYTfkzZYlKrQaIX
         5hJ5iljK+wxTFkiRvsIARcrwzKGiL4e9IaS7qB02bR+Hf4aQSWE4s8oEppiTgmt1a0V9
         JpmLZHjXvjh/tOFeyDjcfuwQyn+tQrdqD4NV7YyGnYWFPYCr+4llLJg4Z2RwYy+0pffy
         6TYw==
X-Gm-Message-State: AOAM5322BeEfmfRc9byxjhgjTztiV9uJxPx1dTnACRieVsUFd6OP2BV9
        xgKVjkBz1VRbCOu7uyI5BmqgtA/itq112fs71h1kWA==
X-Google-Smtp-Source: ABdhPJzYPKm/erB6sVI52cjRD9FHiQr2nWVZVyOZjhc+4s1LOvf5ZcI3PFb7AEEsBm6nMUykRgV5fktNAgsesrmbuZs=
X-Received: by 2002:a5d:6641:: with SMTP id f1mr5731384wrw.307.1596250386460;
 Fri, 31 Jul 2020 19:53:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200729150748.1945589-1-daniel@0x0f.com> <20200729150748.1945589-3-daniel@0x0f.com>
 <CAK8P3a2DY8kNMzZs6vpcsvpU1CaEQy6yCiHq40txEgUBn8d=wA@mail.gmail.com>
In-Reply-To: <CAK8P3a2DY8kNMzZs6vpcsvpU1CaEQy6yCiHq40txEgUBn8d=wA@mail.gmail.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Sat, 1 Aug 2020 11:53:10 +0900
Message-ID: <CAFr9PXmNLMXDXGOF+XDK1dPVY5OO6PfSvy54tLw-Wj-gdb8wBA@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: arm: mstar: remove the binding
 description for mstar,pmsleep
To:     Arnd Bergmann <arnd@arndb.de>
List-Id: <soc.lore.kernel.org>
Cc:     SoC Team <soc@kernel.org>, DTML <devicetree@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Aug 2020 at 04:22, Arnd Bergmann <arnd@arndb.de> wrote:

> This patch for some reason did not apply, so I ended up removing the
> file manually and using your changelog.
>
>       Arnd

Thanks Arnd.
