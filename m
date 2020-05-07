Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C20C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:45:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01F02207DD
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 12:45:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cgkCoFI6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgEGMp2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 08:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725939AbgEGMp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 08:45:26 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84605C05BD09
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 05:45:24 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id h4so6362071wmb.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 05:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tc54G0swG8CTxHpRzIJicQ+dWaw02lBcaaXJW9A91/A=;
        b=cgkCoFI6x7ULrpuxlc3Pot4OLbdagWZR3Riu4oqoLyuTnqTUtaw/P1oSLU9GUNZLBh
         uBzz6Tn/obB4yHCjWHFNB00yoG2NX2PzJx+68S20f2iamTkB9rBhE3CbIO7K8/ng535Z
         PP/4T6ahdJEid5BH6ota2i6158SrfDoU4hCMjRSEUZY/cXcZ36thF7i5KpFYhRHsAwst
         hFHdPMNWIhlDUfdOgxISjBLDq3GESj9wmW2pMwoNIwiF+xfOYB3giQ1rvFGg04+KbTYJ
         7qcqWRLaP6XKGxPpD50zmm8Ljzoy5q3Wn6QG1dxtCg+vr1Rr83WXfYIYUnLpjD/5IZ7G
         hPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=tc54G0swG8CTxHpRzIJicQ+dWaw02lBcaaXJW9A91/A=;
        b=pNgt9Z2WGf2KXK5eYJIcYOsWobpnShkm4/PlrvpSrFRsy3FlGnfjso119Hf89f10w0
         x+dkNuuwgSJcBhfThaHPE+9/1Ad29xOgjAlsx5qkGWrcSutKEWhUFpxL6dLnfvnkWWkw
         LUclS1uFXNTWXcE9cIEHQaVY1HtXgTOLkw96uh2rbpox7JvCP6MdXNezWZxhzeM4a43P
         HTinAvWdC7laRX79CZE/fXLrG/uag6RJCPq4Auq1vhAQF5SKOU6GVmul+943l5u1zFzR
         afm22U/abcxdu8qdZOICLZde0NKN72/b2ms6u2a8QiifAAZRtAcE8nVwQP2Z03eKUObj
         lsVg==
X-Gm-Message-State: AGi0PubXBWJovp63QFK9zWlIq6yHCyN8kB/y/4WD78v/xoiHvkWkkjbI
        qtiUL7efxttWHZFS5+z8RuRPsQ==
X-Google-Smtp-Source: APiQypJUW4IMne2lqh0irngXT2iCewbj1NbU/g07pTPKmQaWFrKPK5bXCb6d0RGyftkr/I2AfTCWsA==
X-Received: by 2002:a1c:4d17:: with SMTP id o23mr9736752wmh.47.1588855523069;
        Thu, 07 May 2020 05:45:23 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id c17sm8034106wrn.59.2020.05.07.05.45.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 05:45:22 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     heikki.krogerus@linux.intel.com, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        nikolaus.voss@loewensteinmedical.de,
        andriy.shevchenko@linux.intel.com, garsilva@embeddedor.com,
        keescook@chromium.org,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Subject: [PATCH 0/1] Add USB role switch to tps6598x
Date:   Thu,  7 May 2020 13:45:55 +0100
Message-Id: <20200507124556.1774311-1-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

