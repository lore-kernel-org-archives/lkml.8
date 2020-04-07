Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239F1C2BA2B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012D020730
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 15:46:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgDGPqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 11:46:42 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:39307 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgDGPqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 11:46:42 -0400
Received: from mail-qv1-f46.google.com ([209.85.219.46]) by
 mrelayeu.kundenserver.de (mreue108 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MacWq-1iks3e49EY-00c5Ig for <linux-kernel@vger.kernel.org>; Tue, 07 Apr
 2020 17:46:41 +0200
Received: by mail-qv1-f46.google.com with SMTP id ef12so2013891qvb.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Apr 2020 08:46:40 -0700 (PDT)
X-Gm-Message-State: AGi0PubmcWPbCPlmo07dIhBvrKn1lcaiaJTAzG/Ikt4Ul4hWTwzYSA6O
        C49eEyju7coATrvKsUNCPX5jszp2SeHG6QrbbXo=
X-Google-Smtp-Source: APiQypKNO+u/yzxhH9DQJz5YEUJnrTOprM50mwIVnYynamqBHTW23070diLUdO+0pvwO+n5ywyhGSCh2D/jPXTOFAow=
X-Received: by 2002:a0c:fc03:: with SMTP id z3mr2671977qvo.210.1586274399883;
 Tue, 07 Apr 2020 08:46:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190205133821.1a243836@gandalf.local.home> <20190206021611.2nsqomt6a7wuaket@treble>
 <20190206121638.3d2230c1@gandalf.local.home> <CAK8P3a1hsca02=jPQmBG68RTUAt-jDR-qo=UFwf13nZ0k-nDgA@mail.gmail.com>
 <20200406221614.ac2kl3vlagiaj5jf@treble> <CAK8P3a3QntCOJUeUfNmqogO51yh29i4NQCu=NBF4H1+h_m_Pug@mail.gmail.com>
In-Reply-To: <CAK8P3a3QntCOJUeUfNmqogO51yh29i4NQCu=NBF4H1+h_m_Pug@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 7 Apr 2020 17:46:23 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2Bvebrvj7XGBtCwV969g0WhmGr_xFNfSRsZ7WX1J308g@mail.gmail.com>
Message-ID: <CAK8P3a2Bvebrvj7XGBtCwV969g0WhmGr_xFNfSRsZ7WX1J308g@mail.gmail.com>
Subject: Re: libelf-0.175 breaks objtool
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:T+31wuhrCnAug86f3PCvmD8v4gHzDtTjmyHN0JyEqxnWhHdNQpy
 8IDAUQBnWrt6jeJN0FMmCdArLNk7wpYfkkefvcVEnk1ovK7RuSr+OWKrfZLlTU80iytCyfv
 rG59HhzHyqOBj03sThWh4YZM0wtqBLgR85nujFcZ/11Lh6fcIqA6jvzmcaP/XdrYBVjWocl
 qNKxAOLVfCIGCTSeB8RAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iSDF0yr5u1w=:uzVqAWJRKo1uQBIlae3Vf9
 1fjEXGDIFZWF1AQhinroKwqfZ5iHHQjl1ThHI/RjQ2EwpM9o17JhWOmd/XAi0bMstg/9RO8Yu
 KFpjQjDfaGgqEJREWJL5JrHyXvALnifRFFv6PADP+ihST8MiJT/LJqVCVZGpUNbwHG5wqmVnc
 oZNwu0Vgvbhlh6HolnBJ0lbMM4XjzmkgXViiX5ESXQbTpoIVUiELD7O+A7D4FaNdFnZj4hPyD
 7LedD47PH+JTbPDwYUxCcFSB+ZBG2+mMotd8Rcb4GfxImefa+OYy9ZOMFQTuUYENeDg2ta3N6
 whkF296WvbSee1gqB1zvOUwaK9LVJKrqIDkT5XT5tupgEKaN9wWiFULhoz6BTQFI0Phf9aslc
 cAzuNtCZc/WMOxwDMkIrgpOCqGhp7u+Pzi+DIQUXmZ4XglslPUMJklwczl4Cb1rMaNkqfbyah
 6Zrp+BqyTWvGUfECmGauijlV0wai3qyCQYfKstZuN2KpAmxiIFat5trq5Gi8CdZSTORM1sKi5
 tSz3JVhPtCDcTckMYOc94Kim4AO3bXA8Z4f9aEnZ8AhVfT40jrtEV03WqisoP1tvtK3WpUAO/
 TWkainyeTpg3mwriDfxDiG4LxF5rwbGFlEQcXSXOFFSpoXtCTc7aIrI9fRzuVjoMozWwt+cMi
 2G9VL4ow02/TWMcaIJpPg+AiXdDbEvuHZrTxUM2tSVEu70Cr+FZYn+1HKrcfLl7pFMxGUn+TD
 rXcijvIQCdEbQgwsM2sT0k++aP+WqsJD1KHvVUJMl27H/d/94HCqGuOoXWr1IdAXbKc6l4O4B
 0sTOLleEp/KMH+8MuXdDGhsaejOmSNzClYUSFeF7amNIuIBmnk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 7, 2020 at 12:31 AM Arnd Bergmann <arnd@arndb.de> wrote:
> On Tue, Apr 7, 2020 at 12:16 AM Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>
> It's also odd that I only see the problem in two specific files:
> arch/x86/realmode/rm/trampoline_64.o (in half of the randconfig builds)
> and fs/xfs/xfs_trace.o  (in only one configuration so far).
>
> With this patch I can avoid the first one, which is unconditionally
> built with -g (why?):
>
> --- a/arch/x86/realmode/rm/Makefile
> +++ b/arch/x86/realmode/rm/Makefile
> @@ -69,7 +69,7 @@ $(obj)/realmode.relocs: $(obj)/realmode.elf FORCE
>  # ---------------------------------------------------------------------------
>
>  KBUILD_CFLAGS  := $(REALMODE_CFLAGS) -D_SETUP -D_WAKEUP \
> -                  -I$(srctree)/arch/x86/boot
> +                  -I$(srctree)/arch/x86/boot -gz=none
>  KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
>  KBUILD_CFLAGS  += -fno-asynchronous-unwind-tables
>  GCOV_PROFILE := n
>
> I'll look at the other one tomorrow.

I found where -g gets added in both cases, and adding -gz=none
seems to address all randconfigs with CONFIG_DEBUG_INFO=n:

--- a/fs/xfs/Makefile
+++ b/fs/xfs/Makefile
@@ -7,7 +7,7 @@
 ccflags-y += -I $(srctree)/$(src)              # needed for trace events
 ccflags-y += -I $(srctree)/$(src)/libxfs

-ccflags-$(CONFIG_XFS_DEBUG) += -g
+ccflags-$(CONFIG_XFS_DEBUG) += -g $(call cc-option,-gz=none)

 obj-$(CONFIG_XFS_FS)           += xfs.o

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index f16e1fa52a28..17dd9ab538ed 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -40,6 +40,7 @@ REALMODE_CFLAGS += $(call __cc-option, $(CC),
$(REALMODE_CFLAGS), -ffreestanding
 REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS),
-fno-stack-protector)
 #REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS),
-Wno-address-of-packed-member)
 REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS),
$(cc_stack_align4))
+REALMODE_CFLAGS += $(call __cc-option, $(CC), $(REALMODE_CFLAGS), -gz=none)
 export REALMODE_CFLAGS

 # BITS is used as extension for files which are available in a 32 bit


I'm now building again with CONFIG_DEBUG_INFO enabled on x86, to see
if that triggers the same problem elsewhere.

       Arnd
