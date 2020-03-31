Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3045C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79A0A20787
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 08:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585643882;
	bh=Ym4sEKBsm7WVAHA44Y6xNGEN/flh9Z/LgJ6Vr0eL9Q8=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=P30bIjAcUL2PvV+akjCQBKe4p3qRsyDL43MUOqNywIjUXhZeU0oQ6vVr39m4Fmxhu
	 xDKhSUmooeqF2OcI+7YaKEfkQ7soqDWEtW9y1bkBzJ4/All1yjdSKuh+9nL/CuC9Up
	 i73VxCn3FTf+w1ZKvtjMBn0gsWTHwmZ6aDdeiQbs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730266AbgCaIiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 04:38:01 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33166 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730180AbgCaIh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 04:37:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id a25so24851068wrd.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 01:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=u+l9cJDXtAcVTGo/WCJEmLohq3OICTOB58fN6/+YtsU=;
        b=GsHFJ3m4NEEtHszFz9Lv939yIEBBHtXyPTbLXSnZXUDeJ1dZeUc1OgtvrL5VR0IYVl
         Gc9yJmnZKKHV3D8xujdm7d40z+eTXU8Qh0KC9wudkISrVxg4MLh0OUuSBUvoAIQJlxOq
         3anX4aSdxkgYQYv8xojxWsDr68B+Sg1w/YaKMEis4yZ2DaaAqarpCmqODrCxlyTG8p1c
         KFrh5G176vqd5OrqxL9PflrBDSpEhD4q+b6ZyLn0CAnTGW1EHV9DKfBNlks5wwl5cXoQ
         dD3+nyEHVz6r/+bp9NruSu4r14+0g55r0z0Ki3JLvI1XbBx3sT0oKe+ybKtXXHXE794/
         ilcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=u+l9cJDXtAcVTGo/WCJEmLohq3OICTOB58fN6/+YtsU=;
        b=Z9lowBVHswYJDocCEPAAjujGlQAaMHkr9WbL9aWs+z4CIK2kjNV4y40oM9wieAdcNC
         vTKIjBH5gVhOfxPAf+iFFLyvSpl9M4Iv/8nDZSKuxhxYL3w1K5iVqbODRzXiMlgiqQUk
         HV5lafcu4TvdwuuRdy72l7y0KIFMBBuWRA0uXHEWBEgpDcnwITC303SWEw4Si04L3McI
         rz4Cd6OnyBTFTn/gOE2LSEbFxwyPBPpYaF77Sj/q7XxIPygnZeEUwbaOg3K1g6dXc15+
         vAOtyF4iDpqQfdth3WGz8xO8gWQlqIBLhARCYZdvDI7ChIC9VB89ArfQ1bpTYCWLijUo
         EGiQ==
X-Gm-Message-State: ANhLgQ0224yzbSjyMm38hEx0ciUbAMiudOdTJF+fCVa7jWq8RCYv8R6E
        HpnTzC3Igh4R+KC5ZYiqswQ=
X-Google-Smtp-Source: ADFU+vswsni4V/DVLuX57f48bPyEIZtZDrG6Kz+1AQFZCCA804WmmtXfW88pw7tBNED0Q2EuztA1Hg==
X-Received: by 2002:a5d:4f86:: with SMTP id d6mr18747307wru.315.1585643877831;
        Tue, 31 Mar 2020 01:37:57 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id 98sm26377716wrk.52.2020.03.31.01.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 01:37:57 -0700 (PDT)
Date:   Tue, 31 Mar 2020 10:37:55 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/misc changes for v5.7
Message-ID: <20200331083755.GA70287@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-misc-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-misc-for-linus

   # HEAD: 1032f32645f8a650edb0134d52fa085642d0a492 perf/tests: Add CET instructions to the new instructions test

Misc [ :-) ] changes:

 - extend the decoder maps with CET instructions

 - fix !vDSO corner cases


  out-of-topic modifications in x86-misc-for-linus:
  ---------------------------------------------------
  tools/testing/selftests/x86/ptrace_syscall.c# 630b99ab60aa: selftests/x86/ptrace_syscall
  tools/testing/selftests/x86/test_vdso.c# 07f24dc95dac: selftests/x86/vdso: Fix no-v
  tools/testing/selftests/x86/vdso_restorer.c# 07f24dc95dac: selftests/x86/vdso: Fix no-v

 Thanks,

	Ingo

------------------>
Adrian Hunter (1):
      perf/tests: Add CET instructions to the new instructions test

Andy Lutomirski (2):
      selftests/x86/vdso: Fix no-vDSO segfaults
      selftests/x86/ptrace_syscall_32: Fix no-vDSO segfault

Yu-cheng Yu (1):
      x86/insn: Add Control-flow Enforcement (CET) instructions to the opcode map


 arch/x86/lib/x86-opcode-map.txt              |  17 +-
 tools/arch/x86/lib/x86-opcode-map.txt        |  17 +-
 tools/perf/arch/x86/tests/insn-x86-dat-32.c  | 112 +++++++++++++
 tools/perf/arch/x86/tests/insn-x86-dat-64.c  | 196 ++++++++++++++++++++++
 tools/perf/arch/x86/tests/insn-x86-dat-src.c | 236 +++++++++++++++++++++++++++
 tools/testing/selftests/x86/ptrace_syscall.c |   8 +-
 tools/testing/selftests/x86/test_vdso.c      |   5 +
 tools/testing/selftests/x86/vdso_restorer.c  |  15 ++
 8 files changed, 592 insertions(+), 14 deletions(-)
