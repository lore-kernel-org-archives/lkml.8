Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F60C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E988206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 16:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591028588;
	bh=sYsHGCZGXO1Q3BckbVF76yQIJfyp90b+T56aNJ1NsbQ=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=rO5Eb+0QeKYIve9Yvk12d/7LETZ79RwwI/yUfpAl7//tSww/Db5woktosK+GkTsBD
	 kjTG+agJ5OhYmocPEIlqKDRDBb07YOeriqHh9dCeMo1YLZnPHABjxZ91YULGbfMYwe
	 bqijBFYodC7atm06E3Ig+nvl7LUzwBys68j6isZA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgFAQXH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 12:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgFAQXH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 12:23:07 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94492C05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 09:23:06 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id c3so394966wru.12
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 09:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=MKmHiaFINZPLg82Dw2TKjTnxk0X6EWpuOFGm/aRIn0o=;
        b=EbG/9POs7lhCLbPyJmRqU4I/RRHW3gzPM/OUcWyXaGw2hGeDfCqqlvuSKD1Qlkc7+N
         HbUs6wydQTnqKyeTxjpBP4LMjXQ6zFX/CxuYYMz9njyD4pXoLM4o0urg2UXsY1dvIIP/
         BvmeQTRy+6EILm5pDZul0+1y0fhLxHO9uJzpXw3LypLvafzohIc8xmtT/BeqKfU0OVR5
         rWR2HtcKtrMRzSYgaoSbtFg+n8ShNs2qq1i3DBCrPN1kUWxjDIu6KwJXhNEzgufrSxxq
         P4YWo/+NNci+5ExqgZTuCGKkRMPQ/4g+a1rrTSUfkce0V5kOGswN04kGUgqYbxJLv3so
         pKKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=MKmHiaFINZPLg82Dw2TKjTnxk0X6EWpuOFGm/aRIn0o=;
        b=QOmGyopcgASDDflzzrMz9GDUuW3xkRk2wM2o9u26fwxDP3lj7CXAHeq7r0AaU1CN8z
         hRD08s3IQvc+rI89K6M+b+Opcf3M5d0Tq9McJ3wwIxRv967Zb3YeJ8bexcmWRPfqXe6+
         sGj1Omol/aU6J470HL8NHJw3t7LrJcshGEu7yt1Uhsfv2nN2kbl6WjEeKyJOlGafPeSY
         UBm6ss9rpjPk9B8B4oqUVqmF8qArxS13uDz5dPNPnMcTNX13ZPqlslic4cWAXEVhAmMM
         1MAwmZM/bXcEG70pQmvH6qgV5R3Mw67IMPcAMxJ6Un9WXALcXKf89xypJmadFWpcFsG4
         wWEg==
X-Gm-Message-State: AOAM530MBb4a8fP3V0QWHIeurktEMsp9Zp1/RdjmJ1dMjvvSGcEl4suH
        nfXJMpZU48ahNOIJhicOizx0jHLo
X-Google-Smtp-Source: ABdhPJwPV/acAlvoKP2GOH7XTNxXZs8YRFcEy+TVgLe2ixraNlhBGc2jXlExFKQ7ieeA09ygg3Gvkg==
X-Received: by 2002:adf:b348:: with SMTP id k8mr24796518wrd.157.1591028585285;
        Mon, 01 Jun 2020 09:23:05 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id s8sm19032807wrm.96.2020.06.01.09.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 09:23:04 -0700 (PDT)
Date:   Mon, 1 Jun 2020 18:23:02 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/boot updates for v5.8
Message-ID: <20200601162302.GA1138465@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/boot git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-boot-2020-06-01

   # HEAD: 5214028dd89e49ba27007c3ee475279e584261f0 x86/boot: Correct relocation destination on old linkers

Misc updates:

 - Add the initrdmem= boot option to specify an initrd embedded in RAM (flash most likely)
 - Sanitize the CS value earlier during boot, which also fixes SEV-ES.
 - Various fixes and smaller cleanups.

  out-of-topic modifications in x86/boot:
  -----------------------------------------
  include/linux/tboot.h              # 767dea211cd0: x86/tboot: Mark tboot static
  init/do_mounts_initrd.c            # 694cfd87b0c8: x86/setup: Add an initrdmem=

 Thanks,

	Ingo

------------------>
Arvind Sankar (1):
      x86/boot: Correct relocation destination on old linkers

Christoph Hellwig (1):
      x86/tboot: Mark tboot static

Joerg Roedel (1):
      x86/boot/compressed/64: Switch to __KERNEL_CS after GDT is loaded

Ronald G. Minnich (1):
      x86/setup: Add an initrdmem= option to specify initrd physical address

Vamshi K Sthambamkadi (2):
      x86/boot: Add kstrtoul() from lib/
      x86/boot: Fix -Wint-to-pointer-cast build warning


 Documentation/admin-guide/kernel-parameters.txt |  7 ++++
 arch/x86/boot/compressed/acpi.c                 |  7 ++--
 arch/x86/boot/compressed/head_32.S              |  5 +--
 arch/x86/boot/compressed/head_64.S              |  9 ++++++
 arch/x86/boot/string.c                          | 43 ++++++++++++++++++++++++-
 arch/x86/boot/string.h                          |  1 +
 arch/x86/kernel/setup.c                         |  6 ++++
 arch/x86/kernel/tboot.c                         |  8 +++--
 include/linux/tboot.h                           |  8 +----
 init/do_mounts_initrd.c                         | 13 +++++++-
 10 files changed, 90 insertions(+), 17 deletions(-)

