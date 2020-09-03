Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DD1BC433E2
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 09:55:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B997720709
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 09:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599126910;
	bh=wGGOlIPEQZMs6G4FyfRkt319cMrz0ughZmzT6itrP6E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=NVFVRlto9tsHhN4M6DBCZuQB0yrxPaAPZAdyJFJj8NCohoGA74l2+6id5qTOkTDrr
	 2Myl02Rb58ati82UgE4O6b3ZGLXyVyXs5Rk/sVJL/bRPqpBlsLjg6f2u5ufg5v2cBk
	 iZ8Zowk6zmtVGIMilZ6oHnQV7zhvpo/YKumo1xtc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgICJzJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 05:55:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:50112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbgICJzI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 05:55:08 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B60BB20709;
        Thu,  3 Sep 2020 09:55:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599126907;
        bh=wGGOlIPEQZMs6G4FyfRkt319cMrz0ughZmzT6itrP6E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WELnOw3/IIMCBxlcl08e5d8AMglTsbW8Opp+VYi7/jIj4PpwCqMxwAIuM5DXsUQWG
         /EJnZxA2TzWL1jDuYYhid8kytedNP9X7yrpxRM30BbAY2ICNBn44T1+Y2CXtrlpQMH
         BeHEE72pO5qNy9xy/VBT8iEcC+XInu4I2jSGZ3bs=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1kDlxR-008r8X-SA; Thu, 03 Sep 2020 10:55:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 03 Sep 2020 10:55:05 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Zou Cao <zoucao@linux.alibaba.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, jason@lakedaemon.net
Subject: Re: [PATCH] irqchip/gic-v3: change gic_data into gic_v3_data
In-Reply-To: <1599124088-80231-1-git-send-email-zoucao@linux.alibaba.com>
References: <1599124088-80231-1-git-send-email-zoucao@linux.alibaba.com>
User-Agent: Roundcube Webmail/1.4.8
Message-ID: <c6eacce9e0990239ee12bfc5826fe2c6@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: zoucao@linux.alibaba.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, tglx@linutronix.de, jason@lakedaemon.net
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-09-03 10:08, Zou Cao wrote:
> There are multiple gic_data symbol between irq_gic.c and irq_gic_v3.c,
> we can see the same symbol name:
> 
> 	cat /proc/kallsyms | grep gic_data
> ------>
> 	ffff80001138f1d0 d gic_data
> 	ffff80001138f940 d gic_data
> 
> Normally CONFIG_ARM_GIC and CONFIG_ARM_GIC_V3 are all enabled, move
> the gic_data symbol into different name, it will be friend for
> kallsyms_lookup_name to get addr easily.
> 
> Signed-off-by: Zou Cao <zoucao@linux.alibaba.com>

I'm sorry, but this kind of change is not acceptable.

It is pure churn, for zero benefit. As an example, give the following
script a go:

awk '{ print $3 }' /proc/kallsyms | sort | uniq -c| awk '$1 > 1 
{print}'| sort -n

Are you going to repaint all these symbols?

         M.
-- 
Jazz is not dead. It just smells funny...
