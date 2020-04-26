Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B0EC54FCB
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 20:54:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFF212070A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 20:54:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g0iikt3m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726323AbgDZUyY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 16:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726225AbgDZUyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 16:54:24 -0400
Received: from mail-ua1-x944.google.com (mail-ua1-x944.google.com [IPv6:2607:f8b0:4864:20::944])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0276C061A41
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 13:54:22 -0700 (PDT)
Received: by mail-ua1-x944.google.com with SMTP id f5so5390133ual.5
        for <linux-kernel@vger.kernel.org>; Sun, 26 Apr 2020 13:54:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UHvmvK16dxVZw6xg1c1UR5rBSf+5kVr8sJmjd9CEFaU=;
        b=g0iikt3mYmux7IwGv0TbadGw9Y6+jimMW6kFslUPJHz8ZfEaKjbAX7MM1TWAc2g19A
         jQq52LSsRFkDtP6uKd4Eh2cx49hDiAWC91zEK4xe91a0COcvxakOvJlG1VQWhfIQ3hhz
         cJlf0HElpFA5laQ8feNVA6pkJ6qgJHMDxwcDlISx3Fq3peJ+lRJVcVg3keI3dQastsKz
         vfcfwAyIDydBtZy8Kab7hMSKOoxiVgw/RUo6X1y/Dh/1wc9+pEpunq7E9EEKcqO7EhMB
         hvdvOb2Zuib6JqHtZgs8rWWahgIXvJtlcOhgn/xiQRzUrOHDUJeJd3bg4l+shdiA5Grw
         FOJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UHvmvK16dxVZw6xg1c1UR5rBSf+5kVr8sJmjd9CEFaU=;
        b=Mroc8h+ziVHtm9pjOLpVGBAtHqLBr5xlPxHmPrOaYtJP/jTiQucSQrMcbHK6934wPP
         71nczuHfo3hwivZuVkuHhC5IXyaOz0DLX02pVEdf8L4c1fTkJkvDCw+QfWZeQcmw1FRu
         7B5BNCg60pAMKNOaOuapm7KEa2FVieAsXnWPFX1vgBQ5NrxUeGeyk91MUaNife2boNHr
         uuLV3ZxtAfJeVtClljJKja2MG2w2RjVuFACPkpY4FMKKdJaKSTWw5+F6TY96dspoxSYY
         rwohFPHqkB2aFZfMK4vRvJbi7fnAMH3/BiV3/zQMtq1dEJ4hpDUqDFWAl0NYYhwtjB/a
         yvcA==
X-Gm-Message-State: AGi0PubN0bogLvIJJz67uIWwYyQGXq6d8Dt5LLVFKl7Wba00kbd31M5O
        MNJMdxLHI/fHQW0xc6klRSt9QmM0v4ZIEqc8Uj7mCQ==
X-Google-Smtp-Source: APiQypId8CuX+BVlYDBqShj5QXvD9DNxkAFHvl3ApU8OQndR7n1PGxIP4ZPoBVcEBdDymek/PW1GiZK5okEd6QgjhJA=
X-Received: by 2002:a67:f254:: with SMTP id y20mr15058958vsm.177.1587934461499;
 Sun, 26 Apr 2020 13:54:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200420202643.87198-1-zenczykowski@gmail.com>
 <20200426163125.rnxwntthcrx5qejf@ast-mbp> <CAADnVQ+FM2Rb2uHPMjXnSGmQo2WMfV7f_sikADHPhnHMq0aK9w@mail.gmail.com>
In-Reply-To: <CAADnVQ+FM2Rb2uHPMjXnSGmQo2WMfV7f_sikADHPhnHMq0aK9w@mail.gmail.com>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <zenczykowski@gmail.com>
Date:   Sun, 26 Apr 2020 13:54:09 -0700
Message-ID: <CANP3RGexEgmeGHab5d0pP2QsR8yVqQ+kBi=2FW1rd2CtafyJUw@mail.gmail.com>
Subject: Re: [PATCH] net: bpf: add bpf_ktime_get_boot_ns()
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Linux Network Development Mailing List 
        <netdev@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > I fixed it up and applied. Thanks
> >
> > In the future please cc bpf@vger for all bpf related patches.

Will do so.

> The order of comments for bpf_ktime_get_boot_ns
> was also incorrect.
> Most selftests were broken.
> I fixed it up as well.

Thank you.
