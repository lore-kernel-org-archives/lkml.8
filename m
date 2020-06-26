Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31008C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 16:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D191207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 16:46:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="pzp6D3pE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgFZQql (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 12:46:41 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:27768 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727779AbgFZQql (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 12:46:41 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 49tjTB6004z8k;
        Fri, 26 Jun 2020 18:46:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1593189999; bh=ofBzS/SldmdlJhhC4bXI4RuRAaqqDnuXgg2USY5F64Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pzp6D3pE4/cHDTi+YhI3HtmEdYCiWsCBA4kH4FE2wIA+6bI2F8H3Kj4GaVPXDmuVf
         gK/KVz6MAWPKc/3Ct0xWNjxitvQs4q2ccW1UNAbcEa/L9PfEfXoQuVPwvr1cpjPLLp
         d6YXJFQEjXbTzm2yyOi1xBTHrwGGw8MKK/WF7hythIK29+MYjtOL96pqWlUtOxYWcf
         9YbnJLJZKjccFbIsVUrrXsAxedhLEgoyqTnYCWxf2b/4OHWzsC4Y7OYST+i/DkYtuE
         5nmVLryLLDRnlVEFUJIiLT0WnaYpRJ/1PP+LDsAPJ6LG1dNeZ0o67tL9axTQIZtkqf
         DaSDaaP+h3pMg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.3 at mail
Date:   Fri, 26 Jun 2020 18:46:37 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] misc: cb710: sgbuf2: Add missing documentation for
 cb710_sg_dwiter_write_next_block()'s 'data' arg
Message-ID: <20200626164637.GB9302@qmqm.qmqm.pl>
References: <20200626130525.389469-1-lee.jones@linaro.org>
 <20200626130525.389469-9-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200626130525.389469-9-lee.jones@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 02:05:23PM +0100, Lee Jones wrote:
> An attempt was made to provide a proper kerneldoc header for
> cb710_sg_dwiter_write_next_block(), but a description for it's 'data'
> argument was missed.
> 
> Squashes W=1 kernel build warning:
> 
>  drivers/misc/cb710/sgbuf2.c:131: warning: Function parameter or member 'data' not described in 'cb710_sg_dwiter_write_next_block'
[...]

Acked-by: Micha³ Miros³aw <mirq-linux@rere.qmqm.pl>
