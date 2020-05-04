Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C960C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:13:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20812206B9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 18:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r6pBRaZe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732321AbgEDSNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 14:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731918AbgEDSNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 14:13:37 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80754C061A0E
        for <linux-kernel@vger.kernel.org>; Mon,  4 May 2020 11:13:37 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id y4so10655441ljn.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 May 2020 11:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=noyhhByb12LN4LKrdHZP/yohxdBTg9eACOZjHEQQZSw=;
        b=r6pBRaZeaSe6YLtjSricU/1PdZ4Z/UNZt8MLyfVqVNUDNKGKZbCPVSfVa1VWqlczTE
         3exkc6YflKaC+zwu/U/e0tp3BY1dl5wdsa+zeiUi/QFCxv/afDvZ1xaGH1npNS7AHj51
         jzBeNaIXtnkcr8fahBzZoBnEQd3EST4uUUWlUGLuUns8PByZamCIJQHiasROr+hHc/1P
         Ll+Llg0743huW2Dqb6Kt4eBspyn1ebrROyB8PCFVhwc93N6tx/5Zf0YQTWInI1NMvglp
         dpMMFV4C56tsrb4joX+RXCCawIGPlfmy0sT187WVxJ5JpJrgjhAcoNAIII4GXAI8eDGZ
         a8TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=noyhhByb12LN4LKrdHZP/yohxdBTg9eACOZjHEQQZSw=;
        b=JFGLdYRdNAwl86HxBAnicEAUIM8f1SawxNetYKeFFXNHOFjlt4k/2HRz0ij+C8Y3IP
         MU0KQJiXAj95OvnQFiFpAW8vpbHEGHSH+axj7gF1f2UwTBjLWvlkPON+gRQto7z8WK2Y
         OVHVVC3wyUL5RscUTIFLTqV5mcQ50637cVeqJfhpcGXw9j0mcYaILaLCUJU2Kcs0yd5c
         pdsKRpksypGfIYdEzzaHqucYi58vlI/DRbOZfY2pbnvivdqaaulqUygL2NSMiv66Lxnj
         qpM6to2yGi5HgZMO6D5XcPPOT/4vQc2adhAqWjBDnffUPrwJiyd4m59ySq2PSHEe32S/
         nlZQ==
X-Gm-Message-State: AGi0PuZlGV8HUYTVwNzO5bqRFdyaPZxXGLvsMCT1Yy3cgOveqMaQH/L9
        cCz4hR2WpLUo3lf5UY1NtcEvZA==
X-Google-Smtp-Source: APiQypIXsSBpPqvz5nwBaR6TohrSjdXOt+8TvHMn4JimyxDTWHqEZSW6G48ENPGzKPER4VorYMz00w==
X-Received: by 2002:a2e:3017:: with SMTP id w23mr11282519ljw.150.1588616016018;
        Mon, 04 May 2020 11:13:36 -0700 (PDT)
Received: from jade (h-249-223.A175.priv.bahnhof.se. [98.128.249.223])
        by smtp.gmail.com with ESMTPSA id r4sm6033018lfm.28.2020.05.04.11.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 11:13:35 -0700 (PDT)
Date:   Mon, 4 May 2020 20:13:33 +0200
From:   Jens Wiklander <jens.wiklander@linaro.org>
List-Id: <soc.lore.kernel.org>
To:     arm@kernel.org, soc@kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        tee-dev@lists.linaro.org
Subject: [GIT PULL] tee subsystem fix for v5.8
Message-ID: <20200504181333.GA11018@jade>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello arm-soc maintainers,

Please pull this small fix for a Smatch warning in tee_shm_alloc().

Thanks,
Jens

The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:

  Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)

are available in the Git repository at:

  git://git.linaro.org/people/jens.wiklander/linux-tee.git tags/tee-smatch-for-5.8

for you to fetch changes up to 1115899e7aad71bc36100c3fa1d0b99cff9263e6:

  tee: remove unnecessary NULL check in tee_shm_alloc() (2020-04-20 13:12:01 +0200)

----------------------------------------------------------------
tee: remove unnecessary NULL check in tee_shm_alloc()

----------------------------------------------------------------
Dan Carpenter (1):
      tee: remove unnecessary NULL check in tee_shm_alloc()

 drivers/tee/tee_shm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)
