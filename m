Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B5A0C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E27FA2082F
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 10:47:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LDWGbptm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727962AbgBLKrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 05:47:49 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32236 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727912AbgBLKrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 05:47:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581504467;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bU58FGBGLS0jy1qDfhQyMLCuH6KWkAzBxj36lGqtNx4=;
        b=LDWGbptm1GIa/Ovc/btnYUwDslJvDkvL9NWOYuAoSyP8eJjxl01Do8RA5xRYljSCSGIqn9
        DB6GQb8RttxE74LHxsnOZ3t7yusB8rEODNixMG8lQ0S6gXrK4fNqjABu7cVZDZtOlrpXWF
        fUAE4ym8H9IuYfywbst9umb7prvei98=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-hsNPC2EANyusHgd0mOUKgw-1; Wed, 12 Feb 2020 05:47:43 -0500
X-MC-Unique: hsNPC2EANyusHgd0mOUKgw-1
Received: by mail-wr1-f72.google.com with SMTP id p8so653360wrw.5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Feb 2020 02:47:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=bU58FGBGLS0jy1qDfhQyMLCuH6KWkAzBxj36lGqtNx4=;
        b=CJXEzAN3L8wnXrLcPHyl5PFtuXO95Jvtxu6vqRGuZHkoGKC46M+AYaCesuld9D4lVL
         uL1InQaWxjedhfsyxUHkRTdRYEMpFFZlub3YWqmpiCVoAAPNsuk8c7+BmDyh8AGm/FMy
         El6wWrHxqx9jAZhLyCTDzRdsV034d1z9QV6bpJh5BhDjVRJdvJmxGEnE+WPl2Ps5Deb+
         8ysMv6hiiMHWd6aY13HhocXRHYumyKLd4JQlzFKmKWaxkbHs++zaW6ZIShlKIs3J57PU
         9+JwCCg5xdW5uv8W79+dOXMgEfq0KquvFxMKbMa3Ph8dvjNJsjoedGtz1nGtHMMReru5
         f9lQ==
X-Gm-Message-State: APjAAAVkySs5v2gJ6SEJy1dwU4Wwqsw9GXJMuapD8CRpIiKl0GzwcRMW
        /l9JWf/LeyQOm1f/VzILtD8ekICRJRE1UvaLmdRYby7p1ogbdNL2JJODAtCVRlLm6BXwj0bJJgG
        6cLbnpMDtblkHzQXRiTFKpZuN
X-Received: by 2002:adf:f6c8:: with SMTP id y8mr14325510wrp.167.1581504461736;
        Wed, 12 Feb 2020 02:47:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqwLBHyeNGsmOy6Es07w83didIiJIRTo7s+JH2ONtXWburJhx0+/jBzqkYCB8MGwirQ7Wvzn0Q==
X-Received: by 2002:adf:f6c8:: with SMTP id y8mr14325489wrp.167.1581504461457;
        Wed, 12 Feb 2020 02:47:41 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:652c:29a6:517b:66d9? ([2001:b07:6468:f312:652c:29a6:517b:66d9])
        by smtp.gmail.com with ESMTPSA id f8sm150241wru.12.2020.02.12.02.47.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Feb 2020 02:47:40 -0800 (PST)
Subject: Re: [RFC] eventfd: add EFD_AUTORESET flag
To:     Stefan Hajnoczi <stefanha@gmail.com>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Avi Kivity <avi@scylladb.com>,
        Davide Libenzi <davidel@xmailserver.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20200129172010.162215-1-stefanha@redhat.com>
 <66566792-58a4-bf65-6723-7d2887c84160@redhat.com>
 <20200212102912.GA464050@stefanha-x1.localdomain>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <156cb709-282a-ddb6-6f34-82b4bb211f73@redhat.com>
Date:   Wed, 12 Feb 2020 11:47:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200212102912.GA464050@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xU0tVZrw8brOJjVsV01vKofMTvhRKZKxV"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xU0tVZrw8brOJjVsV01vKofMTvhRKZKxV
Content-Type: multipart/mixed; boundary="MaDoqHjjBxHp8eCAqI3jz65LJEMmeZZxz"

--MaDoqHjjBxHp8eCAqI3jz65LJEMmeZZxz
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12/02/20 11:29, Stefan Hajnoczi wrote:
> On Wed, Feb 12, 2020 at 09:31:32AM +0100, Paolo Bonzini wrote:
>> On 29/01/20 18:20, Stefan Hajnoczi wrote:
>>> +	/* Semaphore semantics don't make sense when autoreset is enabled *=
/
>>> +	if ((flags & EFD_SEMAPHORE) && (flags & EFD_AUTORESET))
>>> +		return -EINVAL;
>>> +
>>
>> I think they do, you just want to subtract 1 instead of setting the
>> count to 0.  This way, writing 1 would be the post operation on the
>> semaphore, while poll() would be the wait operation.
>=20
> True!  Then EFD_AUTORESET is not a fitting name.  EFD_AUTOREAD or
> EFD_POLL_READS?

Avi's suggestion also makes sense.  Switching the event loop from poll()
to IORING_OP_POLL_ADD would be good on its own, and then you could make
it use IORING_OP_READV for eventfds.

In QEMU parlance, perhaps you need a different abstraction than
EventNotifier (let's call it WakeupNotifier) which would also use
eventfd but it would provide a smaller API.  Thanks to the smaller API,
it would not need EFD_NONBLOCK, unlike the regular EventNotifier, and it
could either set up a poll() handler calling read(), or use
IORING_OP_READV when io_uring is in use.

Paolo



--MaDoqHjjBxHp8eCAqI3jz65LJEMmeZZxz--

--xU0tVZrw8brOJjVsV01vKofMTvhRKZKxV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAl5D19IACgkQv/vSX3jH
roM+aAf/W3jBbdLNeQLTS0tYtPLyv8cKjG4tqJDI1MqsLa0ZboNfbejC+I//nLsn
yww6C9VTcbCtwGLsZcw6gHjRqJZH5jbZIlUKITmFYO1zs5wpIBr7zdjfQ7J6aJjJ
Gr2F/p+/Idy+PmetqsTaM2c+bluEodXk/mks5lqylxxuG8JNTwvl1ZHu9e2ITNAp
ZsftPzb78n5EPlZGGkcwwwGWj+285Ah5r2tN8UWZgn1EV5AQ/CUYwvzWLseeaNJA
q4Alm/OTEEqIY2QidMU48of2wCZA/kTNsO815RjUvIFE2fNtweISOu5ElDXn24Ov
ca6hSkq7yToF+9vxMrNZJsjJSrN3LA==
=7XVH
-----END PGP SIGNATURE-----

--xU0tVZrw8brOJjVsV01vKofMTvhRKZKxV--

