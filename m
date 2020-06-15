Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A18C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ED02B2074D
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 20:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592253242;
	bh=zW7MbhrB+h7RvacW8419wKuWZSJlkuQg8hGDlf7k564=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=uhbdBNOfg1jqy0IEbaTpiaPq2/+1SlmqK01v9hanudALe9oFVl6DlaN9XmSwrr2p1
	 y3nqn3bEIc3ZqxF0C6w7vuXTe0W1TBB4LizCArhR4ea2I5/Z5y4Z+zVCspiV3ctu40
	 RJRQ5JasgdxQ9UCstfuNA2WacZ+bCNzNxMe/h8PQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731459AbgFOUd7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 16:33:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:43432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728346AbgFOUd7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 16:33:59 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC7FA20663;
        Mon, 15 Jun 2020 20:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592253238;
        bh=zW7MbhrB+h7RvacW8419wKuWZSJlkuQg8hGDlf7k564=;
        h=Date:From:To:Cc:Subject:From;
        b=yLJOSpyvilqrcFA1Xc14LUoiqcjY+5K08KeIRXijnsXo/Znfpbwr4wu49rzTvPyG2
         3ku9PaKdGIMcADlbfHG/VeAgOmm/rCwbRWHV8bLLxafZ/7GLhP0JrlIiyHugvFRXg2
         S+Um2FzqpAymD/Je3vgFlW3b9E5RUE+Unu6zKofU=
Date:   Mon, 15 Jun 2020 15:39:17 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [GIT PULL] flexible-array member conversion patches for 5.8-rc2
Message-ID: <20200615203917.GA15876@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gustavoars/linux.git tags/flex-array-conversions-5.8-rc2

for you to fetch changes up to 4caeb3acd21ffa2496fc3e94398019d4b3415523:

  w1: Replace zero-length array with flexible-array (2020-06-15 15:20:19 -0500)

----------------------------------------------------------------
flexible-array member conversion patches for 5.8-rc2

Hi Linus,

Please, pull the following patches that replace zero-length arrays with
flexible-array members.

Notice that all of these patches have been baking in linux-next for
two development cycles now.

There is a regular need in the kernel to provide a way to declare having a
dynamically sized set of trailing elements in a structure. Kernel code should
always use “flexible array members”[1] for these cases. The older style of
one-element or zero-length arrays should no longer be used.

In older C code, dynamically sized trailing elements were done by specifying
a one-element array at the end of a structure:

struct something {
        size_t count;
        struct foo items[1];
};

This led to fragile size calculations via sizeof() (which would need to remove
the size of the single trailing element to get a correct size of the “header”).
A GNU C extension[2] was introduced to allow for zero-length arrays, to avoid
these kinds of size problems:

struct something {
        size_t count;
        struct foo items[0];
};

But this led to other problems, and didn’t solve some problems shared by both
styles, like not being able to detect when such an array is accidentally being
used _not_ at the end of a structure (which could happen directly, or when
such a struct was in unions, structs of structs, etc).

C99 introduced “flexible array members”, which lacks a numeric size for the
array declaration entirely:

struct something {
        size_t count;
        struct foo items[];
};

This is the way the kernel expects dynamically sized trailing elements to be
declared. It allows the compiler to generate errors when the flexible array
does not occur last in the structure, which helps to prevent some kind of
undefined behavior[3] bugs from being inadvertently introduced to the codebase.
It also allows the compiler to correctly analyze array sizes (via sizeof(),
CONFIG_FORTIFY_SOURCE, and CONFIG_UBSAN_BOUNDS). For instance, there is no
mechanism that warns us that the following application of the sizeof() operator
to a zero-length array always results in zero:

struct something {
        size_t count;
        struct foo items[0];
};

struct something *instance;

instance = kmalloc(struct_size(instance, items, count), GFP_KERNEL);
instance->count = count;

size = sizeof(instance->items) * instance->count;
memcpy(instance->items, source, size);

At the last line of code above, size turns out to be zero, when one might have
thought it represents the total size in bytes of the dynamic memory recently
allocated for the trailing array items. Here are a couple examples of this
issue[4][5]. Instead, flexible array members have incomplete type, and so the
sizeof() operator may not be applied[2], so any misuse of such operators will
be immediately noticed at build time.

With respect to one-element arrays, one has to be acutely aware that such
arrays occupy at least as much space as a single object of the type[2], hence they
contribute to the size of the enclosing structure. This is prone to error every
time people want to calculate the total size of dynamic memory to allocate for
a structure containing an array of this kind as a member:

struct something {
        size_t count;
        struct foo items[1];
};

struct something *instance;

instance = kmalloc(struct_size(instance, items, count - 1), GFP_KERNEL);
instance->count = count;

size = sizeof(instance->items) * instance->count;
memcpy(instance->items, source, size);

In the example above, we had to remember to calculate count - 1 when using the
struct_size() helper, otherwise we would have –unintentionally– allocated memory
for one too many items objects. The cleanest and least error-prone way to
implement this is through the use of a flexible array member:

struct something {
        size_t count;
        struct foo items[];
};

struct something *instance;

instance = kmalloc(struct_size(instance, items, count), GFP_KERNEL);
instance->count = count;

size = sizeof(instance->items[0]) * instance->count;
memcpy(instance->items, source, size);

Thanks
--
Gustavo

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[3] https://git.kernel.org/linus/76497732932f15e7323dc805e8ea8dc11bb587cf
[4] https://git.kernel.org/linus/f2cd32a443da694ac4e28fbf4ac6f9d5cc63a539
[5] https://git.kernel.org/linus/ab91c2a89f86be2898cee208d492816ec238b2cf

