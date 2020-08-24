Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EF3C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 20:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E79682078D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 20:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598301027;
	bh=nt0719zQ8JrrEKevXcqBTtNwUnhbIKaVhcQP6r/1JaQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=ziqeQ9HKQ4l6wTIHUnQqk9hJniqRVabxOcRDTBpSLWLCSHVmZPuDNcrg/VyHkN8Zy
	 zC+7foiIE/RZiIHmk/+kOsuyqEILmRE0xNaDnrftMpOzZL+GtBPpZItJ/HJGF1edbg
	 uHRp2ZTQCQ6El9wbCAOBMl1zJEg8w2G3e0r5PUys=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726737AbgHXUaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 16:30:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgHXUaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 16:30:20 -0400
Received: from embeddedor (187-162-31-110.static.axtel.net [187.162.31.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A45BB2078D;
        Mon, 24 Aug 2020 20:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598301019;
        bh=nt0719zQ8JrrEKevXcqBTtNwUnhbIKaVhcQP6r/1JaQ=;
        h=Date:From:To:Cc:Subject:From;
        b=OWhqAOfhpiSuvgtpF9IjtrS/4dgVG92RYbfxG+kH0Y5MaL2e3bcVFfUQ0naZvMUOI
         w9phWGJZsG+39j+Pb9fOktkGOJYF5T3/6UjNKQT7BCoxHhAP3neRoEHGR0XhifXs9D
         +3gGWvUAsrH5HKP4PXb/xeL7+QvBI6NiElc6xKag=
Date:   Mon, 24 Aug 2020 15:36:14 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: [PATCH] lib: Revert use of fallthrough pseudo-keyword in lib/
Message-ID: <20200824203614.GA28543@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following build error for powerpc64 was reported by Nathan Chancellor:

"$ scripts/config --file arch/powerpc/configs/powernv_defconfig -e KERNEL_XZ

$ make -skj"$(nproc)" ARCH=powerpc CROSS_COMPILE=powerpc64le-linux- distclean powernv_defconfig zImage
...
In file included from arch/powerpc/boot/../../../lib/decompress_unxz.c:234,
                 from arch/powerpc/boot/decompress.c:38:
arch/powerpc/boot/../../../lib/xz/xz_dec_stream.c: In function 'dec_main':
arch/powerpc/boot/../../../lib/xz/xz_dec_stream.c:586:4: error: 'fallthrough' undeclared (first use in this function)
  586 |    fallthrough;
      |    ^~~~~~~~~~~
arch/powerpc/boot/../../../lib/xz/xz_dec_stream.c:586:4: note: each undeclared identifier is reported only once for each function it appears in
In file included from arch/powerpc/boot/../../../lib/decompress_unxz.c:235,
                 from arch/powerpc/boot/decompress.c:38:
arch/powerpc/boot/../../../lib/xz/xz_dec_lzma2.c: In function 'xz_dec_lzma2_run':
arch/powerpc/boot/../../../lib/xz/xz_dec_lzma2.c:1046:4: error: 'fallthrough' undeclared (first use in this function)
 1046 |    fallthrough;
      |    ^~~~~~~~~~~
make[2]: *** [arch/powerpc/boot/Makefile:215: arch/powerpc/boot/decompress.o] Error 1
make[2]: Target 'arch/powerpc/boot/zImage' not remade because of errors.
make[1]: *** [arch/powerpc/Makefile:295: zImage] Error 2
make: *** [Makefile:335: __build_one_by_one] Error 2
make: Target 'distclean' not remade because of errors.
make: Target 'powernv_defconfig' not remade because of errors.
make: Target 'zImage' not remade because of errors.

This will end up affecting distribution configurations such as Debian
and OpenSUSE according to my testing. I am not sure what the solution
is, the PowerPC wrapper does not set -D__KERNEL__ so I am not sure that
compiler_attributes.h can be safely included."

In order to avoid these sort of problems, it seems that the best
solution is to use /* fall through */ comments instead of the
fallthrough pseudo-keyword macro in lib/, for now.

Reported-by: Nathan Chancellor <natechancellor@gmail.com>
Fixes: df561f6688fe ("treewide: Use fallthrough pseudo-keyword")
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 lib/asn1_decoder.c      |  4 ++--
 lib/assoc_array.c       |  2 +-
 lib/bootconfig.c        |  4 ++--
 lib/cmdline.c           | 10 +++++-----
 lib/dim/net_dim.c       |  2 +-
 lib/dim/rdma_dim.c      |  4 ++--
 lib/glob.c              |  2 +-
 lib/siphash.c           | 36 ++++++++++++++++++------------------
 lib/ts_fsm.c            |  2 +-
 lib/vsprintf.c          | 14 +++++++-------
 lib/xz/xz_dec_lzma2.c   |  4 ++--
 lib/xz/xz_dec_stream.c  | 16 ++++++++--------
 lib/zstd/bitstream.h    | 10 +++++-----
 lib/zstd/compress.c     |  2 +-
 lib/zstd/decompress.c   | 12 ++++++------
 lib/zstd/huf_compress.c |  4 ++--
 16 files changed, 64 insertions(+), 64 deletions(-)

diff --git a/lib/asn1_decoder.c b/lib/asn1_decoder.c
index 13da529e2e72..58f72b25f8e9 100644
--- a/lib/asn1_decoder.c
+++ b/lib/asn1_decoder.c
@@ -381,7 +381,7 @@ int asn1_ber_decoder(const struct asn1_decoder *decoder,
 	case ASN1_OP_END_SET_ACT:
 		if (unlikely(!(flags & FLAG_MATCHED)))
 			goto tag_mismatch;
-		fallthrough;
+		/* fall through */
 
 	case ASN1_OP_END_SEQ:
 	case ASN1_OP_END_SET_OF:
@@ -448,7 +448,7 @@ int asn1_ber_decoder(const struct asn1_decoder *decoder,
 			pc += asn1_op_lengths[op];
 			goto next_op;
 		}
-		fallthrough;
+		/* fall through */
 
 	case ASN1_OP_ACT:
 		ret = actions[machine[pc + 1]](context, hdr, tag, data + tdp, len);
diff --git a/lib/assoc_array.c b/lib/assoc_array.c
index 04c98799c3ba..6f4bcf524554 100644
--- a/lib/assoc_array.c
+++ b/lib/assoc_array.c
@@ -1113,7 +1113,7 @@ struct assoc_array_edit *assoc_array_delete(struct assoc_array *array,
 						index_key))
 				goto found_leaf;
 		}
-		fallthrough;
+		/* fall through */
 	case assoc_array_walk_tree_empty:
 	case assoc_array_walk_found_wrong_shortcut:
 	default:
diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 1b5de2a45b27..2c905a91d4eb 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -817,7 +817,7 @@ int __init xbc_init(char *buf, const char **emsg, int *epos)
 							q - 2);
 				break;
 			}
