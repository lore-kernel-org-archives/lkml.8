Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4BD6C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91EDF20708
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 11:43:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="kuJu9lu9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729508AbgEKLne (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 07:43:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727873AbgEKLne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 07:43:34 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F073EC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 04:43:32 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id g185so9321786qke.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 04:43:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=HrZSofo3iZFTh2jWDrYHo1noV2+xdcUG6DMvzbqh4qg=;
        b=kuJu9lu9imJ02yqGcj2fHwbhmZM1veTUhrSCepuKecNYH/uPA37AoMyqX/yCHUn5VA
         FZSSXzKY5C3OW5DnkUF3nRZIj5kkoClPt5aobsr+m9VnLbcK7JewiiXWVn8cqNiVj445
         CQ702HdJvr2MxDcU9cYWWzpZT+74rc/pN7N/uKAQz1s7b7p3ra5kdn74AUboxnpB9s27
         n6YkYe2I0N/dIF06LHbxtvrTxZD4Bmkn9XS+qpa02lpiDSubXN09Hnz5hVSG4D7dBsyv
         BXiY51kFI9ww0APazvLGzvsArPoumnWAldY7G/isso99zPnBy0QTgw9HXGXXkbaQ5VFl
         QHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=HrZSofo3iZFTh2jWDrYHo1noV2+xdcUG6DMvzbqh4qg=;
        b=gS7078uDQJULpsJheJ2PCOVF5Pa6vPFCYHiPXM4QpRAvJshmgp1HQIieYOCC+TXolM
         qn4UhTL8I3U5ZX37oy4CTCltXOxIK7Ftio2fZZVJRlYtqnymHnAev6Xy8M7hvf4Z2hbw
         oyDA/2GfISVTojUxmrPtudwueJg0DRzpJMV36hvMNqbuR2njN1GBJTo6A36V3cSYlgPZ
         YmQs88GOfxQqQOUcYUnr6BuRjZ+i4ShoZ5Vph1ddH/EoIWKb325XNflDUvHWTXM1TKeW
         lUpAEPRJZfG/4EwYjbzPVQccgHTZ65CzIoPjpPeKJkOOq4CjH83HTmzJilx2OeGnfL7x
         R4eA==
X-Gm-Message-State: AGi0PubIuMtrkJWrXRE+atOVKuyy7pA77R/Dc9Pt6+LeYIANyDFwfngY
        Zflz0KPKLsyT3PVJSRNx5HpfzUkJBq4HdA==
X-Google-Smtp-Source: APiQypLZGdZcXwPLwTgije5MzeISj5JWm75i71YFaAFtuioZHStvxhs3C3pSF0EnksEQ6BzGWvKnRw==
X-Received: by 2002:a37:668b:: with SMTP id a133mr14285835qkc.488.1589197412193;
        Mon, 11 May 2020 04:43:32 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id e23sm7670945qkm.63.2020.05.11.04.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 May 2020 04:43:31 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] powerpc/kvm: silence kmemleak false positives
Date:   Mon, 11 May 2020 07:43:30 -0400
Message-Id: <44807D44-98D9-431C-9266-08014C4B47F6@lca.pw>
References: <87y2pybu38.fsf@mpe.ellerman.id.au>
Cc:     paulus@ozlabs.org, benh@kernel.crashing.org,
        catalin.marinas@arm.com, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <87y2pybu38.fsf@mpe.ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 11, 2020, at 7:15 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>=20
> There is kmemleak_alloc_phys(), which according to the docs can be used
> for tracking a phys address.
>=20
> Did you try that?

Caitlin, feel free to give your thoughts here.

My understanding is that it seems the doc is a bit misleading. kmemleak_allo=
c_phys() is to allocate kmemleak objects for a physical address range, so  k=
memleak could scan those memory pointers within for possible referencing oth=
er memory. It was only used in memblock so far, but those new memory allocat=
ions here contain no reference to other memory.

In this case, we have already had kmemleak objects for those memory allocati=
on. It is just that other pointers reference those memory by their physical a=
ddress which is a known kmemleak limitation won=E2=80=99t be able to track t=
he the connection. Thus, we always use kmemleak_ignore() to not reporting th=
ose as leaks and don=E2=80=99t scan those because they do not contain other m=
emory reference.=
