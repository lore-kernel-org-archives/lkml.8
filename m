Return-Path: <SRS0=f/ZA=AP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0C5C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 02:49:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3A02206BE
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jul 2020 02:49:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="XPQlFxT8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgGDCtt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 22:49:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41689 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbgGDCtt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 22:49:49 -0400
Received: from [IPv6:2601:646:8600:3281:5dc2:80d2:54f0:602b] ([IPv6:2601:646:8600:3281:5dc2:80d2:54f0:602b])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 0642h1es2638706
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Fri, 3 Jul 2020 19:49:43 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 0642h1es2638706
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020062301; t=1593830983;
        bh=xdajIi3z5FFfZAyVanzcSQpfogwjK/4I+USQ7ObbpEE=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=XPQlFxT8T06YRZ7opcjjm3+cLdvEHMd3X/Y5XZfafJ86BFb/9mWelxuZgGpPptQ8r
         MFsQo1b0KftT0FQ6S4zL/qWR4O+nELOqUeEeAkezS5qhMof4C+BpxVSpRUFgfZcwmj
         T5nb4MhSYmURzPinEyLgq6+wt93fQwnrYVx10gDGxLfYcdDDlu3Vtixu0bmRNozbgJ
         0T0iNqTSObyaLXV7mWNssuQT+088t5Cs6XHxkRN5rOj7YJtdx371FTWc+gPSk+o/US
         VkXDpTeE9WK6Ua/l1zeC2GZ3nGCrpQFeXSbGMQ+qRB2NlIPQVxDuOKC8SAlymcqKlI
         ilo7IK3ldLKEA==
Date:   Fri, 03 Jul 2020 19:19:22 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <e60b1977-2e1d-75ee-e934-207658145098@youngman.org.uk>
References: <20200615125323.930983-1-hch@lst.de> <20200615125323.930983-10-hch@lst.de> <514b0176-d235-f640-b278-9a7d49af356f@zytor.com> <e60b1977-2e1d-75ee-e934-207658145098@youngman.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 09/16] initrd: remove the BLKFLSBUF call in handle_initrd
To:     antlists <antlists@youngman.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
CC:     Song Liu <song@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-raid@vger.kernel.org, linux-fsdevel@vger.kernel.org
From:   hpa@zytor.com
Message-ID: <54AE9966-852F-4F42-A720-8D6053F0EF52@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On July 3, 2020 5:18:48 PM PDT, antlists <antlists@youngman=2Eorg=2Euk> wro=
te:
>On 03/07/2020 04:40, H=2E Peter Anvin wrote:
>> On 2020-06-15 05:53, Christoph Hellwig wrote:
>>> BLKFLSBUF used to be overloaded for the ramdisk driver to free the
>whole
>>> ramdisk, which was completely different behavior compared to all
>other
>>> drivers=2E  But this magic overload got removed in commit ff26956875c2
>>> ("brd: remove support for BLKFLSBUF"), so this call is entirely
>>> pointless now=2E
>>>
>>> Signed-off-by: Christoph Hellwig <hch@lst=2Ede>
>>=20
>> Does *anyone* use initrd as opposed to initramfs anymore? It would
>seem
>> like a good candidate for deprecation/removal=2E
>>=20
>Reading the gentoo mailing list, it seems there's a fair few people who
>
>don't use initramfs=2E I get the impression they don't use initrd either,
>
>though=2E
>
>I don't know too much about booting without an initramfs - I switched=20
>ages ago - so what is possible and what they're actually doing, I don't
>
>know=2E
>
>Cheers,
>Wol

Not using any init userspace at all is an entirely different issue=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
