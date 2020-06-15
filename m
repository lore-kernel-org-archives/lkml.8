Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CEAC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C5602078A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 14:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592229824;
	bh=QEvRkG6/IQtHFGsvkTsm4YyDyhotVNl1laaGrtZ+NeQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=xe2GRtUz4HPt+UJKao01RQbkyVXsuJa/bB1t8QBmvdwIEfsOS/gwC36twxqmxTad0
	 rlsrY5ao/H7V8RWd/W2QTFh6P3YDdYlrEcNxEJdZG9MmIOV31U7T4SYzO+14YXltpi
	 W1dTPG/FWYPeKESA0P8Mu5NQ+CHrpenSMzMfoEYM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730150AbgFOODn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 10:03:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:34704 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729962AbgFOODl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 10:03:41 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8A74206D7;
        Mon, 15 Jun 2020 14:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592229820;
        bh=QEvRkG6/IQtHFGsvkTsm4YyDyhotVNl1laaGrtZ+NeQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=wEBXL+mN8JwNilGhnF9YC/ChIJA1act+6qnG+N761Rdj3khVIiJG88UKSq5zlN6ZT
         Y3u4Ff3gJMnFVpgMkw0ZES+NSOnBMvpJU8F5VUyj03wcDygwZQsKERel+hVEriP+uZ
         4fo12pXVhSf9AYFZNxgjpcnVtDzx073+bh/+sBfs=
Date:   Mon, 15 Jun 2020 23:03:34 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>,
        Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        linux-remoteproc@vger.kernel.org, tee-dev@lists.linaro.org
