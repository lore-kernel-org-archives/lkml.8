Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2E74C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 23:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C3872064B
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 23:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="JeF6aey/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728014AbgGZXze (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 19:55:34 -0400
Received: from ozlabs.org ([203.11.71.1]:38673 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbgGZXzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 19:55:33 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BFKZC4Qlcz9sPf;
        Mon, 27 Jul 2020 09:55:31 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1595807732;
        bh=Fr3vWGZnocWpaQCTPNmdNT8S3mTtioms9OXn3Tuj0w0=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=JeF6aey/KplqXVwH5q2jc8UG7RWEutJbIidNvpEBWFC/zXRJfnyoGoMQFcCTAZ24/
         xs7rXmhuZe4NZHjVHdqGb3EE8mso6nfwidi17u5nPLB1VXtLOfZl9iRDNPT3Q5AsGR
         Z4xIa+mKPAgM2jfKrUjI0Pj8IClbLHLEQJS+j0HXuh6OZtOXh3sWmGSsnxjPfYtZkW
         PMVjv3luwjfaC9NYo3EJPD4gpWNx4kSJaeYktmZ8UfU4FGfmmPpLjhggeNZL24quS1
         ZbDqCtjnQdMPMIaj0JyLws9TFTd/ZbLv8CwmKRPDKfynX01a7eCFI8qRxYM6cDx9Wo
         3qDKk3/nceWcA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/9] powerpc: delete duplicated words
In-Reply-To: <b796e912-e945-3cb1-03f8-0f38009634a4@infradead.org>
References: <20200726162902.Horde.TCqHYaODbkzEpM-rFzDd8A2@messagerie.si.c-s.fr> <b796e912-e945-3cb1-03f8-0f38009634a4@infradead.org>
Date:   Mon, 27 Jul 2020 09:55:31 +1000
Message-ID: <87wo2pg7bg.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Dunlap <rdunlap@infradead.org> writes:
> On 7/26/20 7:29 AM, Christophe Leroy wrote:
>> Randy Dunlap <rdunlap@infradead.org> a =C3=A9crit=C2=A0:
>>=20
>>> Drop duplicated words in arch/powerpc/ header files.
>>=20
>> How did you detect them ? Do you have some script for tgat, or you just =
read all comments ?
>
> Yes, it's a script that finds lots of false positives, so I have to check
> each and every one of them for validity.
>
>>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>>=20
>> You say you Cc Michael, but in fact you don't ... Allthough he is the po=
werpc maintainer
>
> Thanks for noticing that.
> [time passes]
> I checked all of my emails for this patch series and they say that Mike w=
as Cc:ed
> on all of them.
>
> I am adding his email address back to this one.
> Mike, did you receive this patch series?

Yes.

There's a mailman option which drops me from being explicity on Cc,
because I'm subscribed to the list. Otherwise I get two copies of
everything.

So as long as it goes to linuxppc-dev I should see it, regardless of
whether I'm explicitly listed in Cc.

cheers
