Return-Path: <SRS0=BhYR=34=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEBBDC35242
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 21:25:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91C1022522
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Feb 2020 21:25:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="F8PJ4CXg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgBHVZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Feb 2020 16:25:40 -0500
Received: from mail-pj1-f47.google.com ([209.85.216.47]:37079 "EHLO
        mail-pj1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbgBHVZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Feb 2020 16:25:40 -0500
Received: by mail-pj1-f47.google.com with SMTP id m13so2466381pjb.2
        for <linux-kernel@vger.kernel.org>; Sat, 08 Feb 2020 13:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8lA4iqONRNqA3ySFcb+v4bckKAK+PELt3278196lhaU=;
        b=F8PJ4CXgSzEFNpED+Uq4lHJM+GiD5a5m1AFpWK4ATJTQ+1yDFeJQGPfinnPqJHSW2y
         5gyDf4qcc+xXlf1PN/xWr9HKvtbRDr2OZ57XrNZRn9JyOPpYs02vijcAWJ6Om/9MIe26
         fbi8llC7vpTszGNePk8qCqfk+8zz0Bj94KBsXNLZc3JaPH+DAtgsQgPfu4+QvwsgmvLh
         45syekHaWEdM/aU775IG33TdQz5+qhTfPCdzvreTCTAlploNfwT6e4dowm0htidv76uy
         nWuM4e9dSAOXbW8k95n51R2ieyVbrEQ2TTetlf0ufZIl50oZ5BSyoKVBoc19UNTvZQqi
         9tug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8lA4iqONRNqA3ySFcb+v4bckKAK+PELt3278196lhaU=;
        b=gQa16YgLMW20Y4XSgKC7PUVWZ9QEsbrs5kNNX+PHEn8QEkiEmaCH8O8vMJZvvwTD7E
         l9no9sT2nyXn4AFLy2Dtp3C7yf1PcXXZhaz9CWQ7R4zMGPQlVHgsPEW2M+2hjQ4Icu7N
         bwiKdstLe/s4b2DZ1O90G+DdPLOy5PlQRYARQoqvxRseLWv1mARzG2lBiqlMDno+PQlz
         VR3mrpqb4ddSDxi3BtBSxOMW9AXK6iOqtEJ9ETRTsgYL/6OhFwLPhs8ZngHVLuPghA7k
         Ua1pI2+DoQFfQeu/8FHlIm69aB24uVPnN1zr+r5nGURSbBuNDDn5F2qbueiqMMr28oT1
         GeBQ==
X-Gm-Message-State: APjAAAXL2wRYtZ4klQpmjzOojM8GJt5PpwDg0ELfbbIRkpkFDxfJBick
        jHPJwwODjYTI9fS9wGuIkGpKwg==
X-Google-Smtp-Source: APXvYqysnFLWHFoHmkxAgiSMpKv/1WJecVJBkwN9dT0+uE9ubFjRLxwl2VQ8HTqcGQILsMsMwnmxiQ==
X-Received: by 2002:a17:90a:bf0c:: with SMTP id c12mr11427402pjs.112.1581197139469;
        Sat, 08 Feb 2020 13:25:39 -0800 (PST)
Received: from localhost.localdomain (99-152-116-91.lightspeed.sntcca.sbcglobal.net. [99.152.116.91])
        by smtp.gmail.com with ESMTPSA id a21sm7126831pgd.12.2020.02.08.13.25.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Feb 2020 13:25:38 -0800 (PST)
From:   Olof Johansson <olof@lixom.net>
To:     torvalds@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        arm@kernel.org, soc@kernel.org
Subject: [GIT PULL 0/5 v2] ARM: SoC contents for 5.6
Date:   Sat,  8 Feb 2020 13:25:28 -0800
Message-Id: <20200208212533.30744-1-olof@lixom.net>
X-Mailer: git-send-email 2.22.GIT
In-Reply-To: <20200208112018.29819-1-olof@lixom.net>
References: <20200208112018.29819-1-olof@lixom.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

I completely botched the last generation of pull requests by
mis-generating them, and I also missed to push the tags to the server.

Here's the fresh set. Apologies for the noise, please merge.


For anyone keeping track at home, what happened at my end was:

We use a script to generate our pull requests, and it's ran against a tree
that is mainline + the merged branches. The flow is usually to merge in
a branch, note down any conflicts needing to be resolved, then generate
the pull request. Or, sometimes, I do all the merges and then generate the
last pull request, reset the tree to HEAD~, second-last pull request, etc.

I completely missed changing the tree between the generation this time,
so every pull request referenced the right tag, but the diffstat and
other contents was botched.

It's probably time to automate more of this with scripts at my end,
to avoid these manual mistakes.


-Olof


