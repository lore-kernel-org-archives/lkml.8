Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48947C433F2
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 23:12:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 175782177B
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 23:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fpPqAUq1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbgGSXL7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 19:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgGSXLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 19:11:51 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121B4C0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 16:11:51 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id n24so10802299otr.13
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 16:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GLnZLZnFrYgrRLtl0OQRxaMDUVx3fh8Zfv1w7shqteg=;
        b=fpPqAUq1SUoZ3hB5Kh/mgbdZa3NRpsXme+zKATQm6j58K4YzR5BUFJuoZwr/omsVaG
         9hyKYkVRdl/cAfSe32R66ktMseB6zZGXWpUHz3n3dLB48G2zEfOf64h7Qj3M13aDLHTT
         k6LET/nYVhEWytZatX0WPI9OE08zZhtZ2GCIFX2O9cpETxT2QkcDGo2me7CxZaTsQS1q
         LxvJDMFcK9BdcJLDCnv/48g35uyXKYh0DlkZX1y3Wyqe45qKhj66vuviK8xfjnRiBgL6
         fb5IlM7wK3LVp20vwxaJ8mhA4fVDRJdMZ0V2bRMUDWWJ8zHm4k6eRQ4iEfNomgB7zhZv
         sTOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GLnZLZnFrYgrRLtl0OQRxaMDUVx3fh8Zfv1w7shqteg=;
        b=MMPBPlfX9GAcmKqi42255naE7F2dJl3ABJ9jUuonIzDBXxmhNj89PADuerv15teWtS
         Qm7Qhp7veV3Kl+wrJNCyCzVMpnJFMrtAR6f3Z77GRyadoVJ7Xrilm5yS5aivj1r1h7YB
         +VHHuNOenWN2IjgEqWiH5WExmHdtxEaX89KTPA38n7jazPsqtie0RC05B5c8YXAQZjb+
         6cZtVlAzfxo58b1/9UMfiRS2ZJoSE06N3pCsDrSOnJiPxrkjNoWXl4OkccoGkY8kyLb0
         kYzzikh9MMssmF8LFwa2uTK7yx5HQWdu8XxwKIVQLMAzjkiptUDosyFbEEwmAhL+LbLw
         S/Nw==
X-Gm-Message-State: AOAM533cgvYXXam2Daj4HxnPVPV/icHJ3YcxE9YvBNYmZyVBM66Qp2Pc
        Vr4+7MFJTNYTbmkOLjI6ks4=
X-Google-Smtp-Source: ABdhPJzgrPW51PyMHS8DJ2/+UMF+jhWTiRgHqCPB9dJZnCBVu0SLhAgIQD/gP5IbxVcYoMRl45Qqog==
X-Received: by 2002:a05:6830:18ed:: with SMTP id d13mr18414188otf.196.1595200310382;
        Sun, 19 Jul 2020 16:11:50 -0700 (PDT)
Received: from frodo.hsd1.co.comcast.net ([2601:284:8204:6ba0::5e16])
        by smtp.googlemail.com with ESMTPSA id q19sm2394680ooi.14.2020.07.19.16.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2020 16:11:49 -0700 (PDT)
From:   Jim Cromie <jim.cromie@gmail.com>
To:     jbaron@akamai.com, linux-kernel@vger.kernel.org,
        akpm@linuxfoundation.org, gregkh@linuxfoundation.org
Cc:     linux@rasmusvillemoes.dk, Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v5 18/18] dyndbg: export ddebug_exec_queries
Date:   Sun, 19 Jul 2020 17:10:58 -0600
Message-Id: <20200719231058.1586423-19-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200719231058.1586423-1-jim.cromie@gmail.com>
References: <20200719231058.1586423-1-jim.cromie@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export ddebug_exec_queries() for use by modules.

This will allow module authors to control all their *pr_debug*s
dynamically.  And since ddebug_exec_queries() is what implements
"echo $query >control", it gives the same per-callsite control.

Virtues of this:
- simplicity. just an export.
- full control over any/all subsets of callsites.
- same "query/command-string" in code and console
- full callsite selectivity with module file line format

Format in particular deserves special attention; it is where
low-hanging fruit will be found.

Consider: drivers/gpu/drm/amd/display/include/logger_types.h:

  #define DC_LOG_SURFACE(...)          pr_debug("[SURFACE]:"__VA_ARGS__)
  #define DC_LOG_HW_LINK_TRAINING(...) pr_debug("[HW_LINK_TRAINING]:"__VA_ARGS__)
  .. 9 more ..