----------------------------------------------------------------
Gustavo A. R. Silva (41):
      firmware: dmi-sysfs: Replace zero-length array with flexible-array member
      firmware: google: memconsole: Replace zero-length array with flexible-array member
      firmware: google: vpd: Replace zero-length array with flexible-array member
      aio: Replace zero-length array with flexible-array
      ARM: tegra: Replace zero-length array with flexible-array
      dmaengine: Replace zero-length array with flexible-array
      can: peak_canfd: Replace zero-length array with flexible-array
      can: Replace zero-length array with flexible-array
      crypto: Replace zero-length array with flexible-array
      drbd: Replace zero-length array with flexible-array
      drm/edid: Replace zero-length array with flexible-array
      cb710: Replace zero-length array with flexible-array
      firewire: ohci: Replace zero-length array with flexible-array
      FS-Cache: Replace zero-length array with flexible-array
      ia64: kernel: unwind_i.h: Replace zero-length array with flexible-array
      samples: mei: Replace zero-length array with flexible-array
      ibft: Replace zero-length array with flexible-array
      jffs2: Replace zero-length array with flexible-array
      KVM: Replace zero-length array with flexible-array
      kexec: Replace zero-length array with flexible-array
      keys: encrypted-type: Replace zero-length array with flexible-array
      kprobes: Replace zero-length array with flexible-array
      libata: Replace zero-length array with flexible-array
      tools/testing/nvdimm: Replace zero-length array with flexible-array
      block: Replace zero-length array with flexible-array
      oprofile: Replace zero-length array with flexible-array
      firmware: pcdp: Replace zero-length array with flexible-array
      media: pwc: Replace zero-length array with flexible-array
      rapidio: Replace zero-length array with flexible-array
      RxRPC: Replace zero-length array with flexible-array
      phy: samsung: Replace zero-length array with flexible-array
      sctp: Replace zero-length array with flexible-array
      ima: Replace zero-length array with flexible-array
      ASoC: SOF: Replace zero-length array with flexible-array
      Squashfs: Replace zero-length array with flexible-array
      stm class: Replace zero-length array with flexible-array
      dmaengine: tegra-apb: Replace zero-length array with flexible-array
      tifm: Replace zero-length array with flexible-array
      soc: ti: Replace zero-length array with flexible-array
      tracing/probe: Replace zero-length array with flexible-array
      w1: Replace zero-length array with flexible-array

 arch/ia64/kernel/unwind_i.h                   |  2 +-
 block/partitions/ldm.h                        |  2 +-
 drivers/amba/tegra-ahb.c                      |  2 +-
 drivers/block/drbd/drbd_int.h                 |  2 +-
 drivers/block/drbd/drbd_protocol.h            |  8 +++---
 drivers/crypto/chelsio/chcr_crypto.h          |  8 +++---
 drivers/dma/milbeaut-hdmac.c                  |  2 +-
 drivers/dma/milbeaut-xdmac.c                  |  2 +-
 drivers/dma/moxart-dma.c                      |  2 +-
 drivers/dma/tegra20-apb-dma.c                 |  2 +-
 drivers/dma/ti/edma.c                         |  2 +-
 drivers/dma/ti/k3-udma.c                      |  2 +-
 drivers/dma/timb_dma.c                        |  2 +-
 drivers/firewire/core-cdev.c                  |  2 +-
 drivers/firewire/core-transaction.c           |  2 +-
 drivers/firewire/core.h                       |  2 +-
 drivers/firewire/nosy.c                       |  2 +-
 drivers/firewire/ohci.c                       |  2 +-
 drivers/firmware/dmi-sysfs.c                  |  2 +-
 drivers/firmware/google/memconsole-coreboot.c |  2 +-
 drivers/firmware/google/vpd.c                 |  2 +-
 drivers/firmware/iscsi_ibft.c                 |  2 +-
 drivers/firmware/pcdp.h                       |  2 +-
 drivers/hwtracing/stm/policy.c                |  2 +-
 drivers/hwtracing/stm/stm.h                   |  4 +--
 drivers/media/usb/pwc/pwc.h                   |  2 +-
 drivers/net/can/peak_canfd/peak_pciefd_main.c |  4 +--
 drivers/oprofile/cpu_buffer.h                 |  2 +-
 drivers/phy/samsung/phy-samsung-usb2.h        |  2 +-
 drivers/rapidio/rio-scan.c                    |  2 +-
 drivers/soc/ti/knav_qmss.h                    |  2 +-
 drivers/w1/w1_netlink.h                       |  4 +--
 fs/aio.c                                      |  2 +-
 fs/jffs2/nodelist.h                           |  2 +-
 fs/jffs2/summary.h                            |  4 +--
 fs/squashfs/squashfs_fs.h                     | 16 ++++++------
 include/drm/drm_displayid.h                   |  2 +-
 include/keys/encrypted-type.h                 |  2 +-
 include/keys/rxrpc-type.h                     |  4 +--
 include/linux/can/skb.h                       |  2 +-
 include/linux/cb710.h                         |  2 +-
 include/linux/dmaengine.h                     |  4 +--
 include/linux/fscache-cache.h                 |  2 +-
 include/linux/kexec.h                         |  2 +-
 include/linux/kprobes.h                       |  2 +-
 include/linux/kvm_host.h                      |  2 +-
 include/linux/libata.h                        |  2 +-
 include/linux/sctp.h                          | 36 +++++++++++++--------------
 include/linux/tifm.h                          |  2 +-
 kernel/trace/trace_probe.h                    |  2 +-
 samples/mei/mei-amt-version.c                 |  2 +-
 security/integrity/integrity.h                |  4 +--
 sound/soc/sof/probe.h                         |  8 +++---
 tools/testing/nvdimm/test/nfit_test.h         |  6 ++---
 54 files changed, 96 insertions(+), 96 deletions(-)
