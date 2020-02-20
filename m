Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81ED6C11D0C
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45B9E24673
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 18:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Un0y7ZRp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgBTSEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Feb 2020 13:04:53 -0500
Received: from mout.web.de ([212.227.15.14]:34947 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727298AbgBTSEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Feb 2020 13:04:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1582221886;
        bh=cED0tHcFWzQhYnuQNvhD6+a83OOv92ePG6aWKNeLv9Y=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=Un0y7ZRp+gADQR8u6zJrF8HSgozZRdBmiVH5npvs+8iaL4kvxaOKdoLF+IQwkFGMU
         /V4Kg9kckTledA9+L7zsEmlNqUm5r0t13UnKzL8PIafiB9oQEsBajab6XDpLvsLZu7
         klCO4FLrd3i8VSrheIXXrjeyvMOL1RDFzllsild4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([94.134.180.199]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lzs0p-1jZD011LVb-0152pg; Thu, 20
 Feb 2020 19:04:46 +0100
Date:   Thu, 20 Feb 2020 19:04:45 +0100
From:   Lukas Straub <lukasstraub2@web.de>
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        dm-devel <dm-devel@redhat.com>
Subject: [PATCH] dm-integrity: Prevent RMW for full tag area writes
Message-ID: <20200220190445.2222af54@luklap>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:j/VhRjSkDO6znn4FrHt3mC8n7LlVlbZVwkVTUlm/MVlZnqIEN/E
 Q+Q63qWJCXLRysqLWXYyI5sNRzNR+nGrjrwhjDL4AmIDX2z/tbid1AOZi9cSolIRjDJ+E6G
 DpcGJbKsRMvzxriSnblo6CEIuPT08lG584MRJ7/JMFo51AfBGgF9FQx3nvZ/8dDueft3vqE
 tg0Rg+vgmApE9S/rn6h0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:634g0Ktj+5Q=:OeZZsXReddB08MfLeqtxs0
 aR3FIXFQVklIZVpkbWdK1bZpWyfc7djbSeGEZrQGoo3dMIypBGlgDGaWsuip2P9orzj1K6H8L
 608zJQn8tOapXyKRHZZiV6jcsO+AnPqhHRksRJhqZwKo9IqATTOg7Cg2ulu2Swkh6HpIacpK9
 ocnzDTx15Giux/YoWWZqSNb2zJza7uPOAINUtC4CdT32l2/YsUcAUXdFgcGOJjgwtRWA5WEbE
 HjU0zL+h3L26r72nK1m6FzHdqKjhcnimIza5VQmJLSJ3QJQuWdqx1jWakMuBajKMJr6wmLWsR
 b1zdq4yP9nIeWXrusutgDHydrMRwvpDtALPte4a2jOM70tGAL8+klwAySC8fRpFLv+ky0DLx/
 HEG680CRO6Ugn73qWA+04uLuLFg4WeECqNBJPrPbwegwk2F2QYxLwqldTtUZhFI+ceeZU4w0H
 8bL9GyU1upbHGcRoQBJvqDB1fsq6X53A7nq44anR61Rh9uYE6drDelNKskmKoBeErf76Q+D3T
 OEvh06DIhR4f10Igwfgox+NwgBb9igZOyzrggesZmJCHDVEPmu9nkc2U6dEK0K8NjpyMIDPQN
 EyNwbhS4aa3JlP1sU7WrfsBPTS3ycGlZACp6jN+brmmY8APQEP05yDdfyL6Tg54XcZDSN/JNv
 FloOqdHkJtc1f4ZTEu72uE5TaCs+i465myRpT519jV0q/ww4Ei98S8luXtWjoSVWcqqY5+mlW
 bRgffY83z0WyQUNrMHFPG17qrIQ//f0lYCDYl0YrHAsv2Lnz1iAFwXTURiwY42e+ssComG1Ee
 azeqSpNYur8h+aW1mcCeI/2WqyADj64LNGsTAiGyQjLAvdaKWvGF5EtRw2m7R1ub8RLDPaNZv
 744U5sncz2Ni/S/+1+DZaLb0kq0ihkbgx5nUIdW52Btft4fjqKwMj4AJhTW29/jrBvto8FQpk
 EwacYMkvw3a7ILT7buj+zg8cR1MN+T4cphpmSRY7IAQoiuwQRPlDnGGTS1cPZNvkgxr6Q3c4g
 wwD1LrOtktt99A7XeRd2RERBJwiweTp8eXEJnApIFQ9mE/qxg++ZjCM033/XFjtlp7kn3Tp8r
 CZiLvWPDslG3s5raDK9dyckajifS6kxqnBHAXgIwHYrnGv1RSK5sAABbx6yHiZMSwKQ69NO2c
 x45hbhF+LSC1mqv6vl7NcadHCTVCYE2My2bVuAXc2Y3eko5NFVHb2KWX+DiiXj6xUlapQYktx
 muWXXnnvOWYEcKusS
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a full tag area is being written, don't read it first. This prevents a
read-modify-write cycle and increases performance on HDDs considerably.

To do this we now calculate the checksums for all sectors in the bio in on=
e
go in integrity_metadata and then pass the result to dm_integrity_rw_tag,
which now checks if we overwrite the whole tag area.

Benchmarking with a 5400RPM HDD with bitmap mode:
integritysetup format --no-wipe --batch-mode --interleave-sectors $((64*10=
24)) -t 4 -s 512 -I crc32c -B /dev/sdc
integritysetup open -I crc32c -B /dev/sdc hdda_integ
dd if=3D/dev/zero of=3D/dev/mapper/hdda_integ bs=3D64K count=3D$((16*1024*=
4)) conv=3Dfsync oflag=3Ddirect status=3Dprogress

Without patch:
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 400.326 s, 10.7 MB/s

With patch:
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 41.2057 s, 104 MB/s

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
 drivers/md/dm-integrity.c | 80 ++++++++++++++++++++++-----------------
 1 file changed, 46 insertions(+), 34 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index b225b3e445fa..0e5ddcf44935 100644
=2D-- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1309,9 +1309,16 @@ static int dm_integrity_rw_tag(struct dm_integrity_=
c *ic, unsigned char *tag, se
 		if (unlikely(r))
 			return r;

-		data =3D dm_bufio_read(ic->bufio, *metadata_block, &b);
-		if (IS_ERR(data))
-			return PTR_ERR(data);
+		/* Don't read tag area from disk if we're going to overwrite it complet=
ely */
+		if (op =3D=3D TAG_WRITE && *metadata_offset =3D=3D 0 && total_size >=3D=
 ic->metadata_run) {
+			data =3D dm_bufio_new(ic->bufio, *metadata_block, &b);
+			if (IS_ERR(data))
+				return PTR_ERR(data);
+		} else {
+			data =3D dm_bufio_read(ic->bufio, *metadata_block, &b);
+			if (IS_ERR(data))
+				return PTR_ERR(data);
+		}

 		to_copy =3D min((1U << SECTOR_SHIFT << ic->log2_buffer_sectors) - *meta=
data_offset, total_size);
 		dp =3D data + *metadata_offset;
@@ -1514,6 +1521,8 @@ static void integrity_metadata(struct work_struct *w=
)
 {
 	struct dm_integrity_io *dio =3D container_of(w, struct dm_integrity_io, =
work);
 	struct dm_integrity_c *ic =3D dio->ic;
+	unsigned sectors_to_process =3D dio->range.n_sectors;
+	sector_t sector =3D dio->range.logical_sector;

 	int r;

@@ -1522,16 +1531,14 @@ static void integrity_metadata(struct work_struct =
*w)
 		struct bio_vec bv;
 		unsigned digest_size =3D crypto_shash_digestsize(ic->internal_hash);
 		struct bio *bio =3D dm_bio_from_per_bio_data(dio, sizeof(struct dm_inte=
grity_io));
-		char *checksums;
+		char *checksums, *checksums_ptr;
 		unsigned extra_space =3D unlikely(digest_size > ic->tag_size) ? digest_=
size - ic->tag_size : 0;
 		char checksums_onstack[HASH_MAX_DIGESTSIZE];
-		unsigned sectors_to_process =3D dio->range.n_sectors;
-		sector_t sector =3D dio->range.logical_sector;

 		if (unlikely(ic->mode =3D=3D 'R'))
 			goto skip_io;

-		checksums =3D kmalloc((PAGE_SIZE >> SECTOR_SHIFT >> ic->sb->log2_sector=
s_per_block) * ic->tag_size + extra_space,
+		checksums =3D kmalloc((dio->range.n_sectors >> ic->sb->log2_sectors_per=
_block) * ic->tag_size + extra_space,
 				    GFP_NOIO | __GFP_NORETRY | __GFP_NOWARN);
 		if (!checksums) {
 			checksums =3D checksums_onstack;
@@ -1542,49 +1549,45 @@ static void integrity_metadata(struct work_struct =
*w)
 			}
 		}

+		checksums_ptr =3D checksums;
 		__bio_for_each_segment(bv, bio, iter, dio->orig_bi_iter) {
 			unsigned pos;
-			char *mem, *checksums_ptr;
-
-again:
+			char *mem;
 			mem =3D (char *)kmap_atomic(bv.bv_page) + bv.bv_offset;
 			pos =3D 0;
-			checksums_ptr =3D checksums;
 			do {
 				integrity_sector_checksum(ic, sector, mem + pos, checksums_ptr);
-				checksums_ptr +=3D ic->tag_size;
-				sectors_to_process -=3D ic->sectors_per_block;
+
+				if (likely(checksums !=3D checksums_onstack)) {
+					checksums_ptr +=3D ic->tag_size;
+				} else {
+					r =3D dm_integrity_rw_tag(ic, checksums, &dio->metadata_block, &dio-=
>metadata_offset,
+								ic->tag_size, !dio->write ? TAG_CMP : TAG_WRITE);
+					if (unlikely(r))
+						goto internal_hash_error;
+				}
+
 				pos +=3D ic->sectors_per_block << SECTOR_SHIFT;
 				sector +=3D ic->sectors_per_block;
-			} while (pos < bv.bv_len && sectors_to_process && checksums !=3D check=
sums_onstack);
+				sectors_to_process -=3D ic->sectors_per_block;
+			} while (pos < bv.bv_len && sectors_to_process);
 			kunmap_atomic(mem);

-			r =3D dm_integrity_rw_tag(ic, checksums, &dio->metadata_block, &dio->m=
etadata_offset,
-						checksums_ptr - checksums, !dio->write ? TAG_CMP : TAG_WRITE);
-			if (unlikely(r)) {
-				if (r > 0) {
-					DMERR_LIMIT("Checksum failed at sector 0x%llx",
-						    (unsigned long long)(sector - ((r + ic->tag_size - 1) / ic->tag=
_size)));
-					r =3D -EILSEQ;
-					atomic64_inc(&ic->number_of_mismatches);
-				}
-				if (likely(checksums !=3D checksums_onstack))
-					kfree(checksums);
-				goto error;
-			}
-
 			if (!sectors_to_process)
 				break;
+		}

-			if (unlikely(pos < bv.bv_len)) {
-				bv.bv_offset +=3D pos;
-				bv.bv_len -=3D pos;
-				goto again;
+		if (likely(checksums !=3D checksums_onstack)) {
+			r =3D dm_integrity_rw_tag(ic, checksums, &dio->metadata_block, &dio->m=
etadata_offset,
+						(dio->range.n_sectors >> ic->sb->log2_sectors_per_block) * ic->tag_=
size,
+						!dio->write ? TAG_CMP : TAG_WRITE);
+			if (unlikely(r)) {
+				kfree(checksums);
+				goto internal_hash_error;
 			}
+			kfree(checksums);
 		}

-		if (likely(checksums !=3D checksums_onstack))
-			kfree(checksums);
 	} else {
 		struct bio_integrity_payload *bip =3D dio->orig_bi_integrity;

@@ -1615,6 +1618,13 @@ static void integrity_metadata(struct work_struct *=
w)
 skip_io:
 	dec_in_flight(dio);
 	return;
+internal_hash_error:
+	if (r > 0) {
+		DMERR_LIMIT("Checksum failed at sector 0x%llx",
+				(unsigned long long)(sector - ((r + ic->tag_size - 1) / ic->tag_size)=
));
+		r =3D -EILSEQ;
+		atomic64_inc(&ic->number_of_mismatches);
+	}
 error:
 	dio->bi_status =3D errno_to_blk_status(r);
 	dec_in_flight(dio);
@@ -3019,6 +3029,8 @@ static void dm_integrity_io_hints(struct dm_target *=
ti, struct queue_limits *lim
 		limits->physical_block_size =3D ic->sectors_per_block << SECTOR_SHIFT;
 		blk_limits_io_min(limits, ic->sectors_per_block << SECTOR_SHIFT);
 	}
+
+	blk_limits_io_opt(limits, (1U << ic->sb->log2_interleave_sectors));
 }

 static void calculate_journal_section_size(struct dm_integrity_c *ic)
=2D-
2.20.1