Thats 11 string prefixes, used in 804 places in drivers/gpu/**
Clearly this is a systematized classification of those callsites.
And one I'd expect to see repeated often.

Using ddebug_exec_queries(), authors can select on those prefixes
as a unitary set, equivalent to:

    echo "module=MODULE_NAME format=^[SURFACE]: +p" >control

Trivially, those sets can be subsected with the other query terms too,
say file=foo, should the author see fit.

Perhaps as important, users can modify the set of enabled callsites,
presumably to aid debugging by enabling helpful debug callsites, and
disabling those that just clutter the info.

Authors could even alter [fmlt] flags, though I dont see a good reason
why they would.  Perhaps harnessed by bug-logging automation to get
fuller, or more minimal bug-reports.

DRM

drm has both drm.debug, which defines 32 categories of drm_printk
logging, and entirely separate uses of pr_debug, which are dynamic on
this i915 laptop, running mainline.  So I can observe and report on
both.

The i915 driver has 118 dyndbg callsites, with following
"classifications" defined in drivers/gpu/drm/i915/gvt/**

$ grep 915 /proc/dynamic_debug/control | cut -d= -f2 | cut -d: -f1,2 | sort -u
_ "gvt: cmd
_ "gvt: core
_ "gvt: dpy
_ "gvt: el
_ "gvt: irq
_ "gvt: mm
_ "gvt: mmio
_ "gvt: render
_ "gvt: sched
_ "%s for root hub!\012"
_ "Vendor defined info completion code %u\012"

This classification is entirely out-of-band for control by drm.debug,
and is only available to root user at the console.  But module authors
can activate them with ddebug_exec_queries(sprintf("format=^%s +p")),
and then decide how to expose the groups to the user for max utility.

drm.debug

drm.debug has 32 bit-flags, and matching enum drm_debug_category
values to classify the ~2943 DRM_DEBUG*() callsites in drivers/gpu

The drm.debug callback could invoke ddebug_exec_queries() with 32
different hardcoded query strings, needing only (bit) ? " +p" : " -p"
added.

I briefly enabled drm.debug=0xff on my i915 laptop, which yielded
these unique prefixes: (dmesg | cut -c17- | cut -d\] -f1 | sort -u)

[drm:drm_atomic_check_only [drm
[drm:drm_atomic_get_crtc_state [drm
[drm:drm_atomic_get_plane_state [drm
[drm:drm_atomic_nonblocking_commit [drm
[drm:drm_atomic_set_fb_for_plane [drm
[drm:drm_atomic_state_default_clear [drm
[drm:__drm_atomic_state_free [drm
[drm:drm_atomic_state_init [drm
[drm:drm_crtc_vblank_helper_get_vblank_timestamp_internal [drm
[drm:drm_handle_vblank [drm
[drm:drm_ioctl [drm
[drm:drm_mode_addfb2 [drm
[drm:drm_mode_object_get [drm
[drm:drm_mode_object_put.part.0 [drm
[drm:drm_update_vblank_count [drm
[drm:drm_vblank_enable [drm
[drm:drm_vblank_restore [drm
[drm:vblank_disable_fn [drm
i915 0000:00:02.0: [drm:gen9_set_dc_state [i915
i915 0000:00:02.0: [drm:intel_atomic_get_global_obj_state [i915
i915 0000:00:02.0: [drm:__intel_display_power_get_domain.part.0 [i915
i915 0000:00:02.0: [drm:__intel_display_power_put_domain [i915
i915 0000:00:02.0: [drm:intel_plane_atomic_calc_changes [i915
i915 0000:00:02.0: [drm:skl_enable_dc6 [i915

Several good format=^prefixes are apparent there, and some misses.

 ^[drm:drm_atomic_	# misses: [drm:__drm_atomic_state_free [drm
 ^[drm:drm_ioctl
 ^[drm:drm_mode
 ^[drm:drm_vblank_	# misses: [drm:drm_update_vblank_count & [drm:vblank_disable_fn

Its not a perfect 1:1 single format-match per class, but the misses
above can be covered with 1 & 2 additional queries, which can be
concatenated together with ";" separators and submitted with 1 call.

Benefits:

For drm, adapting DRM_DEBUG to use dynamic-debug inside could
replicate (and thereby obsolete) lots of bit-checking in current
DRM_DEBUG callsites, at least with JUMP_LABEL optimized code.
ddebug_exec_queries() and a handful of fixed query-strings can select
and thereby control the already classified callsites.

With the classes mapped to queries, the enum type and parameter can be
eliminated (folded away with macro magic), at least for DYNAMIC_DEBUG
& JUMP_LABEL builds.

Is it safe ?

ddebug_exec_queries() is currently exposed to user space in
several limited ways;

1 it is called from module-load callback, where it implements the
  $modname.dyndbg=+p "fake" parameter provided to all modules.

2 it handles query input via >control directly

IOW, it is "fully" exposed to local root user; exposing the same
functionality to other kernel modules is no additional risk.

The other standard issue to check is locking:

dyndbg has a single mutex, taken by ddebug_change to handle >control,
and by ddebug_proc_(start|stop) to span `cat control`.  Queries
submitted via export will typically have module specified, which
dramatically cuts the scan by ddebug_change vs "module=* +p".
ISTM this proposed export presents no locking problems.

TLDR;

It would be interesting to see how drm.dyndbg=$QUERY and
drm.debug=$HEXY would interact; it might be order dependent, as
if given as modprobe args or in /etc/modprobe.d/

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index e87b630bd793..1d012e597cc3 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -525,7 +525,7 @@ static int ddebug_exec_query(char *query_string, const char *modname)
    last error or number of matching callsites.  Module name is either
    in param (for boot arg) or perhaps in query string.
 */
-static int ddebug_exec_queries(char *query, const char *modname)
+int ddebug_exec_queries(char *query, const char *modname)
 {
 	char *split;
 	int i, errs = 0, exitcode = 0, rc, nfound = 0;
@@ -557,6 +557,7 @@ static int ddebug_exec_queries(char *query, const char *modname)
 		return exitcode;
 	return nfound;
 }
+EXPORT_SYMBOL_GPL(ddebug_exec_queries);
 
 #define PREFIX_SIZE 64
 
-- 
2.26.2

