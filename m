Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07E6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 07:49:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82ABA2074D
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 07:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590738563;
	bh=aCGFQYbsAT60YQynQCKKkC03PHI2qjYDqDdAWNfUFig=;
	h=Date:From:To:Cc:Subject:List-ID:From;
	b=BR0r7h+tPPtwK+QDB6LdDV95N3YAUaxQdq4iDpJ103kaxuBWA3S3ebqD0kNSb7vdG
	 /JdUww3uke8MhwCHV1OMTcCR6WkrU+80gLY407VrxnjafyLYOmhaqcTKltDyT1FPLL
	 SBblT/wvPL6FuFo2COfyagZcMQzdQho8oDbuaOLQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725852AbgE2HtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 03:49:22 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:47033 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725562AbgE2HtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 03:49:22 -0400
Received: by mail-lj1-f193.google.com with SMTP id z6so1373561ljm.13
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 00:49:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=xl2Y4lkvUazqe+Jjvsy5WYFN2BWBdYf817yckIkXXLA=;
        b=JmUdcxSTM8bFJ9WSY0jdf+doZcudqjH/JR7i9vw5MCGU29ivkj1EVoldhDj7SeRSo4
         FXw7r5PW7dSLnrfLWYf/VQtq4/cXaswMR3CDroYCTR7gjqpUTiIhl7ksSj7CVlTUro13
         iP1jUZkA3YsSFajRMJBGFZZ+39MdEyh03oR0uqtgRQGg1kpVSJmaVCsOeuEnTuogz/iG
         hLS/41wB7C4DbfgU9SaPSHnq0qzIYMCQR5smrw9pqrFyKJbLtIUiJXG5hrhekG8VT/7U
         wPeVKiPI/ULmsNbr3FXlIvm1D6rhuEBAM7jGHfl+oCZZHqfKt1NNzVMAk2iTyvyQElqU
         XG6A==
X-Gm-Message-State: AOAM530ARYixxU5wv/0QASj0BD89y+wl6IW/HefC1p3YF3uoxxUSppUx
        VqAThDoFkz8KnjCxDNaF2RQ=
X-Google-Smtp-Source: ABdhPJwylayAvkMt8IDHhVlAUlsPTf4xkaW7Yk0mPxw319iA7KAW9etCbgywE9VIHi42qSDGDEz3Lw==
X-Received: by 2002:a2e:8654:: with SMTP id i20mr3253299ljj.79.1590738560384;
        Fri, 29 May 2020 00:49:20 -0700 (PDT)
Received: from xi.terra (c-beaee455.07-184-6d6c6d4.bbcust.telenor.se. [85.228.174.190])
        by smtp.gmail.com with ESMTPSA id f6sm1848903ljn.91.2020.05.29.00.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 00:49:19 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.93.0.4)
        (envelope-from <johan@kernel.org>)
        id 1jeZlT-0003lc-J5; Fri, 29 May 2020 09:49:15 +0200
Date:   Fri, 29 May 2020 09:49:15 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [GIT PULL] GNSS updates for 5.8-rc1
Message-ID: <20200529074915.GA14457@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 2ef96a5bb12be62ef75b5828c0aab838ebb29cb8:

  Linux 5.7-rc5 (2020-05-10 15:16:58 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/johan/gnss.git tags/gnss-5.8-rc1

for you to fetch changes up to 9b5816b56af6a424619ab51d24de34dfc65102d8:

  gnss: replace zero-length array with flexible-array (2020-05-13 17:30:31 +0200)

----------------------------------------------------------------
GNSS updates for 5.8-rc1

Here are the GNSS updates for 5.8-rc1, including:

 - a fix for two broken probe errors paths in the sirf driver
 - a flexible array conversion

Both have been in linux-next with no reported issues.

----------------------------------------------------------------
Gustavo A. R. Silva (1):
      gnss: replace zero-length array with flexible-array

Wei Yongjun (1):
      gnss: sirf: fix error return code in sirf_probe()

 drivers/gnss/serial.h | 2 +-
 drivers/gnss/sirf.c   | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)