Subject: Re: [PATCH 20/22] docs: move remaining stuff under
 Documentation/*.txt to Documentation/staging
Message-Id: <20200615230334.a6183feacc5b8ea6c3d2e9de@kernel.org>
In-Reply-To: <11bd0d75e65a874f7c276a0aeab0fe13f3376f5f.1592203650.git.mchehab+huawei@kernel.org>
References: <cover.1592203650.git.mchehab+huawei@kernel.org>
        <11bd0d75e65a874f7c276a0aeab0fe13f3376f5f.1592203650.git.mchehab+huawei@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

If you have any chance to update this series, could you move
kprobes.rst under trace/ directly? I think Naveen's idea is better.

Thank you,

On Mon, 15 Jun 2020 08:50:25 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> There are several files that I was unable to find a proper place
> for them, and 3 ones that are still in plain old text format.
> 
> Let's place those stuff behind the carpet, as we'd like to keep the
> root directory clean.
> 
> We can later discuss and move those into better places.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/index.rst                       | 13 ++++++++
>  .../{crc32.txt => staging/crc32.rst}          |  0
>  Documentation/staging/index.rst               | 32 +++++++++++++++++++
>  .../{kprobes.txt => staging/kprobes.rst}      |  0
>  Documentation/{lzo.txt => staging/lzo.rst}    |  0
>  .../remoteproc.rst}                           |  2 +-
>  .../{rpmsg.txt => staging/rpmsg.rst}          |  0
>  .../speculation.rst}                          |  8 +++--
>  .../static-keys.rst}                          |  0
>  Documentation/{tee.txt => staging/tee.rst}    |  1 +
>  Documentation/{xz.txt => staging/xz.rst}      |  0
>  Documentation/trace/kprobetrace.rst           |  2 +-
>  MAINTAINERS                                   |  8 ++---
>  include/linux/jump_label.h                    |  2 +-
>  lib/crc32.c                                   |  2 +-
>  lib/lzo/lzo1x_decompress_safe.c               |  2 +-
>  lib/xz/Kconfig                                |  2 +-
>  samples/kprobes/kprobe_example.c              |  2 +-
>  samples/kprobes/kretprobe_example.c           |  2 +-
>  19 files changed, 63 insertions(+), 15 deletions(-)
>  rename Documentation/{crc32.txt => staging/crc32.rst} (100%)
>  create mode 100644 Documentation/staging/index.rst
>  rename Documentation/{kprobes.txt => staging/kprobes.rst} (100%)
>  rename Documentation/{lzo.txt => staging/lzo.rst} (100%)
>  rename Documentation/{remoteproc.txt => staging/remoteproc.rst} (99%)
>  rename Documentation/{rpmsg.txt => staging/rpmsg.rst} (100%)
>  rename Documentation/{speculation.txt => staging/speculation.rst} (97%)
>  rename Documentation/{static-keys.txt => staging/static-keys.rst} (100%)
>  rename Documentation/{tee.txt => staging/tee.rst} (99%)
>  rename Documentation/{xz.txt => staging/xz.rst} (100%)
> 
> diff --git a/Documentation/index.rst b/Documentation/index.rst
> index 71eca3171574..3b491af0122d 100644
> --- a/Documentation/index.rst
> +++ b/Documentation/index.rst
> @@ -182,6 +182,19 @@ subprojects.
>  
>     filesystems/ext4/index
>  
> +Other documentation
> +-------------------
> +
> +There are several unsorted documents that don't seem to fit on other parts
> +of the documentation body, or may require some adjustments and/or conversion
> +to ReStructured Text format, or are simply too old.
> +
> +.. toctree::
> +   :maxdepth: 2
> +
> +   staging/index
> +
> +
>  Translations
>  ------------
>  
> diff --git a/Documentation/crc32.txt b/Documentation/staging/crc32.rst
> similarity index 100%
> rename from Documentation/crc32.txt
> rename to Documentation/staging/crc32.rst
> diff --git a/Documentation/staging/index.rst b/Documentation/staging/index.rst
> new file mode 100644
> index 000000000000..8e98517675ca
> --- /dev/null
> +++ b/Documentation/staging/index.rst
> @@ -0,0 +1,32 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Unsorted Documentation
> +======================
> +
> +.. toctree::
> +   :maxdepth: 2
> +
> +   crc32
> +   kprobes
> +   lzo
> +   remoteproc
> +   rpmsg
> +   speculation
> +   static-keys
> +   tee
> +   xz
> +
> +Atomic Types
> +============
> +
> +.. literalinclude:: ../atomic_t.txt
> +
> +Atomic bitops
> +=============
> +
> +.. literalinclude:: ../atomic_bitops.txt
> +
> +Memory Barriers
> +===============
> +
> +.. literalinclude:: ../memory-barriers.txt
> diff --git a/Documentation/kprobes.txt b/Documentation/staging/kprobes.rst
> similarity index 100%
> rename from Documentation/kprobes.txt
> rename to Documentation/staging/kprobes.rst
> diff --git a/Documentation/lzo.txt b/Documentation/staging/lzo.rst
> similarity index 100%
> rename from Documentation/lzo.txt
> rename to Documentation/staging/lzo.rst
> diff --git a/Documentation/remoteproc.txt b/Documentation/staging/remoteproc.rst
> similarity index 99%
> rename from Documentation/remoteproc.txt
> rename to Documentation/staging/remoteproc.rst
> index 2be1147256e0..9cccd3dd6a4b 100644
> --- a/Documentation/remoteproc.txt
> +++ b/Documentation/staging/remoteproc.rst
> @@ -22,7 +22,7 @@ for remote processors that supports this kind of communication. This way,
>  platform-specific remoteproc drivers only need to provide a few low-level
>  handlers, and then all rpmsg drivers will then just work
>  (for more information about the virtio-based rpmsg bus and its drivers,
> -please read Documentation/rpmsg.txt).
> +please read Documentation/staging/rpmsg.rst).
>  Registration of other types of virtio devices is now also possible. Firmwares
>  just need to publish what kind of virtio devices do they support, and then
>  remoteproc will add those devices. This makes it possible to reuse the
> diff --git a/Documentation/rpmsg.txt b/Documentation/staging/rpmsg.rst
> similarity index 100%
> rename from Documentation/rpmsg.txt
> rename to Documentation/staging/rpmsg.rst
> diff --git a/Documentation/speculation.txt b/Documentation/staging/speculation.rst
> similarity index 97%
> rename from Documentation/speculation.txt
> rename to Documentation/staging/speculation.rst
> index 50d7ea857cff..8045d99bcf12 100644
> --- a/Documentation/speculation.txt
> +++ b/Documentation/staging/speculation.rst
> @@ -1,9 +1,11 @@
> +===========
> +Speculation
> +===========
> +
>  This document explains potential effects of speculation, and how undesirable
>  effects can be mitigated portably using common APIs.
>  
> -===========
> -Speculation
> -===========
> +------------------------------------------------------------------------------
>  
>  To improve performance and minimize average latencies, many contemporary CPUs
>  employ speculative execution techniques such as branch prediction, performing
> diff --git a/Documentation/static-keys.txt b/Documentation/staging/static-keys.rst
> similarity index 100%
> rename from Documentation/static-keys.txt
> rename to Documentation/staging/static-keys.rst
> diff --git a/Documentation/tee.txt b/Documentation/staging/tee.rst
> similarity index 99%
> rename from Documentation/tee.txt
> rename to Documentation/staging/tee.rst
> index c8fad81c4563..324604a15d17 100644
> --- a/Documentation/tee.txt
> +++ b/Documentation/staging/tee.rst
> @@ -162,6 +162,7 @@ The AMD-TEE driver packages the command buffer payload for processing in TEE.
>  The command buffer format for the different TEE commands can be found in [7].
>  
>  The TEE commands supported by AMD-TEE Trusted OS are:
> +
>  * TEE_CMD_ID_LOAD_TA          - loads a Trusted Application (TA) binary into
>                                  TEE environment.
>  * TEE_CMD_ID_UNLOAD_TA        - unloads TA binary from TEE environment.
> diff --git a/Documentation/xz.txt b/Documentation/staging/xz.rst
> similarity index 100%
> rename from Documentation/xz.txt
> rename to Documentation/staging/xz.rst
> diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
> index cc4c5fc313df..c1709165c553 100644
> --- a/Documentation/trace/kprobetrace.rst
> +++ b/Documentation/trace/kprobetrace.rst
> @@ -40,7 +40,7 @@ Synopsis of kprobe_events
>   MEMADDR	: Address where the probe is inserted.
>   MAXACTIVE	: Maximum number of instances of the specified function that
>  		  can be probed simultaneously, or 0 for the default value
> -		  as defined in Documentation/kprobes.txt section 1.3.1.
> +		  as defined in Documentation/staging/kprobes.rst section 1.3.1.
>  
>   FETCHARGS	: Arguments. Each probe can have up to 128 args.
>    %REG		: Fetch register REG
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 805309399939..4c9814ee2fdb 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9597,7 +9597,7 @@ M:	Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
>  M:	"David S. Miller" <davem@davemloft.net>
>  M:	Masami Hiramatsu <mhiramat@kernel.org>
>  S:	Maintained
> -F:	Documentation/kprobes.txt
> +F:	Documentation/staging/kprobes.rst
>  F:	include/asm-generic/kprobes.h
>  F:	include/linux/kprobes.h
>  F:	kernel/kprobes.c
> @@ -14500,7 +14500,7 @@ S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git rproc-next
>  F:	Documentation/ABI/testing/sysfs-class-remoteproc
>  F:	Documentation/devicetree/bindings/remoteproc/
> -F:	Documentation/remoteproc.txt
> +F:	Documentation/staging/remoteproc.rst
>  F:	drivers/remoteproc/
>  F:	include/linux/remoteproc.h
>  F:	include/linux/remoteproc/
> @@ -14512,7 +14512,7 @@ L:	linux-remoteproc@vger.kernel.org
>  S:	Maintained
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/andersson/remoteproc.git rpmsg-next
>  F:	Documentation/ABI/testing/sysfs-bus-rpmsg
> -F:	Documentation/rpmsg.txt
> +F:	Documentation/staging/rpmsg.rst
>  F:	drivers/rpmsg/
>  F:	include/linux/rpmsg.h
>  F:	include/linux/rpmsg/
> @@ -16761,7 +16761,7 @@ TEE SUBSYSTEM
>  M:	Jens Wiklander <jens.wiklander@linaro.org>
>  L:	tee-dev@lists.linaro.org
>  S:	Maintained
> -F:	Documentation/tee.txt
> +F:	Documentation/staging/tee.rst
>  F:	drivers/tee/
>  F:	include/linux/tee_drv.h
>  F:	include/uapi/linux/tee.h
> diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
> index 3526c0aee954..32809624d422 100644
> --- a/include/linux/jump_label.h
> +++ b/include/linux/jump_label.h
> @@ -68,7 +68,7 @@
>   * Lacking toolchain and or architecture support, static keys fall back to a
>   * simple conditional branch.
>   *
> - * Additional babbling in: Documentation/static-keys.txt
> + * Additional babbling in: Documentation/staging/static-keys.rst
>   */
>  
>  #ifndef __ASSEMBLY__
> diff --git a/lib/crc32.c b/lib/crc32.c
> index 4a20455d1f61..35a03d03f973 100644
> --- a/lib/crc32.c
> +++ b/lib/crc32.c
> @@ -24,7 +24,7 @@
>   * Version 2.  See the file COPYING for more details.
>   */
>  
> -/* see: Documentation/crc32.txt for a description of algorithms */
> +/* see: Documentation/staging/crc32.rst for a description of algorithms */
>  
>  #include <linux/crc32.h>
>  #include <linux/crc32poly.h>
> diff --git a/lib/lzo/lzo1x_decompress_safe.c b/lib/lzo/lzo1x_decompress_safe.c
> index 2717c7963acd..7892a40cf765 100644
> --- a/lib/lzo/lzo1x_decompress_safe.c
> +++ b/lib/lzo/lzo1x_decompress_safe.c
> @@ -32,7 +32,7 @@
>   * depending on the base count. Since the base count is taken from a u8
>   * and a few bits, it is safe to assume that it will always be lower than
>   * or equal to 2*255, thus we can always prevent any overflow by accepting
> - * two less 255 steps. See Documentation/lzo.txt for more information.
> + * two less 255 steps. See Documentation/staging/lzo.rst for more information.
>   */
>  #define MAX_255_COUNT      ((((size_t)~0) / 255) - 2)
>  
> diff --git a/lib/xz/Kconfig b/lib/xz/Kconfig
> index 22528743d4ce..5cb50245a878 100644
> --- a/lib/xz/Kconfig
> +++ b/lib/xz/Kconfig
> @@ -5,7 +5,7 @@ config XZ_DEC
>  	help
>  	  LZMA2 compression algorithm and BCJ filters are supported using
>  	  the .xz file format as the container. For integrity checking,
> -	  CRC32 is supported. See Documentation/xz.txt for more information.
> +	  CRC32 is supported. See Documentation/staging/xz.rst for more information.
>  
>  if XZ_DEC
>  
> diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
> index 501911d1b327..240f2435ce6f 100644
> --- a/samples/kprobes/kprobe_example.c
> +++ b/samples/kprobes/kprobe_example.c
> @@ -5,7 +5,7 @@
>   * stack trace and selected registers when _do_fork() is called.
>   *
>   * For more information on theory of operation of kprobes, see
> - * Documentation/kprobes.txt
> + * Documentation/staging/kprobes.rst
>   *
>   * You will see the trace data in /var/log/messages and on the console
>   * whenever _do_fork() is invoked to create a new process.
> diff --git a/samples/kprobes/kretprobe_example.c b/samples/kprobes/kretprobe_example.c
> index 013e8e6ebae9..78a2da6fb3cd 100644
> --- a/samples/kprobes/kretprobe_example.c
> +++ b/samples/kprobes/kretprobe_example.c
> @@ -11,7 +11,7 @@
>   * If no func_name is specified, _do_fork is instrumented
>   *
>   * For more information on theory of operation of kretprobes, see
> - * Documentation/kprobes.txt
> + * Documentation/staging/kprobes.rst
>   *
>   * Build and insert the kernel module as done in the kprobe example.
>   * You will see the trace data in /var/log/messages and on the console
> -- 
> 2.26.2
> 


-- 
Masami Hiramatsu <mhiramat@kernel.org>
