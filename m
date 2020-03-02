Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 502C1C3F2D2
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 04:27:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10F6F24695
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 04:27:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5i2Z6zA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgCBE1a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Mar 2020 23:27:30 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:33282 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726758AbgCBE1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 23:27:30 -0500
Received: by mail-io1-f68.google.com with SMTP id r15so1415969iog.0
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 20:27:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=RdvpJWjBPPcTWPXC9aegdky80sgA4x6TiW5eQN2gIvo=;
        b=b5i2Z6zA3laP6Wvqu7d7rWWkDp3EvbyJEcKOnSBWWbEuMrcdrpZpvg5kNPRoX8eTC3
         AkAMcStj2LJl/27gpbM8ESp6kl6Mis7EDH+/cRxTLraEcosD62HATY9ERvUcyCRtXPud
         FKw9OQda+mHDvVTFnFM8iYJTVxRHhMRnAUHL3TW3iRWOGqRSxIdemDyBl5dzpvZ4Xzw5
         7RU+sbev3INAhOcpj5PK/avfXbpZ/OSywFtyQ3kMVO4rZY85OWK2Nq8DcHjY8il1EtQ7
         7+cESrFS7m7hHPICvLz8vEoPmDIXwk3FjKhY3X8LsBd1Y0++2dRjztdqqqzuAG/ltzu7
         jQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RdvpJWjBPPcTWPXC9aegdky80sgA4x6TiW5eQN2gIvo=;
        b=j0FnLw6kFdWQClclGJB11VO9S/IVaHtnQ7WtwXC9BsQD2JDRFCP22pHil+JHZ52YTQ
         yf8BtQT/x265y5uEBjIc1S/jINU/am5pwih2NlOtuIkFMad5b6LX2GgLbacg/SRr2e9L
         NTZWF3VL+5ZQXj0kJQWVYgLwujVykzqU2eSY9TtiWCcvNRa1Qqm8gLmbyApSDd8NLrEI
         19zM239EMp5JJ73xT+fZOm/52CMcFgK+ImT3dQa7QxmUrWCyKnRnWhl4PHbAB66R4e6J
         9pcO50tBfA31h6ePkurpmVuhchg1ySThBAtqZTzFBgWq8W2Hqr4vFcveEROiTZF2Nkwm
         UGwg==
X-Gm-Message-State: APjAAAVBlLi+Q3rJdg/2NFv4xGh+Vn7XyaxmIFktk/U1sd5gSzSi+2Pt
        8/nOXNA7P8fOfHhDDAJCgV5RyNUd
X-Google-Smtp-Source: APXvYqx5R+c3/auidYizgXuUo8fAR1AHydspcsqQHoZMezCpYtvGiXzNQ/v3e6on+4FbxswG8bRVGQ==
X-Received: by 2002:a05:6602:193:: with SMTP id m19mr10463265ioo.222.1583123249667;
        Sun, 01 Mar 2020 20:27:29 -0800 (PST)
Received: from bifrost (c-71-196-210-244.hsd1.co.comcast.net. [71.196.210.244])
        by smtp.gmail.com with ESMTPSA id q87sm4986055ill.74.2020.03.01.20.27.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 20:27:29 -0800 (PST)
Date:   Sun, 1 Mar 2020 21:27:25 -0700
From:   Cody Planteen <planteen@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de
Subject: [PATCH 0/2] Reed-Solomon lib parameter fix and test fix
Message-ID: <cover.1583122776.git.planteen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Reed-Solomon API allows creation of an invalid code symbol length. The
recently added test also prints a lot of RCU stall messages. This
patchset fixes both.

Cody Planteen (2):
  rslib: Minimum symbol size for a Reed-Solomon code is 2 bits not 1 bit
  rslib: test: Yield to prevent RCU stall messages and fix comment typos

 include/linux/rslib.h           |  4 ++--
 lib/reed_solomon/reed_solomon.c |  2 +-
 lib/reed_solomon/test_rslib.c   | 15 +++++++++++----
 3 files changed, 14 insertions(+), 7 deletions(-)

-- 
2.20.1

