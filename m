Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28333C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 14:48:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C3952065D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 14:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729730AbgGOOsS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 10:48:18 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:49725 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729683AbgGOOsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 10:48:13 -0400
Received: from mail-pl1-f198.google.com ([209.85.214.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jvihe-0001zV-To
        for linux-kernel@vger.kernel.org; Wed, 15 Jul 2020 14:48:11 +0000
Received: by mail-pl1-f198.google.com with SMTP id 67so335129pla.23
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 07:48:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=LCvS2Mg+NMZP1rAlw+7qixFYYr8UXQD9EiMJwb616iQ=;
        b=XlqTOVejoRJH16lyyPIun850vvpT2Dt0xQ3vqURlFxsBSSy5zuSOeJYKydZSFnshgy
         KFQzjPvcEFDksMMSgiq2oyyy1mrKK4OoW30kk2YfO7aIjfD+EJNT4Rvr2Id39yrBW8Sb
         uL/fYnvFL+9qsjdotjqnmVk9RBPNzlAZYhgRGLQp4HqpM9QgyqWHv6S/WEV+ivOWErg9
         b9CeUUoE5YXglEDRiVYzwtjqIX6nYC1v/hZzj8YkVMLg2++rFNkTK+/3G1mSm9UHKn59
         gkW0BunjxzSEqX9SJ303/p6FaRdT/y6C3sKfSZ1Fv6Sngw9JSGzVgtF5RxeaxJIhfdjW
         au8g==
X-Gm-Message-State: AOAM531+yWTb45mt5YiLhJgI8Vhs7LNX44SQLk7XDmoho0p2ukeTTE8A
        LQGrG5M4r+QfljvSkttRDj0lNC0iLPi7OInjaiBTVualHsB0FWeA68m4nGF4fiYqA2w/ECe2S+s
        tEN/9OesnQ2rkAuCCZHqbZVJeAp1c1wt4RN27KRXJ9g==
X-Received: by 2002:a17:90a:c68e:: with SMTP id n14mr10261828pjt.182.1594824489582;
        Wed, 15 Jul 2020 07:48:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKrlh1HvbeAaJgRiC//V1igGnVxmU5HjSc1N2Q+BfJgRLVgPaPWhuIYiLFaQfZuLdvy30qlg==
X-Received: by 2002:a17:90a:c68e:: with SMTP id n14mr10261800pjt.182.1594824489274;
        Wed, 15 Jul 2020 07:48:09 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id f72sm2391275pfa.66.2020.07.15.07.48.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2020 07:48:08 -0700 (PDT)
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: [Regression] "SUNRPC: Add "@len" parameter to gss_unwrap()" breaks
 NFS Kerberos on upstream stable 5.4.y
Message-Id: <309E203B-8818-4E33-87F0-017E127788E2@canonical.com>
Date:   Wed, 15 Jul 2020 22:48:06 +0800
Cc:     matthew.ruffell@canonical.com,
        linux-stable <stable@vger.kernel.org>, linux-nfs@vger.kernel.org,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
To:     chuck.lever@oracle.com
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Multiple users reported NFS causes NULL pointer dereference [1] on Ubuntu, due to commit "SUNRPC: Add "@len" parameter to gss_unwrap()" and commit "SUNRPC: Fix GSS privacy computation of auth->au_ralign".

The same issue happens on upstream stable 5.4.y branch.
The mainline kernel doesn't have this issue though.

Should we revert them? Or is there any missing commits need to be backported to v5.4?

[1] https://bugs.launchpad.net/bugs/1886277

Kai-Heng
