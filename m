Return-Path: <SRS0=flzY=3U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34493C33CB2
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 07:01:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03F7320705
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jan 2020 07:01:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=russell.cc header.i=@russell.cc header.b="WUnP55PU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eWMqdOV0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgAaHBj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 02:01:39 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:51655 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726127AbgAaHBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 02:01:38 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id B98E372C;
        Fri, 31 Jan 2020 02:01:37 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 31 Jan 2020 02:01:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        t/GpK6YsM5srRFf7eFpXme57d41WlX9+o+qAquTPbfY=; b=WUnP55PUGNZUnNgg
        nCC6+Xby2ixN1VG0TnMXE0MGmvManZHvl4QjoRSIWlWn501h0A97hT86h/W3Vv0d
        /SyDesb9JQeXveIte5GJuz+jHsDasy459cDE+iAskHk1r1qnVNSZeMoNwU3K1hhR
        75g9mWhEQXTLd91Md+saO87sl9mnSkrPcM1+GGxzlhmL2gRIEn7fAy+GdqBPQv0n
        Y6ppTNw5CCLL2NQaOcrVVL48LW3MeoY1Li8UzZSTRwmppBv42rXqoMF5sspgfvBF
        5agO1T+IDNV+BnFtE4sy62gRy5DvPvTYcTMiZbQSrlSMJlD8BEOoEXxMNO1FYOyz
        iqlLwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=t/GpK6YsM5srRFf7eFpXme57d41WlX9+o+qAquTPb
        fY=; b=eWMqdOV0wHgRiduKdiglB1u/pBpJaQMLLyYLQ1mA2ovG2/QAoJ18iTR+c
        z2q5mVR5mdF3stI2oRU658zN3PMKmC0hMkhHEwbhvgwxCjHFCRdqlql55RwC1ADa
        l5ODIF4jsBWsiUslco2kQgWJN8xsHV0EMNuySn9cMf+Cz36HsXWo13JoeYCdStk8
        r8NmqBlFp93DSeApXK4zmj600vjkOR2jpT7Us2nEu43PEuomXlei7PMjYs7U/lYc
        r04jLCxy3xbG4jUDfJuXJ4S1n4Z/1Y6GaNSTTyU2pe8KlORAIcWkJwSeqNmSk4JS
        ecuXaUuHMgY5U/w/khTGLLmo2oivg==
X-ME-Sender: <xms:0NAzXqGzS9sO_L0E_NiIJt5SU0J2TR67rtnar_Yr_vDaq4yo1l64Wg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrfeelgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdeftddmnecujfgurhepkffuhffvffgjfhgtfggggfesthekredttder
    jeenucfhrhhomheptfhushhsvghllhcuvehurhhrvgihuceorhhushgtuhhrsehruhhssh
    gvlhhlrdgttgeqnecukfhppeduvddvrdelledrkedvrddutdenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehruhhstghurhesrhhushhsvghllh
    drtggt
X-ME-Proxy: <xmx:0NAzXnYqT8QLiIlSkd5nmOajtCbm_lecNG9Ec6XF5MsF33FGiW57Ww>
    <xmx:0NAzXqHSQcXlNGODJm_uaD8wtvvWalJTXVQAv9dUJoGE0ZLJyxZO6Q>
    <xmx:0NAzXlBiAeGTCGIsyf9Cyn9yrL4OXtPQl43bxAt1R08nA_r5hpM6nA>
    <xmx:0dAzXjG8XyG67mG2BYnamOPEQ07UDA6GdP2sDeTAd0jX-r2WLqnc_Q>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id 403D53060A08;
        Fri, 31 Jan 2020 02:01:34 -0500 (EST)
Message-ID: <9edd517d0238dc3319788a23d708b68102cdbc2f.camel@russell.cc>
Subject: Re: [PATCH] lkdtm: Test KUAP directional user access unlocks on
 powerpc
From:   Russell Currey <ruscur@russell.cc>
To:     Christophe Leroy <christophe.leroy@c-s.fr>, keescook@chromium.org,
        mpe@ellerman.id.au
Cc:     linux-kernel@vger.kernel.org, dja@axtens.net,
        kernel-hardening@lists.openwall.com, linuxppc-dev@lists.ozlabs.org
Date:   Fri, 31 Jan 2020 18:01:32 +1100
In-Reply-To: <c05a4327-0c81-0e3e-d93a-9d62183b146c@c-s.fr>
References: <20200131053157.22463-1-ruscur@russell.cc>
         <1b40cea6-0675-731a-58b1-bdc65f1e495e@c-s.fr>
         <0b016861756cbe27e66651b5c21229a06558cb57.camel@russell.cc>
         <c05a4327-0c81-0e3e-d93a-9d62183b146c@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-01-31 at 07:58 +0100, Christophe Leroy wrote:
> 
> Le 31/01/2020 à 07:53, Russell Currey a écrit :
> > On Fri, 2020-01-31 at 07:44 +0100, Christophe Leroy wrote:
> > > Le 31/01/2020 à 06:31, Russell Currey a écrit :
> > > > +	pr_info("attempting bad read at %px with write
> > > > allowed\n",
> > > > ptr);
> > > > +	tmp = *ptr;
> > > > +	tmp += 0xc0dec0de;
> > > > +	prevent_write_to_user(ptr, sizeof(unsigned long));
> > > 
> > > Does it work ? I would have thought that if the read fails the
> > > process
> > > will die and the following test won't be performed.
> > 
> > Correct, the ACCESS_USERSPACE test does the same thing.  Splitting
> > this
> > into separate R and W tests makes sense, even if it is unlikely
> > that
> > one would be broken without the other.
> > 
> 
> Or once we are using user_access_begin() stuff, we can use 
> unsafe_put_user() and unsafe_get_user() which should return an error 
> instead of killing the caller.

Even better, and thanks for your work on all this stuff.

- Russell

> 
> Christophe

