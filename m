Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0157EC433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 18:46:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C62C42072A
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 18:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HW9t5tWh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgHASqc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 14:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726571AbgHASqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 14:46:32 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D91C06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 Aug 2020 11:46:31 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id t14so6806613wmi.3
        for <linux-kernel@vger.kernel.org>; Sat, 01 Aug 2020 11:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GCUJ6ZU50QAYMzRKgBS37g6xtsoQFMOMmG/UkZeh8U4=;
        b=HW9t5tWhZlaY0l10BnGHxHYtvvjRUfudST8+DcXx96jefUu5C++2lZW8FCGcWXw9ZI
         bngDiTVhV8bswWU9FznHI4uSTFzcU3cgmg0+wP+/ik+YbfH0N23sGLh09sA4JrPUg31a
         4IMPWnY/+xmfdAalHNFdr6lrEo1Mo9ZsKG8sYFJnMvI4YkG4OJYrT1h/lx2h2yTRLSrz
         j0YFWYFk6NWViziLkIlWQuPjfw1RdFazI/E7iBiMpSVnXh1B7CkelQVlJhtlN7Rmib0c
         cwgA3BlYwSEO6IOMq/55QckM7DerlVtduYM/yU1/t3Dw6gHIpsu/CHyAXQLzDOKBngJQ
         FhOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GCUJ6ZU50QAYMzRKgBS37g6xtsoQFMOMmG/UkZeh8U4=;
        b=H5D/UmvHmMaEWOPL5IRiz43T/iAY7L5A4crYxidi4td/tBxGsPE/VXWvXU5XvW7Qly
         cCGzmp6++5MTh/7GDJNDvMLJMvvjMLtX3O7FpVEU98TslIqlllHEowjU4Iy5A/rpl0Hd
         ClbXxxnkJWveoJCeB6Y3hvBJlVRGvDPce/eT7XwH8ufpMU7+7uaplUbIW6m5x12gewsp
         /QT/88kNmnQn6gODTyY6NtR7jgeln2KfHXhd/hY3KhRrzmp7UOZthNtQJ++YymA8lYmY
         er4Ros/TOT1XPt3aKZMvcC5gshqXyjfXqc059k8wiMXeBbcydKJvVX38Un0etZWKQlHZ
         2q5w==
X-Gm-Message-State: AOAM530CdobW6JNf4P5o0sGuGFuI0KJ8IMVp+4eMb3V9YXSOLvLZna/J
        Rq44x6YP0KUKReV7BT11GmDDSsbAR/R9
X-Google-Smtp-Source: ABdhPJzucZXpv2jeZIz353bkTKOIpIVlfotjMyrMB8UGgg+1C7CD75Mtxl/ehLkeHfcnV39N4aXoNw==
X-Received: by 2002:a1c:2985:: with SMTP id p127mr8633929wmp.166.1596307589952;
        Sat, 01 Aug 2020 11:46:29 -0700 (PDT)
Received: from localhost.lan (host-92-25-238-49.as13285.net. [92.25.238.49])
        by smtp.gmail.com with ESMTPSA id g7sm17468447wrv.82.2020.08.01.11.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2020 11:46:28 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jules Irenge <jbi.octave@gmail.com>
Subject: [PATCH 0/4] Checkpatch tool errors clean up
Date:   Sat,  1 Aug 2020 19:45:59 +0100
Message-Id: <20200801184603.310769-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <0/4>
References: <0/4>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi
I am proposing these 4 patches. 
I am currently learning the core kernel the hard way. 
I will appreciate any feedback negative or positive.
Thanks 

Jules Irenge (4):
  acct: Add required space between variable and operator
  audit: uninitialize global variable audit_sig_sid
  audit: uninitialize static variables
  context_tracking: uninitialize static variables

 kernel/acct.c             |  2 +-
 kernel/audit.c            | 10 +++++-----
 kernel/context_tracking.c |  2 +-
 3 files changed, 7 insertions(+), 7 deletions(-)

-- 
2.26.2

