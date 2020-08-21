Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FBEDC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 12:10:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A2BC20702
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 12:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="ea9naKqr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727846AbgHUMKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 08:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727029AbgHUMKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 08:10:07 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D89C061385
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 05:10:06 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id i20so1108784qkk.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 05:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=x2zyWzSDJHBz/coWO6uLAm79U5a8FMGQOT/SueKdJ+Y=;
        b=ea9naKqr8k6EBi1A3g9ObPls+dIpoC6yWY0O5ZhiNNQKvgAEq+BFO0jgMfVfok0Zp1
         dAfmV1ssdGlcRKHJWqrcwLRi4vS9IXcNpinOEIImI38Uz8VskffrqkXknzbZLIiRukJB
         Shwp7ebnq5cXh2dmzt9WCrQZOcXM7lTmVjZds=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=x2zyWzSDJHBz/coWO6uLAm79U5a8FMGQOT/SueKdJ+Y=;
        b=Dpoz2IXDJUdi01EPBvXJMVhlvFQRth5BUVfFO7PNKjJUycxHreMHSQdyySuR3s4gpk
         v04KGqEOzOubh63c5TyEVs4k2zetCdi2IfoDX7I7uOCKu7DAE+wX0XU45C45BEfkYcVI
         zkB6ID8SiHtIM+yxI9vlbVwOzX0orQj87kCw84vgKRZXlPqAasqaFYtrCqa4AEzVeBMQ
         jVTeeI0hMZIlm9Qp1mk2ta/uXC+7s4h+t4Uj6SYFD0XnF0mQ2seEPeOYZanDFSb/J5kq
         bJFBslrllKKTDRd8ddinpvHe4HvDs+Aouy6HKFGzmW+fI0fwMZS8/uk+13giBhA2GJM7
         rrWQ==
X-Gm-Message-State: AOAM532W+UFvwDeJmAajZ1VtzmvzPf/yOBgV3k1c3MI1RX5Agzg5o6AM
        SFvSsgY97c4867313cjOEk7HSSXU5cm6sEum
X-Google-Smtp-Source: ABdhPJzb2TBqXJU8p75CDrXcgQvS4Tke5vC2h2StFVhvIaW1qRIU6238GpVOCetiZkdBYEESZT68XQ==
X-Received: by 2002:a37:a797:: with SMTP id q145mr2232672qke.13.1598011805610;
        Fri, 21 Aug 2020 05:10:05 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:23fc])
        by smtp.gmail.com with ESMTPSA id q4sm1527378qkm.78.2020.08.21.05.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2020 05:10:05 -0700 (PDT)
Date:   Fri, 21 Aug 2020 13:10:03 +0100
From:   Chris Down <chris@chrisdown.name>
To:     linux-kernel@vger.kernel.org
Cc:     Borislav Petkov <bp@suse.de>, Jakub Kicinski <kuba@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, kernel-team@fb.com,
        sean.j.christopherson@intel.com, tony.luck@intel.com,
        torvalds@linux-foundation.org, x86@kernel.org
Subject: [PATCH v2 0/2] a couple of userspace MSR filtering improvements
Message-ID: <cover.1598011595.git.chris@chrisdown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.14.6 (2020-07-11)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As discussed in Message-ID <20200714165621.GA3622@nazgul.tnic>.

We all agree that userspace MSR twiddling is non-ideal, but we should be
a bit cautious of taking up too much kmsg buffer if applications do
repeated writes. `allow_writes=1` is possible, but is non-ideal (see
patch 1 changelog).

Also added pid information to the message, since it makes identification
of the source (more or less) unambiguous.

Changes in v2:

- Fixed mostly aesthetic suggestions from Boris. Thanks! :-)

Chris Down (2):
  x86: Prevent userspace MSR access from dominating the console
  x86: Make source of unrecognised MSR writes unambiguous

 arch/x86/kernel/msr.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

-- 
2.28.0

