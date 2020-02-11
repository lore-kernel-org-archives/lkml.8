Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69CD0C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 09:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A78D2051A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 09:22:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgQZbLuO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727805AbgBKJWP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 04:22:15 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:47023 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbgBKJWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 04:22:15 -0500
Received: by mail-wr1-f66.google.com with SMTP id z7so11252147wrl.13
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 01:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=nUWzJepeO8PjNg3axFni2Tq1paDQdlPMubFeA83+qK8=;
        b=mgQZbLuO3ncl1qvdDTrwLI2Ei6/TFSnWqgPp05KdJFvUhFKgUzDmarzsXAnyfmI5Nn
         cDZKrt2grBYJXdBkDBcQGd57IQ5FDCAz4v6ZJ+v0CcHokBhVANONxA5iPJaoLcAZtCQa
         iNvyd4Y/PBAsaOP8la/vjfdmCqnEQ+75Z8IarkVKlV5lscEQHUZChsAiiWGLA/hCJsDp
         vDe+rJOM0rg8PkFLvyYcp3/3agIyJoO/3mEIfrDCsWJlZuRbIuE7giVZ+426L3jw7UB1
         lquqgSIpncdr3d4eAsJLtYVX13eDFcB+v/7N382hTQnLzxPVOHd31EfYTohfD268we5G
         nxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=nUWzJepeO8PjNg3axFni2Tq1paDQdlPMubFeA83+qK8=;
        b=aLK18Hmq1Tf5R9PWkmm6Keh5xZJYqE4kc1jhKtStJm9r8mxpwmq5N8JjTsuU4p/vgb
         zi4C+dUdjQsvLzy6SK6nLnMhoUyb1sJLTumxTFqoZGGZh9TL3LhCaC3ff6e292YzILfU
         Ij/qi1z0BxsGEQuNiH2wvl9tnxfmQFqpFoxuwLzmoNj/fnC6bY360m3SlotXoW6VwjPD
         EoE5yeQAnkCO6KbQmGHQ+w2g2BSNRg7YeRa7EFsM/N+r1rsF34ql4UQ/yKjJmTLAAMvd
         VGm+xo57pXYVxFXTUU1LN3m6t+QSBU3Mpfj8IshLlu9p1KQKIZeQrA/4oWZgSpSfvuK5
         mLWw==
X-Gm-Message-State: APjAAAVRoFWa0bMPq+GyrdgknFmHSAFk81lPD8+ril4xyvjke97E9tzS
        iZBRRw89bcaiU+pX16DGKfbgPzZhW4o=
X-Google-Smtp-Source: APXvYqybp72IycU6BC7bQav7xevh/OBGYXZyvEJb5mbHU09SESDWFEbGRgF+kitOaDsCUHQaER6xtA==
X-Received: by 2002:adf:ef92:: with SMTP id d18mr7192940wro.234.1581412933453;
        Tue, 11 Feb 2020 01:22:13 -0800 (PST)
Received: from ogabbay-VM ([31.154.190.6])
        by smtp.gmail.com with ESMTPSA id m9sm4455566wrx.55.2020.02.11.01.22.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 11 Feb 2020 01:22:12 -0800 (PST)
Date:   Tue, 11 Feb 2020 11:22:11 +0200
From:   Oded Gabbay <oded.gabbay@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: [git pull] habanalabs fixes for 5.6-rc2
Message-ID: <20200211092211.GA23598@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Greg,

This is habanalabs fixes pull request for 5.6-rc2.
It contains two important fixes for the reset code of the ASIC and another
fix to reference counting of a command buffer object.

Thanks,
Oded

The following changes since commit 95ba79e89c107851bad4492ca23e9b9c399b8592:

  MAINTAINERS: remove unnecessary ':' characters (2020-02-10 15:29:09 -0800)

are available in the Git repository at:

  git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-fixes-2020-02-11

for you to fetch changes up to cf01514c5c6efa2d521d35e68dff2e0674d08e91:

  habanalabs: patched cb equals user cb in device memset (2020-02-11 11:12:47 +0200)

----------------------------------------------------------------
This tag contains the following fixes:

- Two fixes to the reset process of the ASIC. Without these fixes, the
  reset process might take a long time and produce a kernel panic.
  Alternatively, the ASIC could get stuck.

- Fix to reference counting of a command buffer object. It was kref_put
  one more time than it should have been.

----------------------------------------------------------------
Oded Gabbay (2):
      habanalabs: halt the engines before hard-reset
      habanalabs: patched cb equals user cb in device memset

Omer Shpigelman (1):
      habanalabs: do not halt CoreSight during hard reset

 drivers/misc/habanalabs/device.c    |  5 ++++-
 drivers/misc/habanalabs/goya/goya.c | 44 +++++++++++++++++++++++++++++++++++--
 2 files changed, 46 insertions(+), 3 deletions(-)
