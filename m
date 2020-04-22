Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94220C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 16:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 662C02082E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 16:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="JbAJCGJM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbgDVQfM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 12:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgDVQfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 12:35:12 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30C0C03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 09:35:11 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id m67so2987787qke.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 09:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=DqTx+R+JV6vymEcgZ+pw6C27qjNlWqJpkbsx1i9Y7eY=;
        b=JbAJCGJMhGu88bPCsY7coswwKtqVoO+QQiV1fZdl6ErPz9dHJqZeWPGnzxvQ1zeL7F
         5gGlSkjuYxwAkgjXDV4/IyjCXZ2l7CtolGQ/DLGxATIg02NiWkQVGPzt7Mgpo7O+sE1f
         5/U8xisyFAzBGOrm79KMQY4mmTDzeR+ZJZeSgZf7OfdU6jnWXirXdglQuC6Qjxm8L2wb
         5ewxwmddE7Dzh3e92I6qvePV9MQ2OpAwIyJI5kd93dL15L8gryo0QhxdO6h0P/cFV3Mv
         wFJVS8Yk51coyJoGrINcIM1kpGxPvbhTzEJRr2I/5VaixcLArGBh+tDIiu6wzPpn6Gj8
         cn8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=DqTx+R+JV6vymEcgZ+pw6C27qjNlWqJpkbsx1i9Y7eY=;
        b=jGP5D5vMS7Skck3NGqPgOaLrpQax4d5yBZEGYw053ygJ6sher3uDrZzmOFFh5GaTkt
         RfyyulmVNbHCKLlI/NAiDvrWFCL+pjWI42QbkQErO06pwvrncXxeV6JJTw569z+GYi6i
         XvKyiNFWfCDt3vE+osvFWFLk/uKMuOrBcq3SYpd9Cr7fPLbcidwT4d6NpUrmpmWcfsGr
         a9GnQg97hFClUkzcP/j4eRl3ZTmU7yhkz4qauxA4VVFYt09w/+lVB8r/iqXNlxxmdQm9
         c63EcS4HLIiJp3Skh+9TWFARaZRk+Qrvg1gAs984LXwoSpP4RPJM2vZkKwz/8usamB+O
         s4QQ==
X-Gm-Message-State: AGi0PubnF+dGP14j0ce6pYyx4VfLofPimhJ0+hVpYqjkB08C3IEo+WuM
        K2UkzMPOj4JJnf6LCivLaOrPSw==
X-Google-Smtp-Source: APiQypKZehf5rRPMT55k+qjxOkJxOGmhAhEj6nXZhHKApHPnIxrSlYi+tmd2g2gTnL7FsTdjkBhtqQ==
X-Received: by 2002:a37:a090:: with SMTP id j138mr28112903qke.168.1587573310995;
        Wed, 22 Apr 2020 09:35:10 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id d17sm4408130qtb.74.2020.04.22.09.35.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 09:35:10 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: AMD boot woe due to "x86/mm: Cleanup pgprot_4k_2_large() and pgprot_large_2_4k()"
Date:   Wed, 22 Apr 2020 12:35:08 -0400
Message-Id: <59604C7F-696A-45A3-BF4F-C8913E09DD4C@lca.pw>
References: <20200422161757.GC26846@zn.tnic>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
In-Reply-To: <20200422161757.GC26846@zn.tnic>
To:     Borislav Petkov <bp@alien8.de>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 22, 2020, at 12:18 PM, Borislav Petkov <bp@alien8.de> wrote:
>=20
> What is the special thing about this config? You have KASAN enabled and?
> Anything else?
>=20
> I need to know what are the relevant switches you've enabled so that I
> can enable them on my box too and try to reproduce.

The config has a few extra memory debugging options enabled like KASAN, debu=
g_pagealloc, debug_vm etc. The affected machines are NUMA AMD servers.=
