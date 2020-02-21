Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A127C35657
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0C0F208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 16:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="kP8Rz3AF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbgBUQ2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 11:28:09 -0500
Received: from mout.gmx.net ([212.227.17.20]:45247 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbgBUQ2I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 11:28:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1582302487;
        bh=iZ4Md3zA+8TD9x9QKRbjlp2m/9bXeZixQfkesgDAkac=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=kP8Rz3AFpQWFFc8jVcaS5Oty5aD3KwMU7qCkFd8KsLVfoCiQsoiylxPN1eylRQGtt
         uH7+yP7hT3E0TVNsxQrlKxwNYXTsLf+QO/FLcVJ5MUycHNIPr4MLEz0g+Q6VssB1Mx
         l7jVfZWb+7lPtkL7qxsDbbjAzth69wwojeu8jc8I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from longitude ([5.146.194.18]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLi8m-1ineBs3qV6-00HbeR; Fri, 21
 Feb 2020 17:22:49 +0100
Date:   Fri, 21 Feb 2020 17:22:48 +0100
From:   Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To:     Tudor.Ambarus@microchip.com
Cc:     j.neuschaefer@gmx.net, linux-mtd@lists.infradead.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mtd: spi-nor: Simplify loop in spi_nor_read_id()
Message-ID: <20200221162248.GG2031@latitude>
References: <20200218151034.24744-1-j.neuschaefer@gmx.net>
 <5604429.rq6fcmI4QA@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fwqqG+mf3f7vyBCB"
Content-Disposition: inline
In-Reply-To: <5604429.rq6fcmI4QA@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Provags-ID: V03:K1:gwSw2P5bp5MrtvsX8GS9o9bSpULoPgmp11M6pF4Ku/78sHNr/JF
 P2ZE2CgtSpDSByK32+K/Xl1AXHZ1z9NWFvGLzuNSiVcyAd9Y6ZWwau6U2FdCWHrYdpK4LeS
 h/fL0T/MLF7am+a4r9xNNJQoAQKKEB/B1it4sskPOA7CkN8qHtjfiNaRwjUeTs5/38WfwW4
 oVj7uMyay+CK1E0jX0PUg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mQo1k0k4lkM=:a0bAAEnBvVQZpUHT08Rag4
 m5xXvWsjB5VfXhkttzLkexJ1F3EeQGkYvCQ5fXQ64vNfpfXPv7prXbrgjSpDn6YB//h9kZgUV
 gGYOxaEuxw1pbifuH1BFsfDbWmF3leuo/nT+iSXAsykT2zyaPfmdy/pnuGQHMe+M79+5COqYO
 lUdtbcZMPqjaZGzfVBE28CizA7X+2lZV/PZ/oVoP07OtQP1LWIRN0zAlZvZ82RdRf6CG/n3cY
 0eCV2iJ5h0NCgAOTAFq3rRlZQH8mmWv+rw7sawJt/7UYz1CHBF2lLVJyh/NlKnVp8ABTJgTDH
 I63uFZoqYerDQOAiHHPyIw7k2Sztg7i5G1RMSo/C1hiSuD6rSXeAvLfxDsMK+j9bNpC2yThu5
 Z8THfA37lYBEqsk6HCa9wmJLm6PATj3XqT+wSRlZeKbMTPuau9to/tolRXm/KiaW0lG2idWch
 QYiIV36cEWVSpfwnlfF/Z9l4alj0wbWvbWe88s7MIQ25xE3xCqtQRJzCpKb91UxX0TJrLhTP3
 j2ziBeYsrMEdt1dy7ggy4FbhCXRdan4kntqUKc/ZolqcQwX9EyUUFGBCzgZUFiG+/iDS6hrr7
 Dv83MMKOzK+3ZP7W02xbYmBYshAviuCEGqgGhOi2TQLdYoCOATVf1JInNuABKdK9plAqYC/F8
 bx+JIUPyBi3w9KNKbKGKudq1U+hMM1QPJan4DUSGb3QQMHzPwnlZJVfF0heUAJsad6ipfb6qY
 zZZ/Bjtwy6awYeGwQb3GSUTtxGnRmQXu2NCqPn0ZGN78WW1xakVfEbCGBB1wTG8Eop/O1QrCB
 7XY6ihOBsV9Wr3fL9+MYj/uAGgJx0AgXUp4Yffb0TLNfqOnTT99dje2Z6mnGwpaV7LIwrPQhT
 kJ6QziYd9xNoKH6i5+rLVYdF/OPP5z/B27nDM2Cl5l6H/CZi41tN/3GAnw/wX0z34cmpFIQFP
 N3YtvX6OOkHZriCqEwOsM40mf+Qmdxn4yRtvFYxRUAILrvTSxzRVog90p5TmleXU1qWpnpsCq
 mZP6KT9GOMd0pM8T6ReuxmaHP6rgSHQR4uATX80J2zUU8RC/Gg+dgDW2lVGfiYfphyWa20sGK
 fgc2/nCIRM7T22ifRg4EmOJ+8TuS0gJD8xFxY95Veqy8QDcvD+uNhFK+Z1SXtDippr+S3de7l
 5fUUq3FjTDXgm55wLHBWKndhQGFSPRpibIM4/BSjvrvKLfE66HPXMvFx1wAnOYEYfbJJWB03e
 iEsQeMbKKP00qvnHw
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fwqqG+mf3f7vyBCB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 19, 2020 at 08:06:08AM +0000, Tudor.Ambarus@microchip.com wrote:
[...]
> >  static const struct flash_info *spi_nor_read_id(struct spi_nor *nor)
> >  {
> > -       int                     tmp;
> > +       int                     tmp, i;
>=20
> while cleaning this function, would you rename tmp with ret?

Good idea, I'll do that in v2.

> >         u8                      *id =3D nor->bouncebuf;
>=20
> and please drop this tab between u8 and *id

The same with the other variables in this functions? They have tabs
between the type and the pointer star / name as well.

>=20
> >         const struct flash_info *info;
>=20
> Also, IMO, the definition of variables should be done with the focus of=
=20
> avoiding stack padding. With this in mind, I would first define the point=
ers=20
> and then the ints and smaller types. But there are others than prefer def=
ining=20
> the variables in a tree/reverse-tree way, depending of the length of the =
line.=20
> There's no agreement on this, either way if fine, do as you prefer.

I have no preference here. I think I'll keep it as is for now.


Thanks for the review,
Jonathan Neusch=C3=A4fer

--fwqqG+mf3f7vyBCB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEvHAHGBBjQPVy+qvDCDBEmo7zX9sFAl5QA8sACgkQCDBEmo7z
X9uH2Q//fzyLMsrdTB+uonzF2+F5EOdbALvPPFFgkuf08zQK5s/IVEXafKly3MDb
aBxj7lBRRADOjT4+UBTVRUr2ouB1VRw4oF1+qy6Oz0Uwcz7UrnSAmq6MezY12Gqp
wdfsOem2psiVOVEnAyeLbyFFTaBYqtX+GYc7Jyo3yfYh08iJ/ryFAPyppgahsQfv
D7j13FFrkOuOEJ/PjWUYIedD9NvTCuUb9EJrgRdGB/PzQtnvdRh2bPnEaNe6HZMs
xwOptqK8El9+RFT/PyXi7W/fxvTw2UxEYOZexUoJQL8OOb2w2kqz4VD1B7wZ5Vgw
nI2TIghlZ7k2PB2FC9Lsg+IakSvkkDsvCKqzM4B3fIKkJOiE8TDTxHZoo5CVH3B+
A5GdvJGc0gdfV2GuF9QxigGTx2C178jsQBmrT8f8i8pK8507ZSbx7MXfypF6X0Ax
gD0L5etKeJthGfDxc1sjywz/UEKF1kawXf5wVFhOHlZgruoePr7+RSna3iqgRAd1
QTx714TzBeeSBbTp9BINQnDb5FTgKgMQPCHKYlLjAsMgImEJ787AtlOyHhIAbPaq
dh46BHs5SlTei1js7/mEZTY/WaAQkzNP/Q5mUnCu//lN2HkfDM6hD/yWMT9Xrtz6
QlRksCjxSVihsH8ojX98SphmCWOng1kAvL5MTGZHx0rfheUMf6Q=
=ZS6o
-----END PGP SIGNATURE-----

--fwqqG+mf3f7vyBCB--