-			fallthrough;
+			/* fall through */
 		case '=':
 			ret = xbc_parse_kv(&p, q, c);
 			break;
@@ -826,7 +826,7 @@ int __init xbc_init(char *buf, const char **emsg, int *epos)
 			break;
 		case '#':
 			q = skip_comment(q);
-			fallthrough;
+			/* fall through */
 		case ';':
 		case '\n':
 			ret = xbc_parse_key(&p, q);
diff --git a/lib/cmdline.c b/lib/cmdline.c
index 55768b4f3f58..fbb9981a04a4 100644
--- a/lib/cmdline.c
+++ b/lib/cmdline.c
@@ -132,23 +132,23 @@ unsigned long long memparse(const char *ptr, char **retptr)
 	case 'E':
 	case 'e':
 		ret <<= 10;
-		fallthrough;
+		/* fall through */
 	case 'P':
 	case 'p':
 		ret <<= 10;
-		fallthrough;
+		/* fall through */
 	case 'T':
 	case 't':
 		ret <<= 10;
-		fallthrough;
+		/* fall through */
 	case 'G':
 	case 'g':
 		ret <<= 10;
-		fallthrough;
+		/* fall through */
 	case 'M':
 	case 'm':
 		ret <<= 10;
-		fallthrough;
+		/* fall through */
 	case 'K':
 	case 'k':
 		ret <<= 10;
