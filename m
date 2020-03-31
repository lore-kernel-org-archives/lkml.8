Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78388C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 12:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2F420838
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 12:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Daey3OiC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730619AbgCaMG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 08:06:29 -0400
Received: from mout.web.de ([212.227.15.3]:55505 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730357AbgCaMG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 08:06:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1585656382;
        bh=JcguktxdKcAMKzgaB7/yuZrpcK5k2nKwp2XqEnDn2lY=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=Daey3OiCEBuYbatVWiTdUmurWUjJc65B1fyG3TDPzdDFy2HKZGvk2ToSpVOKlrV3f
         WFqFCyUh3IYzlCLh29XoExHHpah5CeKBElpvWeQf46uPlJPyLRO62QW5T8BRBHarCG
         f3g2ZoLEsen/z5xPtUk7vTDwBWPoGMmG8V1/b7f8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.253]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lvk9E-1jIJt334Sy-017WK0; Tue, 31
 Mar 2020 14:06:21 +0200
Date:   Tue, 31 Mar 2020 14:06:12 +0200
From:   Lukas Straub <lukasstraub2@web.de>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        dm-devel <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [dm-devel] [PATCH v2] dm-integrity: Prevent RMW for full
 metadata buffer writes
Message-ID: <20200331140612.7c4722f0@luklap>
In-Reply-To: <alpine.LRH.2.02.2003301215050.8032@file01.intranet.prod.int.rdu2.redhat.com>
References: <20200227142601.61f3cd54@luklap>
        <alpine.LRH.2.02.2003301215050.8032@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/s8I2+mEP8SyXlfVJMg4t7./";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:BBiydipvMStQHKPKomSV4WLYdGwIa9yboqHFp2TyPZh7aBNgyK8
 koQzDE1lYSrUtLDKwTpzDbJntLDkguN21DTrUmGJpj8knc9N00O+uO3s4Ax38ieyMten9I/
 1pAKLfIII0fP37Pc+NgnobLhHC5cfSHY1R+ywOf16DZUG9udULykXhREil5zh4pj0/QsM3+
 kIPyR3A5aBWmYhudd+NrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:R7zpMn8TbzY=:PaIidx7Mqo3Nu9OPidmOqC
 EQ8XNXFtNmupBCtvCSb5oeld/5y4SCc27P9aZAXUdQKqW7nsDXfCTaDSSIqzRJxE0kkPnfEgH
 QKDmUCzeU2Ehr/UOUxEj3ckH20Jdcjy65PrVparE5aObH2cU8wXgssNFQOB08M20Bpv+40dUL
 /0kT4OeAMYW38n6uqcKYWviE8PAHSny+PSHv8V+YcT5R2+k+65xE0sNIMmBEr/AC6/iANOWh1
 sDaUiFM+D56vvx6sv9tA56ARolzNzwg2VbkQp3lu2iAz4xn0L+1Yt6B6eW7QdqMUUloMENA3Z
 NNvpo8JnDRMShyQzsnjo5IX/+wG/wc+dDrRcIsi8ljjbBc5maRRT/AEdIq8ZUa7lZPsaTNoAK
 rpuSU+lmOszjeuTJQanbDej6NLaQ/9r+Xa0A1L10R8iHoVe6nwfxsUuxG1xw04yrp4WMigsq9
 GePZZBiB7WGeT9pZqEbm8TwKRNLgrr0zZh0usthIkTAeSmEollOTc7qbGrb74/G7yUt0cGhG1
 QXjDv5gnpERfinIwOfuAfLpblj0Mj1jmVm9VbthAs3FzodHZm21KUFc4dWua8Z2RJXcIx4GJF
 Qjs/b2L/HMlpqOZYB/qZGeBzhMoa3ZkDK+Pve0VoCbcwnpKS5pwk6161lGXkPtA0OXNJf1Q+/
 QIt4T+Z2/lb60RxZ/etaUiyq/V4lvVZDgYeBuoLw6m153z6hlbweumdHc0cLIRi5Kis2GKHFZ
 6ggsPHmx/Uo53Ht9bnTyErXbj0RAw/ko5B7cxA5RUnibnPKWONapYbBcxILtcScPRpr5vVFxq
 tJB5gHcl/y1BJIbi4nrAGUgxhyDd+aMqHASAExp41toCrshZfBrO4DbBWfwvfuenL3IgHWi3U
 ja8Mojo2Q/2M47i9Rt/N+SdHAjSV2fE2bNDN0Apat0nSk2cM0dCSIudTlbL3kehcEpx7XTOcE
 4nloCiu8/yqi01b03Gz/mqes38G3B5k/8Op/WAw5DlKSw448KEWYj/M+hLY7cJ5eLgg+Rp/el
 WkRdjiWkH1ucS0XeffkJDJzfJQVracIO+hnEEKPvYgpUu48gN3ObadpEo4dD+0/54u+Vnbon+
 q4zZLRsaBBWYTTgOhrgflc++8rT/6UdkZreWjYJyTIxrCThAna1kWxdhLI3gDaIAhExmpIdK+
 zqySXbTs6pmfIt7den1xXgJg5I17VVlwnI083wHzG2avTpnx5VAvjDrVNeay5COgva+1NHV4o
 TI1d2crmaZZE2CMHm
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/s8I2+mEP8SyXlfVJMg4t7./
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 30 Mar 2020 12:34:04 -0400 (EDT)
Mikulas Patocka <mpatocka@redhat.com> wrote:

