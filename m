Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2776C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 10:52:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEBD820663
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 10:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s6Br/iSu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgG2KwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 06:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726800AbgG2KwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 06:52:17 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 055F4C0619D2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 03:52:17 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id x10so10365273ybj.19
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jul 2020 03:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=vSliGyBZQKvlS0+61F1LBEoXAn3W7oNlUuyzH64gKZ4=;
        b=s6Br/iSuLIwOpryZlHRvpGvDbfddkW4PyoYgVr62dENEn+ac9CFU44qiia+IbgSEVW
         Nnl2wQRXJsTqxLwAfcFWiLOu/yWLP+ryfzxB/x6ztWI2jsOZ2w70YbEfNh/6A6d4PhZ/
         iMa2jkRQI8v9AfXr4C4y+07e1kKSuqHiyyRipNRzRNbeFAHK125rhYPIgBjRIyHWksfL
         /3T7oqq34vijYmj83jeDTWOhwBWPvdFdrUsUvLosJNgnfy84Sh0fLDpjnMAZowz70BGS
         fNni7Bnbk4PhkrdtAGdDO3uEUcN5KkA1icjYpeJh4rtHh86E6BobzTJydAOJUiwR86wo
         WMIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=vSliGyBZQKvlS0+61F1LBEoXAn3W7oNlUuyzH64gKZ4=;
        b=BChOk+9++Od3AfZc+H1CJb8lExxFjxsg/FrnFym95jO7ZHB+R2J9Tif+DOuX6M40Vq
         ljwIMTNEu9wwujG4k35RVgdco5xge7r51mAu2BpkeLtYAvrItTQzdVgN3jsZJQsExYX+
         3YMmetJPEw25jSOfEYHXaEPIxP5AhGJHS0tr6keES4ZUP4piKKyERElmLwTQa+vp0qxd
         4mddtdlC9Zh+Z/889imP9mDcJLqSp/VmavOfmoHCS0WExGVLzlUhm07GV4+Sudzq78/r
         qfGP05pbqfmlAJA7+qFhhTWEpa6yx/t4IE4aAj2PsWEgI3TbO2Y2F7irOJLwxWRUnpzL
         utbA==
X-Gm-Message-State: AOAM531w8WVGKHe22cLhNkv0A/91+bFA3qsKHshiAnHCuNGqrZbvlbyT
        17j2JhM1V5dUl0pmXoskVYVB+q4nbEMjbF7hyXABYixUGj4SImKotVEESaMthY4YJklxPBYLZbn
        UiOSE2P4mH7C3+WM98pR7DtgJeHL845uHeVpa0MF+Pam6QJtwb8WImnh26VITyNfNEoaM0LJSE2
        HhVkTG
X-Google-Smtp-Source: ABdhPJzk4f0duQ0J4jmHCNnomr0GLgR7krVV4GTA4+LU/ZyuMeFIRYgUpNVsZX0U8Ck588k2y4lL6X82dJhicAgI
X-Received: by 2002:a25:4945:: with SMTP id w66mr50685406yba.285.1596019935958;
 Wed, 29 Jul 2020 03:52:15 -0700 (PDT)
Date:   Wed, 29 Jul 2020 20:52:03 +1000
Message-Id: <20200729105206.2991064-1-victording@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH 0/3] powercap: Enable RAPL for AMD Fam17h
From:   Victor Ding <victording@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Victor Ding <victording@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jan Beulich <jbeulich@suse.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Vineela Tummalapalli <vineela.tummalapalli@intel.com>,
        linux-pm@vger.kernel.org, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds support for AMD Fam17h RAPL counters. As per
AMD PPR, Fam17h support RAPL counters to monitor power usage. The RAPL
counter operates as with Intel RAPL. Therefore, it is beneficial to
re-use existing framework for Intel, especially to allow existing tools
to seamlessly run on AMD.

From the user's point view, this series enables the following two sysfs
entry on AMD Fam17h:
  /sys/class/powercap/intel-rapl/intel-rapl:0/energy_uj
  /sys/class/powercap/intel-rapl/intel-rapl:0/intel-rapl:0:0/energy_uj


Victor Ding (3):
  x86/msr-index: sort AMD RAPL MSRs by address
  powercap/intel_rapl_msr: Convert rapl_msr_priv into pointer
  powercap: Add AMD Fam17h RAPL support

 arch/x86/include/asm/msr-index.h     |  3 +-
 drivers/powercap/intel_rapl_common.c |  2 +
 drivers/powercap/intel_rapl_msr.c    | 58 +++++++++++++++++++++-------
 3 files changed, 47 insertions(+), 16 deletions(-)

-- 
2.28.0.rc0.142.g3c755180ce-goog

