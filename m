Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA5EC4BA2D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2E221556
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 13:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="pkHJ+/fg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729195AbgB0N0I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 08:26:08 -0500
Received: from mout.web.de ([212.227.15.3]:36901 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729100AbgB0N0H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 08:26:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1582809962;
        bh=JyneJF0asbXIWGauQqLaePIxfFjLsxkzvt4oJ1CLFHk=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
        b=pkHJ+/fg7NI21OIc2MhwGA7+e0sX4vFlQFsXETOhCbMDS75+RTAoh8GvGZAw93W3V
         BpK148jILdwEk1yo6pal7is78SzP//z0YAK/wLqB38ZRkGeG0uZ+HYUNYBOR5N1ds3
         BAocis4ufTeinRntIXZ8ixpoN7jxuteapdc8d5MM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([88.130.61.170]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MXpmp-1isASz1uEx-00Wmpi; Thu, 27
 Feb 2020 14:26:02 +0100
Date:   Thu, 27 Feb 2020 14:26:01 +0100
From:   Lukas Straub <lukasstraub2@web.de>
To:     linux-kernel <linux-kernel@vger.kernel.org>
Cc:     Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        dm-devel <dm-devel@redhat.com>
Subject: [PATCH v2] dm-integrity: Prevent RMW for full metadata buffer
 writes
Message-ID: <20200227142601.61f3cd54@luklap>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gFHhBvnByvSMOxFLQSNLjz+7HzXasLy8tEH06JBC/AgIOkntixN
 rg8LHEb/XFDYsyqlD9uigZH1ygvSC7Wc4gIyS5bQqnInJnLCI/xVFXvA6MCznv9wcO8bYiZ
 CA0L36gHhjbQF0XRg7+ES56m9HAlAH1pqmHq243PPsTCSRoMybHOWkDQOSNJk8aFAcXtKAZ
 J38hCFlfy5Bj192iIUxRg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oYdG+isJ23w=:IjdpVrPCXxw//pghbJ3lp9
 2w31JGZ6BgzAaXbVuBBNxDhVBtvDC0YQGGAaa6Y0W5IEaiL4kKy2szZ17bD5ftCiUAVVoVZtU
 P7s+gjLUJKaJx/gfZf/rS62PklEkSK1Ao9EZwCxtRyv9IE9mr1s9ManKHlP7GxZUpreX9aW3P
 y7egdRrFXVAZsMElDx0ByQf2tfidnC03cZeasso/Ipu6kTfm1bKaZ6Gw9Liut83leGE/uiDdG
 fkUSIiAMte+TyeKiNs7w1dt6cLjqCRubTlxxe5WsQkpNg1tZJS1SYHYZwIviQsXw1kQVA4DJD
 M1E5KLfpYaMJdNxzQb71dqgDEVuLxY6JiKR3N9qIQV8ZuruQg8QYk6m/UUOfi14ehtGFMKXH/
 EEB6fOA0GP7us3r5F3dEmiK3y/6VuAt1KJ+KF0cge5b75FL8JhZTRLQBVRJQ3qC8qh+od7bgH
 nxtUjQJO7EBzjAbYrg504EfcRT0+p90dLPK9SnuknMFmB+fULB6ycgtPQfE86y/X9M0L3pwDY
 Mk5MECMkMXl7FejpuyMAZPU/J5vY4Gz1KyUJl6w92t0Ab0rbDUTl6ZpPSFhekAUMo2//fd5mS
 7Le3fvPRdhtree3ZNaq8Tn4feN58wTXDy+F3huwVSC42bLhtE7/3aaEWW5LdPP3OUf74KR20m
 BWCVfyS9rakzL9kyjGlYrwyxGrKaedCyZanqBthNzOs9yIlWZlQ48BehOa80QoMQteYrr5KGB
 96YMXEOwgxbH9I7UzCsE2yxu/gH7uYdlgu1aWsDkLhWM03TsfjEWkcQ5yKKUEsDkfYGoURR2S
 AoP2FszcHqfVKFzVPhhEiRUuESIa82qZVPEzxLjQCKwzGMZ8bO1XIseBNK7u6RbfonQJRZ0az
 mkmn5xDqnXAxcOeoVM/MGha9+HqS94jINZMNMZHDfbKghQ3r/140kKW2RJVSvaURstHzbAF7Q
 QulQp4MjngZ2SdgkFykn1XHAMbHlEF5WlKvir352ESvY9idmL5dsoWc9C9UM92TVXQ2C5YboF
 wzPGGjS1KUs0k/KfDC4IMih0pc/iRwroCrxX2jsGp8W5jFL2+mkq7rIC4Z8cy6LyW4aJsSgB7
 Z0YXgK3QYLJXC3LTMoFDIqH+yRkuwy9/APNLE+Nog5B73rr0CLod+oJJECNIUKDyLZeJKa/DJ
 nJhgomnRDZX+MQY2oP2KDuzouPqYRYzuGGhLjcOLYpYNinekoaNsZkNwJtR5G9ORTDtOiRVEG
 dH2xkQj6kiB66eq1n
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If a full metadata buffer is being written, don't read it first. This
prevents a read-modify-write cycle and increases performance on HDDs
considerably.

To do this we now calculate the checksums for all sectors in the bio in on=
e
go in integrity_metadata and then pass the result to dm_integrity_rw_tag,
which now checks if we overwrite the whole buffer.

Benchmarking with a 5400RPM HDD with bitmap mode:
integritysetup format --no-wipe --batch-mode --interleave-sectors $((64*10=
24)) -t 4 -s 512 -I crc32c -B /dev/sdc
integritysetup open --buffer-sectors=3D1 -I crc32c -B /dev/sdc hdda_integ
dd if=3D/dev/zero of=3D/dev/mapper/hdda_integ bs=3D64K count=3D$((16*1024*=
4)) conv=3Dfsync oflag=3Ddirect status=3Dprogress

Without patch:
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 400.326 s, 10.7 MB/s

With patch:
4294967296 bytes (4.3 GB, 4.0 GiB) copied, 41.2057 s, 104 MB/s

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
=2D--
Hello Everyone,
So here is v2, now checking if we overwrite a whole metadata buffer instea=
d
of the (buggy) check if we overwrite a whole tag area before.
Performance stayed the same (with --buffer-sectors=3D1).

The only quirk now is that it advertises a very big optimal io size in the
standard configuration (where buffer_sectors=3D128). Is this a Problem?

v2:
 -fix dm_integrity_rw_tag to check if we overwrite a whole metadat buffer
 -fix optimal io size to check if we overwrite a whole metadata buffer

Regards,
Lukas Straub

 drivers/md/dm-integrity.c | 81 +++++++++++++++++++++++----------------
 1 file changed, 47 insertions(+), 34 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index b225b3e445fa..a6d3cf1406df 100644
=2D-- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1309,9 +1309,17 @@ static int dm_integrity_rw_tag(struct dm_integrity_=
c *ic, unsigned char *tag, se
 		if (unlikely(r))
 			return r;

-		data =3D dm_bufio_read(ic->bufio, *metadata_block, &b);
-		if (IS_ERR(data))
-			return PTR_ERR(data);
+		/* Don't read metadata sectors from disk if we're going to overwrite th=
em completely */
+		if (op =3D=3D TAG_WRITE && *metadata_offset =3D=3D 0 \
+			&& total_size >=3D (1U << SECTOR_SHIFT << ic->log2_buffer_sectors)) {
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
@@ -1514,6 +1522,8 @@ static void integrity_metadata(struct work_struct *w=
)
 {
 	struct dm_integrity_io *dio =3D container_of(w, struct dm_integrity_io, =
work);
 	struct dm_integrity_c *ic =3D dio->ic;
+	unsigned sectors_to_process =3D dio->range.n_sectors;
+	sector_t sector =3D dio->range.logical_sector;

 	int r;

@@ -1522,16 +1532,14 @@ static void integrity_metadata(struct work_struct =
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
@@ -1542,49 +1550,45 @@ static void integrity_metadata(struct work_struct =
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

@@ -1615,6 +1619,13 @@ static void integrity_metadata(struct work_struct *=
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
@@ -3019,6 +3030,8 @@ static void dm_integrity_io_hints(struct dm_target *=
ti, struct queue_limits *lim
 		limits->physical_block_size =3D ic->sectors_per_block << SECTOR_SHIFT;
 		blk_limits_io_min(limits, ic->sectors_per_block << SECTOR_SHIFT);
 	}
+
+	blk_limits_io_opt(limits, 1U << SECTOR_SHIFT << ic->log2_buffer_sectors =
>> ic->log2_tag_size << SECTOR_SHIFT );
 }

 static void calculate_journal_section_size(struct dm_integrity_c *ic)
=2D-
2.20.1
