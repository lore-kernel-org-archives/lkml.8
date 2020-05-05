Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D81C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 16:37:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18599206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 16:37:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="TOAKhifQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbgEEQhA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 12:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728687AbgEEQg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 12:36:59 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 978FDC061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 09:36:59 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id h11so1027206plr.11
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 09:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=9Te4p8spYKXSVw3V0gfR6Oau5EFQ8EHhhEXqPtlU1vU=;
        b=TOAKhifQdBJXG2aEA2zey/8m+ClFdssXfab1gdtgSAr1wSKueldA8YRrL8plVQM5yD
         1rQbLL8hTP4IdRsbyqRZX6WuTSzB6arUXumeQ5r9MOn4BPug0gt5+ro2lzYyCJ1NReI5
         T0XlOgV7SqDaWR75eDDMgcvQsk5ODuKTk4LPoV3/y1XvYVAkfCzY8gbbd7/YRtdbUPX9
         3D3meKbsKHTCL15Ig0mAxEBOB4bk/8dxLFVPBn4PjlNJkwEx1FX4yAIBS+7hoIFbKyCe
         DFs6K4e+KzFCu5M0lSDKIBWqvLIAQGLh9CmN68OEGLEFa7wvjxYtuLB3dQhsyMP+ij6D
         q26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=9Te4p8spYKXSVw3V0gfR6Oau5EFQ8EHhhEXqPtlU1vU=;
        b=dn1qb8mG57STQMYrJ9f90oVFk9uPVBpjzGeQnyQKrUHJq9RRH0fzrFlnVmQAP6SolE
         lQTh1RO7a4w68zwHOjBPR9TUSl3HmnxZFD29o65V/6XwhpSCTmdMrmUQlQEMnj8LjbmJ
         pDeSk7LjJ1GUtBw4QgZTOaC+FA7c7GNHajH0b0tTvTQd8UvUY6+OoODbX2Qkuh938Cad
         f3scEf0oj4ZIINF4G2ptqS7mHMxbvsgoU/OG4M7P40+r0dG7iHRTqr+j6ygRXTnPjxI0
         4S7AGBUlowpULw8k7oWM4+EV0F9WbNErFIK1HqyPk3FSX/j1eiLi0qjs3gTpYlktPnsX
         GIfw==
X-Gm-Message-State: AGi0Pua/lGDf8WYjJ9nMr+P6EUTq8dLYLtB976Y3iHMLjMVh8vTPmhNq
        aMJYwmqTzFpDa/SmBI/Td9Z9Lw==
X-Google-Smtp-Source: APiQypLWETy/wRHMlEfeo9knRP1HXpMey8Jbww7QACcn1H57D4ThQPBDWwod73aIOlI8JARUZWEaTA==
X-Received: by 2002:a17:90a:8d12:: with SMTP id c18mr4124887pjo.144.1588696618860;
        Tue, 05 May 2020 09:36:58 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:cdd:7a71:a7ed:1085? ([2601:646:c200:1ef2:cdd:7a71:a7ed:1085])
        by smtp.gmail.com with ESMTPSA id o9sm2424343pjp.4.2020.05.05.09.36.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 09:36:57 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: x86/uv cleanups
Date:   Tue, 5 May 2020 09:36:46 -0700
Message-Id: <0EF76ADC-A842-4571-B964-B7A544E11FA3@amacapital.net>
References: <20200505153944.GD2297@hpe.com>
Cc:     Christoph Hellwig <hch@lst.de>, x86@kernel.org,
        Mike Travis <mike.travis@hpe.com>,
        Russ Anderson <russ.anderson@hpe.com>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200505153944.GD2297@hpe.com>
To:     Dimitri Sivanich <sivanich@hpe.com>
X-Mailer: iPhone Mail (17E262)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On May 5, 2020, at 9:25 AM, Dimitri Sivanich <sivanich@hpe.com> wrote:
>=20
> =EF=BB=BFYes, we do see a need to clean up old code where it exists, but w=
e would like
> to assume this responsibility ourselves in order to ensure functional cont=
inuity
> with externally available open-sourced modules that our customers rely on.=
  This
> code supports current Superdome Flex systems, as well as forthcoming platf=
orms
> based on Intel Cooper Lake and Sapphire Rapids processors.  Some cleanup i=
s
> already being included as part of a forthcoming patchset in support of the=

> upcoming Sapphire Rapids platform.
>=20

What is =E2=80=9Cfunctional continuity=E2=80=9D?  How does unused code suppo=
rt anything?

> Nacked-by: Dimitri Sivanich <sivanich@hpe.com>
>=20
>> On Mon, May 04, 2020 at 07:15:16PM +0200, Christoph Hellwig wrote:
>> Hi x86 maintainers,
>>=20
>> this series removes various exports and sniplets of dead code
>> from the x86/uv code.
>>=20
>> Diffstat:
>>=20
>>  8 files changed, 21 insertions(+), 111 deletions(-)
