Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6E80C4CECE
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 01:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B604220637
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 01:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbgCOBgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 21:36:14 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:44552 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbgCOBgA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 21:36:00 -0400
X-isilmar-external: YES
X-isilmar-external: YES
Received: from light.dominikbrodowski.net (brodo.linta [10.1.0.102])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id B82A7200B3E;
        Sat, 14 Mar 2020 13:46:02 +0000 (UTC)
Received: by light.dominikbrodowski.net (Postfix, from userid 1000)
        id 19CBC2075D; Sat, 14 Mar 2020 14:36:19 +0100 (CET)
Date:   Sat, 14 Mar 2020 14:36:18 +0100
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pcmcia: omap: remove useless cast for driver.name
Message-ID: <20200314133618.GA453554@light.dominikbrodowski.net>
References: <1582056436-15775-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1582056436-15775-1-git-send-email-clabbe@baylibre.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 18, 2020 at 08:07:16PM +0000, Corentin Labbe wrote:
> device_driver name is const char pointer, so it not useful to cast
> driver_name (which is already const char).
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Applied to pmcia-next.

Thanks,
	Dominik
