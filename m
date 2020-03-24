Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F95BC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 18:59:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3656220714
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 18:59:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="DHlfHk+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgCXS7q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 14:59:46 -0400
Received: from mout.web.de ([212.227.17.11]:47713 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727672AbgCXS7p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 14:59:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1585076377;
        bh=GTpZWZHLPHgy2gNLa2S/h4IO4UZFntxIXA9jFZ/a+wU=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=DHlfHk+EFX9D9LO/swfw6bGKd+9kIVbinsGHd0yUACS4vl4z0NKxjjd3wUEOkGGWp
         aXN80xMHIRJOgx/90eUpOgCLsp3d9f/smwUpf/OkCMErNnltUbxzutEXZfyZ2U5N+E
         i001sHcNYUOZd+l4hRZ4Yeq6cjCWsFKEE5XVFaFs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.90]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MWB8f-1ik2JE1yMz-00XO2W; Tue, 24
 Mar 2020 19:59:37 +0100
Date:   Tue, 24 Mar 2020 19:59:27 +0100
From:   Lukas Straub <lukasstraub2@web.de>
To:     Mike Snitzer <snitzer@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Alasdair Kergon <agk@redhat.com>,
        dm-devel <dm-devel@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>
Subject: Re: [PATCH v2] dm-integrity: Prevent RMW for full metadata buffer
 writes
Message-ID: <20200324195912.518dc87c@luklap>
In-Reply-To: <20200324171821.GA2444@redhat.com>
References: <20200227142601.61f3cd54@luklap>
        <20200324171821.GA2444@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/rvl/9m6FmaAM/PFvXasJ67k";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:plIiOZQ4XIWl9QGmBFh7ZFJ1E4RnNZbPnAMq/Y+REwZB+/fOLNp
 cYASa+v/MplS1LG0fE5i8p3Mjnf+LC7ocuVRTskow5ygWVT6WnMSlJtgGVAGI3HHFROeMbX
 5WEy1HSRHojq/iHLsSrtoKcUhI/cMGnV4I6JwP92kH3CfzpEEiRzLhcia4BTwIA0jWAPfjy
 rfu7C3MA7ces+MxHx136g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XDa0g1t24Lc=:HCf/GjXe8AN5T2ffUjddBB
 nhRGbQqUJUj5T78odrbUqB4S/BYWMsFpMRcCvrYnAj6lkR5+xHMtPMZwulr1QT8dGYS7KgVoU
 5TWU6Zek+969WLKxGnJu1/5+FrTtWrA38fvzTVgMPUj7zEH4LhZuFSIy+J/B8dhri+a+B2CwB
 EiS6EyBWpJMQKuBZTFNA44DKXucXv2EMBQL0WAbhGqUIhpXochMJjdjkAV8j5D6kDW0gCJQYH
 f+j1incsRrxYgR2hm5S8U9XimnCJTm3KySUwjF3vOL4DIBVGvHC9zt77d/4GnspbOh9kjTrhs
 r+kPzltzCXWL0RdnRNwGdZiaGVjQDTim8d0Moul89lLyEYxERFplO/CqhkuDdg8WhE1rm4guA
 kqRS0bPGJbauu/U684mrMxGXKgK7//pZcG1cjOWHZD/Cg7pVluthGbDD74PI3TfBI+jnEG+lI
 h6TaaH68wGuwDjdn6xGtT/DeXmuGrcJuixDxTgB9PqiahjCQm7urSRL5nGSedw4qW72xLrwOo
 0qODdiDLbB6YUU+kjhMcz4S3xyH5FupBP/mRg5zJ8mWf1ViXp3fENQ0zHLDrrJxC0JcP4hF3O
 8ZeIOYp35+PvPELTgLgHg8DUTtnoixgNsbVlmeTYn5FeFD9frT0VS/bn9sa1N5WZZQ0Yu0F4S
 Y4EKh2tNscGQVox62c+8X7Hoi4EPYIf7w9kqRfk2x5soNa4bi6aIogeGs00aJo/dMaDpy2ea5
 zpB5K/IHBjiS34We8LcYPG3xPnZObGv3dl63rvDOCwJXjwUs+9eTtiaU57ijHpcCswj4/wWz2
 cgT5fI4dKRt9C9eq7qDBq2FN9jaS0MfoCvcrngHCeCPffRNsaEugb71NUNTkuCDJcji/qYSam
 /fG9O3RziPOW8LxZrfgNiwrTFP/Dzn1f0o1wODTjkFzOvWXWMMCM58uE09AIaknQ/CVyr0xrh
 7aWVjy1kv/4P8XFK4vW9ZXrA5v2X92RXYbvjneK+KbVvhXMEhudzkKuBoAh9fir6vo8RNKLxF
 zgsCAsVIwDeFFW5fCWrUVkZnr1ZZjH8yV7biScwnASBDjxczeoGZ2rtBzeLCLerEIae169GX4
 1kfddcPOP8/A2z4w/Eof5Bx3fwYZYS9UQZdpOHalSpGXCq7c2trVXl/EWMyT5Q1aXUkMtuox9
 hSRKV51T/SlBM0HnpwQfVb9Ac/xe+LDH8hWTuyy4CmSSyKDejxob0xrfO0fJLDR/RyAiATJLk
 ckF/8jaGAAVWIzI5v
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/rvl/9m6FmaAM/PFvXasJ67k
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 24 Mar 2020 13:18:22 -0400
Mike Snitzer <snitzer@redhat.com> wrote:

