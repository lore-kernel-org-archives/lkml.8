Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 644ECC34031
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 07:05:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FD7624656
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 07:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726352AbgBRHFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 02:05:17 -0500
Received: from n7.nabble.com ([162.253.133.57]:64303 "EHLO n7.nabble.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbgBRHFR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 02:05:17 -0500
X-Greylist: delayed 547 seconds by postgrey-1.27 at vger.kernel.org; Tue, 18 Feb 2020 02:05:17 EST
Received: from n7.nabble.com (localhost [127.0.0.1])
        by n7.nabble.com (Postfix) with ESMTP id B326213C78940
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2020 23:56:04 -0700 (MST)
Date:   Mon, 17 Feb 2020 23:56:04 -0700 (MST)
From:   "mac.lu" <mac.lu@mediatek.com>
To:     linux-kernel@vger.kernel.org
Message-ID: <1582008964730-0.post@n7.nabble.com>
Subject: NVMEM usage consult for device information
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
Mediatek chip have some SOC configurations and specific data which would be
delivered to kernel by DTB.
So we want to implement a new NVMEM driver to retrieve these data for use by
the NVMEM Framework.
Do you agree with the usage for our application? 


Thanks
Mac



--
Sent from: http://linux-kernel.2935.n7.nabble.com/
