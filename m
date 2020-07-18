Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0162CC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 15:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D485A2076A
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 15:58:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifh1Ra8d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbgGRP6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 11:58:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgGRP6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 11:58:49 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55F4C0619D2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 08:58:49 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id j10so9924428qtq.11
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 08:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Plzvh6H4Hj4vOwuOygDMUlL5YJQ5p6zhFN1IKlQxzyU=;
        b=ifh1Ra8dpMd3QeCqbe0IeHUsUr+GMcVoPiANc+Cl0oz2CHrfUsRokRmGmQ2kfW39Jb
         9jw3Q/Wv8BRh86YqbJyd5r99MRYJNQSGSe9XMrdmsfgydbSyicsEV74ipNbcfM99Gh1T
         xHIdhn7KcErvRd3a+H//yxuCrb3bDh+lDTvfb96m/TKpjSO4m/qrMV87pQbF0OdLkgIv
         calxHyi8+AlbGE4wiW3fMxNR8S2OQzr0W30u2ksvEh539k515LDNEGJGhO4yKb+GF9ua
         Ee0XKlu12o1XOLIYfWpMOqJF6Hghk7H6PsOWc4Ox4uhciYW1v5nG29dn6I1bLigoKBeB
         GyBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Plzvh6H4Hj4vOwuOygDMUlL5YJQ5p6zhFN1IKlQxzyU=;
        b=p+xZy0AScm8RRhvIiq3hRRoYOmHo5jKliIkrO4SIaX5tEl47OhXIhISQYicXsFSUWd
         mRmcr0TUWXAmbh7OfrX5tfFt1wNMUEgn67Wcq0bOUblA/YkWOcXM7nWBi4Id9VY4KikW
         ocplhxXjhey/wLLAnqr5VOyXbAwQ9DnkqjHtK430V9GAlvFLjgdDjC55ZwyJSBO+0YnL
         ejUk16Vy7YHDkhQRIN0xD3dLrfm4avCEO7zbf8qjEvGw3bYvAUl7sqU5wS6Ob5MqzJTX
         cUEwyTP0UzkqYgTAHuv/pxo0jw26STiOCleovZtGUDBK5eW6FV/GD+24SOOrRqwXuZsq
         hzlA==
X-Gm-Message-State: AOAM531vCsEELP/EuxUMPClUVwsND+82N6xSEALrjXWsC6Olm/6pT6Rq
        JKZs4YsEAPh0RsIt/8IVj9U9z8gC
X-Google-Smtp-Source: ABdhPJwufL7Syr0Ze2zYAD9sA8/9Z7unafxdgmSG5XDAziMwjIzM/9Slmurg9TendyyL16QJmAt2Vw==
X-Received: by 2002:ac8:4788:: with SMTP id k8mr16491868qtq.120.1595087927730;
        Sat, 18 Jul 2020 08:58:47 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id h41sm15387296qtk.68.2020.07.18.08.58.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Jul 2020 08:58:46 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id g6so6038452ybo.11
        for <linux-kernel@vger.kernel.org>; Sat, 18 Jul 2020 08:58:45 -0700 (PDT)
X-Received: by 2002:a25:cc4e:: with SMTP id l75mr22783187ybf.165.1595087925354;
 Sat, 18 Jul 2020 08:58:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200718091732.8761-1-srirakr2@cisco.com>
In-Reply-To: <20200718091732.8761-1-srirakr2@cisco.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sat, 18 Jul 2020 11:58:09 -0400
X-Gmail-Original-Message-ID: <CA+FuTSdfvctFD3AVMHzQV9efQERcKVE1TcYVD_T84eSgq9x4OA@mail.gmail.com>
Message-ID: <CA+FuTSdfvctFD3AVMHzQV9efQERcKVE1TcYVD_T84eSgq9x4OA@mail.gmail.com>
Subject: Re: [PATCH v2] AF_PACKET doesnt strip VLAN information
To:     Sriram Krishnan <srirakr2@cisco.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        xe-linux-external@cisco.com,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 18, 2020 at 5:25 AM Sriram Krishnan <srirakr2@cisco.com> wrote:
>
> When an application sends with AF_PACKET and places a vlan header on
> the raw packet; then the AF_PACKET needs to move the tag into the skb
> so that it gets processed normally through the rest of the transmit
> path.
>
> This is particularly a problem on Hyper-V where the host only allows
> vlan in the offload info.

Shouldn't this be resolved in that driver, then?

Packet sockets are not the only way to introduce packets in the
kernel. Tuntap would be another.
