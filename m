Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCF6C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 02:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CABE2082F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 02:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jRfxtjAl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728146AbgGBCFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 22:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbgGBCFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 22:05:04 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCBDC08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jul 2020 19:05:03 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id s14so10645344plq.6
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jul 2020 19:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=si919z/gb731yIF4miWJ8lqQQhvtP91BYHd7qG0jbYg=;
        b=jRfxtjAlsyBpIblze7OawLvko6wtB4QyMbwgZ2kojyHVMh5x2d0X+6XWyvzIh3tYQG
         s3FMJLAYwapjMMIhNjP2Y/ErtQ9LzTAqVz/W/8jecDF/v+BD58/rhMmisvD2QPA1fJL8
         Bb7MHyXobsSUvZORXXjir+iZh59/Fx21HpqZUMngEAq5tdapymT2k2DTG0TaXWR6hYre
         wg0keASysO4otuHcVjLlUCagcFtvIPJ8JCDIDoc1WN3S/RCRAQTueSqdvYVIxXiT2+uK
         NyWPV2aMvVq73zkN8l94NEc7eGCYBjr2BqrSXfVb5b1e2j9OB2yLoTj11sjOoCdXF8Su
         Qx9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=si919z/gb731yIF4miWJ8lqQQhvtP91BYHd7qG0jbYg=;
        b=TwZRYhL1U+4Qfi2hjawRfuJ5BDqLzNndNdHr0JOVSPWslL07wFfsvWgiV3+JM7Dtu+
         g+wo+iIHKZKVPDeFavTxMJnIoGmRQjCDXcG32Ok0S8SjLH5IrPzqKAHa0GO8AToPAX2u
         FUMMam1l65hsw/reBtQf1mk4F+K4AFcmVXq/zAxtxGIMrJKg+2n8LzXh/iTrd1kSyeRx
         NyPKFKvCTvh3o8+1H0PW821ehmtexhziK4/xXFYhJoNqNNvOP5Cv2AiyGHgpVln/Vy+K
         i38LuBj7l+DuVghFQv0pntUBifkZaTzJxsV8zK3/s37eQK2OTvQmygDQs/ayJHAYwoPe
         keWA==
X-Gm-Message-State: AOAM5319S2g3MnmpH3dYmC88akUVclE9d8tPGOJKqKsTnGmEIYg7yzcT
        Fsr3wkHyVR2dawHdlUicdOrgHTvzIEugPmxxpR/5vw==
X-Google-Smtp-Source: ABdhPJzQ68RugUh9HRrPoEsLeqYaVA3vLoMmx53B1gD8wvkBF7BYoTJ+JI3IXYsgPtf7gVwTkCrizpyAsOEoYN1dyGI=
X-Received: by 2002:a17:90a:e602:: with SMTP id j2mr27157132pjy.200.1593655502448;
 Wed, 01 Jul 2020 19:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <20200701184751.84008-1-pierre-louis.bossart@linux.intel.com>
In-Reply-To: <20200701184751.84008-1-pierre-louis.bossart@linux.intel.com>
From:   Vincent Chen <vincent.chen@sifive.com>
Date:   Thu, 2 Jul 2020 10:04:51 +0800
Message-ID: <CABvJ_xhm9a0nzBJ2YKvwm5vKZt3Xp0H9z6QakD0EYK7vRR-_AA@mail.gmail.com>
Subject: Re: [PATCH] riscv: asm/gdb_xml.h: use __maybe_used to make W=1
 warnings go away
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de, broonie@kernel.org,
        kernel test robot <lkp@intel.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "open list:RISC-V ARCHITECTURE" <linux-riscv@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 2, 2020 at 2:48 AM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
