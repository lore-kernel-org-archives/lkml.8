Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D521BC433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:12:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD62721883
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 14:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595859134;
	bh=29cjQnjSC+wuvHtG+20VVuSfXqeNY9zwFB/jMOukLSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rmcw34LhWj9bVf0DPf09heL0usTcIvlnAUjsSDQKSABC+XFZwdv56MpJg6NWTvX3l
	 GRknQcMAOcXlclMLDj/M0GBsxrqJoqZ0mjZbN1VcbUi+fm4OHbwX5yGDOTY8nlySpq
	 mkgjwYEg130yeEx3iHX40ReolYHCVKVA9XtbKRXc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbgG0OMN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:12:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730138AbgG0OMK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 10:12:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB38121775;
        Mon, 27 Jul 2020 14:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595859130;
        bh=29cjQnjSC+wuvHtG+20VVuSfXqeNY9zwFB/jMOukLSE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uGzB/uurOdrp52J/izWLlqdoh9PYXKjgSXoD/lEmq4IHbt+ihIzwRQ4hRhpTzVzBK
         bVa8hV5h3wYM05EYpvOwFgDlDdQ7vjllJ/dq9ahreOy1ns6ZV5B2aSBtOWWgsYjg7s
         peuHZJyKxZB6Dsoy8XnZ9QuMDkhApnjApBKQRNwY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.19 77/86] io-mapping: indicate mapping failure
Date:   Mon, 27 Jul 2020 16:04:51 +0200
Message-Id: <20200727134918.255432367@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200727134914.312934924@linuxfoundation.org>
References: <20200727134914.312934924@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael J. Ruhl <michael.j.ruhl@intel.com>

commit e0b3e0b1a04367fc15c07f44e78361545b55357c upstream.

The !ATOMIC_IOMAP version of io_maping_init_wc will always return
success, even when the ioremap fails.

Since the ATOMIC_IOMAP version returns NULL when the init fails, and
callers check for a NULL return on error this is unexpected.

During a device probe, where the ioremap failed, a crash can look like
this:

    BUG: unable to handle page fault for address: 0000000000210000
     #PF: supervisor write access in kernel mode
     #PF: error_code(0x0002) - not-present page
     Oops: 0002 [#1] PREEMPT SMP
     CPU: 0 PID: 177 Comm:
     RIP: 0010:fill_page_dma [i915]
       gen8_ppgtt_create [i915]
       i915_ppgtt_create [i915]
       intel_gt_init [i915]
       i915_gem_init [i915]
       i915_driver_probe [i915]
       pci_device_probe
       really_probe
       driver_probe_device

The remap failure occurred much earlier in the probe.  If it had been
propagated, the driver would have exited with an error.

Return NULL on ioremap failure.

[akpm@linux-foundation.org: detect ioremap_wc() errors earlier]

Fixes: cafaf14a5d8f ("io-mapping: Always create a struct to hold metadata about the io-mapping")
Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: <stable@vger.kernel.org>
Link: http://lkml.kernel.org/r/20200721171936.81563-1-michael.j.ruhl@intel.com
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/io-mapping.h |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/include/linux/io-mapping.h
+++ b/include/linux/io-mapping.h
@@ -120,9 +120,12 @@ io_mapping_init_wc(struct io_mapping *io
 		   resource_size_t base,
 		   unsigned long size)
 {
+	iomap->iomem = ioremap_wc(base, size);
+	if (!iomap->iomem)
+		return NULL;
+
 	iomap->base = base;
 	iomap->size = size;
-	iomap->iomem = ioremap_wc(base, size);
 #if defined(pgprot_noncached_wc) /* archs can't agree on a name ... */
 	iomap->prot = pgprot_noncached_wc(PAGE_KERNEL);
 #elif defined(pgprot_writecombine)