diff --git a/lib/dim/net_dim.c b/lib/dim/net_dim.c
index 06811d866775..a4db51c21266 100644
--- a/lib/dim/net_dim.c
+++ b/lib/dim/net_dim.c
@@ -233,7 +233,7 @@ void net_dim(struct dim *dim, struct dim_sample end_sample)
 			schedule_work(&dim->work);
 			break;
 		}
-		fallthrough;
+		/* fall through */
 	case DIM_START_MEASURE:
 		dim_update_sample(end_sample.event_ctr, end_sample.pkt_ctr,
 				  end_sample.byte_ctr, &dim->start_sample);
diff --git a/lib/dim/rdma_dim.c b/lib/dim/rdma_dim.c
index 15462d54758d..f7e26c7b4749 100644
--- a/lib/dim/rdma_dim.c
+++ b/lib/dim/rdma_dim.c
@@ -59,7 +59,7 @@ static bool rdma_dim_decision(struct dim_stats *curr_stats, struct dim *dim)
 			break;
 		case DIM_STATS_WORSE:
 			dim_turn(dim);
-			fallthrough;
+			/* fall through */
 		case DIM_STATS_BETTER:
 			step_res = rdma_dim_step(dim);
 			if (step_res == DIM_ON_EDGE)
@@ -94,7 +94,7 @@ void rdma_dim(struct dim *dim, u64 completions)
 			schedule_work(&dim->work);
 			break;
 		}
-		fallthrough;
+		/* fall through */
 	case DIM_START_MEASURE:
 		dim->state = DIM_MEASURE_IN_PROGRESS;
 		dim_update_sample_with_comps(curr_sample->event_ctr, 0, 0,
diff --git a/lib/glob.c b/lib/glob.c
index 85ecbda45cd8..52e3ed7e4a9b 100644
--- a/lib/glob.c
+++ b/lib/glob.c
@@ -102,7 +102,7 @@ bool __pure glob_match(char const *pat, char const *str)
 			break;
 		case '\\':
 			d = *pat++;
-			fallthrough;
+			/* fall through */
 		default:	/* Literal character */
 literal:
 			if (c == d) {
diff --git a/lib/siphash.c b/lib/siphash.c
index a90112ee72a1..c47bb6ff2149 100644
--- a/lib/siphash.c
+++ b/lib/siphash.c
@@ -68,11 +68,11 @@ u64 __siphash_aligned(const void *data, size_t len, const siphash_key_t *key)
 						  bytemask_from_count(left)));
 #else
 	switch (left) {
-	case 7: b |= ((u64)end[6]) << 48; fallthrough;
-	case 6: b |= ((u64)end[5]) << 40; fallthrough;
-	case 5: b |= ((u64)end[4]) << 32; fallthrough;
+	case 7: b |= ((u64)end[6]) << 48; /* fall through */
+	case 6: b |= ((u64)end[5]) << 40; /* fall through */
+	case 5: b |= ((u64)end[4]) << 32; /* fall through */
 	case 4: b |= le32_to_cpup(data); break;
-	case 3: b |= ((u64)end[2]) << 16; fallthrough;
+	case 3: b |= ((u64)end[2]) << 16; /* fall through */
 	case 2: b |= le16_to_cpup(data); break;
 	case 1: b |= end[0];
 	}
@@ -101,11 +101,11 @@ u64 __siphash_unaligned(const void *data, size_t len, const siphash_key_t *key)
 						  bytemask_from_count(left)));
 #else
 	switch (left) {
-	case 7: b |= ((u64)end[6]) << 48; fallthrough;
-	case 6: b |= ((u64)end[5]) << 40; fallthrough;
-	case 5: b |= ((u64)end[4]) << 32; fallthrough;
+	case 7: b |= ((u64)end[6]) << 48; /* fall through */
+	case 6: b |= ((u64)end[5]) << 40; /* fall through */
+	case 5: b |= ((u64)end[4]) << 32; /* fall through */
 	case 4: b |= get_unaligned_le32(end); break;
-	case 3: b |= ((u64)end[2]) << 16; fallthrough;
+	case 3: b |= ((u64)end[2]) << 16; /* fall through */
 	case 2: b |= get_unaligned_le16(end); break;
 	case 1: b |= end[0];
 	}
