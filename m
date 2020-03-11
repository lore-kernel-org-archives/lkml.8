Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62697C3F2D0
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 11:36:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32BBB2465B
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 11:36:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="epXS8b68"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbgCKLgW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 07:36:22 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35550 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgCKLgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 07:36:21 -0400
Received: by mail-wr1-f68.google.com with SMTP id d5so1791599wrc.2
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 04:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a3pvk8YM9KciTsoi8ZTo0J1S/sSYGSlU0IpIN/JdgKY=;
        b=epXS8b68jSfacixPIe996/Issuty7JuLN8tDTKxPy/9fL8ZoneFpxLQoKp55s/Xqrb
         yomyWspUaaoN7PPbyg3+1+dn1USNiC4R2gN3GrIlwzilyKRWugjvBFAVkFtSiLgU6c7L
         yJ2kz9qKA3wpwVLGa7ja7+b5uymfx2YuauBf/dmyNpbqkG9PhfaBYCY73QWPyuGggLKf
         VeziX3p8ojj9CZveIkORRR8MGnOfWObshMianlG0flWNvIcet9GPAkEOVnX0gdr/RSAn
         4s2g2ROl0Jdl5Bez/LDwwa1GgbUCDtDn/GoLHXic4DSOo9MSPaScEcnrEgzdTKNJhET6
         gGJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=a3pvk8YM9KciTsoi8ZTo0J1S/sSYGSlU0IpIN/JdgKY=;
        b=VWHmT2yV2ECPG7BCLsUJuea9WyIs/tEdBhlnXvME9ElI6qNWCQd87NFx4YX5bIXr7Q
         s7sWs7FVIGvNsKJq9yu4FBQYPu9GCy02MSthpOm3VGTYuPIMU36vwsjHEKmEy3zvwmcp
         w4yIEwfgFxZ8SpgTzJeiFGTjy+zUNjCMt3M6uQhdOsMBHIFThUgMdY3xgC3q4CQNokpH
         i5MW3wkKgsyUbMyCdyr9W4T/vEBgWpSK+6ldC5Ie6x6I43wnjBh64hWmRhUKBPAHojqa
         yrWv8LslV34cc5XxHZnzZi9ybA0NUZmr5XvzPaehoflVwzSTGeE4fS65ZymA3G2qyhR9
         rVbA==
X-Gm-Message-State: ANhLgQ1vwfldUaaUG0+pscKkliyvEzMirvz0t6i9YBeSrpkHaWsnsMQb
        kDMd2tDH+K8Em7kZqTngl4Af+g==
X-Google-Smtp-Source: ADFU+vvu2foe5tilScyQakEbJFDrry3CKe/s1NISiVxUkngdoUCD9DWM8A/xs/ohy3NDrj2Prqhzxg==
X-Received: by 2002:a5d:6591:: with SMTP id q17mr3933045wru.22.1583926578262;
        Wed, 11 Mar 2020 04:36:18 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id c8sm61650537wru.7.2020.03.11.04.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 04:36:17 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, vkoul@kernel.org
Cc:     pierre-louis.bossart@linux.intel.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 0/2] soundwire: add read_only_wordlength flag
Date:   Wed, 11 Mar 2020 11:35:43 +0000
Message-Id: <20200311113545.23773-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to SoundWire Specification Version 1.2.
"A Data Port number X (in the range 0-14) which supports only one
value of WordLength may implement the WordLength field in the
DPX_BlockCtrl1 Register as Read-Only, returning the fixed value of
WordLength in response to reads."

As WSA881x interfaces in PDM mode making the only field "WordLength"
in DPX_BlockCtrl1" fixed and read-only. Behaviour of writing to this
register on WSA881x soundwire slave with Qualcomm Soundwire Controller
is throwing up an error. Not sure how other controllers deal with
writing to readonly registers, but this patch provides a way to avoid
writes to DPN_BlockCtrl1 register by providing a read_only_wordlength
flag in struct sdw_dpn_prop


Srinivas Kandagatla (2):
  soundwire: stream: Add read_only_wordlength flag to port properties
  ASoC: wsa881x: mark read_only_wordlength flag

 drivers/soundwire/stream.c    | 16 +++++++++-------
 include/linux/soundwire/sdw.h |  2 ++
 sound/soc/codecs/wsa881x.c    |  4 ++++
 3 files changed, 15 insertions(+), 7 deletions(-)

-- 
2.21.0

