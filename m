Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC3FC35246
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 07:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F5F2467B
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 07:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580194814;
	bh=7J/IqhLvpFCp0WuLvGUQtp2B9kV0Z2Qn17j/cc8KUdw=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Dvzrl0j31wWwfq6Bs78JoLyGatuk3FMEAu9mut4L5bv5E2FgW4iBB3WfrEC2OaYhB
	 4zRINiQehDxvtIzUDZ8gJmx0dN31ZxyPg3qeVezxJuOVW804xkFzO9HjPWeBsONgUV
	 4QhvzYdlI3DvhTFqvzdzM/nP/ruMdOZaW3Jfr+xg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725927AbgA1G66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 01:58:58 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36810 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbgA1G65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 01:58:57 -0500
Received: by mail-wm1-f66.google.com with SMTP id p17so1272528wma.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jan 2020 22:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=zeoNiP/MAHm1Rz5XV/EHtvjjwHfOqzXxOt0twtHj+4E=;
        b=HBQMMX5MM3RuZnZ4VkxzOBHmFtCfLJYJ606waSKp0unwsBpsLmXNhnPv9EFmFWuHqf
         OV81DgDrOB4Ak7O0UqkgBPJmok0jWAFyLfvKVeQFJwtaFCxxtgdLojjQb2Nft+dEXzVZ
         5ihH/lIPOeP0EQdXLUVIwHNgSlu5CHCNPJlVM8uTVNKT+EpGtbTWDtNuqbr1vfJir58t
         Oct/cm+JMaYShCxzxirry3TLi4od81byJ2nwm/HbWNoNMTTPKMD31kz4gic9llZELOZl
         lYfnZhRF9d47U9Z+XsC3RfkuhCBoJ8jGhtavbq57vwWHVjU1CYrxCU5AM09qqxDt5TSs
         Xxfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=zeoNiP/MAHm1Rz5XV/EHtvjjwHfOqzXxOt0twtHj+4E=;
        b=BzwrasOZJUOWepsG0hr7VlXTHq0wilk2zVAl5kFh7CICyidze1JyBEJ+TFp6yYAU3T
         GVPNPGbMv/hPmrkVzXksBzlop66vkS88hwxTsyI1cnZPr/I0kl3fJGyEA0DREdj5rPAb
         PZHaZJnqqTG1+nF0XrKH87p08TSuub9no2aNqIT4YJKBS1/Odd+2XdXYBLyYR0G5f6uD
         HphURV6X9xDlM7CFMiUBnxlPotKO5neUsCg8QcSgMJ6SqapUgfHpcvptGABxuWQRRSsj
         OJmtsNF5bxmshWG9NfigMa+KmZPFG5Wv/DQ/5JJvaJXUgc89PNuhHMUIXdpi0ympzRap
         iOrg==
X-Gm-Message-State: APjAAAWjr4F6L95pJj1EQYaWdiJsNBd4AhJLpjTBb1g41SrgOTZU72RC
        nrQVlig/CqcEvWGS09OH1rs=
X-Google-Smtp-Source: APXvYqwp/Pz0LEGfED+7KWtMKAYDSOns2cCisnuy/Me6Ld0EqpEvSxAx8rJGMAyrKdu4aqjXDdWjwg==
X-Received: by 2002:a05:600c:2507:: with SMTP id d7mr3145721wma.28.1580194735506;
        Mon, 27 Jan 2020 22:58:55 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id k8sm23462105wrl.3.2020.01.27.22.58.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 22:58:54 -0800 (PST)
Date:   Tue, 28 Jan 2020 07:58:52 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] core/headers: Clean up x86 header interactions
Message-ID: <20200128065852.GA18416@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest core-headers-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git core-headers-for-linus

   # HEAD: 960786422fe90a86e81131f5dbd902cb5ebf8760 x86/ACPI/sleep: Move acpi_get_wakeup_address() into sleep.c, remove <asm/realmode.h> from <asm/acpi.h>

This is a treewide cleanup, mostly (but not exclusively) with x86 impact, 
which breaks implicit dependencies on the asm/realtime.h header and 
finally removes it from asm/acpi.h.


 Thanks,

	Ingo

------------------>
Ingo Molnar (3):
      x86/setup: Clean up the header portion of setup.c
      x86/setup: Enhance the comments
      x86/platform/intel/quark: Explicitly include linux/io.h for virt_to_phys()

Sean Christopherson (12):
      x86/efi: Explicitly include realmode.h to handle RM trampoline quirk
      x86/boot: Explicitly include realmode.h to handle RM reservations
      x86/ftrace: Explicitly include vmalloc.h for set_vm_flush_reset_perms()
      x86/kprobes: Explicitly include vmalloc.h for set_vm_flush_reset_perms()
      perf/x86/intel: Explicitly include asm/io.h to use virt_to_phys()
      efi/capsule-loader: Explicitly include linux/io.h for page_to_phys()
      virt: vbox: Explicitly include linux/io.h to pick up various defs
      vmw_balloon: Explicitly include linux/io.h for virt_to_phys()
      ASoC: Intel: Skylake: Explicitly include linux/io.h for virt_to_phys()
      x86/ACPI/sleep: Remove an unnecessary include of asm/realmode.h
      ACPI/sleep: Convert acpi_wakeup_address into a function
      x86/ACPI/sleep: Move acpi_get_wakeup_address() into sleep.c, remove <asm/realmode.h> from <asm/acpi.h>


 arch/ia64/include/asm/acpi.h                 |   5 +-
 arch/ia64/kernel/acpi.c                      |   2 -
 arch/x86/events/intel/ds.c                   |   1 +
 arch/x86/include/asm/acpi.h                  |   3 +-
 arch/x86/kernel/acpi/sleep.c                 |  11 ++
 arch/x86/kernel/acpi/sleep.h                 |   2 +-
 arch/x86/kernel/ftrace.c                     |   1 +
 arch/x86/kernel/kprobes/core.c               |   1 +
 arch/x86/kernel/setup.c                      | 164 ++++++++-------------------
 arch/x86/platform/efi/quirks.c               |   1 +
 arch/x86/platform/intel-quark/imr.c          |   2 +
 arch/x86/platform/intel-quark/imr_selftest.c |   2 +
 drivers/acpi/sleep.c                         |   3 +
 drivers/firmware/efi/capsule-loader.c        |   1 +
 drivers/misc/vmw_balloon.c                   |   1 +
 drivers/virt/vboxguest/vboxguest_core.c      |   1 +
 drivers/virt/vboxguest/vboxguest_utils.c     |   1 +
 sound/soc/intel/skylake/skl-sst-cldma.c      |   1 +
 18 files changed, 81 insertions(+), 122 deletions(-)
