Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6818C433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB52B20791
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729304AbgGMGe6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728341AbgGMGe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 02:34:58 -0400
Received: from smtp.al2klimov.de (smtp.al2klimov.de [IPv6:2a01:4f8:c0c:1465::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F51C061794;
        Sun, 12 Jul 2020 23:34:57 -0700 (PDT)
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
        by smtp.al2klimov.de (Postfix) with ESMTPA id 0E1D1BC053;
        Mon, 13 Jul 2020 06:34:54 +0000 (UTC)
Subject: Re: [PATCH] sh: Replace HTTP links with HTTPS ones
To:     Rich Felker <dalias@libc.org>, Rob Landley <rob@landley.net>
Cc:     ysato@users.sourceforge.jp, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <8b008a69-e73a-43cc-3dba-c1bce90c9902@landley.net>
 <20200712111118.24916-1-grandmaster@al2klimov.de>
 <14fdab51-0197-1784-9ebb-356a0fd39952@landley.net>
 <20200712233944.GB14669@brightrain.aerifal.cx>
From:   "Alexander A. Klimov" <grandmaster@al2klimov.de>
Message-ID: <0b659398-dcd8-26fb-a858-18a9339aabfb@al2klimov.de>
Date:   Mon, 13 Jul 2020 08:34:52 +0200
MIME-Version: 1.0
In-Reply-To: <20200712233944.GB14669@brightrain.aerifal.cx>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp.al2klimov.de;
        auth=pass smtp.auth=aklimov@al2klimov.de smtp.mailfrom=grandmaster@al2klimov.de
X-Spamd-Bar: /
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Am 13.07.20 um 01:39 schrieb Rich Felker:
> Alexander, is this whole set being submitted upstream
> through a single maintainer,
I've no idea what you're talking about, so the answer is likely no.

I've just followed the instructions on how to submit patches as for any 
other subsystem.