> Hi
>=20
> I tested it on my rotational disk:
>=20
>=20
> On Thu, 27 Feb 2020, Lukas Straub wrote:
>=20
> > If a full metadata buffer is being written, don't read it first. This
> > prevents a read-modify-write cycle and increases performance on HDDs
> > considerably.
> >=20
> > To do this we now calculate the checksums for all sectors in the bio in=
 one
> > go in integrity_metadata and then pass the result to dm_integrity_rw_ta=
g,
> > which now checks if we overwrite the whole buffer.
> >=20
> > Benchmarking with a 5400RPM HDD with bitmap mode:
> > integritysetup format --no-wipe --batch-mode --interleave-sectors $((64=
*1024)) -t 4 -s 512 -I crc32c -B /dev/sdc
> > integritysetup open --buffer-sectors=3D1 -I crc32c -B /dev/sdc hdda_int=
eg
> > dd if=3D/dev/zero of=3D/dev/mapper/hdda_integ bs=3D64K count=3D$((16*10=
24*4)) conv=3Dfsync oflag=3Ddirect status=3Dprogress
> >=20
> > Without patch:
> > 4294967296 bytes (4.3 GB, 4.0 GiB) copied, 400.326 s, 10.7 MB/s =20
>=20
> I get 42.3 MB/s. (it seems that my disk has better prefetch than yours).
>=20
> > With patch:
> > 4294967296 bytes (4.3 GB, 4.0 GiB) copied, 41.2057 s, 104 MB/s =20
>=20
> I get 110 MB/s.
>=20
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de> =20
>=20
> BUT: when I removed "--buffer-sectors=3D1" from the command line, I've go=
t=20
> these numbers:
> without the patch: 101 MB/s

I get 86.5 MB/s.

So in my case it's worth it and as you saw it doesn't (negatively) affect o=
ther cases.

Regards,
Lukas Straub

