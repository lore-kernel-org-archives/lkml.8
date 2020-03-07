Return-Path: <SRS0=IBMW=4Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D23FC10F00
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 13:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C678A20674
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Mar 2020 13:33:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b9peg7lt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726267AbgCGNdz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Mar 2020 08:33:55 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33439 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726109AbgCGNdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Mar 2020 08:33:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583588032;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vZfGY13s49Z+QQTEjvvQ2R4XzoYTZZgYxQSqNfoYwE0=;
        b=b9peg7lteCqfY+a4u8y64uWfJxQxUOKOTzxzziPj5X63+EqgHCscY7BrzGTZCWIUf6F4Kj
        T3TXZUdTcAOsy6E5SyDPgkxHrTC0DuEoQQwAP79bdSh2DNoq4G3iAMwWwRehY1HoL3HCRF
        GwICqpOLafKJpypQBPpaj6/ChQQI7yw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-23nz6dGINF-LaM24K7gAZw-1; Sat, 07 Mar 2020 08:33:50 -0500
X-MC-Unique: 23nz6dGINF-LaM24K7gAZw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1097118A5502;
        Sat,  7 Mar 2020 13:33:49 +0000 (UTC)
Received: from elisabeth (ovpn-200-26.brq.redhat.com [10.40.200.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5912F5D9CA;
        Sat,  7 Mar 2020 13:33:46 +0000 (UTC)
Date:   Sat, 7 Mar 2020 14:33:41 +0100
From:   Stefano Brivio <sbrivio@redhat.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/bitmap: rework bitmap_cut()
Message-ID: <20200307143341.5497e7ee@elisabeth>
In-Reply-To: <20200306221423.18631-1-yury.norov@gmail.com>
References: <20200306221423.18631-1-yury.norov@gmail.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  6 Mar 2020 14:14:23 -0800
Yury Norov <yury.norov@gmail.com> wrote:

> diff --git a/include/linux/bitmap.h b/include/linux/bitmap.h
> index 99058eb81042..ed60b7272437 100644
> --- a/include/linux/bitmap.h
> +++ b/include/linux/bitmap.h
> @@ -59,7 +59,7 @@
>   *  						Iterate over all set regions
>   *  bitmap_shift_right(dst, src, n, nbits)      *dst = *src >> n
>   *  bitmap_shift_left(dst, src, n, nbits)       *dst = *src << n
> - *  bitmap_cut(dst, src, first, n, nbits)       Cut n bits from first, copy rest
> + *  bitmap_cut(bmap, first, n, nbits)           Cut n bits from first, copy rest

I think the first argument should be called 'map', for consistency with
similar operations.

>   *  bitmap_replace(dst, old, new, mask, nbits)  *dst = (*old & ~(*mask)) | (*new & *mask)
>   *  bitmap_remap(dst, src, old, new, nbits)     *dst = map(old, new)(src)
>   *  bitmap_bitremap(oldbit, old, new, nbits)    newbit = map(old, new)(oldbit)
> @@ -140,9 +140,8 @@ extern void __bitmap_shift_right(unsigned long *dst, const unsigned long *src,
>  				unsigned int shift, unsigned int nbits);
>  extern void __bitmap_shift_left(unsigned long *dst, const unsigned long *src,
>  				unsigned int shift, unsigned int nbits);
> -extern void bitmap_cut(unsigned long *dst, const unsigned long *src,
> -		       unsigned int first, unsigned int cut,
> -		       unsigned int nbits);
> +extern void bitmap_cut(unsigned long *bmap, unsigned int first,

Same here.

> +			unsigned int cut, unsigned int nbits);
>  extern int __bitmap_and(unsigned long *dst, const unsigned long *bitmap1,
>  			const unsigned long *bitmap2, unsigned int nbits);
>  extern void __bitmap_or(unsigned long *dst, const unsigned long *bitmap1,
> diff --git a/lib/bitmap.c b/lib/bitmap.c
> index 89260aa342d6..06e06e0c3096 100644
> --- a/lib/bitmap.c
> +++ b/lib/bitmap.c
> @@ -170,67 +170,42 @@ EXPORT_SYMBOL(__bitmap_shift_left);
>  
>  /**
>   * bitmap_cut() - remove bit region from bitmap and right shift remaining bits
> - * @dst: destination bitmap, might overlap with src
> - * @src: source bitmap
> + * @bmap:  bitmap to cut

Same here, and excess whitespace.

>   * @first: start bit of region to be removed
>   * @cut: number of bits to remove
>   * @nbits: bitmap size, in bits
>   *
> - * Set the n-th bit of @dst iff the n-th bit of @src is set and
> - * n is less than @first, or the m-th bit of @src is set for any
> - * m such that @first <= n < nbits, and m = n + @cut.
> - *
>   * In pictures, example for a big-endian 32-bit architecture:
>   *
> - * @src:
> + * @bmap:
>   * 31                                   63
>   * |                                    |
>   * 10000000 11000001 11110010 00010101  10000000 11000001 01110010 00010101
>   *                 |  |              |                                    |
>   *                16  14             0                                   32
>   *
> - * if @cut is 3, and @first is 14, bits 14-16 in @src are cut and @dst is:
> + * if @cut is 3, and @first is 14, bits 14-16 in @bmap are cut and @dst is:
>   *
>   * 31                                   63
>   * |                                    |
>   * 10110000 00011000 00110010 00010101  00010000 00011000 00101110 01000010
>   *                    |              |                                    |
>   *                    14 (bit 17     0                                   32
> - *                        from @src)
> - *
> - * Note that @dst and @src might overlap partially or entirely.
> - *
> - * This is implemented in the obvious way, with a shift and carry
> - * step for each moved bit. Optimisation is left as an exercise
> - * for the compiler.
> + *                        from @bmap)
>   */
> -void bitmap_cut(unsigned long *dst, const unsigned long *src,
> -		unsigned int first, unsigned int cut, unsigned int nbits)
> +void bitmap_cut(unsigned long *bmap, unsigned int first,
> +		unsigned int cut, unsigned int nbits)
>  {
> -	unsigned int len = BITS_TO_LONGS(nbits);
> -	unsigned long keep = 0, carry;
> -	int i;
> -
> -	memmove(dst, src, len * sizeof(*dst));
> -
> -	if (first % BITS_PER_LONG) {
> -		keep = src[first / BITS_PER_LONG] &
> -		       (~0UL >> (BITS_PER_LONG - first % BITS_PER_LONG));
> -	}
> +	unsigned long tmp;
> +	unsigned long *b = bmap + first / BITS_PER_LONG;

You could keep the declarations on a single line.

>  
> -	while (cut--) {
> -		for (i = first / BITS_PER_LONG; i < len; i++) {
> -			if (i < len - 1)
> -				carry = dst[i + 1] & 1UL;
> -			else
> -				carry = 0;
> +	if (first % BITS_PER_LONG)
> +		tmp = b[0] & BITMAP_LAST_WORD_MASK(first);
>  
> -			dst[i] = (dst[i] >> 1) | (carry << (BITS_PER_LONG - 1));
> -		}
> -	}
> +	bitmap_shift_right(b, b, cut - first, nbits - first);

This causes an out-of-bounds write, you can easily trigger that with
nftables case:
	tests/shell/testcases/sets/0043concatenated_ranges_0

or even with the 'correctness' test for "net,port" sets from kselftest:
	tools/testing/selftests/netfilter/nft_concat_range.sh

[  146.074987] BUG: unable to handle page fault for address: ffffed1176e86005
[  146.076827] #PF: supervisor read access in kernel mode
[  146.078054] #PF: error_code(0x0000) - not-present page
[  146.079291] PGD 43ffc6067 P4D 43ffc6067 PUD 0 
[  146.080411] Oops: 0000 [#1] SMP KASAN NOPTI
[  146.081441] CPU: 6 PID: 1301 Comm: nft Not tainted 5.6.0-rc2+ #253
[  146.082899] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1 04/01/2014
[  146.084929] RIP: 0010:check_memory_region+0x108/0x1c0
[  146.086158] Code: 00 00 00 00 00 00 ff e9 35 ff ff ff 41 bc 08 00 00 00 45 29 c4 49 89 d8 4d 8d 0c 1c eb 0c 49 83 c0 01 4c 89 c8 4d 39 c8 74 0f <41> 80 38 00 74 ee 49 8d 04 1c 4d 85 c0 75 0b 49 89 e9 49 29 c1 e9
[  146.090711] RSP: 0018:ffff888361d271a8 EFLAGS: 00010206
[  146.091945] RAX: ffffed1176e86005 RBX: ffffed1176e86005 RCX: ffffffff9b449d82
[  146.093691] RDX: 0000000000000001 RSI: 000000001ffffff8 RDI: ffff888bb7430028
[  146.095450] RBP: ffffed117ae86004 R08: ffffed1176e86005 R09: ffffed1176e86008
[  146.097115] R10: ffffed117ae86003 R11: ffff888bd743001f R12: 0000000000000003
[  146.098695] R13: 0000000000000000 R14: dffffc0000000000 R15: ffff8883cc3b4678
[  146.100633] FS:  00007f6a70820740(0000) GS:ffff8883df100000(0000) knlGS:0000000000000000
[  146.102449] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  146.103739] CR2: ffffed1176e86005 CR3: 00000003d1700000 CR4: 00000000003406e0
[  146.105369] Call Trace:
[  146.105946]  memset+0x20/0x40
[  146.106642]  bitmap_cut+0x62/0xf0
[  146.107425]  pipapo_drop+0x1d3/0x630 [nf_tables]
[  146.108507]  nft_pipapo_remove+0x928/0xc50 [nf_tables]
[  146.109783]  ? nft_pipapo_deactivate+0x10/0x10 [nf_tables]
[  146.111121]  ? __free_pages_ok+0x92e/0xcc0
[  146.112128]  ? nf_tables_newrule+0xdc0/0x2380 [nf_tables]
[  146.113410]  __nf_tables_abort+0xac1/0x3510 [nf_tables]
[  146.114618]  ? nft_add_set_elem+0x2550/0x2550 [nf_tables]
[  146.115865]  ? __nft_release_basechain+0x4d0/0x4d0 [nf_tables]
[  146.117217]  nf_tables_abort+0x13/0x30 [nf_tables]
[  146.118311]  nfnetlink_rcv_batch+0xa47/0x1510
[  146.119324]  ? nfnetlink_subsys_register+0x340/0x340
[  146.120456]  ? __lock_acquire+0x92c/0x1420
[  146.121384]  ? memset+0x20/0x40
[  146.122119]  ? __nla_validate_parse+0x3e/0x270
[  146.123146]  nfnetlink_rcv+0x2c1/0x340
[  146.124015]  ? nfnetlink_rcv_batch+0x1510/0x1510
[  146.126901]  netlink_unicast+0x430/0x650
[  146.129580]  ? netlink_attachskb+0x6f0/0x6f0
[  146.132475]  netlink_sendmsg+0x75f/0xc10
[  146.135096]  ? netlink_unicast+0x650/0x650
[  146.137726]  ? netlink_unicast+0x650/0x650
[  146.140217]  sock_sendmsg+0xf0/0x120
[  146.142602]  ____sys_sendmsg+0x522/0x770
[  146.145063]  ? copy_msghdr_from_user+0x20b/0x370
[  146.147662]  ? __might_fault+0xef/0x1a0
[  146.150142]  ? kernel_sendmsg+0x30/0x30
[  146.152577]  ___sys_sendmsg+0xe9/0x160
[  146.154956]  ? sendmsg_copy_msghdr+0x30/0x30
[  146.157455]  ? rcu_read_lock_held+0xaf/0xc0
[  146.159918]  ? rcu_read_lock_sched_held+0xe0/0xe0
[  146.162509]  ? __cgroup_bpf_prog_array_is_empty+0xef/0x1b0
[  146.165246]  ? __cgroup_bpf_run_filter_getsockopt+0x152/0x770
[  146.167997]  ? __might_fault+0xef/0x1a0
[  146.170342]  ? __cgroup_bpf_run_filter_skb+0x10f0/0x10f0
[  146.172955]  ? __fget_light+0x51/0x210
[  146.175182]  __sys_sendmsg+0xbe/0x150
[  146.177371]  ? __sys_sendmsg_sock+0xa0/0xa0
[  146.179633]  ? __down_read+0x400/0x400
[  146.181824]  ? do_syscall_64+0x22/0x510
[  146.183977]  do_syscall_64+0x9f/0x510
[  146.186095]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  146.188490] RIP: 0033:0x7f6a70b84914
[  146.190575] Code: 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b5 0f 1f 80 00 00 00 00 48 8d 05 e9 5d 0c 00 8b 00 85 c0 75 13 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 54 c3 0f 1f 00 41 54 41 89 d4 55 48 89 f5 53
[  146.197226] RSP: 002b:00007ffcca05b178 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
[  146.200181] RAX: ffffffffffffffda RBX: 00007ffcca05c340 RCX: 00007f6a70b84914
[  146.203090] RDX: 0000000000000000 RSI: 00007ffcca05c200 RDI: 0000000000000003
[  146.206014] RBP: 00007ffcca05c2f0 R08: 00007ffcca05b15c R09: 00007ffcca05b180
[  146.208954] R10: fffffffffffffaad R11: 0000000000000246 R12: 0000000000020000
[  146.211881] R13: 0000000000000ec4 R14: 00007ffcca05b190 R15: 0000000000000003
[  146.214837] Modules linked in: snd_hda_codec_generic ledtrig_audio crct10dif_pclmul crc32_pclmul ghash_clmulni_intel bochs_drm snd_hda_intel drm_kms_helper snd_intel_dspcfg snd_hda_codec syscopyarea sysfillrect sysimgblt snd_hwdep fb_sys_fops cec snd_hda_core drm_vram_helper drm_ttm_helper snd_pcm ttm snd_timer joydev drm pcspkr snd virtio_console serio_raw virtio_balloon soundcore nfsd auth_rpcgss nfs_acl lockd grace nf_tables sunrpc ip_tables ext4 mbcache jbd2 ata_generic ata_piix virtio_net net_failover libata virtio_blk crc32c_intel failover i2c_piix4
[  146.233119] CR2: ffffed1176e86005
[  146.235560] ---[ end trace 93407644ed852c1d ]---
[  146.238240] RIP: 0010:check_memory_region+0x108/0x1c0
[  146.240991] Code: 00 00 00 00 00 00 ff e9 35 ff ff ff 41 bc 08 00 00 00 45 29 c4 49 89 d8 4d 8d 0c 1c eb 0c 49 83 c0 01 4c 89 c8 4d 39 c8 74 0f <41> 80 38 00 74 ee 49 8d 04 1c 4d 85 c0 75 0b 49 89 e9 49 29 c1 e9
[  146.248368] RSP: 0018:ffff888361d271a8 EFLAGS: 00010206
[  146.251280] RAX: ffffed1176e86005 RBX: ffffed1176e86005 RCX: ffffffff9b449d82
[  146.254603] RDX: 0000000000000001 RSI: 000000001ffffff8 RDI: ffff888bb7430028
[  146.257939] RBP: ffffed117ae86004 R08: ffffed1176e86005 R09: ffffed1176e86008
[  146.261291] R10: ffffed117ae86003 R11: ffff888bd743001f R12: 0000000000000003
[  146.264654] R13: 0000000000000000 R14: dffffc0000000000 R15: ffff8883cc3b4678
[  146.268006] FS:  00007f6a70820740(0000) GS:ffff8883df100000(0000) knlGS:0000000000000000
[  146.271593] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  146.274753] CR2: ffffed1176e86005 CR3: 00000003d1700000 CR4: 00000000003406e0
[  146.278225] Kernel panic - not syncing: Fatal exception
[  146.282758] Kernel Offset: 0x19600000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[  146.287110] ---[ end Kernel panic - not syncing: Fatal exception ]---

Return to bitmap cut is at 0x1902:

bitmap_shift_right():
/home/sbrivio/nf-next/./include/linux/bitmap.h:432
    18fd:       e8 00 00 00 00          callq  1902 <bitmap_cut+0x62>
                        18fe: R_X86_64_PLT32    __bitmap_shift_right-0x4
bitmap_cut():
/home/sbrivio/nf-next/lib/bitmap.c:208
    1902:       4c 89 e2                mov    %r12,%rdx

so it's caused by the memset in __bitmap_shift_right():

		memset(&dst[lim - off], 0, off*sizeof(unsigned long));

>  
> -	dst[first / BITS_PER_LONG] &= ~0UL << (first % BITS_PER_LONG);
> -	dst[first / BITS_PER_LONG] |= keep;
> +	if (first % BITS_PER_LONG)
> +		b[0] = tmp | (b[0] & BITMAP_FIRST_WORD_MASK(first));
>  }
>  EXPORT_SYMBOL(bitmap_cut);
>  
> diff --git a/lib/test_bitmap.c b/lib/test_bitmap.c
> index 6b13150667f5..4b2fef13003d 100644
> --- a/lib/test_bitmap.c
> +++ b/lib/test_bitmap.c
> @@ -540,6 +540,37 @@ static void __init test_bitmap_arr32(void)
>  	}
>  }
>  
> +struct test_bitmap_cut {
> +	unsigned int first;
> +	unsigned int last;
> +	unsigned int nbits;
> +	unsigned long in;
> +	unsigned long out;
> +};
> +
> +static struct test_bitmap_cut test_cut[] = {
> +	{ 0,  0,  BITS_PER_LONG, 0xdeadbeefUL, 0xdeadbeefUL },
> +	{ 0,  8,  BITS_PER_LONG, 0xdeadbeefUL, 0xdeadbeUL },
> +	{ 4,  8,  BITS_PER_LONG, 0xdeadbeefUL, 0xdeadbefUL },
> +	{ 8,  24, BITS_PER_LONG, 0xdeadbeefUL, 0xdeefUL },
> +	{ 16, 32, BITS_PER_LONG, 0xdeadbeefUL, 0xbeefUL },

...which means it would be a good idea to also add tests for numbers of
bits that are not multiple of eight, and single bits too.

-- 
Stefano

