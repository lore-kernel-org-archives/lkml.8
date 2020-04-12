Return-Path: <SRS0=29S8=54=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E6CAC352BE
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 18:48:07 +0000 (UTC)
Received: from vger.kernel.org (unknown [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2411E206E9
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Apr 2020 18:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mcj0ngPO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2411E206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgDLSrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Apr 2020 14:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:46892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727329AbgDLSrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Apr 2020 14:47:48 -0400
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA017C0A3BF0;
        Sun, 12 Apr 2020 11:47:48 -0700 (PDT)
Received: from kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com (c-67-180-217-166.hsd1.ca.comcast.net [67.180.217.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3C118206DA;
        Sun, 12 Apr 2020 18:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586717268;
        bh=Iov9Ko2BuTYWr8nqT7lSyfqW4br3wc1s7Z69EJKls08=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mcj0ngPOWlZtN2YN2uAm3LIEwXPgEYVTAY37VhxE5n0KEEYK2kGk+/djfQhTp4raP
         4lcfjgUe0QLoThZbh7MMb7uUSCXKVJrxqXawjYBEae4gzGoWWDwORmSQPPP8DQRqur
         deKgJFsvOJwZ9r0Tz2GyUsn6UZVABHWDH02Ard1g=
Date:   Sun, 12 Apr 2020 11:47:46 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     davem@davemloft.net, grygorii.strashko@ti.com,
        colin.king@canonical.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: ti: Add missing '\n' in log messages
Message-ID: <20200412114746.1ed9fda7@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <20200411075211.9027-1-christophe.jaillet@wanadoo.fr>
References: <20200411075211.9027-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 Apr 2020 09:52:11 +0200 Christophe JAILLET wrote:
> Message logged by 'dev_xxx()' or 'pr_xxx()' should end with a '\n'.
> 
> Fixes: 93a76530316a ("net: ethernet: ti: introduce am65x/j721e gigabit eth subsystem driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Applied, thanks!
