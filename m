Return-Path: <SRS0=52rg=4G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60FBC34026
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 13:34:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8875020722
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Feb 2020 13:34:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cyberus-technology.de header.i=@cyberus-technology.de header.b="JxR1ui9p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgBRNeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 08:34:05 -0500
Received: from www413.your-server.de ([88.198.28.140]:45012 "EHLO
        www413.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbgBRNeF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 08:34:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=cyberus-technology.de; s=default1911; h=Content-Transfer-Encoding:
        MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=KgBM6fQQFUnEKedrviIsfqnGvqAjw1bEntua8R0ABEE=; b=JxR1ui9pvq96WRptdQ91aeGGZ
        J+9gG0zLOJqRpHrLGKhTb4vqq8ovXKgsGZXSZC1cdA4jHCHe8VzEM96OwDR1Od3oUDAtsEiKZHAfK
        AfJX0sBUBx1PdjN5wW1UGOTa5aK9kTfStSf3dyLBH3jDZI9Yr49JQD5crxrWUxjUTza7gRBhX1HCC
        VqDutM6atnRkunkPjeGsUsSnSOLT0uWt9D8Ys5YoEItq9J9OajhVYQH816KPGP9sc+bCIZY46hMT5
        eiZdBzb4XC4HvPQIBJqIoEV65SJBWDEImdTuR8kyT2LYNHsJem4EB5zR0AAQ5h4/FQUDcFwA24txv
        vCD+cf0Mw==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www413.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89_1)
        (envelope-from <julian.stecklina@cyberus-technology.de>)
        id 1j430i-0003Ai-PM; Tue, 18 Feb 2020 14:34:00 +0100
Received: from [2a02:8106:231:700:6975:3446:3ada:292d] (helo=localhost.localdomain)
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <julian.stecklina@cyberus-technology.de>)
        id 1j430i-0008RU-Fa; Tue, 18 Feb 2020 14:34:00 +0100
Message-ID: <70deaa05d3a130a91a3757b7a343bbdffccd90be.camel@cyberus-technology.de>
Subject: Re: [PATCH v2 RESEND] drm/i915/gvt: make gvt oblivious of kvmgt
 data structures
From:   Julian Stecklina <julian.stecklina@cyberus-technology.de>
To:     Zhenyu Wang <zhenyuw@linux.intel.com>
Cc:     intel-gvt-dev@lists.freedesktop.org,
        thomas.prescher@cyberus-technology.de,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        hang.yuan@intel.com, zhiyuan.lv@intel.com
Date:   Tue, 18 Feb 2020 14:33:59 +0100
In-Reply-To: <20200218085028.GA31442@zhen-hp.sh.intel.com>
References: <20200217163858.26496-1-julian.stecklina@cyberus-technology.de>
         <20200218085028.GA31442@zhen-hp.sh.intel.com>
Organization: Cyberus Technology GmbH
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: julian.stecklina@cyberus-technology.de
X-Virus-Scanned: Clear (ClamAV 0.102.1/25726/Mon Feb 17 15:01:07 2020)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-02-18 at 16:50 +0800, Zhenyu Wang wrote:
> Looks this needs some backmerge first to apply, I'll include this
> for -next pull later.

I usually base these patches on gvt-staging. If there is some other branch to
rebase them onto to make your life easier, just point me to it.

> Thanks for resend.

No problem!

Julian

