Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C8BC54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 21:57:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF74121D79
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 21:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Xkr8/aqZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726494AbgDVV5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 17:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbgDVV5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 17:57:12 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228FBC03C1A9
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 14:57:12 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id di6so1796025qvb.10
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 14:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=bCYSbrkAcLApqeSJQeNPRxPOgdiEgxapSs/4LEPZeLo=;
        b=Xkr8/aqZzSEbIaNU+WKouKonHl1hcN5AMM1//nlKNA333Xk9fYY3ZaTLBjzO4nwovj
         b9gdpHRiNeV5NUhsTTijI88Pjo0IgWUAXle17f3Z9eJ1n/v5m/vUBogJJSkvXrhhah+N
         y8tZCqU5SA9wcA86EBlOwOtdsXe8Tj+aoyyK694ag0v8T2lhBjSySOAUUvx9dWQfnKFw
         7/RN3GUf6N30hwJP+WOGzAJIrNywqTks65AAz/vNa2kM/6jD7TIvxehkWzCBmhogde0b
         yCXJq6ucAyc3LMjJX3FRNU93L+dDVuTs4/a6i2/8TWev+W1YqazcAS0USKbEbBdVBqY7
         vhEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=bCYSbrkAcLApqeSJQeNPRxPOgdiEgxapSs/4LEPZeLo=;
        b=M33IrcCnS2YR3yYzNXjesJ5KzIC887kdLrh/VJHUoMpSreklOL19A5wLf5MwPOa3dH
         Dx7LOjSHEHpM9j+iCik7E48DGPOSlCexGmDnhZL59mzfj4dbx81eJeRBa7pINWTriS+p
         wSL+ccQ5e+tq4yaW435+Y48Xo25mkM+7wLlA5D/75Hh4iyTncVl/cE49SQhsANdONjar
         icnGhsBWlrzwlF6byfBypvrCDtJHxlJ2bXiMC4TjWBzkuYljuhW4yZTK4lR68JwA+1N6
         TMCHEdnPG61BhecUZippCXLxfhf3amNfwBh1Aabwr4wWSRhtnIvcjbOgDtOArJYF/b/3
         oucw==
X-Gm-Message-State: AGi0PubrJ/ED4bkLyqWxwI8dednm3dppzFmOPDd7pUA59PoiKRinGGYy
        vZ9rgA3Q+dHk7Tzf7bM8kPOzQQ==
X-Google-Smtp-Source: APiQypLpF1KmQgQutpP9riEtxskbXWSTf4LPFqJK47m0AkgfbH050Ve6vTMp00YOimIktZ1oDLoPEg==
X-Received: by 2002:a0c:facb:: with SMTP id p11mr1166011qvo.17.1587592631204;
        Wed, 22 Apr 2020 14:57:11 -0700 (PDT)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 190sm329630qkj.87.2020.04.22.14.57.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2020 14:57:10 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: AMD boot woe due to "x86/mm: Cleanup pgprot_4k_2_large() and pgprot_large_2_4k()"
Date:   Wed, 22 Apr 2020 17:57:09 -0400
Message-Id: <462564C5-1F0F-4635-AAB8-7629A6379425@lca.pw>
References: <20200422214751.GJ26846@zn.tnic>
Cc:     Christoph Hellwig <hch@lst.de>, Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>
In-Reply-To: <20200422214751.GJ26846@zn.tnic>
To:     Borislav Petkov <bp@alien8.de>
X-Mailer: iPhone Mail (17D50)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 22, 2020, at 5:47 PM, Borislav Petkov <bp@alien8.de> wrote:
>=20
> Very good catch - that's one nasty wrongly placed closing bracket!
> pmd_set_huge() has it correct.
>=20
> Mind sending a proper patch?

I thought Christ is going to send some minor updates anyway, so it may be be=
tter for him to include this one together? Otherwise, I am fine to send this=
 one standalone.=
