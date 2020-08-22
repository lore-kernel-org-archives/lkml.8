Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D678C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 17:36:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 703E0206C0
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 17:36:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728381AbgHVRgt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 13:36:49 -0400
Received: from smtprelay0083.hostedemail.com ([216.40.44.83]:38756 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727945AbgHVRgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 13:36:46 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 46521182CED28;
        Sat, 22 Aug 2020 17:36:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: grain22_34001cf27043
X-Filterd-Recvd-Size: 8567
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Sat, 22 Aug 2020 17:36:43 +0000 (UTC)
Message-ID: <ae31327674df92df720b1f026804b66c59e43e4c.camel@perches.com>
Subject: Re: [GIT PULL] fallthrough pseudo-keyword macro conversions for
 5.9-rc2
From:   Joe Perches <joe@perches.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Sat, 22 Aug 2020 10:36:42 -0700
In-Reply-To: <20200820220210.GA14894@embeddedor>
References: <20200820220210.GA14894@embeddedor>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-08-20 at 17:02 -0500, Gustavo A. R. Silva wrote:
> This treewide patch doesn't address ALL fall-through markings in all
> subsystems at once because I have previously sent out patches for some of
> such subsystems separately, and I will follow up on them; however, this
> definitely contributes most of the work needed to replace all the
> fall-through markings with the fallthrough pseudo-keyword macro in the
> whole codebase.

Hi Gustavo.  Thanks for this.

Some stragglers (for -next) in the arch/subsystems modified
by this patch:

arch/x86/
drivers/gpu/
drivers/misc/
drivers/net/ethernet/
lib/

And some in scripts/ and tools/ which maybe shouldn't be changed.

Possible diffs for each straggler directory block below:

>  arch/x86/

$ git diff -U0 arch
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 0f3d01562ded..b825a5a5ede7 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1149 +1149 @@ static inline void x86_assign_hw_event(struct perf_event *event,
-               /* fall through */
+               fallthrough;
diff --git a/arch/x86/kernel/e820.c b/arch/x86/kernel/e820.c
index 983cd53ed4c9..097cc3439e53 100644
--- a/arch/x86/kernel/e820.c
+++ b/arch/x86/kernel/e820.c
@@ -190 +190 @@ static void __init e820_print_type(enum e820_type type)
-       case E820_TYPE_RAM:             /* Fall through: */
+       case E820_TYPE_RAM:
@@ -197 +197 @@ static void __init e820_print_type(enum e820_type type)
-       case E820_TYPE_PMEM:            /* Fall through: */
+       case E820_TYPE_PMEM:
@@ -1044 +1044 @@ static const char *__init e820_type_to_string(struct e820_entry *entry)
-       case E820_TYPE_RESERVED_KERN:   /* Fall-through: */
+       case E820_TYPE_RESERVED_KERN:
@@ -1060 +1060 @@ static unsigned long __init e820_type_to_iomem_type(struct e820_entry *entry)
-       case E820_TYPE_RESERVED_KERN:   /* Fall-through: */
+       case E820_TYPE_RESERVED_KERN:
@@ -1062,7 +1062,7 @@ static unsigned long __init e820_type_to_iomem_type(struct e820_entry *entry)
-       case E820_TYPE_ACPI:            /* Fall-through: */
-       case E820_TYPE_NVS:             /* Fall-through: */
-       case E820_TYPE_UNUSABLE:        /* Fall-through: */
-       case E820_TYPE_PRAM:            /* Fall-through: */
-       case E820_TYPE_PMEM:            /* Fall-through: */
-       case E820_TYPE_RESERVED:        /* Fall-through: */
-       case E820_TYPE_SOFT_RESERVED:   /* Fall-through: */
+       case E820_TYPE_ACPI:
+       case E820_TYPE_NVS:
+       case E820_TYPE_UNUSABLE:
+       case E820_TYPE_PRAM:
+       case E820_TYPE_PMEM:
+       case E820_TYPE_RESERVED:
+       case E820_TYPE_SOFT_RESERVED:
@@ -1082,3 +1082,3 @@ static unsigned long __init e820_type_to_iores_desc(struct e820_entry *entry)
-       case E820_TYPE_RESERVED_KERN:   /* Fall-through: */
-       case E820_TYPE_RAM:             /* Fall-through: */
-       case E820_TYPE_UNUSABLE:        /* Fall-through: */
+       case E820_TYPE_RESERVED_KERN:
+       case E820_TYPE_RAM:
+       case E820_TYPE_UNUSABLE:

>  drivers/gpu/

$ git diff -U1 drivers/gpu
diff --git a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
index b5986d19dc08..77dec1a56b9b 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/si_dpm.c
@@ -6203,3 +6203,3 @@ static void si_request_link_speed_change_before_state_change(struct amdgpu_devic
 #endif
-                       /* fall through */
+                       fallthrough;
                default:
diff --git a/drivers/gpu/drm/radeon/ci_dpm.c b/drivers/gpu/drm/radeon/ci_dpm.c
index 886e9959496f..6ba12f141833 100644
--- a/drivers/gpu/drm/radeon/ci_dpm.c
+++ b/drivers/gpu/drm/radeon/ci_dpm.c
@@ -4863,3 +4863,3 @@ static void ci_request_link_speed_change_before_state_change(struct radeon_devic
 #endif
-                       /* fall through */
+                       fallthrough;
                default:
diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
index d1c73e9db889..76427c893827 100644
--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -5751,3 +5751,3 @@ static void si_request_link_speed_change_before_state_change(struct radeon_devic
 #endif
-                       /* fall through */
+                       fallthrough;
                default:

> drivers/misc/

diff --git a/drivers/misc/mei/interrupt.c b/drivers/misc/mei/interrupt.c
index 326955b04fda..683871267f4f 100644
--- a/drivers/misc/mei/interrupt.c
+++ b/drivers/misc/mei/interrupt.c
@@ -135 +134,0 @@ static int mei_cl_irq_read_msg(struct mei_cl *cl,
-                               fallthrough;

>  drivers/net/ethernet/

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c
index 08c76636c164..2a86307e3c43 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-anarion.c
@@ -87,3 +87,2 @@ static struct anarion_gmac *anarion_config_dt(struct platform_device *pdev)
        case PHY_INTERFACE_MODE_RGMII:
-               fallthrough;
        case PHY_INTERFACE_MODE_RGMII_ID:

>  drivers/scsi/

$ git diff -U1 drivers/scsi
diff --git a/drivers/scsi/libsas/sas_discover.c b/drivers/scsi/libsas/sas_discover.c
index cd7c7d269f6f..26c992213c9c 100644
--- a/drivers/scsi/libsas/sas_discover.c
+++ b/drivers/scsi/libsas/sas_discover.c
@@ -468,5 +468,4 @@ static void sas_discover_domain(struct work_struct *work)
                pr_notice("ATA device seen but CONFIG_SCSI_SAS_ATA=N so cannot attach\n");
-               /* Fall through */
+               fallthrough;
 #endif
-               /* Fall through - only for the #else condition above. */
 
>  lib/

$ git diff -U0 lib
diff --git a/lib/nlattr.c b/lib/nlattr.c
index 665bdaff02c8..e0da8c23d674 100644
--- a/lib/nlattr.c
+++ b/lib/nlattr.c
@@ -404,2 +404 @@ static int validate_nla(const struct nlattr *nla, int maxtype,
-		/* fall through */
-
+		fallthrough;
diff --git a/lib/zlib_inflate/inflate.c b/lib/zlib_inflate/inflate.c
index 67cc9b08ae9d..8147b0ade347 100644
--- a/lib/zlib_inflate/inflate.c
+++ b/lib/zlib_inflate/inflate.c
@@ -399 +399 @@ int zlib_inflate(z_streamp strm, int flush)
-	    /* fall through */
+        	fallthrough;
@@ -407 +407 @@ int zlib_inflate(z_streamp strm, int flush)
-	    /* fall through */
+        	fallthrough;
@@ -410 +410 @@ int zlib_inflate(z_streamp strm, int flush)
-	    /* fall through */
+        	fallthrough;
@@ -449 +449 @@ int zlib_inflate(z_streamp strm, int flush)
-	    /* fall through */
+        	fallthrough;
@@ -483 +483 @@ int zlib_inflate(z_streamp strm, int flush)
-	    /* fall through */
+        	fallthrough;
@@ -504 +504 @@ int zlib_inflate(z_streamp strm, int flush)
-	    /* fall through */
+        	fallthrough;
@@ -578 +578 @@ int zlib_inflate(z_streamp strm, int flush)
-	    /* fall through */
+        	fallthrough;
@@ -618 +618 @@ int zlib_inflate(z_streamp strm, int flush)
-	    /* fall through */
+        	fallthrough;
@@ -626 +626 @@ int zlib_inflate(z_streamp strm, int flush)
-	    /* fall through */
+        	fallthrough;
@@ -652 +652 @@ int zlib_inflate(z_streamp strm, int flush)
-	    /* fall through */
+        	fallthrough;
@@ -672 +672 @@ int zlib_inflate(z_streamp strm, int flush)
-	    /* fall through */
+        	fallthrough;
@@ -723 +723 @@ int zlib_inflate(z_streamp strm, int flush)
-	    /* fall through */
+        	fallthrough;



