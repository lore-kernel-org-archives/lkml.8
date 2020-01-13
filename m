Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EA88C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 10:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E022080D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 10:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="XLCfZDbC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728721AbgAMKTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 05:19:49 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:49157 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725978AbgAMKTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 05:19:49 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id A719922FA7;
        Mon, 13 Jan 2020 11:19:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1578910787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uXzWX/yf1JizFlzgmJ9EVv2s99micrilFg1iwXYcgKk=;
        b=XLCfZDbCOW2OQZJSnG9GWM8MrWPozPMhdvJdQ03TRf+hP86+S7mbaUgk6CiUBbr6mmQvUs
        PANDk3tWOO052qZ8bTRIGijgjTGbFOUNNcd/6iU/eZENrWKTl+C79b5ggabgKI68O0HNW0
        e/PinULGPDuITznrZ8XAWlSA4bjSHDo=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 13 Jan 2020 11:19:47 +0100
From:   Michael Walle <michael@walle.cc>
To:     Tudor.Ambarus@microchip.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        computersforpeace@gmail.com
Subject: Re: [PATCH 2/2] mtd: spi-nor: fix locking argument in
 spi_nor_is_locked()
In-Reply-To: <1617765.HVoytVeEL0@localhost.localdomain>
References: <20200107222317.3527-1-michael@walle.cc>
 <20200107222317.3527-2-michael@walle.cc>
 <1617765.HVoytVeEL0@localhost.localdomain>
Message-ID: <7344bb68b2714755a736e8d27e06aa8e@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.8
X-Spamd-Bar: /
X-Rspamd-Server: web
X-Rspamd-Queue-Id: A719922FA7
X-Spamd-Result: default: False [-0.10 / 15.00];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         MIME_GOOD(-0.10)[text/plain];
         TO_DN_NONE(0.00)[];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[7];
         NEURAL_HAM(-0.00)[-0.780];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,bootlin.com,nod.at,ti.com,gmail.com];
         MID_RHS_MATCH_FROM(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2020-01-13 11:10, schrieb Tudor.Ambarus@microchip.com:
> Hi, Michael,
> 
> On Wednesday, January 8, 2020 12:23:17 AM EET Michael Walle wrote:
>> diff --git a/include/linux/mtd/spi-nor.h b/include/linux/mtd/spi-nor.h
>> index b661fd948a25..a8fcb1d70510 100644
>> --- a/include/linux/mtd/spi-nor.h
>> +++ b/include/linux/mtd/spi-nor.h
>> @@ -235,6 +235,7 @@ enum spi_nor_ops {
>>         SPI_NOR_OPS_ERASE,
>>         SPI_NOR_OPS_LOCK,
>>         SPI_NOR_OPS_UNLOCK,
>> +       SPI_NOR_OPS_IS_LOCKED,
>>  };
> 
> There is no NOR controller that uses this enum, can we get rid of it?

you mean the second argument of the spi_nor_lock_and_prep() and
spi_nor_unlock_and_unprep()? sure. But it removes information from the
prepare() callback. like in "prepare what?". From what I see its only
used for locking. Maybe then rename it to prepare_lock and 
prepare_unlock.

-michael
