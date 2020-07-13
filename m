Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA4FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA349206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 13:30:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MgyQBc6v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbgGMNa6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 09:30:58 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:52538 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729735AbgGMNa6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 09:30:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594647056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mE434XxwP5PyRWK73J9DHyYPMWNnnmIgbcOoIUclI7Y=;
        b=MgyQBc6viKaoWUCGmN00h3bVNdpTJbhnV51FeDPxGp4aDsKwheujAkLGP4fv05+V8cbs7s
        C9plRdop7ygmFJj+GmVqeXceL2Y1ySHBBdywjITFMaMM9OPsFZhjiLcc/JDXO/r+K7CkmD
        cKQ1bWZ9q87XKdVBb5O7QrgHsti4vaw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-92-iIkJF5WuNCizTUn0qGtMwg-1; Mon, 13 Jul 2020 09:30:43 -0400
X-MC-Unique: iIkJF5WuNCizTUn0qGtMwg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5956419200C1;
        Mon, 13 Jul 2020 13:30:42 +0000 (UTC)
Received: from localhost (ovpn-116-148.gru2.redhat.com [10.97.116.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C36385D9DC;
        Mon, 13 Jul 2020 13:30:41 +0000 (UTC)
Date:   Mon, 13 Jul 2020 10:30:40 -0300
From:   Bruno Meneguele <bmeneg@redhat.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        Jason@zx2c4.com
Subject: Re: [PATCH v2] doc:kmsg: explictly state the return value in case of
 SEEK_CUR
Message-ID: <20200713133040.GB4730@glitch>
References: <20200710174423.10480-1-bmeneg@redhat.com>
 <20200713022558.GC491026@jagdpanzerIV.localdomain>
 <20200713131509.GC20226@alley>
MIME-Version: 1.0
In-Reply-To: <20200713131509.GC20226@alley>
X-PGP-Key: http://keys.gnupg.net/pks/lookup?op=get&search=0x3823031E4660608D
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bmeneg@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="neYutvxvOLaeuPCA"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--neYutvxvOLaeuPCA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2020 at 03:15:09PM +0200, Petr Mladek wrote:
> On Mon 2020-07-13 11:25:58, Sergey Senozhatsky wrote:
> > On (20/07/10 14:44), Bruno Meneguele wrote:
> > > The commit 625d3449788f ("Revert "kernel/printk: add kmsg SEEK_CUR
> > > handling"") reverted a change done to the return value in case a SEEK=
_CUR
> > > operation was performed for kmsg buffer based on the fact that differ=
ent
> > > userspace apps were handling the new return value (-ESPIPE) in differ=
ent
> > > ways, breaking them.
> > >=20
> > > At the same time -ESPIPE was the wrong decision because kmsg /does su=
pport/
> > > seek() but doesn't follow the "normal" behavior userspace is used to.
> > > Because of that and also considering the time -EINVAL has been used, =
it was
> > > decided to keep this way to avoid more userspace breakage.
> > >=20
> > > This patch adds an official statement to the kmsg documentation point=
ing to
> > > the current return value for SEEK_CUR, -EINVAL, thus userspace librar=
ies
> > > and apps can refer to it for a definitive guide on what to expect.
> > >=20
> > > Signed-off-by: Bruno Meneguele <bmeneg@redhat.com>
> >=20
> > Looks good to me,
> > Reviewed-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
>=20
> The patch is committed in printk/linux.git, branch for-5.9.
>=20
> Thanks for v2.
>=20
> Best Regards,
> Petr
>=20

Thanks Sergey and Petr.

--=20
bmeneg=20
PGP Key: http://bmeneg.com/pubkey.txt

--neYutvxvOLaeuPCA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEdWo6nTbnZdbDmXutYdRkFR+RokMFAl8MYf4ACgkQYdRkFR+R
okO59wf5AYv1JZs5ZKpnv12HJJ1eEtnHywi+AUGzH+TDmlXLq8IE1mwqw+Nfj1TI
k7whD+BozqecifygMC/5yVO166N/D+Aco3kI1LgySTlMXuojuL0OEvrdcKW596Us
A4kDcZrtuzx4fwmKj+SjL07ga2WfE8G8uOtUPtmNl7I4zswayu6Ujh7sJ4trq+1T
wLwU19MzcXw43Xs50lIJNd287SFzrEWQ27Eeif3zYGWFQFZX5VSUkGoRtNudMyCd
kiBvXrzLphGa2hdHLChKGrqwBgKIpQ2GfBUmS5LBQdDkCHgtFfJxNxwrBQBx9NY1
f7TXJmGbxfxEVaAkUpX2E/AkzgUpug==
=jeqx
-----END PGP SIGNATURE-----

--neYutvxvOLaeuPCA--