> 0day/kbuild reports warnings with the ASoC codecs compiled with W=1.
>
> In file included from arch/riscv/include/asm/kgdb.h:109,
>                  from include/linux/kgdb.h:20,
>                  from include/linux/fb.h:5,
>                  from include/drm/drm_crtc.h:31,
>                  from sound/soc/codecs/hdmi-codec.c:19:
>
> arch/riscv/include/asm/gdb_xml.h:23:19: warning:
> 'riscv_gdb_stub_cpuxml' defined but not used [-Wunused-const-variable=]
>    23 | static const char riscv_gdb_stub_cpuxml[2048] =
>       |                   ^~~~~~~~~~~~~~~~~~~~~
> arch/riscv/include/asm/gdb_xml.h:16:19: warning:
> 'riscv_gdb_stub_target_desc' defined but not used [-Wunused-const-variable=]
>    16 | static const char riscv_gdb_stub_target_desc[256] =
>       |                   ^~~~~~~~~~~~~~~~~~~~~~~~~~
> arch/riscv/include/asm/gdb_xml.h:13:19: warning:
> 'gdb_xfer_read_cpuxml' defined but not used [-Wunused-const-variable=]
>    13 | static const char gdb_xfer_read_cpuxml[39] =
>       |                   ^~~~~~~~~~~~~~~~~~~~
> arch/riscv/include/asm/gdb_xml.h:10:19: warning:
> 'gdb_xfer_read_target' defined but not used [-Wunused-const-variable=]
>    10 | static const char gdb_xfer_read_target[31] = "qXfer:features:read:target.xml:";
>       |                   ^~~~~~~~~~~~~~~~~~~~
> arch/riscv/include/asm/gdb_xml.h:7:19: warning:
> 'riscv_gdb_stub_feature' defined but not used [-Wunused-const-variable=]
>     7 | static const char riscv_gdb_stub_feature[64] =
>       |                   ^~~~~~~~~~~~~~~~~~~~~~
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>
> I don't know if this is the right way of solving this issue but this
> error is now consistently thrown in kbuild compile-test reports w/
> W=1.
>

Dear Pierre-Louis Bossart:
Thanks for your modifications. I have fixed the warnings in my latest
KGDB patchset and sent it out, but the merged KGDB patchset is not my
latest version.
I have sent a patch set to complement the missing ports, and I think
these warnings would disappear after this patch has been accepted and
merged.

Here is the patch to fix this warning:
http://lists.infradead.org/pipermail/linux-riscv/2020-June/000660.html


>  arch/riscv/include/asm/gdb_xml.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/arch/riscv/include/asm/gdb_xml.h b/arch/riscv/include/asm/gdb_xml.h
> index 041b45f5b997..c28fc1a1d230 100644
> --- a/arch/riscv/include/asm/gdb_xml.h
> +++ b/arch/riscv/include/asm/gdb_xml.h
> @@ -4,23 +4,23 @@
>  #define __ASM_GDB_XML_H_
>
>  #define kgdb_arch_gdb_stub_feature riscv_gdb_stub_feature
> -static const char riscv_gdb_stub_feature[64] =
> +static __maybe_unused const char riscv_gdb_stub_feature[64] =
>                         "PacketSize=800;qXfer:features:read+;";
>
> -static const char gdb_xfer_read_target[31] = "qXfer:features:read:target.xml:";
> +static __maybe_unused const char gdb_xfer_read_target[31] = "qXfer:features:read:target.xml:";
>
>  #ifdef CONFIG_64BIT
> -static const char gdb_xfer_read_cpuxml[39] =
> +static __maybe_unused const char gdb_xfer_read_cpuxml[39] =
>                         "qXfer:features:read:riscv-64bit-cpu.xml";
>
> -static const char riscv_gdb_stub_target_desc[256] =
> +static __maybe_unused const char riscv_gdb_stub_target_desc[256] =
>  "l<?xml version=\"1.0\"?>"
>  "<!DOCTYPE target SYSTEM \"gdb-target.dtd\">"
>  "<target>"
>  "<xi:include href=\"riscv-64bit-cpu.xml\"/>"
>  "</target>";
>
> -static const char riscv_gdb_stub_cpuxml[2048] =
> +static __maybe_unused const char riscv_gdb_stub_cpuxml[2048] =
>  "l<?xml version=\"1.0\"?>"
>  "<!DOCTYPE feature SYSTEM \"gdb-target.dtd\">"
>  "<feature name=\"org.gnu.gdb.riscv.cpu\">"
> --
> 2.25.1
>
