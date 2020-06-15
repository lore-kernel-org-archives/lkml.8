Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1109C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 01:59:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AC2C20768
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 01:59:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=canb.auug.org.au header.i=@canb.auug.org.au header.b="XXfUbPRT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgFOB7b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 21:59:31 -0400
Received: from bilbo.ozlabs.org ([203.11.71.1]:58355 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728117AbgFOB73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 21:59:29 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49lZJb1frTz9sRf;
        Mon, 15 Jun 2020 11:59:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=canb.auug.org.au;
        s=201702; t=1592186367;
        bh=Y62cSTTNiDsE9l7hCk4un3+VHOfggzDmAIhiWe5M/x0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XXfUbPRTm0kLQoyKHVRXRQbBSKJZNAcNagxbHMZuWLVTHNHaBqScbhNiLy8jLOOLL
         Nm+Dk7fwfjoQnz+X+bRAL42VE13EBSGZzNvyA4nrOTABAg50VLUt6XoaMuAQiBUahk
         E8/bh5RnF8LRPHhB2eYR/hNTeIMUSu4D9B1vpMLZpKJ6b+H8wsrcjGBH6xNQ3hocDr
         6J0uAyZAMLoZ65hiDUxkzMwMImcqmDReK2aAPoswfkxe0E7x0g4l5LkUQw4+wTfxwD
         76gu1dKG4KQ8nN1pb7YMZorEt7mq9pt0dvyoDr7RWx1qqAm2YvtBBvwJB6vco4eDis
         TAlgCIBFsiC9A==
Date:   Mon, 15 Jun 2020 11:59:26 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: linux-next: stats (Was: Linux 5.8-rc1)
Message-ID: <20200615115926.515187f8@canb.auug.org.au>
In-Reply-To: <CAHk-=whfuea587g8rh2DeLFFGYxiVuh-bzq22osJwz3q4SOfmA@mail.gmail.com>
References: <CAHk-=whfuea587g8rh2DeLFFGYxiVuh-bzq22osJwz3q4SOfmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/CXDwErle5zWfhPG8oDMXpaY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/CXDwErle5zWfhPG8oDMXpaY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Sun, 14 Jun 2020 13:44:07 -0700 Linus Torvalds <torvalds@linux-foundatio=
n.org> wrote:
>
> So I didn't really expect this, but 5.8 looks to be one of our biggest
> releases of all time.

This was the second largest linux-next (and may have been the largest
if June 1 had not been a pubic holiday here).

As usual, the executive friendly graph is at
http://neuling.org/linux-next-size.html :-)

(No merge commits counted, next-20200602 was the first linux-next after
the merge window opened.)

Commits in v5.8-rc1 (relative to v5.7):            14206
Commits in next-20200602:                          13631
Commits with the same SHA1:                        12174
Commits with the same patch_id:                      843 (1)
Commits with the same subject line:                  130 (1)

(1) not counting those in the lines above.

So commits in -rc1 that were in next-20200602:     13147 92%

Some breakdown of the list of extra commits (relative to next-20200602)
in -rc1:

Top ten first word of commit summary:

    140 powerpc
    117 perf
     49 kvm
     46 net
     32 media
     23 drm
     22 dm
     21 thermal
     21 scsi
     19 x86

Top ten authors:

     45 christophe.leroy@csgroup.eu
     38 irogers@google.com
     32 christophe.leroy@c-s.fr
     21 acme@redhat.com
     20 mchehab+huawei@kernel.org
     20 masahiroy@kernel.org
     18 amit.kucheria@linaro.org
     16 david@redhat.com
     15 hare@suse.de
     14 viro@zeniv.linux.org.uk

Top ten commiters:

    148 mpe@ellerman.id.au
    120 acme@redhat.com
     80 davem@davemloft.net
     49 torvalds@linux-foundation.org
     39 pbonzini@redhat.com
     35 mst@redhat.com
     34 axboe@kernel.dk
     32 mchehab+huawei@kernel.org
     28 daniel.lezcano@linaro.org
     23 tglx@linutronix.de

There are also 485 commits in next-20200602 that didn't make it into
v5.8-rc1.

Top ten first word of commit summary:

     90 drm
     51 mm
     20 bus
     14 i2c
     13 fsinfo
     13 fs
     10 memory
     10 media
      8 soc
      8 fsi

Top ten authors:

     42 akpm@linux-foundation.org
     20 alexander.deucher@amd.com
     19 dhowells@redhat.com
     18 cai@lca.pw
     15 axboe@kernel.dk
     15 arnd@arndb.de
     12 minchan@kernel.org
     11 ysato@users.sourceforge.jp
     10 rppt@linux.ibm.com
     10 ira.weiny@intel.com

Some of Andrew's patches are fixes for other patches in his tree (and
have been merged into those).

Top ten commiters:

    164 sfr@canb.auug.org.au
     84 alexander.deucher@amd.com
     19 dhowells@redhat.com
     18 ysato@users.sourceforge.jp
     15 tglx@linutronix.de
     15 axboe@kernel.dk
     14 wsa@kernel.org
     14 manivannan.sadhasivam@linaro.org
     13 treding@nvidia.com
     11 tytso@mit.edu

Those commits by me are from the quilt series (mainly Andrew's mmotm
tree).

--=20
Cheers,
Stephen Rothwell

--Sig_/CXDwErle5zWfhPG8oDMXpaY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAl7m1f4ACgkQAVBC80lX
0Gx8qQf/cLJTXGWaHqDI4FOhyRAvwxSVYB3M53FhLTfgPL/kTJryVaEYNl7U8syj
RnFlKfz0L407SrIaDc4FEzrVPIN5Y9djIrNDrAdSkdDPuyxh5xYAJndrs1jHVJlW
38H117bfHIbPNT3v0KDHtAVAm4pQauPYLtiHrJEkJuCL77sAw4J0z77fbl8ZEUUh
ChOnIh9qBBHWp+oPcNPOMhUHYfbDBECMCAlj6al5DFX8II8TErDVgC0PFdeyyum+
yxjhFKZDzOtIQfhPrwv0dnG21lyZNSsW/RNhekFVvHRncRvHjM/aaAk+PkURgVdD
2EI/vp8obFc+1C2xRVMu30t9Oyqeiw==
=MqAZ
-----END PGP SIGNATURE-----

--Sig_/CXDwErle5zWfhPG8oDMXpaY--
