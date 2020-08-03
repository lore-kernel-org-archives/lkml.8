Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDA2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 18:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 724C02070A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 18:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596480445;
	bh=0w67hvyd/00bwWNq4RqrFiO5auWeGm8H64DyD9ZQIfY=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=PHnRZ99sjcCsYwHaQ0HwyRYOg4dtfCN+ABL11q3LOs5Aw48wcTQHvrNOhv0Q5y4eS
	 gJ0uMDPQm2dbD87tUEJhstBfP80j+QU+gnWwWjN6rS0AnctdVZ1ysYksAzbMdCTaui
	 wkABsFQMUvDptt1fAUjzC2ExqparOwsgondwjAj4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbgHCSrY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 14:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgHCSrY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 14:47:24 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEE5EC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 11:47:23 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id bs17so9235257edb.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 11:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=uqDHAIUa0HxVXe12Avfm5Zv0Jo0lrG5p/rK3x08NonA=;
        b=jt9Eptfc/fzX266KAMowAp3I/gXyXiiWlE7jYMGSjnyjagaohwhOf71USsiquyzD64
         BUP67sIGv8gFQrVbRvJL8dNJsOSTV9InrnM/q28bgsRSJCdWp9AYLlqPVrxs3vBtdJkF
         CAHI8u+6K6//e56TDvg6y1gyX2zgia4hbMlYoP0rxvstnxtfqifBV1PDEfqnhkKnFysM
         mC/MRIHaspktQLf8iH7aBJ0X/8scj+HYFbna6fgU8QBg2lhj3VTD8rTu9bSfepBhGQKZ
         S/a22xwek0Bre7Sq3Yuf2pwU1gnyLA13jzZh3FKxWu81lg9lXhcz3C5P53RkEcYhxO+G
         cxlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=uqDHAIUa0HxVXe12Avfm5Zv0Jo0lrG5p/rK3x08NonA=;
        b=LGWFFJEPwpxaDHxCk0HhFb/cJOxj/TXv2RLXNQIdtNCqEzFhrKT6uuHeZV/hgBs3Dh
         lB5k+YIhZ8DU7FnOdK7XqhT8gKbATQG/HKVD47RtTeJX2/TxOI6vOYiqy+wnPutkf5hA
         W3QDw+EABZnRz/hDyfejGI6a0Pq9soViORvxQ2MJ5tTi6PtpFAMKQMUf1VOa7qA2J8Uy
         lhybI98XPCKta1LRqx/mEXfDYWh0v7omDdJQQuvlFDJ2DpbO4NmBkrtgG5Iw6CqE7ByW
         NdmRcfSmkLAc4nCtBon2Za9Avqlj8CNI6ev3UW4ldlyQNvKGepdCtkvEhDo23jng0HIz
         JH1Q==
X-Gm-Message-State: AOAM530s39hCuzQoj+85Tdg3qhPi8Y/Vql9tGxgIXGULnW8hUkmQCVMA
        6SjETW+3Yp0DXa2tELvnumG8P+v1
X-Google-Smtp-Source: ABdhPJyzrJMndqloNyqHBfS01eY/70qfZPgH1A7tkWdexT00dfaPtHnJipqlKLsI7M7kSasqAYPQfQ==
X-Received: by 2002:a05:6402:2038:: with SMTP id ay24mr17234303edb.200.1596480442702;
        Mon, 03 Aug 2020 11:47:22 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id cn27sm2156238edb.4.2020.08.03.11.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 11:47:22 -0700 (PDT)
Date:   Mon, 3 Aug 2020 20:47:20 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/misc changes for v5.9
Message-ID: <20200803184720.GA1230231@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/misc git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-misc-2020-08-03

   # HEAD: a7e1f67ed29f0c339e2aa7483d13b085127566ab x86/msr: Filter MSR writes

Filter MSR writes from user-space by default, and print a syslog entry if
they happen outside the allowed set of MSRs, which is a single one for now,
MSR_IA32_ENERGY_PERF_BIAS.

The plan is to eventually disable MSR writes by default (they can still be
enabled via allow_writes=on).

Signed-off-by: Ingo Molnar <mingo@kernel.org>
 Thanks,

	Ingo

------------------>
Borislav Petkov (1):
      x86/msr: Filter MSR writes


 arch/x86/kernel/msr.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

