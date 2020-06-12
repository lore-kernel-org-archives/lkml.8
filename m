Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 773CEC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 09:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57F692068E
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 09:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgFLJXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 05:23:30 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:46810 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726335AbgFLJXa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 05:23:30 -0400
Received: by mail-lj1-f194.google.com with SMTP id z9so10262330ljh.13
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jun 2020 02:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=GTlETfJAqgPvg35DMgD/h26+y1CLIe8qwd990R5lpVA=;
        b=hPAWDVjCTHgcAHgnJikGnkFA1W0jlhzGpB/LfWhVzAoy4KKfSfaZjavXoGXKaA3k0a
         hLlaceDCZTAqST5R42DVkFsTJ/BJjDQMtT0a/qeaPFSo8/HIKzevTxRpwdeqTuBdVz0N
         evY8JczF42SMjOlImkg9RnrQlMV21KvE4tuhCXTJbb6Q/+scWCjIX+1KCtCEmrf047kk
         Muzl/Ui2am5yjsD8iPrMLV61Led2cHOGzJIlCCMZMEHHm87fVggtipFAjXRRWv+6iAOp
         Q7c70NF2RqB1FdJod/Lpb6mR4GFfqC5iv4apehXQ/NULJYjLNoUq46Sgvo1x8LTAT2O0
         qErg==
X-Gm-Message-State: AOAM531unYbdggIDXQRmw5mXJPyYFTSGUfE5ZsZDNKvPqSbeFQKhEr/K
        reUClePcz5MDQXZYi61+sLc=
X-Google-Smtp-Source: ABdhPJzAB6w+a7tqY2PnFiKVfk26wEVoV99hp4Tyrd8LqPTvlSMbdJ+0xo+j4fSm5WcCPVaWVlORMQ==
X-Received: by 2002:a2e:750c:: with SMTP id q12mr6540338ljc.142.1591953807116;
        Fri, 12 Jun 2020 02:23:27 -0700 (PDT)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id a1sm2087395lfi.36.2020.06.12.02.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2020 02:23:26 -0700 (PDT)
Date:   Fri, 12 Jun 2020 12:23:17 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: Fix pickable ranges mapping
Message-ID: <20200612090225.GA3243@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pickable ranges mapping function never used range min selector. Thus
existing drivers broke when proper linear_ranges functionality was taken
in use. Fix this for now just by ignoring the minimum selector.

Fixes: commit 60ab7f4153b6 ("regulator: use linear_ranges helper")
Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---

I noticed BD71847 voltage changes for BUCK3 did not work as expected.
Setting voltage to 1050000 did not work even though this should be
supported. It appears I broke pickable-ranges support with
linear_ranges change. I expect the MAX77650 and BD71847/BD71850 to
be broken.

 drivers/regulator/helpers.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/helpers.c b/drivers/regulator/helpers.c
index e970e9d2f8be..e4bb09bbd3fa 100644
--- a/drivers/regulator/helpers.c
+++ b/drivers/regulator/helpers.c
@@ -486,7 +486,7 @@ int regulator_map_voltage_pickable_linear_range(struct regulator_dev *rdev,
 			continue;
 		}
 
-		ret = selector + sel;
+		ret = selector + sel - range->min_sel;
 
 		voltage = rdev->desc->ops->list_voltage(rdev, ret);
 

base-commit: 0b0c0bd818ef76a20f58c3cb1ac96a3056ccb681
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
