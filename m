Return-Path: <SRS0=sVLE=55=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B36CEC2BA2B
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 20:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AA9920732
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Apr 2020 20:43:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VT1Z726v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388538AbgDMUnQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Apr 2020 16:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388507AbgDMUnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 16:43:04 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0864C008748
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 13:43:03 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id np9so4344452pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 13:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=Jzl9zw+WWi+s6Kx4ZBqfebz2iDt6ayXKGXNZZjJo2Pk=;
        b=VT1Z726v06Ujmb0lEnnzZAtHRT4apvVynE5ed5Ktp3UGwkACAebRQ9zx2/tlMYHO5F
         rywIuPMKAUti5V6eK/5urkFIHTA2avL3pBcpv8gN80Owcdom1iv5VfXqsI01rnIAsKJM
         rhph9sz5PVaOOwI3UNEZQRB4o7SSiuZeWuVIfQT2JqASu3CFmZUlpXfo30toXIzJhl94
         Ho65K0a43xa3bx6V4R+etOwnd0T+g1i7+JU+XRFRXnG4mBVArkSUa7KSxBRF8wIRSwaP
         kS6YP99wSgijh6YDO/COskWhGnToZT/yF2UvsM9LBykI/oQZrBYpXSEtLHX9qU8G7Haq
         TQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Jzl9zw+WWi+s6Kx4ZBqfebz2iDt6ayXKGXNZZjJo2Pk=;
        b=SMVmJftWUdf11cZk0Gr3K7yIeKfv3tLE+bfSqL8FVVEoiQivdD6LK8IuVSohHZaar0
         1pP08yONXp3tmB3JtQC8xoIBBQDfphY7FsXt3pD6NFMo2aSNpQ9vYTbZ3tfIIszwl6tz
         8jVnnHBHJhJNEhDegVxFU4To8Soq6AITnz2BM+q4p+lbYr/mvApFX9VMWkugchkJ1D3c
         xXJubdg4lDBBrHopkuJhyXtlKBEsIL6BqPAy6JYKwke2SpTI6gm/IkOnI24OBIYEyI+w
         V+akqAicRUScbhprkNkHf7NwKzIrrejKF0+2h7VQJSt15nfqUTXU7SSnfhtC4tsmkKO8
         TjqA==
X-Gm-Message-State: AGi0PubFIsmRe2UhIHGAxwefjuMv67e0B12Pz61fvy3VMItBkQBI2AbV
        9p+xAXzaKvaqKLD3Kpvtc4RTMjjKGBo=
X-Google-Smtp-Source: APiQypIRvteVMg0gNs6DmMEEBBIlRcc/01DPdawXCFZi7iOutYc4cJYrlnAN1psu50sBspsa1M3cjw==
X-Received: by 2002:a17:90a:77cb:: with SMTP id e11mr24567922pjs.0.1586810583200;
        Mon, 13 Apr 2020 13:43:03 -0700 (PDT)
Received: from localhost.localdomain ([2601:1c2:680:1319:692:26ff:feda:3a81])
        by smtp.gmail.com with ESMTPSA id o21sm4763340pjr.37.2020.04.13.13.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2020 13:43:02 -0700 (PDT)
From:   John Stultz <john.stultz@linaro.org>
To:     lkml <linux-kernel@vger.kernel.org>
Cc:     John Stultz <john.stultz@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        netdev <netdev@vger.kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH v2 0/2] Fixes for deferred_probe_timeout cleanup
Date:   Mon, 13 Apr 2020 20:42:51 +0000
Message-Id: <20200413204253.84991-1-john.stultz@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just wanted to submit these two fixes for the
deferred_probe_timeout cleanup that landed in the v5.7-rc1 merge
window.

The first resets the default timeout value back to zero so we
have no behavioral change from 5.6. This avoids regressions on
boards that have "optional links" in their device tree.

The scond fixes an issue discovered by Yoshihiro Shimoda
and Geert Uytterhoeven, where if a timeout was set, things
like NFS root might fail due to wait_for_device_probe()
not blocking until the timeout expires.

thanks
-john

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>
Cc: Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Rob Herring <robh@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: netdev <netdev@vger.kernel.org>
Cc: linux-pm@vger.kernel.org

John Stultz (2):
  driver core: Revert default driver_deferred_probe_timeout value to 0
  driver core: Ensure wait_for_device_probe() waits until the
    deferred_probe_timeout fires

 drivers/base/dd.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

-- 
2.17.1

