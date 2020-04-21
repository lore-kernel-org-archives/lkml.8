Return-Path: <SRS0=8uoY=6F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50677C55181
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 11:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F288206D5
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Apr 2020 11:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="j/6HQPLH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbgDULVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 07:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728778AbgDULVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 07:21:51 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C84FFC061A41
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 04:21:50 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id q31so6300726qvf.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Apr 2020 04:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=kNM2KRkAMSsc+pYLKtlKu09j47YU3pGF6ToSVV1GC2A=;
        b=j/6HQPLHk6ynL/FoB4R7yMl5t9W90U39EGGlAjJdv3xTVLAGO1U3fwtR876zviUMgS
         8h19VkOF136hk6Kyq+tM4kn+M4lYQ5SozOlH39NpV9v5nmttnocXoC+YaoiEJE5/p02I
         1iSnlkan6Hr5DiOqZoHCgxS5KWE0xbJ6uSN73gAhfr7MuJBmDX8J4oldsj9jWdCiK/BQ
         BITOyFoOFwJuRR9ZpmxV7fI7yEIX2/C19JDFdOKYGaCavcKouLbSOWDD0gJq4NShxH3I
         YSzGbmqOUGUhXfIowlrMH/xBmwuVg3pcvOEKpTteoYRaw5IPqLzES5e2e7ptjMBWlOFB
         Gltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=kNM2KRkAMSsc+pYLKtlKu09j47YU3pGF6ToSVV1GC2A=;
        b=JlSRx63tMRJ5RSQonSla8SGTi1lTW1lCH7CmQltG5F9KG5UYJro+70uhSSqnibratQ
         iyjaYAO2U47JAtBEjBAkPRMWIh1Y5BFQ9ZN1GxrmNCWRogLAEOa9/uSvvv6Nu4D7PLA+
         pXyPeRsYXT+8qorS9LD0k/xeW1kZUWdgMwDrktMhYyciwt7c/d9ql5CNDrGhwFFCmyJn
         XbwFlDcWBnKlzW1ig+XAbguvxk0nhMtz8wAoMaS44zoYt/x50D31AtILIbAOk28zTQ+k
         RDl+aTNCQOxzYdWqqxpL1iQsRw7RGeNmLeTLCp9j3Hd1EtEaCzS7XZsloFyuCfE5L1bP
         8pKQ==
X-Gm-Message-State: AGi0Pubh/HU1+M9XrxtTgU7fX3aSnB4Dkwv7wubenkO1Eilz0f4BhqV+
        9IZmtdt7qqCK6u2b10UexFTq4A==
X-Google-Smtp-Source: APiQypIz8KpdLC2geW/BC+9l/tMpLTLdQdGdy4IFB0lhF2Q+hFfDhzRYrnPW8u4g9GZV1E2ef7eESg==
X-Received: by 2002:a0c:b501:: with SMTP id d1mr31042qve.63.1587468110010;
        Tue, 21 Apr 2020 04:21:50 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id i56sm1625973qte.6.2020.04.21.04.21.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Apr 2020 04:21:49 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: linux-next test error: WARNING: suspicious RCU usage in ipmr_device_event
Date:   Tue, 21 Apr 2020 07:21:48 -0400
Message-Id: <36C7F018-510E-4555-BC6B-42DEB0468CBA@lca.pw>
References: <CACT4Y+ZuGaeyyVsCkqJRo4+0hoMP8Eq_JTuU0L-NFqTrQP_czA@mail.gmail.com>
Cc:     syzbot <syzbot+21f82f61c24a7295edf5@syzkaller.appspotmail.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        David Miller <davem@davemloft.net>, kuba@kernel.org,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
In-Reply-To: <CACT4Y+ZuGaeyyVsCkqJRo4+0hoMP8Eq_JTuU0L-NFqTrQP_czA@mail.gmail.com>
To:     Dmitry Vyukov <dvyukov@google.com>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 21, 2020, at 6:51 AM, Dmitry Vyukov <dvyukov@google.com> wrote:
>=20
> +linux-next, Stephen for a new linux-next breakage

I don=E2=80=99t know why you keep sending the same thing over and over again=
 where I replied you just two days ago for the same thing.=
