Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8C4C433E1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74674207DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 12:37:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kDOfzWkO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728996AbgHCMfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 08:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729151AbgHCMfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:35:09 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68330C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 05:35:09 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g8so14187306wmk.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 05:35:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RC5i9ArL4g9Cb7In6/crhZNE521qGugsCHIJdhq6P7U=;
        b=kDOfzWkO2N1CaYjyppdfD6fsyf+Orv098rFtmOTBNzmihF831ga3PWK6UlBWo9fE4+
         Mil7ZuuuMoorMBfyt6fApCMg3yVf4SqO0iPi9iV31cLaqTExqzCd0i99tpwraf9eiNHO
         EWvs2NUGm4ZI2s7CYSdR7VhAT8Cmbqs8UcPg8e2ZBX89+BrrLvx54DmnCCQABGigTMkC
         glWKium0ks7sLjuXB/SW2Aoz2WzUukYxXmkC57NViRSnoBAidCLqWggyv9lWYxZ34BTv
         6UpAXyqYdE71i3OX9dhHypbu6cQkUrmnYqCWIw/RIvz/qVwwFk9r+PAyhWaJwCq6Mu4c
         +IQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RC5i9ArL4g9Cb7In6/crhZNE521qGugsCHIJdhq6P7U=;
        b=V7I9nSHrfOYyjVm53FalSYYa+UypPcK7GU8fvuhN7mJUBD6RH0f8ymUVmb1JAk/V8y
         XcU49CUH5qZJu4blG74MyHx+cJQAN7XsXaqPommH7IHMqtMP9VVArPEwlyCQk7AsNajq
         toC7/Ajhl7NLnjYEH0GxaJzNUfMM6xf1el9tRwyFUJYusax+hyrrMAPhVs7GcMxuqz/+
         zWhfyGueIsj7JPbVYYyevu62NeK4csMMK4XI4+ugxHPUcZGsKfAeWW6Vq100pKHyIa/O
         y1f7WnJVqeBGULrJwc80Huve5aer53fIa2WfUEsISkmO6X18JcSapXZP+BnhOTh8Iw0L
         FHqg==
X-Gm-Message-State: AOAM531gshu7mheVY3nX5I7n2PzxMGWWnoNVzTSkqbqTvHyChrFgJgv5
        q7V5QjA9xUf4k9RxjEjTyFTaNdI7lQ==
X-Google-Smtp-Source: ABdhPJyTXoIFHGPUr5ZGK4skFoKm1/ShVXJ2/Eis5gbtB41Wt0ccmxhS3PmoMhy7AEBNUG42IScxSg==
X-Received: by 2002:a1c:9ec6:: with SMTP id h189mr3070251wme.22.1596458107862;
        Mon, 03 Aug 2020 05:35:07 -0700 (PDT)
Received: from localhost.lan (host-92-25-238-49.as13285.net. [92.25.238.49])
        by smtp.gmail.com with ESMTPSA id u66sm24201133wmu.37.2020.08.03.05.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 05:35:07 -0700 (PDT)
From:   Jules Irenge <jbi.octave@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jules Irenge <jbi.octave@gmail.com>
Subject: [RESEND PATCH 0/2] cleanups 
Date:   Mon,  3 Aug 2020 13:34:37 +0100
Message-Id: <20200803123439.83400-1-jbi.octave@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <0/2>
References: <0/2>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am proposing these 2 patches, one of which is recommendation of Joe Perches,
namely the removing of unnecessary globals and change them to static.
I am currently learning the core kernel the hard way.
I will appreciate any feedback negative or positive.
Thanks

Jules Irenge (2):
  audit: change unnecessary globals into statics
  audit: uninitialize variable audit_sig_sid

 kernel/audit.c | 6 +++---
 kernel/audit.h | 4 ----
 2 files changed, 3 insertions(+), 7 deletions(-)

-- 
2.26.2

