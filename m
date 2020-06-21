Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A8AC433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 04:04:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C0D1247E7
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 04:04:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="bpLMLL2x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725876AbgFUEEY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 00:04:24 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:34063 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgFUEEY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 00:04:24 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49qJny0ynCz9sSf;
        Sun, 21 Jun 2020 14:04:22 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1592712262;
        bh=0y9lqcZxScz6v4FrAxC6Cq/NFnvqITQh9WW4FNVlxn4=;
        h=Date:From:To:Cc:Subject:From;
        b=bpLMLL2xXSZHpNvr7yF4n1uauLbIUMleOopQhhRG4c3Yu2xbx8T+zkERVMTpbNuvy
         fm7TEkdF85gquZB+43wKiq6fMwofLr9FMc/CPvUNKqlJaCtMa8HBsRBCXKsbVMV6ES
         nouWyppw7Xlxx4PwIbawcH3HJcQdSv6cS7Iq8Z5vt5dp32i2SwgwKuJJBF9+6nwEYw
         enwcgkG6XhMWUz7yKgoRivjUWYce3oMdrjDCxYw5b1WRmMA+o0HzjKuJArJ0ogzEuG
         Cj/Jc5xeZSe6q8s9ZHoU3Njx8HXgIyc0YtB6ptYWGu14DbwAtjBZguJlKZFpE+vCvk
         sabujgnLsIOnA==
Date:   Sun, 21 Jun 2020 14:04:21 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: build failures after merge of the hid tree
Message-ID: <20200621140421.7f4552df@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BzAOoJymflJFIspQvfqam+H";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BzAOoJymflJFIspQvfqam+H
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the hid tree, today's linux-next build (x86_64 allmodconfig)
failed like this:

drivers/hid/intel-ish-hid/ipc/ipc.c:12:10: fatal error: client.h: No such f=
ile or directory
   12 | #include "client.h"
      |          ^~~~~~~~~~
drivers/hid/intel-ish-hid/ipc/pci-ish.c:22:10: fatal error: ishtp-dev.h: No=
 such file or directory
   22 | #include "ishtp-dev.h"
      |          ^~~~~~~~~~~~~

I don't know what caused it, but commit

  470376737e88 ("HID: allow building hid.ko as an external module")

did not fix it.  BTW, I build with "make O=3D...".

I have used the hid tree from next-20200618 for today.

BTW, the hid tree really needs cleaning up, it contains merge commits dating
back to April 2018 :-(

$ git rev-list --count origin/master..hid/for-next
301
$ git rev-list --no-merges --count origin/master..hid/for-next
12

--=20
Cheers,
Stephen Rothwell

--Sig_/BzAOoJymflJFIspQvfqam+H
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7u3EUACgkQAVBC80lX
0GzZpAgAoaKisReGtr78dW8JHDYwVt+w00ysYLl7yuQGSkH+4qtGsUqxpNAEaSq9
jrVGg1I07+zzhnKlDuS2tQ0kG+TKjDgMYgYZEQEaCfQUso2EzIS6KaSc1VJiMKnn
nRxYsqfFDYDKACDeH9PqrN+hyP47ODNZ/GDw5dvI9dX9Hcf0WkSiF/JTZETVw4Qi
7MTNGneToYrbLXDcRJOfmFhcUwDA2RXQ1NifxtLvPPD4k1zVxbT/v3Fx+cZo5cGz
MC27QOAOeeejPl84txuBqP19GOgEfvU+8EIt4DzL44O0DfcqhilJwjoGmpzwS/Os
I03c/aJbbkxHx/Tn4O9+Rg6cudHz0g==
=heXW
-----END PGP SIGNATURE-----

--Sig_/BzAOoJymflJFIspQvfqam+H--
