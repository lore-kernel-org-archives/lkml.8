Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D243DC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 23:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2D1E206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 23:27:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="G7XdpGyw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbgHQX1I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 19:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbgHQX1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 19:27:06 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B544C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 16:27:06 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id t6so8388159pjr.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 16:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=MBN+SlhP2ntU2w//OB7YrvqOLp488Wvdr4EltW58bu4=;
        b=G7XdpGyw6bk61NHSfh6QhtjxlQQvyCpHb8SZvwjTJ+PYnaLyuHcfkf3D/IsCqJxnin
         AP/eeX4wd+0JflHEZoinwCF38mkqijshHM4Y9ZW5gsgIVlslBu1QU6mXsKo7nvzcxupJ
         P+gwu5ARyfXMCOJEZlNqLShYDDVqNYySIbLTY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=MBN+SlhP2ntU2w//OB7YrvqOLp488Wvdr4EltW58bu4=;
        b=FjLA7hsLwGJnECZHvfR3DO8Ig1dX5Cm5BpPaGEkQU2D4OpkiPwjWGDD0DeLWTi02G1
         yD1aJWFI9tjRRI8D0i74KJdy8jvS0fhI/jrvHmkPn407dyR9PJxqFYCq2ajh1qi+HjKl
         VR9FtAqkbl6IuIn0mUonqMCEVLkzT0uvPw7esU6HBbatF1xejcg1QQLGZhu/izCM2cTT
         o08UjEzadyfut89v8cu2K1zfMTRx9tHF2B2RbhRM4Z0eCzF8ZkWbmAQ8s08h/U//kn6w
         zPoavyGgSfEBfAjn5PSrn/7eff16ZLntzdJ4yAeEp31hMj/r7oKQ4pMNTzn8a4LnWIeg
         M1og==
X-Gm-Message-State: AOAM531qUH7/tCNN2v3YQ6SlhjI3FNtEu0r1lkciIf+NSwGymO9TDc7W
        xt0hNhIVeNgQ7FBwpgS+638FZg==
X-Google-Smtp-Source: ABdhPJwGyKIP+ggnM92kiclWyG7Ac1whzS2mV+vI2r7aFbUEGTxCyMOuT1Y8TsjZZi+gSAiqOvTf4A==
X-Received: by 2002:a17:90b:816:: with SMTP id bk22mr14883594pjb.185.1597706825159;
        Mon, 17 Aug 2020 16:27:05 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k21sm18954718pgl.0.2020.08.17.16.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 16:27:04 -0700 (PDT)
Date:   Mon, 17 Aug 2020 16:27:03 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, WeiXiong Liao <gmpy.liaowx@gmail.com>
Subject: [GIT PULL] mailmap update for v5.9-rc2
Message-ID: <202008171624.8E3C303@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Please pull this mailmap update for v5.9-rc2. This was originally part of
my pstore tree, but when I realized that mailmap needed re-alphabetizing,
I decided to wait until -rc1 to send this, as I saw a lot of mailmap
additions pending in -next for the merge window. It's a programmatic
reordering and the addition of a pstore contributor's preferred email
address.

Thanks!

-Kees

The following changes since commit 9123e3a74ec7b934a4a099e98af6a61c2f80bbf5:

  Linux 5.9-rc1 (2020-08-16 13:04:57 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git tags/pstore-v5.9-rc2

for you to fetch changes up to 5a4fe0624687e62919a5913dc7c937fbfcf61fdc:

  mailmap: Add WeiXiong Liao (2020-08-17 14:32:44 -0700)

----------------------------------------------------------------
mailmap alphabetizing and addition

----------------------------------------------------------------
Kees Cook (2):
      mailmap: Restore dictionary sorting
      mailmap: Add WeiXiong Liao

 .mailmap | 115 ++++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 58 insertions(+), 57 deletions(-)

-- 
Kees Cook
