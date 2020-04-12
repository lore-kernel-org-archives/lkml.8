Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DC6EC2D0EC
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 20:27:25 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 440A4206E5
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 20:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 440A4206E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728094AbgDLU1W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 16:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:35208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbgDLU1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 16:27:22 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA3AAC0A3BF0;
        Sun, 12 Apr 2020 13:27:21 -0700 (PDT)
X-Originating-IP: 50.39.163.217
Received: from localhost (50-39-163-217.bvtn.or.frontiernet.net [50.39.163.217])
        (Authenticated sender: josh@joshtriplett.org)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 06C7A240005;
        Sun, 12 Apr 2020 20:27:16 +0000 (UTC)
Date:   Sun, 12 Apr 2020 13:27:14 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     "Jubran, Samih" <sameehj@amazon.com>
Cc:     "Machulsky, Zorik" <zorik@amazon.com>,
        "Belgazal, Netanel" <netanel@amazon.com>,
        "Kiyanovski, Arthur" <akiyano@amazon.com>,
        "Tzalik, Guy" <gtzalik@amazon.com>,
        "Bshara, Saeed" <saeedb@amazon.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Re: [PATCH] ena: Speed up initialization 90x by reducing poll
 delays
Message-ID: <20200412202714.GB3916@localhost>
References: <eb427583ff2444dcae18e1e37fb27918@EX13D11EUB003.ant.amazon.com>
 <20200313122824.GA1389@localhost>
 <1679d519016c4984b67eeb510d50e4b4@EX13D11EUB003.ant.amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1679d519016c4984b67eeb510d50e4b4@EX13D11EUB003.ant.amazon.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 12, 2020 at 09:37:22AM +0000, Jubran, Samih wrote:
> I wanted to let you know that we are still looking into your patch. 
> After some careful considerations we have decided to set the value of 
> ENA_POLL_US to 100us. The rationale behind this choice is that the 
> device might take up to 1ms to complete the reset operation and we 
> don't want to bombard device. We do agree with most of your patch 
> and we will be sending one based on it for review.

Thank you, that sounds entirely reasonable.

Please also consider making the probing asynchronous (via linux/async.h)
to allow other initialization to happen in parallel.