> On Thu, Feb 27 2020 at  8:26am -0500,
> Lukas Straub <lukasstraub2@web.de> wrote:
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
> > 4294967296 bytes (4.3 GB, 4.0 GiB) copied, 400.326 s, 10.7 MB/s
> >=20
> > With patch:
> > 4294967296 bytes (4.3 GB, 4.0 GiB) copied, 41.2057 s, 104 MB/s
> >=20
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
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
> > Lukas Straub =20
>=20
>=20
> Not sure why you didn't cc Mikulas but I just checked with him and he
> thinks:
>=20
> You're only seeing a boost because you're using 512-byte sector and
> 512-byte buffer. Patch helps that case but hurts in most other cases
> (due to small buffers).

Hmm, buffer-sectors is still user configurable. If the user wants fast
write performance on slow HDDs he can set a small buffer-sector and
benefit from this patch. With the default buffer-sectors=3D128 it
shouldn't have any impact.

Regards,
Lukas Straub


> Mike
>=20
>=20
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
> >  =20
>=20


--Sig_/rvl/9m6FmaAM/PFvXasJ67k
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAl56WI8ACgkQNasLKJxd
slhytw/+JQ2SvoMda2Nc3JAnYwgArLhFKB57cw92Qu4nNrqpx5ko4G2SLV6qJgEN
FcaIvsnzICzf0OEK4GKjKyvt4C413eVa8Ph73aH4idRI/6pnsVmX03PVVBITiQp0
Aywtt9Dgm7HW8Abyishr+3l3kh9bZjiapUzM6cdZQ1910/zIzQuap9grytATnfvw
WcZIgqEGhcY7AV3aZyZhtYMWXzCn5y0r9Ohnb0VFRTUJzm6pFbTx2Qlj4N+zs4Un
o9j2ltL1BBTL1yzVYnW5m3b+7VORcbhky8eMDYaeFSyQdWjQmtA1LBN+QmT983TW
AsrZ2draSTY6DnNxETX6rzdctV0X4Dc8nIMEqXtMYweGeo7kzCzUtuHeIB5pwyVI
crlf86uCEqMR2gKBYZfjNfu40JAhsSX10gc4ViGPlXtOwSFkiVY+fHqsOW3o1cxp
E0A7l8iAdY/zvR4NRGBtwii5QOpwsWus0sQmZPss38NjnTwRxxssQnmFu/Ex+lTu
qG7QdKRk9/dvjJhBxhtY0W2EX9UFb97jGsjfVQWQLV1MQY7jYF1qvsDuPJVH/cm2
aptA2XDxLjchnIvNru7xclWUBg0TyZsXYZeBxKpBUqusNI7n87dzOw9MeLXclnt2
NEOImqIYros446duioGHRzeG6+BtgGCs9Ta5lEKx+XojF0Ayt3A=
=EzcZ
-----END PGP SIGNATURE-----

--Sig_/rvl/9m6FmaAM/PFvXasJ67k--
