Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 915E7C2D0F8
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 06:24:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4543A206F5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 06:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="GLjuEFNs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729471AbgEMGYa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 02:24:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728498AbgEMGYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 02:24:30 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB199C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 23:24:29 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id b1so12530706qtt.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 23:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=ha/ounVPt6yY52Fm9rK6clkqfuhFQ2zd+ThkBQKemO4=;
        b=GLjuEFNsKrWt/eI0OIGIaj3JW23vEO6bqvgqwo2GFK/n+aEeWEAu86Hy+UzeD5t3xf
         G5jmATRNs1B79Y5CQo28cjOqzkn8Ark9FBUzQ+FBDKxL7JbGM57994g1ywYfgR0kS9F7
         ExQVOCPdnHWHrKhOQ5eJCPgNkpbadOmRSmyBvLQQYmfet/hNo9ZzL4yBs4HabnDaP8pa
         X3Wr4CFmML7GGpCr2C8jGf9Bu6hrkr4vTlUMnh7UrT1QoqmwUrYUBBrlGBGrR1qMU7uE
         hX0Slm0avY/QUfP4I838fUNVblnxc5ehhfMAKJYLpm42+ILRgPVPqhSsrwXOwvfi6fDq
         816g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=ha/ounVPt6yY52Fm9rK6clkqfuhFQ2zd+ThkBQKemO4=;
        b=q8nNMzAAtiTLxE/ujT+9osgLF8vcodOyPj0rzInYBIaUDCHmNSB5BLkGrITOsTcsjy
         43V7hSodkbw1Tlj/kpquaaefMy7Bx/npk21A/M19b/TYXi5IfmtPXRRliYV8wUBZVtOG
         rI/n0Z4fnJ4I44Gsa0hozCr2gm138oM8xbLAdEg9lvJPz0Ea+Exo2UpCHnp0Eys3fKiT
         mEOfowK9e3szbDjJrAzzXuwWJbeVXfpmxaOApHmHl5j0/ltu+TkjMCLOkLgxdqmrz3R4
         Lu4uK/VScBi8YIWXwi8djjfaNFa/lLggVBaAWQaQwqvIamolEQLhaqEOGuoENxnvur4C
         EYRQ==
X-Gm-Message-State: AOAM531jhF/IsGft0ZvITocmf4KE5NE/Z7bpPur9TJQyeOk/8UYHwd1U
        5E6hoAhBjdVTbM04GiuBuduSTQ==
X-Google-Smtp-Source: ABdhPJxTYQm31Sf4DquSKEbLUABTbJHGdWBrkj7N/gWc05wPWn2ctXxedJf2IrAYckiob4si+X2FBQ==
X-Received: by 2002:ac8:724b:: with SMTP id l11mr6049058qtp.27.1589351069158;
        Tue, 12 May 2020 23:24:29 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id t12sm12580679qkt.77.2020.05.12.23.24.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 May 2020 23:24:28 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] powerpc/kvm: silence kmemleak false positives
Date:   Wed, 13 May 2020 02:24:27 -0400
Message-Id: <F9DDFD57-C008-4518-B54C-91814286E2E8@lca.pw>
References: <87h7wkbhu4.fsf@mpe.ellerman.id.au>
Cc:     paulus@ozlabs.org, benh@kernel.crashing.org,
        catalin.marinas@arm.com, kvm-ppc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
In-Reply-To: <87h7wkbhu4.fsf@mpe.ellerman.id.au>
To:     Michael Ellerman <mpe@ellerman.id.au>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 13, 2020, at 12:04 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:=

>=20
> This should probably also have an include of <linux/kmemleak.h> ?

No, asm/book3s/64/pgalloc.h has already had it and since this is book3s_64_m=
mu_radix.c, it will include it eventually from,

asm/pgalloc.h
  asm/book3s/pgalloc.h=
