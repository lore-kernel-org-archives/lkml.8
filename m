Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98335C4724C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:59:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 753D320725
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 21:59:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aGESkxJL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgEGV7J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 17:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726480AbgEGV7H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 17:59:07 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42EFAC05BD09
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 14:59:06 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id g13so8242321wrb.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 14:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t3RcuTfATJPIk2PpFOWFeubdL2oxOOoFafQJ/eMWyS8=;
        b=aGESkxJLEnPKhYPOXsknxCmACG2VOHSTPvA3IkN8bDuJ52fDGV+2/pJTF83FFTS/qm
         KLxfwvfJFFOTMSVeX4JD/RnYfEWU1K1Q9c4yHMwYeamr866iU7vJSUQ7EYDxl0xRySYF
         qeYoqhgtci9DihQZWS1Ln5i6gVQPq6DuLYkryznlEzVpu/Gw7ixsIvWhzEkBPDIQO5t/
         F9HENQtUYfAXtd4KAJDj34UuAwguug4vl1Yj8Rxttq24GUO6EcxL5UqP9HU8hoKuMWY4
         RzziAHu6pa8HjiuvyEeSTK/WE/YHO4pDUW9bvIkTy64L5QauFi1EZZsBG+QMEeAnGRr4
         JkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t3RcuTfATJPIk2PpFOWFeubdL2oxOOoFafQJ/eMWyS8=;
        b=JCvx4CptZc6mk2OHmCQ6mcC0413R/6Fl81iWq+P+zy0eessQxsKEvCAgaaVqqa9WbA
         f8LEoS77cLgZuKN64YGVVf0XLDeW7XfmvtEU73AhPPJNY2ec/7C/61M2WFFtvV6CZ9Xl
         VsYLr5CdcOKOl9DCGo7Wh2964IxjW9kBNHJ8tqVc6d9j/tR3ncblPkqKNdvrbKh2YUKY
         +4wMgDvXyojXd6sIcVlQ9ecczbYEcU2fjo85arJlFOrOQRDaISJeoTd0bzUgi2tOijDU
         syEWWW7/UxQ+QDKzCOdiLGsEy12mwJ1OLLgUrYo8CnO9sts67IUKFFAuej9mtj1s/XcL
         PvBw==
X-Gm-Message-State: AGi0Pubyzsl++CqCf4gtjyQewSmLG9D5vKqyw8UoS3svGSRJ0jh/34Rj
        okgx4tgUaVgWxa7IS9DI9HS7AQ==
X-Google-Smtp-Source: APiQypIw6C1LouSvwYnIQbTEFcF4XymG+MeqV9Vea7gsPVFW65Oc1KDuBjhZii2HuPxdNXC9lsGzXw==
X-Received: by 2002:adf:f907:: with SMTP id b7mr17699159wrr.203.1588888744591;
        Thu, 07 May 2020 14:59:04 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id z18sm9814245wrw.41.2020.05.07.14.59.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 14:59:03 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     heikki.krogerus@linux.intel.com, linux-usb@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        nikolaus.voss@loewensteinmedical.de,
        andriy.shevchenko@linux.intel.com, garsilva@embeddedor.com,
        keescook@chromium.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH v2 0/1] Add USB role switch to tps6598x
Date:   Thu,  7 May 2020 22:59:37 +0100
Message-Id: <20200507215938.1983363-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2:
- Updates the git commit to include a link to the TI document which
  describes firmware configuration - Andy
- Pads out the description a bit to include information on baking the
  data-role into the firmware with the referenced utility.

V1:
This patch - adds USB role switching to the TI TPS6598x. It has been tested
out with a ChipIdea controller inside a Qualcomm MSM8939.

Right now you need to have configured the TPS firmware with the TI
configuration tool so that the chip knows if it should initiate or accept
data and power role swaps.

https://www.ti.com/lit/an/slva843a/slva843a.pdf

Heikki mentioned that on the ACPI systems the firmware had been
pre-configured to do data/power role swaps. On the hardware I have this is
the case also, which is why I did't invest more time in adding DT bindings
to control data/power roles that I don't need or necessarily support with
the reference hardware.

As-is this code will do role-swappping nicely for me, and I think should be
safe on existing ACPI systems.

Bryan O'Donoghue (1):
  usb: typec: tps6598x: Add USB role switching logic

 drivers/usb/typec/tps6598x.c | 56 +++++++++++++++++++++++++++++++-----
 1 file changed, 49 insertions(+), 7 deletions(-)

-- 
2.25.1

