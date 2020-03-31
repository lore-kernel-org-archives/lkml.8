Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5BA0C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 10:03:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A433E20658
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 10:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585649039;
	bh=7F+5e0uIUrP9gif9JBbsKudFuxlnCWBdawj4CpaS5hU=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=Pjng9p2AK+IHw6l/mtaVTpIQAIYLLqJA+yHovXXft6x55iuVo27yPtrhIme3cNO77
	 cvqw/yajK1PYQNvuoPfS94VzO1sygr4IEDq/4pbFbrO+NTeTyxxnGlCoVoiq0Rxvo2
	 nWwqLWvXHv6kRjnShVMY9UUVXKlBcUJ22FmsDizU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730342AbgCaKD6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 06:03:58 -0400
Received: from mail-wm1-f51.google.com ([209.85.128.51]:36449 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730153AbgCaKD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 06:03:58 -0400
Received: by mail-wm1-f51.google.com with SMTP id g62so1896189wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 03:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=FgHDUvICQzRsu5J2IxUyl5QfRMigRWMaWEUITezGk2Q=;
        b=Uinvyji3GJbF1sPHoDxAOKE7d+NtZvRPQpymdzJKkJ22pKOtawHhOoI3xofLbiB2a2
         9ohDa+7eWnJLzoVarkYxa812wVHJr5ajdwHK3tim7AfI0Vs9C7fjgYEohp2tFZXINVMM
         M6JHniaYhgd9X28G8GcXVhJhQbf73pv3MJ3ELRhZw/AprKcsZuthpBlQhIQfVfhCMjCj
         hmyazB/UPUnTBwezXe1P9A4DK3Wvhy+GGiwim9qKdGbbSt+jUPzhUpN45/IYuElKdVJ5
         siVsOlScdoSABQjPnrn5kmmQtanTuedec4Tbtzsnnw7f7JfocVoAVqKo98hwD9TDLDSJ
         fdPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=FgHDUvICQzRsu5J2IxUyl5QfRMigRWMaWEUITezGk2Q=;
        b=h6AU0226/hb2oraBZiSIgO/g4ZDbOBVHqFUnGLGTdddSeD4CAblbpLjH2PBWMyAURV
         DKGDCPxLl25D1ZydGkf2hJH2LOouqOTLF1kVc5SX/2WIrcZnIxVCP7xMEH0vA3E9IS7e
         qy3l8s6YxDge/xckSAQtvaulCGtLgf76a94yiSnrW0mQ4Mm/13EjnRWpTUpDo915njhr
         0bR0xsEl97Z1Dh3659Zt2AsorLgIZzZIsAZ8kiF7VMsWP5vPniX6KHYAGdQy6Z/QqpN4
         oXmTMBtKTGG2b5+wjRT/ut+b0HYLXEu2raPvSQV/1cj6vD76aL1qpDJ/d5AsCgndIwwX
         AaGg==
X-Gm-Message-State: ANhLgQ32Sb7vYzVBmPzp5JzgIBekSXNiC6ldxNd2WTKOk2sr6TksebxD
        2xMSXRVjh1p4tpUXqEObhO8=
X-Google-Smtp-Source: ADFU+vvPJk4oau3EJw76PYg8m81JniOJSi2Vwezvg1+8clyKgKFP6Gw1TbgwCTD9qd5WY+ZCSaqbAw==
X-Received: by 2002:a7b:ce8b:: with SMTP id q11mr1495155wmj.91.1585649035874;
        Tue, 31 Mar 2020 03:03:55 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id x11sm19939461wru.62.2020.03.31.03.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 03:03:55 -0700 (PDT)
Date:   Tue, 31 Mar 2020 12:03:53 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/vmware changes for v5.7
Message-ID: <20200331100353.GA37509@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-vmware-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-vmware-for-linus

   # HEAD: 8fefe9dacdb0a1347d3dac871bb1bba3cbc32945 x86/vmware: Use bool type for vmw_sched_clock

The main change in this tree is the addition of "steal time clock 
support" for VMware guests.

 Thanks,

	Ingo

------------------>
Alexey Makhalov (5):
      x86/vmware: Make vmware_select_hypercall() __init
      x86/vmware: Remove vmware_sched_clock_setup()
      x86/vmware: Add steal time clock support for VMware guests
      x86/vmware: Enable steal time accounting
      x86/vmware: Use bool type for vmw_sched_clock


 Documentation/admin-guide/kernel-parameters.txt |   2 +-
 arch/x86/kernel/cpu/vmware.c                    | 229 +++++++++++++++++++++++-
 2 files changed, 222 insertions(+), 9 deletions(-)
