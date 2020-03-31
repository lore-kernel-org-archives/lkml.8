Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD4CC43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 07:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ABA7206F6
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 07:56:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585641377;
	bh=wfk9kSVrabM7d0Ey9B7NX7Fl2JbiQQXZ6XvE9cysx/E=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=EzRUuCTU4vBbmHvbFDFUHuwW1KWkLbFU0IRykjy1nBinxRcbHLKJvP84fiHvhS8BL
	 LPTTYQCCVxGuc7oG+lSrGMcfCs0nh5S93wc72h57mizK9Zx2tHMKvrP7I3UMMuXySW
	 PMcX863RGWu2xOmKjyvXbI1wLywta1DiFALjSd8U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730218AbgCaH4Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 03:56:16 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55868 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730012AbgCaH4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 03:56:16 -0400
Received: by mail-wm1-f67.google.com with SMTP id r16so1368502wmg.5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 00:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=BMUV/Hj0+3itoIbuWpbc8ypyJxaIukLES3hau8z2Dt4=;
        b=EaRepmSfeNXXk/gcdulzVoKebyVlprb0XPhhBJpt4NYbQ1ck9FdBI7jmx8q4UnJQUX
         h5//eSDKwIdbwFwIoDoYdCvDaL++b5kAqPkBJKnHzuo21mgwlJ66YdpmuTv/xtHIFXag
         DbcCGEUATsbWjqVYldAP/NUN6iAsRx2KNzDhWOjrKI5SJtgeK/gIx2NHkhTGvY+RoT6z
         Ewi+6PmIvabUfCuSOmMHpx8iNmNIJaS9ADq0pCUPB0oG3cErdLkkJU3P61IqhIiR4lxN
         FoaVKjR81lww4qmCY4T/4ocYG6cBj27r28E2xYFDno6VdsVBdLtOth6G23so6MHUThhE
         BL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=BMUV/Hj0+3itoIbuWpbc8ypyJxaIukLES3hau8z2Dt4=;
        b=Y8p0Nf/F/5VTctJijTpMV88IIdtGfHyhzBvvDfA7sUODN0ugevqDaK0kWZ4z/BpoF6
         mXNNpGFgG9/SgbEVNDohEUocK8fD2egav7mKJwzPMrDGpOH2m/q/Pmm/DKHR9z+Rsu95
         iV+d0eZSjUqbhAYu9jPU3fnc8YIdroOe6pMqToPSSV+5Ea9PCRGkRWoD9sJxt3Z7T8Uo
         FQlWEMM3iwdHw2pWrw4ArYBcjiEVIWribKFXMe5f4NYrmMaFhK+Lo5eTTnR2v9I1+mE/
         b1zEMnKDgYXs1jjcjVEdUgtTGc7YzYTwK3KhuuMdh1VMA7C0bZqtJHhFZLas3Rn+OxFy
         dw8A==
X-Gm-Message-State: ANhLgQ3CrjTxRzElURuYgOTI+uXU9/OLEf7bQuSrpuo3INYkt2BNbQCa
        jgMbv69Pc+z9L85KZxUf6JkvCTxT
X-Google-Smtp-Source: ADFU+vtHeHDjLNqrR2pFNSgHBuURQEq5elddWS9MqWZeWo2k0DdlV7nVIpvi3/7EPW6vN3WzoRMvjQ==
X-Received: by 2002:a1c:96d1:: with SMTP id y200mr2240267wmd.114.1585641374030;
        Tue, 31 Mar 2020 00:56:14 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id t12sm27794500wrm.0.2020.03.31.00.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 00:56:13 -0700 (PDT)
Date:   Tue, 31 Mar 2020 09:56:11 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/build changes for v5.7
Message-ID: <20200331075611.GA129965@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-build-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-build-for-linus

   # HEAD: 4caffe6a28d3157c11cae923a40456a053c520ea x86/vdso: Discard .note.gnu.property sections in vDSO

A handful of updates: two linker script cleanups and a stock 
defconfig+allmodconfig bootability fix.

  out-of-topic modifications in x86-build-for-linus:
  ----------------------------------------------------
  include/asm-generic/vmlinux.lds.h  # 84d5f77fc2ee: x86, vmlinux.lds: Add RUNTIM

 Thanks,

	Ingo

------------------>
Anders Roxell (1):
      x86/Kconfig: Make CMDLINE_OVERRIDE depend on non-empty CMDLINE

H.J. Lu (2):
      x86, vmlinux.lds: Add RUNTIME_DISCARD_EXIT to generic DISCARDS
      x86/vdso: Discard .note.gnu.property sections in vDSO


 arch/x86/Kconfig                      |  2 +-
 arch/x86/entry/vdso/vdso-layout.lds.S |  7 +++++++
 arch/x86/kernel/vmlinux.lds.S         |  1 +
 include/asm-generic/vmlinux.lds.h     | 11 +++++++++--
 4 files changed, 18 insertions(+), 3 deletions(-)

