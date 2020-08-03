Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57A1EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:25:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 598C62086A
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 20:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596486348;
	bh=LO2kfzEYgxKuq23B2EQDgjSe4rJ1OT85wQbyAvoHVJM=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=MsIWcE/SoRFmzn+P4AwciCgvxmk2lIaANq+IhH+PH1TpD9xtnYo77adiESW0JPM1i
	 eysHSxtrE+c+Nls8WLZ62eZY6c5bktG/giBsUOhA3R+lD0Lj+vgelGnW2Sl/Pahu5U
	 keqKZo717Inp/ar888GXsdFmOcljJ5TfupH1s4so=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbgHCUZq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 16:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgHCUZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 16:25:46 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14D1DC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 13:25:46 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id o18so39989245eje.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 13:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=KrXUGQJ4CRTS+uPce+ywusiHQCHyfc28Y+mQSw1Etg4=;
        b=QMJb0d7qaPjInmsSaqZALzRdCUQA788voJgk+uHCLY3qyYGe2bg+gk+8T6TuclHZwT
         Ob2iZtF2HsOXU5mrokoRsQ8fB14pD+Zfo0DTt+h93M79lS832USEii30nda3G1lKdYeR
         ZSHMA6ZqMYqivXxrGI3BdUX/w3Xlg66stHP/Wggsqd4xQWPmewxztQkjO2npO2QsqMvy
         gm0WLAbFTI0LBlOe6cFQ247HZz37vmYsFgoqsyG1U0q4NqC3ka+u++p1lSE+9YwnI6sJ
         YtGvSL9yipjdYMZK/mi1CHaKxja67lHfXtm9F95XTLtQZpg0S7pakmmxa3piOn+e1wB2
         MrGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=KrXUGQJ4CRTS+uPce+ywusiHQCHyfc28Y+mQSw1Etg4=;
        b=GuAgmQofIRZWgAgYrJ8o3NDg3ojgKrxkFdGbhyHDTRZeWyeiRFFx039c2V2+9vC4ao
         MgqSoUqBt9Q3osll3N7G3XAkcV+UtWitOyQbnZbbTG0RZ0ntD8vItZAl91CRYhaJ/i66
         9UKMpcu/iTAM3KpayVB+5Xk4kFEwxCJg0ctNXjQeHJBaTekqrHG5TlfXQbiwj8WJdoT+
         /6GFUjlezM/PGsw8uSegCFe4GLT105zKptsdxtqNsdDDpiL3OaLpY6vaYE/f9sWXUV4q
         BzUdDh/NFaGFs54bGyMT0LcFK72Sze6Fw0+8CNH2AFT+b9BFB0TxhptImdDzharTjS06
         qHHw==
X-Gm-Message-State: AOAM530WrJMRxGV5pa8I3pof/sQ0NX/R4efE/GlrfdUsmNykdMOaRz6h
        LScxY2WWwCnGciVhLtYmtnlZxTHr
X-Google-Smtp-Source: ABdhPJyL8ZVnhhMSgOhEuT1X6GTGS22wIQ5tTL+RSwDePa8UOM0we5OqB1BFC3ujh1c8nHK3MMLpbA==
X-Received: by 2002:a17:906:9399:: with SMTP id l25mr18075682ejx.212.1596486344865;
        Mon, 03 Aug 2020 13:25:44 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id pj19sm16418647ejb.66.2020.08.03.13.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 13:25:44 -0700 (PDT)
Date:   Mon, 3 Aug 2020 22:25:42 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] RAS changes for v5.9
Message-ID: <20200803202542.GA1474582@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest ras/core git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ras-core-2020-08-03

   # HEAD: bb2de0adca217a114ce023489426e24152e4bfcf x86/mce, EDAC/mce_amd: Print PPIN in machine check records

Boris is on vacation and he asked us to send you the pending RAS bits:

 - Print the PPIN field on CPUs that fill them out
 - Fix an MCE injection bug
 - Simplify a kzalloc in dev_mcelog_init_device()

 Thanks,

	Ingo

------------------>
Gustavo A. R. Silva (1):
      x86/mce/dev-mcelog: Use struct_size() helper in kzalloc()

Smita Koralahalli (1):
      x86/mce, EDAC/mce_amd: Print PPIN in machine check records

Zhenzhong Duan (1):
      x86/mce/inject: Fix a wrong assignment of i_mce.status


 arch/x86/kernel/cpu/mce/core.c       | 2 ++
 arch/x86/kernel/cpu/mce/dev-mcelog.c | 2 +-
 arch/x86/kernel/cpu/mce/inject.c     | 2 +-
 drivers/edac/mce_amd.c               | 3 +++
 4 files changed, 7 insertions(+), 2 deletions(-)
