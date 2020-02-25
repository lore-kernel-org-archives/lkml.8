Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F86EC35DF2
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 05:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15A1F24682
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 05:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HGakzGud"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgBYFIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 00:08:35 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38424 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgBYFIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 00:08:35 -0500
Received: by mail-pf1-f195.google.com with SMTP id x185so6541216pfc.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2020 21:08:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=tqUZYiy81UZHq8KwguRSjJqW3NIJKHOMPFN5dA6hUv8=;
        b=HGakzGuddi3jXQkWHnNveg1vOMeIzRUtO/HXDf4I2PUzHfltbjm1Qezj+1200nLeOB
         TQvKVErZTc5ASbCnmw+DEp1J0aTGRROvPcxXLhkOhmFlbwjoca4lTNscoG8v3YySwblG
         Tv7aOi6vW0mj+pArzFrotksKu9IMk6MiwwrmDodrY1/X5U51Le3pXnoRpcW1kF8bicPZ
         d10DqU4SEZ9Imy5zD+ds94sLfJPaFa7cpdFCuxwMCg7xjk/fu8OlPoCLglRW3DkIcCWl
         ZNR7NukXTFSf/c9NrJRxAkIBcaMiGanlWaynkU5LP+2+pVU7o5bb0NWxWW8u3ajLM/tN
         6ZFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tqUZYiy81UZHq8KwguRSjJqW3NIJKHOMPFN5dA6hUv8=;
        b=E9rTp9nQw9wIaRBzJ9D3F2xi6St0sWs9CU2rOALkiQ4zv3XSMh5/XH/fJhvrq5bzfE
         j5ZV6S1xt+WcikhjjsCQuXdq/l1SxU9xPgFDgUdlCQy8bsc/9ifF9NKEQoxg1slyDP2f
         IOAcyBXqIxtpHfq7TyfKgMaiYENXel6LOLKWzsprbh1WxO9jpeh+g1AP2rlsjRFmBuS1
         ucdtVvfkO3L75ZHaryl0EIptvipiMKQmN+j9MsW92lb8C/PO8Pr25tw8TrgK+6O36E/n
         ZF2AyKdpd3fSi0JJNX58jWyo5t0TSrJEF8X/AQi9gCx0M4yFp7FDGRUkWAa1BvIXUcjw
         2c/w==
X-Gm-Message-State: APjAAAXGqrGVoID8HvjBX8eQxmslmLiJ2A6SCfobodnNxlGmXPJYyWIn
        ihs9G6PdbKPAY+9YpYZnxfRBKZal1pw=
X-Google-Smtp-Source: APXvYqz6IE9jh60Xr9+8h5LussuaMmJSlBt6AR00pDT9XEyDZcJ9EfJ4du1eFt5MYekdaXcI574iUw==
X-Received: by 2002:a62:6342:: with SMTP id x63mr54999297pfb.103.1582607314399;
        Mon, 24 Feb 2020 21:08:34 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id r66sm15156450pfc.74.2020.02.24.21.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 21:08:33 -0800 (PST)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Todd Kjos <tkjos@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v5 0/6] driver core: Improve and cleanup driver_deferred_probe_check_state()
Date:   Tue, 25 Feb 2020 05:08:22 +0000
Message-Id: <20200225050828.56458-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series goal is to improve and cleanup the
driver_deferred_probe_check_state() code in the driver core.

This series is useful for being able to support modules
dependencies which may be loaded by userland, far after
late_initcall is done. For instance, this series allows us to
successfully use various clk drivers as modules on the db845c
board. And without it, those drivers have to be statically built
in to work.

Since I first sent out this patch, Saravana suggested an
alternative approach which also works for our needs, and is a
bit simpler:
 https://lore.kernel.org/lkml/20200220055250.196456-1-saravanak@google.com/T/#u

However, while that patch provides the functionality we need,
I still suspect the driver_deferred_probe_check_state() code
could benefit from the cleanup in this patch, as the existing
logic is somewhat muddy.

New in v5:
* Reworked the driver_deferred_probe_check_state() logic as
  suggested by Saravana to tie the initcall_done checking with
  modules being enabled.
* Cleanup some comment wording as suggested by Rafael
* Try to slightly simplify the regulator logic as suggested by
  Bjorn

Thanks so much to Bjorn, Saravana and Rafael for their reviews
and suggestions! Additional review and feedback is always greatly
appreciated!

thanks
-john

Cc: Rob Herring <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Kevin Hilman <khilman@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Cc: Todd Kjos <tkjos@google.com>
Cc: Saravana Kannan <saravanak@google.com>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org

John Stultz (6):
  driver core: Fix driver_deferred_probe_check_state() logic
  driver core: Set deferred_probe_timeout to a longer default if
    CONFIG_MODULES is set
  pinctrl: Remove use of driver_deferred_probe_check_state_continue()
  driver core: Remove driver_deferred_probe_check_state_continue()
  driver core: Rename deferred_probe_timeout and make it global
  regulator: Use driver_deferred_probe_timeout for
    regulator_init_complete_work

 drivers/base/dd.c             | 82 +++++++++++++----------------------
 drivers/pinctrl/devicetree.c  |  9 ++--
 drivers/regulator/core.c      | 25 ++++++-----
 include/linux/device/driver.h |  2 +-
 4 files changed, 49 insertions(+), 69 deletions(-)

-- 
2.17.1

