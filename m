Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCE2C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 12:58:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C7B4207CD
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 12:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598101112;
	bh=zz65S2/WRjexEgYEeGRHDKkwIBZKl8TsBifrZMSGdwc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oBbEAeYLqe/KgYzIy52C3zBbLWfES1RotsD0onuTSkz8OT2mQ/YrDU9Lz6FUJhBXz
	 S6C3osUIRu+TacY9+3JyfHJ0WO7g95qk67yUP4jIGc4+Gf83x0E/JUyiiFEdwHsxAE
	 q5KDd2IslT/k7oB9jzTL22v/7z3Z385B0RtyzwvY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgHVM6a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 08:58:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:46306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727920AbgHVM62 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 08:58:28 -0400
Received: from dragon (80.251.214.228.16clouds.com [80.251.214.228])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B9632072D;
        Sat, 22 Aug 2020 12:58:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598101108;
        bh=zz65S2/WRjexEgYEeGRHDKkwIBZKl8TsBifrZMSGdwc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xeyA2kCTjsSKIoxAseh1B/u2KNWGGsRkjA3qovCEfajrey+vjbTOAkKfS+ejnHTIf
         aKCdBe2ZmH04SXUjzt3+U8TXLerdrYcfRjsYe8PN1A3dZKsL2HvWoSjz5BnGXSHvLg
         JdbN6aPKg9iKKt0GnWHcNMaTKu9hWq6MJMdb+Sww=
Date:   Sat, 22 Aug 2020 20:58:23 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        daniel.baluta@nxp.com, agx@sigxcpu.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Linux-imx@nxp.com
Subject: Re: [PATCH] soc: imx: gpcv2: Use dev_err_probe() to simplify error
 handling
Message-ID: <20200822125822.GC30094@dragon>
References: <1597115082-20328-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1597115082-20328-1-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 11:04:42AM +0800, Anson Huang wrote:
> dev_err_probe() can reduce code size, uniform error handling and record the
> defer probe reason etc., use it to simplify the code.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Applied, thanks.
