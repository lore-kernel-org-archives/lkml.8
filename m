Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84091C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52CCE2469C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 16:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1582907841;
	bh=5A5iE043J0H7bsRCOK/blI10h304v4dt+OVpLOWvVU8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=1bKzu2tIqgszMD5RvhGgw6PD7zhVZZRY2hVwNK1gd37o6KW0lyojKEbKeW5IplIGt
	 SfSc0HlLuNOwQ3X6VpvcUx+rwdYZv8KRmjrmbvm0L4WYRbqZoPHl9Jz1cJKwM88J7E
	 kTown/jG/JBtsOXSFVc5ZtYBq8CSno314A48DzgM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgB1QhU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 11:37:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:57052 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725827AbgB1QhT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 11:37:19 -0500
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B8DB20732;
        Fri, 28 Feb 2020 16:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582907839;
        bh=5A5iE043J0H7bsRCOK/blI10h304v4dt+OVpLOWvVU8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=on4ec+8kSt94Kmj8q1fLw5B16jN29K/IftmvlVaqoFaOiVAE4i7T2jsInOeb2qea8
         9CF18L7Iv8RNU110slHRF4pI/aEyCO/CE/O4pBtqvgrPXtvjF8jGy7vS60++mvYQSS
         tAzGV3lf4TlOW2k4q76BOtAqDyHWZn7KphC7dLTk=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1j7idZ-008np4-Hi; Fri, 28 Feb 2020 16:37:17 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Fri, 28 Feb 2020 16:37:17 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Joe Jin <joe.jin@oracle.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq/debugfs: add new config option for trigger
 interrupt from userspace
In-Reply-To: <44a7007d-9624-8ac7-e0ab-fab8bdd39848@oracle.com>
References: <44a7007d-9624-8ac7-e0ab-fab8bdd39848@oracle.com>
Message-ID: <006a08b8bfb991853ede8c9d1e29d6a7@kernel.org>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/1.3.10
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: joe.jin@oracle.com, tglx@linutronix.de, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

On 2020-02-28 05:42, Joe Jin wrote:
> commit 536e2e34bd00 ("genirq/debugfs: Triggering of interrupts from
> userspace") is allowed developer inject interrupts via irq debugfs, 
> which
> is very useful during development phase, but on a production system, 
> this
> is very dangerous, add new config option, developers can enable it as
> needed instead of enabling it by default when irq debugfs is enabled.

I don't really mind the patch (although it could be more elegant), but 
in
general I object to most debugfs options being set on a production 
kernel.
There is way too much information in most debugfs backends to be 
comfortable
with it, and you can find things like page table dumps, for example...

         M.
-- 
Jazz is not dead. It just smells funny...