> with the patch: 101 MB/s
>=20
> So, you crippled performance with "--buffer-sectors=3D1" and then made a=
=20
> patch to restore it.
>=20
> The patch only helps 10%.
>
> Mikulas
>=20
>=20
> > ---
> > Hello Everyone,
> > So here is v2, now checking if we overwrite a whole metadata buffer ins=
tead
> > of the (buggy) check if we overwrite a whole tag area before.
> > Performance stayed the same (with --buffer-sectors=3D1).
> >=20
> > The only quirk now is that it advertises a very big optimal io size in =
the
> > standard configuration (where buffer_sectors=3D128). Is this a Problem?
> >=20
> > v2:
> >  -fix dm_integrity_rw_tag to check if we overwrite a whole metadat buff=
er
> >  -fix optimal io size to check if we overwrite a whole metadata buffer
> >=20
> > Regards,
> > Lukas Straub
> >=20
> >  drivers/md/dm-integrity.c | 81 +++++++++++++++++++++++----------------
> >  1 file changed, 47 insertions(+), 34 deletions(-)
> >=20
> > diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
> > index b225b3e445fa..a6d3cf1406df 100644
> > --- a/drivers/md/dm-integrity.c
> > +++ b/drivers/md/dm-integrity.c
> > @@ -1309,9 +1309,17 @@ static int dm_integrity_rw_tag(struct dm_integri=
ty_c *ic, unsigned char *tag, se
> >  		if (unlikely(r))
> >  			return r;
> >=20
> > -		data =3D dm_bufio_read(ic->bufio, *metadata_block, &b);
> > -		if (IS_ERR(data))
> > -			return PTR_ERR(data);
> > +		/* Don't read metadata sectors from disk if we're going to overwrite=
 them completely */
> > +		if (op =3D=3D TAG_WRITE && *metadata_offset =3D=3D 0 \
> > +			&& total_size >=3D (1U << SECTOR_SHIFT << ic->log2_buffer_sectors))=
 {
> > +			data =3D dm_bufio_new(ic->bufio, *metadata_block, &b);
> > +			if (IS_ERR(data))
> > +				return PTR_ERR(data);
> > +		} else {
> > +			data =3D dm_bufio_read(ic->bufio, *metadata_block, &b);
> > +			if (IS_ERR(data))
> > +				return PTR_ERR(data);
> > +		}
> >=20
> >  		to_copy =3D min((1U << SECTOR_SHIFT << ic->log2_buffer_sectors) - *m=
etadata_offset, total_size);
> >  		dp =3D data + *metadata_offset;
> > @@ -1514,6 +1522,8 @@ static void integrity_metadata(struct work_struct=
 *w)
> >  {
> >  	struct dm_integrity_io *dio =3D container_of(w, struct dm_integrity_i=
o, work);
> >  	struct dm_integrity_c *ic =3D dio->ic;
> > +	unsigned sectors_to_process =3D dio->range.n_sectors;
> > +	sector_t sector =3D dio->range.logical_sector;
> >=20
> >  	int r;
> >=20
> > @@ -1522,16 +1532,14 @@ static void integrity_metadata(struct work_stru=
ct *w)
> >  		struct bio_vec bv;
> >  		unsigned digest_size =3D crypto_shash_digestsize(ic->internal_hash);
> >  		struct bio *bio =3D dm_bio_from_per_bio_data(dio, sizeof(struct dm_i=
ntegrity_io));
> > -		char *checksums;
> > +		char *checksums, *checksums_ptr;
> >  		unsigned extra_space =3D unlikely(digest_size > ic->tag_size) ? dige=
st_size - ic->tag_size : 0;
> >  		char checksums_onstack[HASH_MAX_DIGESTSIZE];
> > -		unsigned sectors_to_process =3D dio->range.n_sectors;
> > -		sector_t sector =3D dio->range.logical_sector;
> >=20
> >  		if (unlikely(ic->mode =3D=3D 'R'))
> >  			goto skip_io;
> >=20
> > -		checksums =3D kmalloc((PAGE_SIZE >> SECTOR_SHIFT >> ic->sb->log2_sec=
tors_per_block) * ic->tag_size + extra_space,
> > +		checksums =3D kmalloc((dio->range.n_sectors >> ic->sb->log2_sectors_=
per_block) * ic->tag_size + extra_space,
> >  				    GFP_NOIO | __GFP_NORETRY | __GFP_NOWARN);
> >  		if (!checksums) {
> >  			checksums =3D checksums_onstack;
> > @@ -1542,49 +1550,45 @@ static void integrity_metadata(struct work_stru=
ct *w)
> >  			}
> >  		}
> >=20
> > +		checksums_ptr =3D checksums;
> >  		__bio_for_each_segment(bv, bio, iter, dio->orig_bi_iter) {
> >  			unsigned pos;
> > -			char *mem, *checksums_ptr;
> > -
> > -again:
> > +			char *mem;
> >  			mem =3D (char *)kmap_atomic(bv.bv_page) + bv.bv_offset;
> >  			pos =3D 0;
> > -			checksums_ptr =3D checksums;
> >  			do {
> >  				integrity_sector_checksum(ic, sector, mem + pos, checksums_ptr);
> > -				checksums_ptr +=3D ic->tag_size;
> > -				sectors_to_process -=3D ic->sectors_per_block;
> > +
> > +				if (likely(checksums !=3D checksums_onstack)) {
> > +					checksums_ptr +=3D ic->tag_size;
> > +				} else {
> > +					r =3D dm_integrity_rw_tag(ic, checksums, &dio->metadata_block, &d=
io->metadata_offset,
> > +								ic->tag_size, !dio->write ? TAG_CMP : TAG_WRITE);
> > +					if (unlikely(r))
> > +						goto internal_hash_error;
> > +				}
> > +
> >  				pos +=3D ic->sectors_per_block << SECTOR_SHIFT;
> >  				sector +=3D ic->sectors_per_block;
> > -			} while (pos < bv.bv_len && sectors_to_process && checksums !=3D ch=
ecksums_onstack);
> > +				sectors_to_process -=3D ic->sectors_per_block;
> > +			} while (pos < bv.bv_len && sectors_to_process);
> >  			kunmap_atomic(mem);
> >=20
> > -			r =3D dm_integrity_rw_tag(ic, checksums, &dio->metadata_block, &dio=
->metadata_offset,
> > -						checksums_ptr - checksums, !dio->write ? TAG_CMP : TAG_WRITE);
> > -			if (unlikely(r)) {
> > -				if (r > 0) {
> > -					DMERR_LIMIT("Checksum failed at sector 0x%llx",
> > -						    (unsigned long long)(sector - ((r + ic->tag_size - 1) / ic->=
tag_size)));
> > -					r =3D -EILSEQ;
> > -					atomic64_inc(&ic->number_of_mismatches);
> > -				}
> > -				if (likely(checksums !=3D checksums_onstack))
> > -					kfree(checksums);
> > -				goto error;
> > -			}
> > -
> >  			if (!sectors_to_process)
> >  				break;
> > +		}
> >=20
> > -			if (unlikely(pos < bv.bv_len)) {
> > -				bv.bv_offset +=3D pos;
> > -				bv.bv_len -=3D pos;
> > -				goto again;
> > +		if (likely(checksums !=3D checksums_onstack)) {
> > +			r =3D dm_integrity_rw_tag(ic, checksums, &dio->metadata_block, &dio=
->metadata_offset,
> > +						(dio->range.n_sectors >> ic->sb->log2_sectors_per_block) * ic->t=
ag_size,
> > +						!dio->write ? TAG_CMP : TAG_WRITE);
> > +			if (unlikely(r)) {
> > +				kfree(checksums);
> > +				goto internal_hash_error;
> >  			}
> > +			kfree(checksums);
> >  		}
> >=20
> > -		if (likely(checksums !=3D checksums_onstack))
> > -			kfree(checksums);
> >  	} else {
> >  		struct bio_integrity_payload *bip =3D dio->orig_bi_integrity;
> >=20
> > @@ -1615,6 +1619,13 @@ static void integrity_metadata(struct work_struc=
t *w)
> >  skip_io:
> >  	dec_in_flight(dio);
> >  	return;
> > +internal_hash_error:
> > +	if (r > 0) {
> > +		DMERR_LIMIT("Checksum failed at sector 0x%llx",
> > +				(unsigned long long)(sector - ((r + ic->tag_size - 1) / ic->tag_si=
ze)));
> > +		r =3D -EILSEQ;
> > +		atomic64_inc(&ic->number_of_mismatches);
> > +	}
> >  error:
> >  	dio->bi_status =3D errno_to_blk_status(r);
> >  	dec_in_flight(dio);
> > @@ -3019,6 +3030,8 @@ static void dm_integrity_io_hints(struct dm_targe=
t *ti, struct queue_limits *lim
> >  		limits->physical_block_size =3D ic->sectors_per_block << SECTOR_SHIF=
T;
> >  		blk_limits_io_min(limits, ic->sectors_per_block << SECTOR_SHIFT);
> >  	}
> > +
> > +	blk_limits_io_opt(limits, 1U << SECTOR_SHIFT << ic->log2_buffer_secto=
rs >> ic->log2_tag_size << SECTOR_SHIFT );
> >  }
> >=20
> >  static void calculate_journal_section_size(struct dm_integrity_c *ic)
> > --
> > 2.20.1
> >=20
> >=20
> > --
> > dm-devel mailing list
> > dm-devel@redhat.com
> > https://www.redhat.com/mailman/listinfo/dm-devel
> >  =20
>=20


--Sig_/s8I2+mEP8SyXlfVJMg4t7./
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl6DMjQACgkQNasLKJxd
sljl7xAAjXgtf6dcLjcJrMsMQkrHHlFlL1WbzsUwXL90+iEOfgJYBh/d+6HLnWLE
/Sl8fbWT8/Vy7f3XxAVoWp0h/+b0l863gr5gHF/89W6uUAfwcTX93PKERqRaVHCI
7M0ztwt9UC2K9clcrlqkbA3Iowpyrf7Xs8eQC8Xy5DZqLL8AHc36+qWqVkb8pcls
zQrA4Ygjcm21HUDAop/EWvYE96blJVyh6wKt2mTxjnPGkIh4J1YOkRe9NX+MAPuF
0I/4Bt/vo5B2HwCSv7Y6loEJMX1tEoGnPSnDEaHUpgYej0+/V5pjz4uvfPFnyczk
dMdvwLuEnxWgfAULSC3vN60kmJChGNXDDgv1NcWCaI0mMpNvnx8htweR/MVYcLx2
SwJ/fzw3nAkfo5m7gF3Ed875i1jXAWadhhf9Kdhy9HsrkX/8/+vOaP5z4tt9LZdR
CDTQRsJeWJ3+d4iU/lA5ZrzS1U91yoiu/3z6mYB2CmdFD+HOzcvXG6equ6/8Gtit
3TCiWmSTH2zo4WkAowu/wmK8RSguztbGsPnQYHyio2MI+cSPi7TtJ+CzdcvotVmc
vOOIE63pr4sb+OPQkQ9+sFlJs212JnfkV+xz6OIcmYK5fUj81t0N3yA8VWMIyfGt
4sTscTqtQaGINaCP+RWb8wk6najur3TuChaZYWMGsXTYdefn1/Q=
=jGdH
-----END PGP SIGNATURE-----

--Sig_/s8I2+mEP8SyXlfVJMg4t7./--
