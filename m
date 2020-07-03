Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6777C433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:22:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8A9920708
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:22:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgGCRW4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:22:56 -0400
Received: from smtprelay0036.hostedemail.com ([216.40.44.36]:45992 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726157AbgGCRWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:22:55 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 28584837F253;
        Fri,  3 Jul 2020 17:22:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: loss37_440877626e93
X-Filterd-Recvd-Size: 6355
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Fri,  3 Jul 2020 17:22:52 +0000 (UTC)
Message-ID: <e954c0d2befcbe2b19450de989facd0ce35f71bd.camel@perches.com>
Subject: Re: [PATCH v2] editorconfig: Add automatic editor configuration file
From:   Joe Perches <joe@perches.com>
To:     Matthew Wilcox <willy@infradead.org>, Danny Lin <danny@kdrag0n.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Fri, 03 Jul 2020 10:22:50 -0700
In-Reply-To: <20200703124939.GG25523@casper.infradead.org>
References: <16043769.gqpzGLO8mG@pinwheel>
         <20200703073143.423557-1-danny@kdrag0n.dev>
         <20200703124939.GG25523@casper.infradead.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-07-03 at 13:49 +0100, Matthew Wilcox wrote:
> On Fri, Jul 03, 2020 at 12:31:43AM -0700, Danny Lin wrote:
> > +# This avoids introducing too many unnecessary changes in trivial commits
> > +trim_trailing_whitespace = false
> 
> I think we prefer trailing whitespace to be trimmed, even for trivial commits.

I think so as well, but I also believe the flag will
whitespace trim not just any modified lines in a patch,
but all lines in the file.

That _might_ be an issue, but if it is, it's trivial.

There are ~50k files and ~26000k lines in the linux
kernel source tree.

There are ~2k files and ~24k lines with trailing
spaces in the code.

$ git grep -P --name-only "\s+$" -- '*.[ch]' | wc -l
2035

$ git grep -P "\s+$" -- '*.[ch]' | wc -l
24083

It's spread all over the kernel, mostly in old files
so likely it doesn't matter much.

$ git grep -P --name-only "\s+$" -- '*.[ch]' | \
  cut -f1,2 -d'/' | sort | uniq -c
    108 arch/alpha
     51 arch/arm
      1 arch/arm64
     18 arch/ia64
     20 arch/m68k
      1 arch/mips
     90 arch/parisc
     73 arch/powerpc
     20 arch/s390
      2 arch/sh
     57 arch/sparc
     32 arch/um
     27 arch/x86
     17 arch/xtensa
      1 block/blk-mq.h
      7 block/partitions
      1 block/scsi_ioctl.c
      1 crypto/khazad.c
      1 crypto/md4.c
      1 crypto/md5.c
      1 crypto/proc.c
      1 crypto/tea.c
      1 crypto/tgr192.c
      1 crypto/twofish_generic.c
      4 drivers/acpi
      1 drivers/ata
     29 drivers/atm
      1 drivers/base
     31 drivers/block
      1 drivers/bus
      1 drivers/cdrom
     20 drivers/char
      2 drivers/clk
      3 drivers/clocksource
      1 drivers/connector
      2 drivers/cpufreq
      1 drivers/cpuidle
      1 drivers/crypto
      1 drivers/dio
      1 drivers/dma
      1 drivers/dma-buf
      1 drivers/extcon
     55 drivers/gpu
      8 drivers/hid
      3 drivers/hwmon
      5 drivers/i2c
     18 drivers/ide
      3 drivers/iio
      1 drivers/infiniband
      6 drivers/input
      1 drivers/irqchip
     14 drivers/macintosh
      1 drivers/memory
      2 drivers/message
      1 drivers/mfd
      1 drivers/misc
      2 drivers/mmc
      7 drivers/mtd
     85 drivers/net
      3 drivers/nvme
     17 drivers/parisc
     10 drivers/parport
     13 drivers/pcmcia
      2 drivers/platform
      2 drivers/pnp
      1 drivers/power
      1 drivers/regulator
     10 drivers/s390
      4 drivers/sbus
    121 drivers/scsi
      2 drivers/soc
      1 drivers/spi
      1 drivers/staging
      1 drivers/target
     30 drivers/tty
     31 drivers/usb
      1 drivers/vhost
     70 drivers/video
      2 drivers/xen
      2 fs/adfs
      1 fs/affs
      1 fs/afs
      1 fs/aio.c
      1 fs/bad_inode.c
      1 fs/bfs
      1 fs/binfmt_aout.c
      1 fs/binfmt_elf.c
      1 fs/binfmt_em86.c
      1 fs/block_dev.c
      3 fs/btrfs
      1 fs/buffer.c
      2 fs/ceph
      2 fs/cifs
     11 fs/coda
      1 fs/compat.c
      1 fs/dcache.c
      1 fs/dcookies.c
      1 fs/direct-io.c
      3 fs/dlm
      1 fs/d_path.c
      5 fs/efs
      9 fs/ext2
      4 fs/ext4
      1 fs/fcntl.c
      1 fs/filesystems.c
      9 fs/freevxfs
      1 fs/fscache
     13 fs/gfs2
      1 fs/hfs
     11 fs/hpfs
      4 fs/isofs
      3 fs/jbd2
      9 fs/jffs2
      5 fs/lockd
      1 fs/mpage.c
      1 fs/namei.c
     11 fs/nfs
     16 fs/nfsd
     37 fs/nls
      8 fs/ntfs
      4 fs/ocfs2
      1 fs/omfs
      1 fs/open.c
      1 fs/openpromfs
      1 fs/pnode.c
      1 fs/posix_acl.c
      5 fs/proc
      1 fs/qnx4
      1 fs/readdir.c
      1 fs/read_write.c
      2 fs/reiserfs
      1 fs/select.c
      5 fs/sysv
      1 fs/timerfd.c
      1 fs/ubifs
      9 fs/ufs
      9 fs/xfs
      8 include/crypto
     97 include/linux
      6 include/math-emu
     29 include/net
      8 include/scsi
     22 include/sound
      1 include/trace
    114 include/uapi
      6 include/video
      2 include/xen
      1 init/do_mounts.c
      1 kernel/audit.h
      1 kernel/auditsc.c
      1 kernel/nsproxy.c
      1 kernel/power
      1 kernel/signal.c
      1 kernel/sysctl.c
      3 kernel/trace
      1 kernel/user.c
      2 lib/fonts
      1 lib/inflate.c
      1 lib/libcrc32c.c
      1 lib/textsearch.c
      1 lib/ts_bm.c
      1 lib/ts_kmp.c
      3 lib/zlib_deflate
      2 lib/zlib_inflate
      1 mm/memory-failure.c
      1 mm/oom_kill.c
      1 mm/page_io.c
      1 mm/rmap.c
      1 mm/swap_state.c
      1 net/ethtool
      1 net/rxrpc
      1 samples/connector
      1 scripts/asn1_compiler.c
      1 scripts/gcc-plugins
      1 security/commoncap.c
      1 security/device_cgroup.c
      1 sound/aoa
     45 sound/core
     17 sound/drivers
      5 sound/i2c
     35 sound/isa
      1 sound/last.c
      2 sound/oss
      1 sound/parisc
    117 sound/pci
      7 sound/pcmcia
      4 sound/ppc
      1 sound/sh
     20 sound/soc
      1 sound/sound_core.c
      7 sound/synth
     12 sound/usb
      1 tools/iio
      6 tools/include
      2 tools/lib
      6 tools/perf
      3 tools/power
      3 tools/testing
      4 tools/virtio
      1 usr/gen_init_cpio.c
      1 virt/kvm



