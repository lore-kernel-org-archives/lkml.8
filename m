Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C58ABC4BA0A
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:27:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75DA121556
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 08:27:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Q3vg5i1p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727489AbgBZI1L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 03:27:11 -0500
Received: from mout.web.de ([212.227.15.14]:52765 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbgBZI1K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 03:27:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1582705626;
        bh=sgWRhAQeY9ARazx00HVnuVjRJ5+qt3/pQlq363uFA7E=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:In-Reply-To:References;
        b=Q3vg5i1p/sjOxM7Ydb+MLOT4Uo3IKAx9dsU62YdCFaUKwP7uWq7430VUkpivvBikz
         PmCpXgYxseASqPa29bu9QJKoS0GUNXU5BKqO8MlXMs/tDaP+Z93DnK2N2ig8nsOFEA
         gyNkbqH0ZbspcylCan/zwNpm3Kds03ZmpWLE5Mis=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.40]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LkEaw-1jhqPT3e8I-00cA8r; Wed, 26
 Feb 2020 09:27:05 +0100
Date:   Wed, 26 Feb 2020 09:27:05 +0100
From:   Lukas Straub <lukasstraub2@web.de>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        dm-devel <dm-devel@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Alasdair Kergon <agk@redhat.com>
Subject: Re: [dm-devel] [PATCH] dm-integrity: Prevent RMW for full tag area
 writes
Message-ID: <20200226092705.61b7dcf4@luklap>
In-Reply-To: <alpine.LRH.2.02.2002251127070.1014@file01.intranet.prod.int.rdu2.redhat.com>
References: <20200220190445.2222af54@luklap>
 <alpine.LRH.2.02.2002251127070.1014@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ETYl0Nmp3BF/MjJ/ywSqfTGadH2Jkw7G4NCOcWFPRVYc/it9z6+
 gorTJAvGCgN5F2oo98DrfZ8iHj4B3THNc94CCiLEV+IqBEzKmXFWlSh1PRMhqeqWy2c1MrK
 rIRFdyczRA+nqHNhZ5W0A7J+tevklDI7xfGk0y6avTdPTYT7SCwgCYDCqPIesStq3B2Ul6k
 eLoA9WZKCD5faokEHFheQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:c9UlD8rtFnw=:ocJhNvvcmDUsl36w2AdP2I
 Lh7iLzt1yODX/OpHqWpcKuyfCI6GbJOPm05/7H6ROqX9TvjPo6y5r+/8Vyzc7/qlpYu7SyfMZ
 mhbvKP4DY7jOqgj1ATXeVhrv6elAJKZWkRqa6ItSFJXeOLF0Fr3T7jN6sEV+KCyC5wQjqUDxh
 SxPZLACj8Y3embk4pCEeS+3EbtxHgwkUQrrtXeoG7+GBib5kPD8DZMnzRsPptBrGsgTyaqZX6
 pbe/XoW24cLlejvz1s1ulLvnjqAlN9rsCQEbxl6o9DOaYuIuYyILDT03u8xPq7CnX1/82lQQd
 2atxEvW7ChkY+AU4ZqIVzszgLD40Fdrk4WdvjAdv4Lo5lLPzBhi4ZZOuob5IujnGMvxYz0JuH
 6A6rJ2BNMCNLlK0b0C7PiUeYFmVwsqBJ7w3BJ3ZsON5Dp2I/RBdEgCwGJnNZtCtn1nx9HbCtD
 TiBvtE6cL4FKccKqgIu5JfA5bvhITT3Yz1kEPz5O6LXrBSWc4SUk5A165sJhrzAk5J21sqJe6
 BvbUhIeOQfTF7nyy7FW5g8y0UtINKGS3BMZEnnSZoRKGNI2O7lIHs54psoo9njUoghi2dyNXV
 zphxrUmfKFUvRrFGwWC+Y7H8qnJZxNfhYLuTwhEVZHX0f7NVHYJQZcY5EEMuIDHhUibU9kdiM
 Ws0ErmVoZav9mVW57wzJAcJTamA1gtGioLDUJwdzcFqxKFB2tjL83IwyWwz2in+6/E2bzdgTZ
 2Gut0xgQxcQHlfDWySf1vfZr57An1dGzkY2vdgKDSuTkMAfPj76Y/+q4BzSUcD8JpEdCmdGAq
 nTe2g8nmJtjF93T3wB9PA5f8DxsGzsooFFlLqsG0VXEP8KUalvYTRvT0iQQYfnbw0ghedSG8F
 myX0so5j1KahzgsGUP2Aeev//f3s/HD4QQYn9N4/kPXeHwsTJHZ91SDJb6yK+La/6BGGJ3FKo
 3kW6m4p8MT34yOInc3L+iRbD8I9b4hebbsIX5OlYFXLGTY8nC1KWEXBoUnfbsRCguBGMygijq
 /7vtJXmzReLpJXZ77uHnJEAR8d1jmQonsCa3VJ3BT67RxNF4d2GAVSw8ICvQAOqkYRX9qXCos
 wju8iQ2e4P546rivKHuk6aQFjr9ewQAFsYMyLSwBV9oXRwBDk/g8v5G7I+Y8+riXtJ7oFV8nN
 4jE2onmlS/UQyW+foUcUBbgO95biI+dIqcZohN5E6z2XMOc20Z2YJ7rrBUZ3IIvXxvmnDFjUz
 YRa8NDkR2+ZMFzPrN
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Feb 2020 11:41:45 -0500 (EST)
Mikulas Patocka <mpatocka@redhat.com> wrote:

