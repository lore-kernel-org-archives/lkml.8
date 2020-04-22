Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2944C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 18:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A72021473
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 18:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="KcTXmBwo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgDVSyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 14:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgDVSyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 14:54:21 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5C2C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 11:54:20 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id l78so3583653qke.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 11:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Cf7V5KoTnxdr5/vwnYfKOK1hbcf2VCNupE2mGkiuZek=;
        b=KcTXmBwoIyFsReVVYls7BajqrIrspSH0iNNqeeoSCbJ1km/PQo8w0qd1DVGlcI5wtd
         epSmrLWikleQZqX3pHCfL1JFUrerpfeHCOpdeJ6TxQpMMFgjU8UnAbUqnm9n4odpGC0Z
         h8dSAvVDfqEV2uWYahcHsKm3bbR1r9+sFqCfE4TJbB5qezAoSSBAWMj2ODHe5Yx4JErg
         K3TsP/aFzT/M5NpCX45/+kL4+YQw9T0MowYiB4l0//03Xe7/DKB1It8+Di3fsheISnnx
         9oa+6NLukM5zhR65LouLFnBzAd4ReYdNXebNbIGHm06k8xOvUYEfvXY5um7HH4a+ZuhH
         zFyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Cf7V5KoTnxdr5/vwnYfKOK1hbcf2VCNupE2mGkiuZek=;
        b=OdTXxTEfFKh6zE9rlzZesN9yUckB65Izugz+npOYd3wOIUDOPwTMuzhkOzswYgWpMN
         j8a55eqhRjEb/5o/StbxqSqhT4uYwcAr7Apgiii07YB4ww8yjnsfOEHGO5zXfmR7UNfc
         RVDPp6Rl/2pvymvAl8PHPZ7JrhMKTtQIUVy5kuJS9T8ILM+kuVSzuA8BqYwcrjfVOSkd
         0lhbniv7N/N72rEjrO0CIVlSO8ryKFrzaaZ9ApQhUvWciyqACZVqmyVXqHouLn6J20Fp
         sjbphrlDVumLJ3cFnCBW8tGEq3Ku2EONKQ5HjMjg7VZsl57DOHjwb+MQMBkR4LEOkxsO
         P/Dw==
X-Gm-Message-State: AGi0PuYjNMfNE1hCoCmbiq53IPVzsopmTlatB7hJhMAQui/mEpsSxVyO
        Xa5QyG5eKDr+wShl6hwe+a716A==
X-Google-Smtp-Source: APiQypLefFFUCOrVXY/c295ql6Ptfv0WWhhMmxgYsFJPpBKPqVLuPU1BCIMA7YXBtpYWKf4YlHt2xw==
X-Received: by 2002:a37:4c4d:: with SMTP id z74mr27822914qka.53.1587581660096;
        Wed, 22 Apr 2020 11:54:20 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id c41sm29245qta.96.2020.04.22.11.54.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Apr 2020 11:54:19 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: AMD boot woe due to "x86/mm: Cleanup pgprot_4k_2_large() and
 pgprot_large_2_4k()"
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200422164703.GD26846@zn.tnic>
Date:   Wed, 22 Apr 2020 14:54:18 -0400
Cc:     Christoph Hellwig <hch@lst.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <48A05550-75AD-40EA-921E-BAE43453AC47@lca.pw>
References: <20200422161757.GC26846@zn.tnic>
 <59604C7F-696A-45A3-BF4F-C8913E09DD4C@lca.pw>
 <20200422164703.GD26846@zn.tnic>
To:     Borislav Petkov <bp@alien8.de>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 22, 2020, at 12:47 PM, Borislav Petkov <bp@alien8.de> wrote:
>=20
> On Wed, Apr 22, 2020 at 12:35:08PM -0400, Qian Cai wrote:
>> The config has a few extra memory debugging options enabled like
>> KASAN, debug_pagealloc, debug_vm etc.
>=20
> How about you specify exactly which CONFIG_ switches and cmdline =
options
> you have enabled deliberately? I can rhyme up the rest from the =
.config
> file.

The thing is pretty much the same debug kernel config has been used for
a few years, so I don=E2=80=99t deliberately enable anything today.

The best bet is probably to skim through the =E2=80=9CKernel hacking=E2=80=
=9D section of
the config and enable whatever you feel relevant if you have not enabled
already.

The cmdline is also in the .config via CONFIG_CMDLINE.

>=20
> Full dmesg would be good too, sent privately's fine too.

https://cailca.github.io/files/dmesg.txt

First, it comes with the dmesg that crashes and followed by the good =
dmesg
after reverting the commits (starting from line 644).=
