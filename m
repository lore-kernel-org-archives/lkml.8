Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB0AC10F29
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:28:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C0B6208C3
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 07:28:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=walle.cc header.i=@walle.cc header.b="WwepzPq2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728400AbgCKH2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 03:28:12 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:51845 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726310AbgCKH2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 03:28:12 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 0672923E74;
        Wed, 11 Mar 2020 08:28:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1583911689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JSw70fkISSLa6g6Yq0UJ8frDvfTka8uWBM+qhrV4Jkk=;
        b=WwepzPq2B5tgYsgHjvakBFxdsuP/fzodyQIhQ8Gs+QpFwplu4DHBt5cuDihxTWHict4N/Y
        CvnqF/qcVcGsd5oKHJ9cGt6w+bE00SP+p2pEXZ7RrEFKT0xVEP4UCCw6/ghUNsVCTCbsjC
        7vHVlHoHedjfxIN3iGsRVnY1sPOuijI=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 11 Mar 2020 08:28:02 +0100
From:   Michael Walle <michael@walle.cc>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Li Yang <leoyang.li@nxp.com>
Subject: Re: [PATCH 1/3] arm64: dts: ls1028a: sl28: fix on-board EEPROMS
In-Reply-To: <20200311071613.GL29269@dragon>
References: <20200225175756.29508-1-michael@walle.cc>
 <20200225175756.29508-2-michael@walle.cc> <20200311071613.GL29269@dragon>
Message-ID: <ad7bd5b3286f00be2d43b696b40aeaae@walle.cc>
X-Sender: michael@walle.cc
User-Agent: Roundcube Webmail/1.3.10
X-Spamd-Bar: +
X-Rspamd-Server: web
X-Rspamd-Queue-Id: 0672923E74
X-Spamd-Result: default: False [1.40 / 15.00];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         DKIM_SIGNED(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[7];
         NEURAL_HAM(-0.00)[-0.310];
         RCVD_COUNT_ZERO(0.00)[0];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2020-03-11 08:16, schrieb Shawn Guo:
> On Tue, Feb 25, 2020 at 06:57:54PM +0100, Michael Walle wrote:
>> The module itself has another EEPROM at 50h on I2C4. The EEPROM on the
>> carriers is located at 57h on I2C3. Fix that in the device trees.
>> 
>> Signed-off-by: Michael Walle <michael@walle.cc>
> 
> Doesn't apply to my branch.

Oh, sorry. there was a patch missing. I'll send a v2 shortly.

-michael