> On Thu, 20 Feb 2020, Lukas Straub wrote:
>
> > If a full tag area is being written, don't read it first. This prevent=
s a
> > read-modify-write cycle and increases performance on HDDs considerably=
.
> >
> > To do this we now calculate the checksums for all sectors in the bio i=
n one
> > go in integrity_metadata and then pass the result to dm_integrity_rw_t=
ag,
> > which now checks if we overwrite the whole tag area.
> >
> > Benchmarking with a 5400RPM HDD with bitmap mode:
> > integritysetup format --no-wipe --batch-mode --interleave-sectors $((6=
4*1024)) -t 4 -s 512 -I crc32c -B /dev/sdc
> > integritysetup open -I crc32c -B /dev/sdc hdda_integ
> > dd if=3D/dev/zero of=3D/dev/mapper/hdda_integ bs=3D64K count=3D$((16*1=
024*4)) conv=3Dfsync oflag=3Ddirect status=3Dprogress
> >
> > Without patch:
> > 4294967296 bytes (4.3 GB, 4.0 GiB) copied, 400.326 s, 10.7 MB/s
> >
> > With patch:
> > 4294967296 bytes (4.3 GB, 4.0 GiB) copied, 41.2057 s, 104 MB/s
> >
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de>
> > ---
> >  drivers/md/dm-integrity.c | 80 ++++++++++++++++++++++----------------=
-
> >  1 file changed, 46 insertions(+), 34 deletions(-)
> >
> > diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
> > index b225b3e445fa..0e5ddcf44935 100644
> > --- a/drivers/md/dm-integrity.c
> > +++ b/drivers/md/dm-integrity.c
> > @@ -1309,9 +1309,16 @@ static int dm_integrity_rw_tag(struct dm_integr=
ity_c *ic, unsigned char *tag, se
> >  		if (unlikely(r))
> >  			return r;
> >
> > -		data =3D dm_bufio_read(ic->bufio, *metadata_block, &b);
> > -		if (IS_ERR(data))
> > -			return PTR_ERR(data);
> > +		/* Don't read tag area from disk if we're going to overwrite it com=
pletely */
> > +		if (op =3D=3D TAG_WRITE && *metadata_offset =3D=3D 0 && total_size =
>=3D ic->metadata_run) {
>
> Hi
>
> This is incorrect logic because ic->metadata_run is in the units of
> 512-byte sectors and total_size is in bytes.
>
> If I correct the bug and change it to "if (op =3D=3D TAG_WRITE &&
> *metadata_offset =3D=3D 0 && total_size >=3D ic->metadata_run << SECTOR_=
SHIFT)",
> then the benchmark doesn't show any performance advantage at all.

Uh oh, looking at it again i have mixed up sectors/bytes elsewhere too.
Actually, could we rewrite this check like
 total_size >=3D (1U << SECTOR_SHIFT << ic->log2_buffer_sectors)?
this should work, right?
So we only have to overwrite part of the tag area, as long as it's whole s=
ectors.

> You would need much bigger bios to take advantage for this - for example=
,
> if we have 4k block size and 64k metadata buffer size and 4-byte crc32,
> there are 65536/4=3D16384 tags in one metadata buffer and we would need
> 16384*4096=3D64MiB bio to completely overwrite the metadata buffer. Such=
 big
> bios are not realistic.

What prevents us from using a single sector as the tag area? (Which was my=
 assumption with this patch)
Then we would have (with 512b sectors) 512/4 =3D 128 tags =3D 64k bio, whi=
ch is still below the optimal write
size of raid5/6.
I just tried to accomplish this, but there seems to be minimum limit of in=
terleave_sectors.

Regards,
Lukas Straub

> Mikulas
>
>
> > +			data =3D dm_bufio_new(ic->bufio, *metadata_block, &b);
> > +			if (IS_ERR(data))
> > +				return PTR_ERR(data);
> > +		} else {
> > +			data =3D dm_bufio_read(ic->bufio, *metadata_block, &b);
> > +			if (IS_ERR(data))
> > +				return PTR_ERR(data);
> > +		}
> >
> >  		to_copy =3D min((1U << SECTOR_SHIFT << ic->log2_buffer_sectors) - *=
metadata_offset, total_size);
> >  		dp =3D data + *metadata_offset;
> > @@ -1514,6 +1521,8 @@ static void integrity_metadata(struct work_struc=
t *w)
> >  {
> >  	struct dm_integrity_io *dio =3D container_of(w, struct dm_integrity_=
io, work);
> >  	struct dm_integrity_c *ic =3D dio->ic;
> > +	unsigned sectors_to_process =3D dio->range.n_sectors;
> > +	sector_t sector =3D dio->range.logical_sector;
> >
> >  	int r;
> >
> > @@ -1522,16 +1531,14 @@ static void integrity_metadata(struct work_str=
uct *w)
> >  		struct bio_vec bv;
> >  		unsigned digest_size =3D crypto_shash_digestsize(ic->internal_hash)=
;
> >  		struct bio *bio =3D dm_bio_from_per_bio_data(dio, sizeof(struct dm_=
integrity_io));
> > -		char *checksums;
> > +		char *checksums, *checksums_ptr;
> >  		unsigned extra_space =3D unlikely(digest_size > ic->tag_size) ? dig=
est_size - ic->tag_size : 0;
> >  		char checksums_onstack[HASH_MAX_DIGESTSIZE];
> > -		unsigned sectors_to_process =3D dio->range.n_sectors;
> > -		sector_t sector =3D dio->range.logical_sector;
> >
> >  		if (unlikely(ic->mode =3D=3D 'R'))
> >  			goto skip_io;
> >
> > -		checksums =3D kmalloc((PAGE_SIZE >> SECTOR_SHIFT >> ic->sb->log2_se=
ctors_per_block) * ic->tag_size + extra_space,
> > +		checksums =3D kmalloc((dio->range.n_sectors >> ic->sb->log2_sectors=
_per_block) * ic->tag_size + extra_space,
> >  				    GFP_NOIO | __GFP_NORETRY | __GFP_NOWARN);
> >  		if (!checksums) {
> >  			checksums =3D checksums_onstack;
> > @@ -1542,49 +1549,45 @@ static void integrity_metadata(struct work_str=
uct *w)
> >  			}
> >  		}
> >
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
> > +					r =3D dm_integrity_rw_tag(ic, checksums, &dio->metadata_block, &=
dio->metadata_offset,
> > +								ic->tag_size, !dio->write ? TAG_CMP : TAG_WRITE);
> > +					if (unlikely(r))
> > +						goto internal_hash_error;
> > +				}
> > +
> >  				pos +=3D ic->sectors_per_block << SECTOR_SHIFT;
> >  				sector +=3D ic->sectors_per_block;
> > -			} while (pos < bv.bv_len && sectors_to_process && checksums !=3D c=
hecksums_onstack);
> > +				sectors_to_process -=3D ic->sectors_per_block;
> > +			} while (pos < bv.bv_len && sectors_to_process);
> >  			kunmap_atomic(mem);
> >
> > -			r =3D dm_integrity_rw_tag(ic, checksums, &dio->metadata_block, &di=
o->metadata_offset,
> > -						checksums_ptr - checksums, !dio->write ? TAG_CMP : TAG_WRITE);
> > -			if (unlikely(r)) {
> > -				if (r > 0) {
> > -					DMERR_LIMIT("Checksum failed at sector 0x%llx",
> > -						    (unsigned long long)(sector - ((r + ic->tag_size - 1) / ic-=
>tag_size)));
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
> >
> > -			if (unlikely(pos < bv.bv_len)) {
> > -				bv.bv_offset +=3D pos;
> > -				bv.bv_len -=3D pos;
> > -				goto again;
> > +		if (likely(checksums !=3D checksums_onstack)) {
> > +			r =3D dm_integrity_rw_tag(ic, checksums, &dio->metadata_block, &di=
o->metadata_offset,
> > +						(dio->range.n_sectors >> ic->sb->log2_sectors_per_block) * ic->=
tag_size,
> > +						!dio->write ? TAG_CMP : TAG_WRITE);
> > +			if (unlikely(r)) {
> > +				kfree(checksums);
> > +				goto internal_hash_error;
> >  			}
> > +			kfree(checksums);
> >  		}
> >
> > -		if (likely(checksums !=3D checksums_onstack))
> > -			kfree(checksums);
> >  	} else {
> >  		struct bio_integrity_payload *bip =3D dio->orig_bi_integrity;
> >
> > @@ -1615,6 +1618,13 @@ static void integrity_metadata(struct work_stru=
ct *w)
> >  skip_io:
> >  	dec_in_flight(dio);
> >  	return;
> > +internal_hash_error:
> > +	if (r > 0) {
> > +		DMERR_LIMIT("Checksum failed at sector 0x%llx",
> > +				(unsigned long long)(sector - ((r + ic->tag_size - 1) / ic->tag_s=
ize)));
> > +		r =3D -EILSEQ;
> > +		atomic64_inc(&ic->number_of_mismatches);
> > +	}
> >  error:
> >  	dio->bi_status =3D errno_to_blk_status(r);
> >  	dec_in_flight(dio);
> > @@ -3019,6 +3029,8 @@ static void dm_integrity_io_hints(struct dm_targ=
et *ti, struct queue_limits *lim
> >  		limits->physical_block_size =3D ic->sectors_per_block << SECTOR_SHI=
FT;
> >  		blk_limits_io_min(limits, ic->sectors_per_block << SECTOR_SHIFT);
> >  	}
> > +
> > +	blk_limits_io_opt(limits, (1U << ic->sb->log2_interleave_sectors));
> >  }
> >
> >  static void calculate_journal_section_size(struct dm_integrity_c *ic)
> > --
> > 2.20.1
> >
> >
> > --
> > dm-devel mailing list
> > dm-devel@redhat.com
> > https://www.redhat.com/mailman/listinfo/dm-devel
> >
>

