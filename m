Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4537C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:31:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C284E2067B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 17:31:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="pmNQbjbL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgFCRb5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 13:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgFCRb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 13:31:57 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D9CC08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 10:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fQ5rJHxTAUDx/PzHWXapRSQXU1QWJQi13AuiMXfnHFs=; b=pmNQbjbLo1a4P6/ria3gmP6/v
        76SMiuM5a34BC0yvpTkMfAAPuSFq9FtAmCVPnbYEi/Zxz0F8yz2lvHz6odCSZ/FcGlBh/XSW7tQTH
        1wqxG3iy5f5DxuyTOi534i5Xv9zvNWIPiI69EVnxTDfneltF3m9vqSDqMjFROccnChavM5hS6vcCL
        Nxmqv8BJrmKc2LW0UkeHbaXYDjAWffTp5IsuLMtenTl3wBjjUwWW9KVOBAcQspEu28fZaQNfvMe+e
        B51zbst1eSfYeFUa8YNRf37i/CP84aKeQurW7jRjxTCvKqpQztoXv6y4wL39YA9juk5U5MI0Wm8PH
        ZWz1BnsXA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40884)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1jgXF1-0005wn-Rn; Wed, 03 Jun 2020 18:31:52 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1jgXF0-0005ZA-Cg; Wed, 03 Jun 2020 18:31:50 +0100
Date:   Wed, 3 Jun 2020 18:31:50 +0100
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Thara Gopinath <thara.gopinath@linaro.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: v5.7: new core kernel option missing help text
Message-ID: <20200603173150.GB1551@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A new kernel configuration option ("SCHED_THERMAL_PRESSURE") was
recently added, but has no help text. This is most unhelpful when
trying to configure the kernel, since one does not know what the
effect of answering yes or no to this option would be.

Please supply a proper help text when adding core kernel options
so that people can make an informed decision when answering the
prompt, rather than just guessing.

One suggestion on IRC has been that this option has something to
do with climate change.

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTC for 0.8m (est. 1762m) line in suburbia: sync at 13.1Mbps down 424kbps up
