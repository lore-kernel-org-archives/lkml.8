Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DF5C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 14:52:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECE1F21775
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 14:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MY+/PXRt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgBFOwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 09:52:05 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50220 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727678AbgBFOwE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 09:52:04 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so313409wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 06:52:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=mJxTh9S4n0F4s5VxjTTNjdqiTqHIU1Yz89fV5yVtbcM=;
        b=MY+/PXRtdFE0kGyhmQO6CI5BTAO1Se7mdcKRfgHaw0gbVPmmkDIc/fE7OP1H1Ntct1
         593K3T539bQM4slWTzc+u84QJpc3edzBNdTlIwJIqXY6uxy4ijP1Jk1zm88I9wkRaZTc
         CGrvilSdVk1cqZ3Y2PzE2rRVzto9nrOw2idIzGGWG52WRyRFCQJFRvrlkSjGRNbVQOWs
         u78GrUv/57KjOJHi0YIXwacLbW3TVAPs1Sdp3OYX/GHgOS3ji87LcBfYp5FYRKPdGwLR
         +OBHRxH8BnpPH8jusy4su4jWNhhXlDhyAfyu48yM9icOiv27/Y3zf6s8zLAKJeIzBu+5
         WpSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=mJxTh9S4n0F4s5VxjTTNjdqiTqHIU1Yz89fV5yVtbcM=;
        b=pQ3tsYjmLEXCp5CbGZJy/Mvp/+VcoJzhRoc7gnWy6PO6RE5Ro0sl4qS5tsShBhVneg
         PKQCiHM/LFTQ9x2bFfP+246f+7cGiDHHEuoRpT4l5U5SpEW28gGWWPoaicO8eYPC0kzY
         KoEvT1hjQMaRGPnDydU9KwTdd9ekIZX4n4UbQWgWliyXEmS6frzeW8VRbYt2CrnnAaC/
         uBBEhvWTkl+1pI8JJwDwtqxf5LvMehRNuZJZP3N6K1WvLqc5pNUXeMXrwx/IfAc2PgSE
         FkDAxYBGVtnyUrZR9N/iN5rFs9LEZpMjBT8dsm3Ep1N+FZcRCY1tPr72IHRL0W8JQCQ+
         GF7Q==
X-Gm-Message-State: APjAAAXOZeopn/IJMyEoi8zzjiVKSGFDd1QADm5T/ic8q3fkdynxk8/K
        BNWpe9C5YoH2kibo5crYq6As7KE2BTjT4Q==
X-Google-Smtp-Source: APXvYqyebkbTN9MGqapvZFGquDE74sOJyPmK+PjYKnjruE3amVtOOWzsBDEtNlQho9HPNpBEXNIsSw==
X-Received: by 2002:a7b:cf0d:: with SMTP id l13mr5229896wmg.13.1581000722859;
        Thu, 06 Feb 2020 06:52:02 -0800 (PST)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id r5sm4415391wrt.43.2020.02.06.06.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 06:52:02 -0800 (PST)
Date:   Thu, 6 Feb 2020 14:52:00 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>
Subject: [GIT PULL] kgdb fixes for v5.6-rc1
Message-ID: <20200206145200.pafzy25atqrh5wro@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus

I think you are likely to conclude from the following that the issue
fixed in this PR should have been detected before it ever reached you.
If that is your conclusion then I agree (and is one of the reasons
I chose to address it with a direct revert).

Sorry!

I have already added additional architectures to my pre-release tests
so this mistake is now (much) more likely to be caught in future.


The following changes since commit dc2c733e65848b1df8d55c83eea79fc4a868c800:

  kdb: Use for_each_console() helper (2020-01-31 17:34:54 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/danielt/linux.git/ tags/kgdb-fixes-5.6-rc1

for you to fetch changes up to fcf2736c82ca1908e3a0e74730c404baebd8ccdf:

  Revert "kdb: Get rid of confusing diag msg from "rd" if current task has no regs" (2020-02-06 11:40:09 +0000)

----------------------------------------------------------------
kgdb fixes for 5.6-rc1

One of the simplifications added for 5.6-rc1 has caused build
regressions on some platforms (it was reported for sparc64).
This pull request fixes it with a direct revert.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>

----------------------------------------------------------------
Daniel Thompson (1):
      Revert "kdb: Get rid of confusing diag msg from "rd" if current task has no regs"

 kernel/debug/kdb/kdb_main.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)
