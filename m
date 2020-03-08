Return-Path: <SRS0=tZRF=4Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0073C10DCE
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 13:56:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E775206D7
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Mar 2020 13:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583675797;
	bh=Te5og7rgpLeKBUFsSWJdkGR3q4WB0pRYdKLovx/RtaY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=ZyqCF8bMQclx/eXXu2JWOQGvDaLy5bPOSpmrf3FhdiJtxHFhoTNJ2zSe6sEXk3EJn
	 Z7ixlvAMSTvKcuk7WX4DHn2d/sDmmDy5W7HlaAa9wsNI3qeBQ46CVzSJnO1DDpS1CG
	 KDVZFf9dXezT82uWOI8pQMptqrHNlDG01PvEZhd8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgCHN4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Mar 2020 09:56:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:38928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbgCHN4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Mar 2020 09:56:14 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB1D9206D7;
        Sun,  8 Mar 2020 13:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583675773;
        bh=Te5og7rgpLeKBUFsSWJdkGR3q4WB0pRYdKLovx/RtaY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PwoXXizTms53CU4dGlCuAQElcDPbJA72s6EsBCTwJluR8ucGjiNyZyvDptQkICyI5
         vJTnE528Xo9+C7w5GK2nK3kqS0jfzPnwn1jbFrUu9Ybky0NZgAsHxyxDrA1tBLK+TW
         Rtr5hCO379yco0IVVLJw0MF4yspB20GlqXBTQv3w=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jAwPc-00B2h6-2l; Sun, 08 Mar 2020 13:56:12 +0000
Date:   Sun, 8 Mar 2020 13:56:10 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     luanshi <zhangliguang@linux.alibaba.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqdomain: Fix function documentation of
 __irq_domain_alloc_fwnode
Message-ID: <20200308135610.379db6da@why>
In-Reply-To: <1583200125-58806-1-git-send-email-zhangliguang@linux.alibaba.com>
References: <1583200125-58806-1-git-send-email-zhangliguang@linux.alibaba.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: zhangliguang@linux.alibaba.com, tglx@linutronix.de, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  3 Mar 2020 09:48:45 +0800
luanshi <zhangliguang@linux.alibaba.com> wrote:

> The function got renamed at some point, but the kernel-doc was not
> updated.
> 
> Signed-off-by: luanshi <zhangliguang@linux.alibaba.com>

Queued for 5.7.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
