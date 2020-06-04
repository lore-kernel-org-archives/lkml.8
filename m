Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0AFEC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 18:59:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0F01206C3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 18:59:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mFnYc9KB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbgFDS7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 14:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729076AbgFDS7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 14:59:15 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13D0C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 11:59:15 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id m2so5606839otr.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 11:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:reply-to:mime-version
         :content-disposition:user-agent;
        bh=O/Cab+u4ryADYeVDtsfv5F0l84DgLwwEoZEafL+lgHs=;
        b=mFnYc9KB/90X8Z+3+YeS9uvEEUKHAWpmrW3FNY3VRXhdByVTByineni0qIX/1PjC8p
         VaUW3YWslLh3XR6g4cA/BWIQhDLplVN4v3GGaodFrJpKsotMeyE0MZMufhTHVkUK0jWW
         vjPGxPTvu+DlCmY+YKa7OtQeU4L5YHDb84L20Pj+Gf6hskSKmt4V8fdjOCTJmqhPm64g
         Ca+fuylKiHiwUs4lLgTKGNDXg7gQFJhLLD9u/4CiN/HUbS8C9PtTqMUAaKQzfDB4aORf
         1SACY+2df0LM70HNqAT3jesysgaJBjFC5kS4G3AKOyKtrNfOA/BMDVrHavHk0GXVOLYI
         aUag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :reply-to:mime-version:content-disposition:user-agent;
        bh=O/Cab+u4ryADYeVDtsfv5F0l84DgLwwEoZEafL+lgHs=;
        b=ODWzQXhHTO2EpIDTLHJ5zOPMxuKE3kn453sXliBUe+N7QPqSf2Nu2cwawWa+YkSI41
         r/T/vPrzoUxp2wxOh4eXvPZT1CuIAMb9nb0Dy9PYLowl8ZwwD4dC5TMkB039sE9zhzG9
         KvB4CY+gL0GMYgWX28b3TNLkEEsNEoojekip+f4Zk8z6aFwLbl7VgeBPIRFrvb9umJZb
         2yA4kkga/FDT7oQw9daJWxuFmvOzVUjLS5h371Yy2sMbwTVGVK3Fdg9N5ngH/eVACeD8
         t2AtoIgCKQk0mqw5Yg2vMODtkA+/WH9lK3biwIyWobagb5SNVxtlwSV9eAe9jfthDMB1
         Bthw==
X-Gm-Message-State: AOAM530cEuWC0Fr7+BSLb14nh7VWGk1iX52snxLUXt0RMXtpunKwVz1I
        uM4YwHdSgp8rotQGxpoWug==
X-Google-Smtp-Source: ABdhPJwiMHjVXm++PkbFZdIMmw6LD9IBOvoIvtpFTRdu16nYsunUDtJST06TJxsOX3k8/crWRezplg==
X-Received: by 2002:a05:6830:2089:: with SMTP id y9mr5082850otq.308.1591297155106;
        Thu, 04 Jun 2020 11:59:15 -0700 (PDT)
Received: from serve.minyard.net (serve.minyard.net. [2001:470:b8f6:1b::1])
        by smtp.gmail.com with ESMTPSA id l9sm224427oot.2.2020.06.04.11.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 11:59:14 -0700 (PDT)
Received: from minyard.net (unknown [IPv6:2001:470:b8f6:1b:e4c9:2a79:bb80:2326])
        by serve.minyard.net (Postfix) with ESMTPSA id 4907118003A;
        Thu,  4 Jun 2020 18:59:13 +0000 (UTC)
Date:   Thu, 4 Jun 2020 13:59:12 -0500
From:   Corey Minyard <minyard@acm.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        openipmi-developer@lists.sourceforge.net
Subject: [GIT PULL] IPMI bug fixes for 5.8
Message-ID: <20200604185912.GA19831@minyard.net>
Reply-To: minyard@acm.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b9bbe6ed63b2b9f2c9ee5cbd0f2c946a2723f4ce:

  Linux 5.7-rc6 (2020-05-17 16:48:37 -0700)

are available in the Git repository at:

  https://github.com/cminyard/linux-ipmi.git tags/for-linus-5.8-1

for you to fetch changes up to 2a556ce779e39b15cbb74e896ca640e86baeb1a1:

  ipmi:ssif: Remove dynamic platform device handing (2020-05-27 18:25:56 -0500)

----------------------------------------------------------------
IPMI update for 5.8

A few small fixes for things, nothing earth shattering.

-corey

----------------------------------------------------------------
Andy Shevchenko (1):
      ipmi: Replace guid_copy() with import_guid() where it makes sense

Corey Minyard (2):
      Try to load acpi_ipmi when an SSIF ACPI IPMI interface is added
      ipmi:ssif: Remove dynamic platform device handing

Feng Tang (1):
      ipmi: use vzalloc instead of kmalloc for user creation

Stuart Hayes (1):
      ipmi_si: Load acpi_ipmi when ACPI IPMI interface added

Tang Bin (3):
      ipmi:bt-bmc: Avoid unnecessary check
      ipmi:bt-bmc: Fix some format issue of the code
      ipmi:bt-bmc: Fix error handling and status check

 drivers/char/ipmi/bt-bmc.c           | 21 +++++++++------------
 drivers/char/ipmi/ipmi_msghandler.c  |  9 +++++----
 drivers/char/ipmi/ipmi_si_platform.c |  2 ++
 drivers/char/ipmi/ipmi_ssif.c        | 24 ++----------------------
 4 files changed, 18 insertions(+), 38 deletions(-)

