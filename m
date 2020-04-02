Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A6EC2BA12
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 19:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A13B520B1F
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 19:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1585856051;
	bh=1JzoXcWz3hij2feVyT6t2nJm6hf4czR8TBPqJp2nkqI=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=b+WOeCi/UHy+6c9Awp0W1CVWsyXrHJvPqkczhWjvBFSVPp1YFtU8q+qTl7XwIKaGg
	 CTuqzlEdYuMbIO2kgIEKFn6OgUtxAh/BWEjgM2cAkJPeF6NtAC2KhaLJRRRZ+WZkPZ
	 9dmXDPCmPF2p5CJuznRqwf6BkQH8twFySIge4Tm4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389052AbgDBTeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 15:34:10 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:42649 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729033AbgDBTeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 15:34:10 -0400
Received: by mail-qv1-f66.google.com with SMTP id ca9so2351409qvb.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 12:34:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=5nIZlZKWjxlLnnHhs1gakYHEKHBE6JYgP01PsDatF0U=;
        b=CPPAQGiwsa5Taa8JRa86X/5KETJdJgODL/3gq+OwpgAYjoLoTjmgVeJ5gIcSbVggL2
         ENRyulRw0yPZoOVtPh3leM4b+L8l6HRLQFHRB1EygeEcgd2wLMPmyrGAFLCKdlrbmMMd
         5813G2VOpRPRb0V/Y/F1doxaeydMfFhwS1xpwmdB6mVqeJNoFVqNmaUzJpeLv3C1ZPxQ
         QLxlNtIpz0Ewo1vpQXdQgT1XK7rnaTqWQjcuqcbFsJ/tYjCzGPULK0hz52huCyiuQ6az
         ZtTak9ob0Xj3gNPsEsqmaDiKfTYzWtlCwKZ8wPw1HwgBOtLH1MKJYhDbzf++K91sw2Hk
         I/wg==
X-Gm-Message-State: AGi0PuYgMMKu1eJ/a63b4AEkNN82RKBQkTGGHVLhlANCvrCGoy1dnTY4
        DBPug0RBnNC2cuxrFFXe4W0iR7phigo=
X-Google-Smtp-Source: APiQypI6ncleeN1Ci/FHsko9mI0ApbSB9QSEplnw9jY5o+6Cbns2CqrKcl+HcueNyTY2+79LiVD1pw==
X-Received: by 2002:a0c:bd99:: with SMTP id n25mr4971589qvg.149.1585856049254;
        Thu, 02 Apr 2020 12:34:09 -0700 (PDT)
Received: from dennisz-mbp.dhcp.thefacebook.com ([2620:10d:c091:480::7841])
        by smtp.gmail.com with ESMTPSA id e16sm2637979qtq.78.2020.04.02.12.34.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 12:34:08 -0700 (PDT)
Date:   Thu, 2 Apr 2020 14:34:03 -0500
From:   Dennis Zhou <dennis@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] percpu changes for v5.7-rc1
Message-ID: <20200402193403.GA8781@dennisz-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is just a few documentation fixes for percpu refcount, bitmap
helpers that went in v5.6, and moving my emails to all be at korg.

Thanks,
Dennis

The following changes since commit 98d54f81e36ba3bf92172791eba5ca5bd813989b:

  Linux 5.6-rc4 (2020-03-01 16:38:46 -0600)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dennis/percpu.git for-5.7

for you to fetch changes up to bfacd38f8d5b1f12b80aaacae2c15e1ffe11f06e:

  percpu: update copyright emails to dennis@kernel.org (2020-04-01 10:09:12 -0700)

----------------------------------------------------------------
Dennis Zhou (1):
      percpu: update copyright emails to dennis@kernel.org

Ira Weiny (1):
      percpu_ref: Fix comment regarding percpu_ref_init flags

Wolfram Sang (2):
      include/bitmap.h: add missing parameter in docs
      include/bitmap.h: add new functions to documentation

 include/linux/bitmap.h | 8 +++++++-
 lib/percpu-refcount.c  | 7 ++++---
 mm/percpu-stats.c      | 2 +-
 mm/percpu.c            | 2 +-
 4 files changed, 13 insertions(+), 6 deletions(-)
