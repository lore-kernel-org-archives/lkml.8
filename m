Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA66C2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 18:29:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 388E920716
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 18:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580236157;
	bh=iyaHIIOcGJa8EsCCKZFdDMrJ7IhXmIAwWiVmR3bJ9hk=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=rMtshmMIlAroYtVuVaKN+N/1vtArVW0Arj8czaV8l+SG6bzqUYv0uXLyKYvfXn0w9
	 HV84Y2pyYvz5LruQfuOz+Qfp4k4SRx033ZjKDRwun2W1iVOADwenZIEVSatydE8RoV
	 M8nNi/T2NDmZ8hGenocc9tZjGPwPxgTwZlHfB3OU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgA1S3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 13:29:16 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:55608 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgA1S3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 13:29:16 -0500
Received: by mail-wm1-f66.google.com with SMTP id q9so3596486wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 10:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=UArcWrkCpkZ1zVNM7ybNgPasMo5PhRIF6wdJ3/DaRBY=;
        b=HUSWlLar0T6g/BHfB0FrzxjUWXpYQ39D6XmSovov+HaFuUkijh1S7FqyFG8IKubhmJ
         6/1gzg+QODmMp70yqXL+wDS57TI3T01/AMSPIFr9WWMxAxkFAVfSbU9y5e7m9jh4fFyK
         flNFkeZ7KQvO9S+yV71AHl2UWmJycTaxoDY8taHlaLM30R3i10BFfq8CBpjCbVc2cuQy
         U06tGPv3j0EbKwYNzdncE3sN9vf35MYwST+2L9V4pIvASJNZMinbd+dh7at1wyVxv3bv
         ucJQWzZ4NZrf5g7BF24Gk7HiN3DXIVwPBhWZ4QyrlC3LKFt/lYoITxDR6QGz4Diew4j+
         WMhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=UArcWrkCpkZ1zVNM7ybNgPasMo5PhRIF6wdJ3/DaRBY=;
        b=p+Np/HjMg6xaSoYThXtvivPoFvltFFxcJHXvls/24aB2/33CQkzQ0IxQHWKgS6A9MB
         2kaTWGlydH6ul7q2SifpUYsmYMA7dPB7jY/kHQvy4Nq/bfn4k8elD96/351cWk5o7vPy
         BVU0gAuWy1JOcesgljtyf9t/AeVexS+CfLIp/7msr2rrPqQrlgjq3V/gKU2sNdLyV7JB
         veDpJGY2sxW4Xv8XkeRdjdX4dbUkbNQmj0/l3yJiJ8eUgEwvYpo80Ug8m7v6RXRz5DBc
         25Jvs1hzfPYeLAZwNY32bisbEIaCc71aq2IShQHB57OUkQGyqvPKTTzcCjPZZanG4wZp
         5TWw==
X-Gm-Message-State: APjAAAUX1B2iWPQXDVoP/4NAU7Mcu3S/pQLf4/C4ItMj5LaczK8ronL1
        2wOq1vThbL66oG51QgpAybpG7dN4
X-Google-Smtp-Source: APXvYqyjvcI/2dtJ8JySWbwqud7KCHRILpnD2a/d3IFOHB2dnhUbw0ZAsCIiBLyIlIG+fQ3gnp1huA==
X-Received: by 2002:a7b:c386:: with SMTP id s6mr6390675wmj.105.1580236154128;
        Tue, 28 Jan 2020 10:29:14 -0800 (PST)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id c9sm4296392wme.41.2020.01.28.10.29.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2020 10:29:13 -0800 (PST)
Date:   Tue, 28 Jan 2020 19:29:11 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/mtrr changes for v5.6
Message-ID: <20200128182911.GA109695@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86-mtrr-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-mtrr-for-linus

   # HEAD: 4fc265a9c9b258ddd7eafbd0dbfca66687c3d8aa x86/mtrr: Require CAP_SYS_ADMIN for all access

Two changes: restrict /proc/mtrr to CAP_SYS_ADMIN, plus a cleanup.

 Thanks,

	Ingo

------------------>
Borislav Petkov (1):
      x86/mtrr: Get rid of mtrr_seq_show() forward declaration

Kees Cook (1):
      x86/mtrr: Require CAP_SYS_ADMIN for all access


 arch/x86/kernel/cpu/mtrr/if.c | 63 +++++++++++++++----------------------------
 1 file changed, 22 insertions(+), 41 deletions(-)

