Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEE5C43461
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 14:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02C5A21532
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 14:52:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="lp7l+6dw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730045AbgIGOwV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 10:52:21 -0400
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167]:29288 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729818AbgIGOpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 10:45:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1599489903;
        s=strato-dkim-0002; d=goldelico.com;
        h=To:References:Message-Id:Cc:Date:In-Reply-To:From:Subject:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=NOna0XYj9tBCqmu0fx8vHTHHo5OSSALK9O6lyq/Fb8w=;
        b=lp7l+6dwG5ets1LyBZJZg+PhCl8Zij4Xgrqm9sUuB5Qen6y7IZ1/C2yJoruGfhLK5n
        IIRgMwyYOpV57QI+71gG8QItK+UASzYFchWz0ULy+Wp8EqWBGSCgCDq8DZCJGuWswoIt
        IHINPGVqQxI9eWZB8kxIYILGlWbekqlJ/f7iAn/StOotiRhU8ydwiUBwb6OxMpXAovn0
        snJSEea/wV3+ELYvf02qdCHHW3k4HkBayrXtsN1e1Aa/Nd42628jJ9Nf3NryXSfkyhWQ
        1c72udsSXNWVIiEwYcoekTTO4RVl63Z4qg65kKTIp5GXDdlUJENLM0jpg2aeHn0plKnc
        C8tg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMgPgp8VKxflSZ1P34KBj4Qpw9iZeHmMiw4/p9Q=="
X-RZG-CLASS-ID: mo00
Received: from imac.fritz.box
        by smtp.strato.de (RZmta 46.10.7 DYNA|AUTH)
        with ESMTPSA id n03b0dw87Eg3Q8O
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Mon, 7 Sep 2020 16:42:03 +0200 (CEST)
Subject: Re: [BUG]: KVM: arm64: Fix symbol dependency in __hyp_call_panic_nvhe
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Content-Type: text/plain; charset=us-ascii
From:   "H. Nikolaus Schaller" <hns@goldelico.com>
In-Reply-To: <20200907142206.GL8670@sasha-vm>
Date:   Mon, 7 Sep 2020 16:42:02 +0200
Cc:     David Brazdil <dbrazdil@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3FB315D0-C65D-49C0-A632-6E103F1D02B7@goldelico.com>
References: <3750C774-62A4-4D02-8C07-6C98304F32F3@goldelico.com> <20200907142206.GL8670@sasha-vm>
To:     Sasha Levin <sashal@kernel.org>
X-Mailer: Apple Mail (2.3124)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Am 07.09.2020 um 16:22 schrieb Sasha Levin <sashal@kernel.org>:
>=20
> On Mon, Sep 07, 2020 at 03:29:40PM +0200, H. Nikolaus Schaller wrote:
>> Hi,
>> it seems as if your patch
>>=20
>> 34f379956e9d7 ("KVM: arm64: Fix symbol dependency in =
__hyp_call_panic_nvhe")
>> [ Upstream commit b38b298aa4397e2dc74a89b4dd3eac9e59b64c96 ]
>>=20
>> fails to compile in v5.8.7 for me (using an aarch64 gcc 4.9 =
cross-toolchain to try
>> to build a kernel for the PinePhone):
>>=20
>> CC      arch/arm64/kvm/hyp/switch.o - due to target missing
>> arch/arm64/kvm/hyp/switch.c: In function 'hyp_panic':
>> arch/arm64/kvm/hyp/switch.c:904:2: error: impossible constraint in =
'asm'
>> asm volatile("ldr %0, =3D%1" : "=3Dr" (str_va) : "S" =
(__hyp_panic_string));
>> ^
>=20
> Does upstream build correctly for you?

It is 100% upstream code in arch/arm64, just with a private config.
diff --stat arch/arm64 shows only 2 dts and 2 config files. It did
compile well with v5.8.5 and just broke after merge v5.8.7.

>=20
>> I can find the commit b38b298aa4397e2dc74a89b4dd3eac9e59b64c96 in =
upstream
>> but not the affected file. There is also "KVM: arm64: Split =
hyp/switch.c to VHE/nVHE"
>> which does a cleanup and rename and v5.9-rc4 compiles fine.
>=20
> Right, it got moved around in upstream.

Maybe this has fixed something...

BR and thanks,
Nikolaus

