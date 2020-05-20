Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88487C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 06:11:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B54520748
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 06:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgETGLE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 02:11:04 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:37561 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgETGLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 02:11:04 -0400
Received: by mail-lj1-f195.google.com with SMTP id o14so2252340ljp.4
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 23:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=bnICOn/Ls9L7VkdJqYNqQPYwFGnRPfcq5kfoLGIdoVs=;
        b=ejmrwQlEqzpvyVXkrvCc6Dax3TVszjZT71gMNjPbEqiYgUZXufBGX7I8i/Hq0GPchp
         LrXA5OrNPU8etL3t3dG6TNW32lal/9V1B3uR0U4rynB52gP4fK0MA4ZhueCL6SLlFufc
         YTKc1Wi+Q2yEFtddrXQIP3BV8Gg/Wtgnd6akXa3huk4ThQlohyHNKN/gecQ7yImWfln0
         EKd2g6O1spW4yc6uw/arRGd/Y/fs7am6eiI5eJ2Z3zH6Yr4ruRMquol90HlrQFjVAUYD
         C69afgB/jkLJsrnd32/Su8MNKI71NnJNUbQoUK995sNcE4tkBvgffLDrAj0CO/ORMHZy
         q3pQ==
X-Gm-Message-State: AOAM532SJgyPTX5cPBRaYckqLY29x5wvQv9n10JeYsmVjkRijuxAjLRG
        WLTv0svoQAWMkVhkXUx9tr6UcmTExN4=
X-Google-Smtp-Source: ABdhPJz3c5S+JD5sGw2mH6VDFQM/mqWWFCmL0T7a3eZhn6reEZD3evimiGFq4sFKXR7RZPHonOjchw==
X-Received: by 2002:a2e:8347:: with SMTP id l7mr1897381ljh.243.1589955062203;
        Tue, 19 May 2020 23:11:02 -0700 (PDT)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id t22sm786928ljk.11.2020.05.19.23.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 23:11:01 -0700 (PDT)
Date:   Wed, 20 May 2020 09:10:22 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Michael Turquette <mturquette@baylibre.com>,
        SebastianReichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] MAINTAINER entries for few ROHM power devices
Message-ID: <cover.1589866137.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add maintainer entries to a few ROHM devices and Linear Ranges

Linear Ranges helpers were refactored out of regulator core to lib so
that other drivers could utilize them too. (I guess power/supply drivers 
and possibly clk drivers can benefit from them). As regulators is
currently the main user it makes sense the changes to linear_ranges go
through Mark's tree.

During past two years few ROHM PMIC drivers have been added to
mainstream. They deserve a supporter from ROHM side too :)

Patch 1:
	Maintainer entries for few ROHM IC drivers
Patch 2:
	Maintainer entry for linear ranges helpers

---

Matti Vaittinen (2):
  MAINTAINERS: Add entry for ROHM power management ICs
  MAINTAINERS: Add maintainer entry for linear ranges helper

 MAINTAINERS | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)


base-commit: b9bbe6ed63b2b9f2c9ee5cbd0f2c946a2723f4ce
-- 
2.21.0


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
