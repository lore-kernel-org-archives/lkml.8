Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B3FC5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 08:27:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA6552076C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 08:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="e8dl+Udn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbgCRI1O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 04:27:14 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:43460 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbgCRI1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 04:27:12 -0400
Received: by mail-pg1-f181.google.com with SMTP id u12so13246070pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 01:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5LGJ1tadBVSKcXHWmxYL9RsY79DWIeIh5wKubnO5eqk=;
        b=e8dl+UdnULDH7XYMFNjJmuLS6sr66005KzMrcl9E+V3VoFx05HjvO7RQSNdU3ghaz8
         Q33IZFKTfLuuV2UEmgENXMwlL4GJ5ZGoWgCw/rVr8Dk/OB60kYw90aArMAJPWrxFTWjb
         A9+oCSEQABtZCuvwV8fQfvNVVjG1pyk3Q274b2+QgDjyAs0z9vtEXTVKqlexteUwHjHX
         I1TD5yvw5EWCHxX6FqwK5wJC8+NPPvrzzX/gy2yZbfDSrQ1kMBFUnprUjynugofCz8gA
         KWeEH6ztWip0/HbPthW6yFu5oxajfN4xXYhrmVI4jD1N4+0K3bhN+2EhWM4DIw9AyCU2
         MC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5LGJ1tadBVSKcXHWmxYL9RsY79DWIeIh5wKubnO5eqk=;
        b=FGD0J6B6G4L9JWTDQB+hAGLsR6vp73d7pmtXlfOlDK6h67PcnsIfAeLV3aI/VcYZEk
         HXt0/RQR7fwQE3DtiuJZ1Db787UBOp4cvs5RgPDzF2O14gUhArA1tMPzur+3PKZdH1X5
         iUK5BSB/RmK7Jnv4WPqE7duiHCTYaAKgnu/2o2I8/Lb4mKmCn83vmwFwft3WU0Kfq+QH
         P/ftMAAUl06epSutYHhZkv38ZrblCRejr1JTbx14En1vxw2KYviX/JJ4zVr/EUjXBK8Z
         KSbTnlgTSrRbTzGuGsSjx3pDL/9t/MR1AAh+mLMlmJZnKVjZO+qbvQUj+87+aCWDTl8O
         HSnQ==
X-Gm-Message-State: ANhLgQ2xKGrFbuNWF0Vscx+nNIUV36WNKlO2FmAxrPUNgFCY0GipCb7q
        K3UP0wTz7MtjSjTPO2AGjkXqSCj9xlc=
X-Google-Smtp-Source: ADFU+vtzMfXeCeHxOSeg+6PKfpDdbNC5fJZ5fLgsY4UNtVtABqiqbRlsTey5zSb/YgEPIRFuWf+OLg==
X-Received: by 2002:a63:5f13:: with SMTP id t19mr3302456pgb.265.1584520029786;
        Wed, 18 Mar 2020 01:27:09 -0700 (PDT)
Received: from localhost.localdomain (59-127-47-126.HINET-IP.hinet.net. [59.127.47.126])
        by smtp.gmail.com with ESMTPSA id 18sm5492148pfj.140.2020.03.18.01.27.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2020 01:27:09 -0700 (PDT)
From:   Chris Chiu <chiu@endlessm.com>
To:     Jes.Sorensen@gmail.com, kvalo@codeaurora.org, davem@davemloft.net
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com
Subject: [PATCH 0/2] Feed current txrate information for mac80211
Date:   Wed, 18 Mar 2020 16:26:58 +0800
Message-Id: <20200318082700.71875-1-chiu@endlessm.com>
X-Mailer: git-send-email 2.21.1 (Apple Git-122.3)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset fills the txrate, sgi, bandwidth information
in the sta_statistics function. Then the nl80211 commands
such as 'iw link' can show the correct txrate information.

Chris Chiu (2):
  rtl8xxxu: add enumeration for channel bandwidth
  rtl8xxxu: Feed current txrate information for nl80211 commands

 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  | 21 ++++-
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 77 ++++++++++++++++++-
 2 files changed, 95 insertions(+), 3 deletions(-)

-- 
2.20.1

