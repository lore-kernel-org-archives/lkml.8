Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B5BC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:43:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A621E20663
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 16:43:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="ZI64ZvYC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbgGHQn2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 12:43:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730315AbgGHQn1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 12:43:27 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEDAC08C5CE
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 09:43:26 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id lx13so32597169ejb.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 09:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=FQSHslaL0I5rKFTIhpxMpuxHDgff/m/4s4E6drvSh50=;
        b=ZI64ZvYCqO1H9OvrPp+sZP7/XNOM1eSKEv165nyoWnJKSgYOqctlem6U92BTuRwSno
         JKFPw1V3X9OTm1K5+0imAO2r1YwBMe9FG28MNUzf1FUKOVXd9pjlxg3T08k47hWbRc3m
         1hBLD+5rWU2nj1yJhY3r4oTRao5i6jhtiT49spGa5MbIFpSuIpRQYOjfrsVHGd9xOqce
         EvMVBeHzaZyl6JQm1dDYzs8aVpuhwC/DiOxXdLsOJ3gQsQwfiaS9xRC3ppomgcU6VDbL
         WlQjE6a6mmTn82MsBhP3WJcSYWdOWRX+jqT/0W+8DzR+RrC8p0EAESmmPLw/RXl+9bAf
         1GCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=FQSHslaL0I5rKFTIhpxMpuxHDgff/m/4s4E6drvSh50=;
        b=D1CbGhUEnfTPdw+vGxrZCUUWo8RyfS3+gtKb6PJybGbE5jA0t5N/1OCVKxOQFQ8VBx
         +J3MXgcgxrrRqTELDyy+9FsfxWc2lKy7Sihu62geuyjKDj1nhE/irYuytTfctIWriwG8
         UD1tC2l/HU8QiKRa8yBgWgAGOHxyBknZGcim9gNFVcRv+fokIOD4ZjjBoo3xcduBhiEf
         dewYCNiiul5vaMRBoHkkepZX5hmmImPaiebjnG2OTiXbdkfokW5uHwYC6hPF+H7LHqru
         WeUL/p57mhTi6xUm+PJAwYRTt8pidw/QyckwD6hsy6BFLFYAXanX++5Vf6XkEYeGwGAA
         63+A==
X-Gm-Message-State: AOAM533LwmrDypUSofMTxNyCucdDX3ctq4ndQCQduZQc5imLxp9wYUa2
        EXbxTSO4qTBHmHIoGWsE/X0ocQ==
X-Google-Smtp-Source: ABdhPJwVOZw1Q3GjDKZxUluodDe6sBT5Cc5u0gd8LD+PmIgpIMcao77CAuaHErHT7XlP6ld5uZ5lEA==
X-Received: by 2002:a17:906:3a17:: with SMTP id z23mr42641650eje.238.1594226605397;
        Wed, 08 Jul 2020 09:43:25 -0700 (PDT)
Received: from [192.168.2.16] (5.186.127.235.cgn.fibianet.dk. [5.186.127.235])
        by smtp.gmail.com with ESMTPSA id w3sm55818edq.65.2020.07.08.09.43.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jul 2020 09:43:24 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   =?utf-8?Q?Javier_Gonz=C3=A1lez?= <javier@javigon.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3 4/4] io_uring: add support for zone-append
Date:   Wed, 8 Jul 2020 18:43:24 +0200
Message-Id: <4AB9628B-CD6C-4F30-8580-BF8DC2001EE3@javigon.com>
References: <20200708163327.GU25523@casper.infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Kanchan Joshi <joshi.k@samsung.com>,
        viro@zeniv.linux.org.uk, bcrl@kvack.org, hch@infradead.org,
        damien.lemoal@wdc.com, asml.silence@gmail.com,
        linux-fsdevel@vger.kernel.org, mb@lightnvm.io,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org,
        io-uring@vger.kernel.org, linux-block@vger.kernel.org,
        Selvakumar S <selvakuma.s1@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Javier Gonzalez <javier.gonz@samsung.com>
In-Reply-To: <20200708163327.GU25523@casper.infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On 8 Jul 2020, at 18.34, Matthew Wilcox <willy@infradead.org> wrote:
>=20
> =EF=BB=BFOn Wed, Jul 08, 2020 at 06:08:12PM +0200, Javier Gonz=C3=A1lez wr=
ote:
>>> I just wanted to get clarification there, because to me it sounded like
>>> you expected Kanchan to do it, and Kanchan assuming it "was sorted". I'd=

>>> consider that a prerequisite for the append series as far as io_uring is=

>>> concerned, hence _someone_ needs to actually do it ;-)
>=20
> I don't know that it's a prerequisite in terms of the patches actually
> depend on it.  I appreciate you want it first to ensure that we don't bloa=
t
> the kiocb.
>=20
>> I believe Kanchan meant that now the trade-off we were asking to clear ou=
t is sorted.=20
>>=20
>> We will send a new version shortly for the current functionality - we can=
 see what we are missing on when the uring interface is clear.=20
>=20
> I've started work on a patch series for this.  Mostly just waiting for
> compilation now ... should be done in the next few hours.


Awesome!
