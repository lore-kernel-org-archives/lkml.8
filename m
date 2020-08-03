Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1097CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D2CA92072A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 15:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596470029;
	bh=4o7ZcS4KwuVFntYS90r9JlyzrVYbLDN8X0arg7MQmbU=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=RD9AIoKSh66N04hnGf0hsS4tgNBUKt4zUWTOmFIIDi36E5LxEtkIUj44UeBLT7CE2
	 yOkrRpXP3BmsCI5SlNXdyHbPV11u2rV1T/fsRb+CHQoE1LweM0MSn+FxtRS0AC0Lgz
	 GQrK3Rmi8EA+XwNkYsSsfFPUcV3fXAHKN7pqolf0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbgHCPxt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 11:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728090AbgHCPxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 11:53:49 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7320C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 08:53:48 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id i26so24268557edv.4
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 08:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=+oWJHSequ/xq00s8T95ux1tnE2tehvRlQbuUzCOoncc=;
        b=FXmqA6z9SZnGObZjZtW6ocW7da97RZzlTj+D1nDOyiHDygkPoPsRREv+2xzLa22rJF
         SS8xkuOeEZJY+fnXxYh8jBYhCSEyvi+iT1zn1v2gdsuZuBUfOxCaKQ4vMcpNkqyLCMnF
         3Q761EufkiRHa+WU0gj+H8gMumrkOWSqW8i88KBK+E1HzJicEYxkfgWW5Ct+5AONvPzC
         U5J9uWU4/wMXjaYjaw5llMGB2pp/ij+fCm+vDrkUvGcXixuL67UstJMER5R5/BDM81sy
         bxCdTwqP4NdFcxjSE7lRY/k/FR63aYCTqH8vX7pxBQuGeWqaCjtZvLHBtSt5XxJ71otD
         CZjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=+oWJHSequ/xq00s8T95ux1tnE2tehvRlQbuUzCOoncc=;
        b=iLA1aeZCsct3DYkh3/7uWgpWAt7Pg/10raxe4EzUMZqzhMVUlAuJ4gEscjfyyiAHco
         sbd1Fp3loq4DdFmKYav/furq2APbkWRp+2YtCQUqc/cZVbggFtixxmpiDd+Oh6StiWM9
         CtY0yjgu89tR9AefHE6h7sdl84O+QTDLox04e5kLq2S2FrIR96ZLApgAJipuqaiH7Y8i
         8VCP/CDAoYjWAsmliFCKZVOSbYZsMIZmyLtgspFOuq3MZYZ392/AuutCGd73O0mNBv25
         qis4/DCmxULHy++XjeZqz2PD8op55SESzjOb6cjsW2wCBvveHoCFDUuF1wfyaGKOYzEs
         JCEA==
X-Gm-Message-State: AOAM533eS26MB/iYwraBhsklXSWdwhRfv3P76PWWtPcyCfc+/7PF39XX
        GRw5X2w0ggLXE2HuJ4a93rJWdZ6B
X-Google-Smtp-Source: ABdhPJzXtRB5AhHoPWCiFScsqX63KTDODpLZ7Hdg10ZoZ4x7Bf0jMJln76YeainpfKDi+W7un5YlkQ==
X-Received: by 2002:a05:6402:758:: with SMTP id p24mr5681435edy.35.1596470027077;
        Mon, 03 Aug 2020 08:53:47 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id e13sm16229620eds.46.2020.08.03.08.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 08:53:46 -0700 (PDT)
Date:   Mon, 3 Aug 2020 17:53:44 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] x86/alternatives change for v5.9
Message-ID: <20200803155344.GA696530@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest x86/alternatives git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-alternatives-2020-08-03

   # HEAD: 1b2e335ebfa2243517e09f99653c78d1936cb6d2 x86/alternatives: Add pr_fmt() to debug macros

A single commit that improves the alternatives patching syslog debug output.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
 Thanks,

	Ingo

------------------>
Borislav Petkov (1):
      x86/alternatives: Add pr_fmt() to debug macros


 arch/x86/kernel/alternative.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
