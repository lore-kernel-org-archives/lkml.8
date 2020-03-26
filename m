Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 743EBC2D0E7
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 01:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA9B2073E
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 01:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltqiGJtx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgCZBrN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 21:47:13 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:45519 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727561AbgCZBrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 21:47:13 -0400
Received: by mail-qt1-f193.google.com with SMTP id t17so4013179qtn.12;
        Wed, 25 Mar 2020 18:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MGtWCUE+uLFl5+4WGJ6FqY8rhfqoAZ5ZAEsAc4trkZs=;
        b=ltqiGJtxYKfKmBd2X3uQeeC1CB7LoxZAoGGHqnmmcWQe3jdwrVNbvwFGZdBolLPMXO
         DPq/Ns0wEwrdp6+KCfzekylFb7yKyV97QkUigEHc2S05USUlgcs+qTeLi4xY1rBad/Nl
         8hNAk0seTOtm0wgE8ucdH+XVvleMD/hX2ORbldQsoWJKHzv3VVWO8DZAjG/QDPkAr1fl
         PhBoth93LhMh/NvgvBA40iCEM7R/2oQ497BQ1zE6iu2cElbILGk4od8lwj7wSivL07fQ
         /VHovnLi7Ry1HIeVg+qXZQVNZe7Dy4Ix8v7eOkyB54xm2JwNbHHdAbq77JgAeMl8DcjF
         WmOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MGtWCUE+uLFl5+4WGJ6FqY8rhfqoAZ5ZAEsAc4trkZs=;
        b=N4ZDIH9CbXyjHmC4UFBLk9S6gfbDVYOn5Ay3htQ0nDa7oTdOL1n2G8aWEg5MRjBtqE
         AAQ0RfiWDNmj+5QCa18JceVST5PNmbLYg2XsV+oSwqtdTpqr8RlFVQHVYc4bg6w1/9oU
         MFTa8fA+f7/2bpeA2UDfO3EDMohKbox9VSdS+kyY+gyVM2oRptmzhNM7NenInGFwgOsO
         OboKdGOyJveXnMbLC0MzMUzcRdBzqNyXFwIUmxwmPGvhcZjbQYo6Zr0MVOpLwmCif2Ge
         T8z9m9//7i3w4aWdhV4HzQJdSW40fQMart1oA/kBVFG4BvRwU5AUVqcV92oRfMpKqEyD
         M2Rw==
X-Gm-Message-State: ANhLgQ22grTJIfev5OdVKFHcd8TIx8Sp1kxZDmjrkhZpFrcZI9+OtEtW
        Yf8cR4FG0fnFDmTqtTyIVh4lN4zs
X-Google-Smtp-Source: ADFU+vtytdWCaVsgkuuzqgdL1SaQsMSfBx3mJkY2Um7hkLzrVcoaW7DF+RGEQryoI5ARhhibaZ8SyA==
X-Received: by 2002:ac8:554f:: with SMTP id o15mr5922854qtr.154.1585187231831;
        Wed, 25 Mar 2020 18:47:11 -0700 (PDT)
Received: from localhost.localdomain (c-73-88-245-53.hsd1.tn.comcast.net. [73.88.245.53])
        by smtp.gmail.com with ESMTPSA id h129sm463552qkf.54.2020.03.25.18.47.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Mar 2020 18:47:11 -0700 (PDT)
From:   frowand.list@gmail.com
To:     Rob Herring <robh+dt@kernel.org>, pantelis.antoniou@konsulko.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Alan Tull <atull@kernel.org>
Subject: [PATCH 0/2] of: unittest gpio unittest error exposes tracking error
Date:   Wed, 25 Mar 2020 20:45:29 -0500
Message-Id: <1585187131-21642-1-git-send-email-frowand.list@gmail.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Rowand <frank.rowand@sony.com>

kernel test robot reported "WARNING: held lock freed!" triggered by
unittest_gpio_remove().

This warning is from a bad kfree() call from an unexpected call to
unittest_gpio_remove().  The unexpected call is due to an error
with unittest overlay tracking.

Patch 1/2 fixes the kfree bug.

Patch 2/2 fixes the unittest overlay tracking bug.

Frank Rowand (2):
  of: gpio unittest kfree() wrong object
  of: some unittest overlays not untracked

 drivers/of/unittest.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

-- 
Frank Rowand <frank.rowand@sony.com>

