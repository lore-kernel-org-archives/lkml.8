Return-Path: <SRS0=hCRD=6J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C839AC55194
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 19:52:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFC182072B
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Apr 2020 19:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgDYTwq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Apr 2020 15:52:46 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:40566 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726190AbgDYTwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Apr 2020 15:52:45 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id 24AC11C0239; Sat, 25 Apr 2020 21:52:44 +0200 (CEST)
Date:   Sat, 25 Apr 2020 21:52:42 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Dan Murphy <dmurphy@ti.com>
Cc:     jacek.anaszewski@gmail.com, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v20 02/17] leds: Add multicolor ID to the color ID list
Message-ID: <20200425195242.GA1143@bug>
References: <20200423155524.13971-1-dmurphy@ti.com>
 <20200423155524.13971-3-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423155524.13971-3-dmurphy@ti.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-04-23 10:55:09, Dan Murphy wrote:
> Add a new color ID that is declared as MULTICOLOR as with the
> multicolor framework declaring a definitive color is not accurate
> as the node can contain multiple colors.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>

Please merge with previous patch, and you can keep reviews.

Thanks,

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