@@ -268,11 +268,11 @@ u32 __hsiphash_aligned(const void *data, size_t len, const hsiphash_key_t *key)
 						  bytemask_from_count(left)));
 #else
 	switch (left) {
-	case 7: b |= ((u64)end[6]) << 48; fallthrough;
-	case 6: b |= ((u64)end[5]) << 40; fallthrough;
-	case 5: b |= ((u64)end[4]) << 32; fallthrough;
+	case 7: b |= ((u64)end[6]) << 48; /* fall through */
+	case 6: b |= ((u64)end[5]) << 40; /* fall through */
+	case 5: b |= ((u64)end[4]) << 32; /* fall through */
 	case 4: b |= le32_to_cpup(data); break;
-	case 3: b |= ((u64)end[2]) << 16; fallthrough;
+	case 3: b |= ((u64)end[2]) << 16; /* fall through */
 	case 2: b |= le16_to_cpup(data); break;
 	case 1: b |= end[0];
 	}
@@ -301,11 +301,11 @@ u32 __hsiphash_unaligned(const void *data, size_t len,
 						  bytemask_from_count(left)));
 #else
 	switch (left) {
-	case 7: b |= ((u64)end[6]) << 48; fallthrough;
-	case 6: b |= ((u64)end[5]) << 40; fallthrough;
-	case 5: b |= ((u64)end[4]) << 32; fallthrough;
+	case 7: b |= ((u64)end[6]) << 48; /* fall through */
+	case 6: b |= ((u64)end[5]) << 40; /* fall through */
+	case 5: b |= ((u64)end[4]) << 32; /* fall through */
 	case 4: b |= get_unaligned_le32(end); break;
-	case 3: b |= ((u64)end[2]) << 16; fallthrough;
+	case 3: b |= ((u64)end[2]) << 16; /* fall through */
 	case 2: b |= get_unaligned_le16(end); break;
 	case 1: b |= end[0];
 	}
@@ -431,7 +431,7 @@ u32 __hsiphash_aligned(const void *data, size_t len, const hsiphash_key_t *key)
 		v0 ^= m;
 	}
 	switch (left) {
-	case 3: b |= ((u32)end[2]) << 16; fallthrough;
+	case 3: b |= ((u32)end[2]) << 16; /* fall through */
 	case 2: b |= le16_to_cpup(data); break;
 	case 1: b |= end[0];
 	}
@@ -454,7 +454,7 @@ u32 __hsiphash_unaligned(const void *data, size_t len,
 		v0 ^= m;
 	}
 	switch (left) {
-	case 3: b |= ((u32)end[2]) << 16; fallthrough;
+	case 3: b |= ((u32)end[2]) << 16; /* fall through */
 	case 2: b |= get_unaligned_le16(end); break;
 	case 1: b |= end[0];
 	}
diff --git a/lib/ts_fsm.c b/lib/ts_fsm.c
index 64fd9015ad80..ab749ec10ab5 100644
--- a/lib/ts_fsm.c
+++ b/lib/ts_fsm.c
@@ -193,7 +193,7 @@ static unsigned int fsm_find(struct ts_config *conf, struct ts_state *state)
 				TOKEN_MISMATCH();
 
 			block_idx++;
-			fallthrough;
+			/* fall through */
 
 		case TS_FSM_ANY:
 			if (next == NULL)
diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 19ebe1b257ec..afb9521ddf91 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -1265,7 +1265,7 @@ char *mac_address_string(char *buf, char *end, u8 *addr,
 
 	case 'R':
 		reversed = true;
-		fallthrough;
+		/* fall through */
 
 	default:
 		separator = ':';
@@ -1682,7 +1682,7 @@ char *uuid_string(char *buf, char *end, const u8 *addr,
 	switch (*(++fmt)) {
 	case 'L':
 		uc = true;
-		fallthrough;
+		/* fall through */
 	case 'l':
 		index = guid_index;
 		break;
@@ -2219,7 +2219,7 @@ char *pointer(const char *fmt, char *buf, char *end, void *ptr,
 	case 'S':
 	case 's':
 		ptr = dereference_symbol_descriptor(ptr);
-		fallthrough;
+		/* fall through */
 	case 'B':
 		return symbol_string(buf, end, ptr, spec, fmt);
 	case 'R':
@@ -2450,7 +2450,7 @@ int format_decode(const char *fmt, struct printf_spec *spec)
 
 	case 'x':
 		spec->flags |= SMALL;
-		fallthrough;
+		/* fall through */
 
 	case 'X':
 		spec->base = 16;
@@ -2468,7 +2468,7 @@ int format_decode(const char *fmt, struct printf_spec *spec)
 		 * utility, treat it as any other invalid or
 		 * unsupported format specifier.
 		 */
-		fallthrough;
+		/* fall through */
 
 	default:
 		WARN_ONCE(1, "Please remove unsupported %%%c in format string\n", *fmt);
@@ -3411,10 +3411,10 @@ int vsscanf(const char *buf, const char *fmt, va_list args)
 			break;
 		case 'i':
 			base = 0;
-			fallthrough;
+			/* fall through */
 		case 'd':
 			is_sign = true;
-			fallthrough;
+			/* fall through */
 		case 'u':
 			break;
 		case '%':
diff --git a/lib/xz/xz_dec_lzma2.c b/lib/xz/xz_dec_lzma2.c
index ca2603abee08..65a1aad8c223 100644
--- a/lib/xz/xz_dec_lzma2.c
+++ b/lib/xz/xz_dec_lzma2.c
@@ -1043,7 +1043,7 @@ XZ_EXTERN enum xz_ret xz_dec_lzma2_run(struct xz_dec_lzma2 *s,
 
 			s->lzma2.sequence = SEQ_LZMA_PREPARE;
 
-			fallthrough;
+			/* fall through */
 
 		case SEQ_LZMA_PREPARE:
 			if (s->lzma2.compressed < RC_INIT_BYTES)
@@ -1055,7 +1055,7 @@ XZ_EXTERN enum xz_ret xz_dec_lzma2_run(struct xz_dec_lzma2 *s,
 			s->lzma2.compressed -= RC_INIT_BYTES;
 			s->lzma2.sequence = SEQ_LZMA_RUN;
 
-			fallthrough;
+			/* fall through */
 
 		case SEQ_LZMA_RUN:
 			/*
diff --git a/lib/xz/xz_dec_stream.c b/lib/xz/xz_dec_stream.c
index fea86deaaa01..32ab2a08b7cb 100644
--- a/lib/xz/xz_dec_stream.c
+++ b/lib/xz/xz_dec_stream.c
@@ -583,7 +583,7 @@ static enum xz_ret dec_main(struct xz_dec *s, struct xz_buf *b)
 			if (ret != XZ_OK)
 				return ret;
 
-			fallthrough;
+			/* fall through */
 
 		case SEQ_BLOCK_START:
 			/* We need one byte of input to continue. */
@@ -608,7 +608,7 @@ static enum xz_ret dec_main(struct xz_dec *s, struct xz_buf *b)
 			s->temp.pos = 0;
 			s->sequence = SEQ_BLOCK_HEADER;
 
-			fallthrough;
+			/* fall through */
 
 		case SEQ_BLOCK_HEADER:
 			if (!fill_temp(s, b))
@@ -620,7 +620,7 @@ static enum xz_ret dec_main(struct xz_dec *s, struct xz_buf *b)
 
 			s->sequence = SEQ_BLOCK_UNCOMPRESS;
 
-			fallthrough;
+			/* fall through */
 
 		case SEQ_BLOCK_UNCOMPRESS:
 			ret = dec_block(s, b);
@@ -629,7 +629,7 @@ static enum xz_ret dec_main(struct xz_dec *s, struct xz_buf *b)
 
 			s->sequence = SEQ_BLOCK_PADDING;
 
-			fallthrough;
+			/* fall through */
 
 		case SEQ_BLOCK_PADDING:
 			/*
@@ -651,7 +651,7 @@ static enum xz_ret dec_main(struct xz_dec *s, struct xz_buf *b)
 
 			s->sequence = SEQ_BLOCK_CHECK;
 
-			fallthrough;
+			/* fall through */
 
 		case SEQ_BLOCK_CHECK:
 			if (s->check_type == XZ_CHECK_CRC32) {
@@ -675,7 +675,7 @@ static enum xz_ret dec_main(struct xz_dec *s, struct xz_buf *b)
 
 			s->sequence = SEQ_INDEX_PADDING;
 
-			fallthrough;
+			/* fall through */
 
 		case SEQ_INDEX_PADDING:
 			while ((s->index.size + (b->in_pos - s->in_start))
@@ -699,7 +699,7 @@ static enum xz_ret dec_main(struct xz_dec *s, struct xz_buf *b)
 
 			s->sequence = SEQ_INDEX_CRC32;
 
-			fallthrough;
+			/* fall through */
 
 		case SEQ_INDEX_CRC32:
 			ret = crc32_validate(s, b);
@@ -709,7 +709,7 @@ static enum xz_ret dec_main(struct xz_dec *s, struct xz_buf *b)
 			s->temp.size = STREAM_HEADER_SIZE;
 			s->sequence = SEQ_STREAM_FOOTER;
 
-			fallthrough;
+			/* fall through */
 
 		case SEQ_STREAM_FOOTER:
 			if (!fill_temp(s, b))
diff --git a/lib/zstd/bitstream.h b/lib/zstd/bitstream.h
index 7c65c66e41fd..3a49784d5c61 100644
--- a/lib/zstd/bitstream.h
+++ b/lib/zstd/bitstream.h
@@ -259,15 +259,15 @@ ZSTD_STATIC size_t BIT_initDStream(BIT_DStream_t *bitD, const void *srcBuffer, s
 		bitD->bitContainer = *(const BYTE *)(bitD->start);
 		switch (srcSize) {
 		case 7: bitD->bitContainer += (size_t)(((const BYTE *)(srcBuffer))[6]) << (sizeof(bitD->bitContainer) * 8 - 16);
-			fallthrough;
+			/* fall through */
 		case 6: bitD->bitContainer += (size_t)(((const BYTE *)(srcBuffer))[5]) << (sizeof(bitD->bitContainer) * 8 - 24);
-			fallthrough;
+			/* fall through */
 		case 5: bitD->bitContainer += (size_t)(((const BYTE *)(srcBuffer))[4]) << (sizeof(bitD->bitContainer) * 8 - 32);
-			fallthrough;
+			/* fall through */
 		case 4: bitD->bitContainer += (size_t)(((const BYTE *)(srcBuffer))[3]) << 24;
-			fallthrough;
+			/* fall through */
 		case 3: bitD->bitContainer += (size_t)(((const BYTE *)(srcBuffer))[2]) << 16;
-			fallthrough;
+			/* fall through */
 		case 2: bitD->bitContainer += (size_t)(((const BYTE *)(srcBuffer))[1]) << 8;
 		default:;
 		}
diff --git a/lib/zstd/compress.c b/lib/zstd/compress.c
index b080264ed3ad..5e0b67003e55 100644
--- a/lib/zstd/compress.c
+++ b/lib/zstd/compress.c
@@ -3182,7 +3182,7 @@ static size_t ZSTD_compressStream_generic(ZSTD_CStream *zcs, void *dst, size_t *
 				zcs->outBuffFlushedSize = 0;
 				zcs->stage = zcss_flush; /* pass-through to flush stage */
 			}
-			fallthrough;
+			/* fall through */
 
 		case zcss_flush: {
 			size_t const toFlush = zcs->outBuffContentSize - zcs->outBuffFlushedSize;
diff --git a/lib/zstd/decompress.c b/lib/zstd/decompress.c
index 66cd487a326a..db6761ea4deb 100644
--- a/lib/zstd/decompress.c
+++ b/lib/zstd/decompress.c
@@ -442,7 +442,7 @@ size_t ZSTD_decodeLiteralsBlock(ZSTD_DCtx *dctx, const void *src, size_t srcSize
 		case set_repeat:
 			if (dctx->litEntropy == 0)
 				return ERROR(dictionary_corrupted);
-			fallthrough;
+			/* fall through */
 		case set_compressed:
 			if (srcSize < 5)
 				return ERROR(corruption_detected); /* srcSize >= MIN_CBLOCK_SIZE == 3; here we need up to 5 for case 3 */
@@ -1768,7 +1768,7 @@ size_t ZSTD_decompressContinue(ZSTD_DCtx *dctx, void *dst, size_t dstCapacity, c
 			return 0;
 		}
 		dctx->expected = 0; /* not necessary to copy more */
-		fallthrough;
+		/* fall through */
 
 	case ZSTDds_decodeFrameHeader:
 		memcpy(dctx->headerBuffer + ZSTD_frameHeaderSize_prefix, src, dctx->expected);
@@ -2309,7 +2309,7 @@ size_t ZSTD_decompressStream(ZSTD_DStream *zds, ZSTD_outBuffer *output, ZSTD_inB
 		switch (zds->stage) {
 		case zdss_init:
 			ZSTD_resetDStream(zds); /* transparent reset on starting decoding a new frame */
-			fallthrough;
+			/* fall through */
 
 		case zdss_loadHeader: {
 			size_t const hSize = ZSTD_getFrameParams(&zds->fParams, zds->headerBuffer, zds->lhSize);
@@ -2376,7 +2376,7 @@ size_t ZSTD_decompressStream(ZSTD_DStream *zds, ZSTD_outBuffer *output, ZSTD_inB
 			}
 			zds->stage = zdss_read;
 		}
-			fallthrough;
+			/* fall through */
 
 		case zdss_read: {
 			size_t const neededInSize = ZSTD_nextSrcSizeToDecompress(zds->dctx);
@@ -2405,7 +2405,7 @@ size_t ZSTD_decompressStream(ZSTD_DStream *zds, ZSTD_outBuffer *output, ZSTD_inB
 			zds->stage = zdss_load;
 			/* pass-through */
 		}
-			fallthrough;
+			/* fall through */
 
 		case zdss_load: {
 			size_t const neededInSize = ZSTD_nextSrcSizeToDecompress(zds->dctx);
@@ -2438,7 +2438,7 @@ size_t ZSTD_decompressStream(ZSTD_DStream *zds, ZSTD_outBuffer *output, ZSTD_inB
 				/* pass-through */
 			}
 		}
-			fallthrough;
+			/* fall through */
 
 		case zdss_flush: {
 			size_t const toFlushSize = zds->outEnd - zds->outStart;
diff --git a/lib/zstd/huf_compress.c b/lib/zstd/huf_compress.c
index 08b4ae80aed4..e727812d12aa 100644
--- a/lib/zstd/huf_compress.c
+++ b/lib/zstd/huf_compress.c
@@ -556,9 +556,9 @@ size_t HUF_compress1X_usingCTable(void *dst, size_t dstSize, const void *src, si
 	n = srcSize & ~3; /* join to mod 4 */
 	switch (srcSize & 3) {
 	case 3: HUF_encodeSymbol(&bitC, ip[n + 2], CTable); HUF_FLUSHBITS_2(&bitC);
-		fallthrough;
+		/* fall through */
 	case 2: HUF_encodeSymbol(&bitC, ip[n + 1], CTable); HUF_FLUSHBITS_1(&bitC);
-		fallthrough;
+		/* fall through */
 	case 1: HUF_encodeSymbol(&bitC, ip[n + 0], CTable); HUF_FLUSHBITS(&bitC);
 	case 0:
 	default:;
-- 
2.27.0

