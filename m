Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6D9C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 10:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DDDB206CC
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 10:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588673302;
	bh=S4OvD3THrqAQKuLduHlxBJEKdVeJl7/rqkq6RJ2Vb14=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=duJGKQQt7nFsqrKNFeYXwvL7Rzj5xbEJROBz1NsS338cnQB7UkbOyEE4MdV4eM6r4
	 ge0aRSuS9xFXOAJGOgNnRL6ebCnS/MYaEVP2i2tsA4pvbRTVwGb5Bqw4Odohb3Rwfr
	 ABeTyOZldPgwZI+afRLY2yCBX3ivflcNJuMW1Uow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbgEEKIV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 06:08:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:57594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728238AbgEEKIU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 06:08:20 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 57C5E206B9;
        Tue,  5 May 2020 10:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588673299;
        bh=S4OvD3THrqAQKuLduHlxBJEKdVeJl7/rqkq6RJ2Vb14=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nrCuaVmZqjpy20leR1WT4PjlQ9kE8WDRu7+fFr4RhuykskZYI0e55I4MXJdRZxeco
         6jWWb7nSu8p69wN7eCcB4Z4nOm3CIWG2zeHsOi0ocA44IkIM1y0tngbpcz4Ktjc6g+
         XAq6Kx1sgFMYvYaol/e1lFJ++q/nnXLlTQACm0EA=
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jVuUr-009N59-OW; Tue, 05 May 2020 11:08:17 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 05 May 2020 11:08:17 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Douglas Anderson <dianders@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        kgdb-bugreport@lists.sourceforge.net,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, julien.thierry.kdev@gmail.com
Subject: Re: [RFC Patch v1 2/4] irqchip/gic-v3: Add support to handle SGI as
 pseudo NMI
In-Reply-To: <CAFA6WYOn+DLf77C1+e5bq-NdT+o4=o32oPu2b3bxD_U+mLQ3WQ@mail.gmail.com>
References: <1587726554-32018-1-git-send-email-sumit.garg@linaro.org>
 <1587726554-32018-3-git-send-email-sumit.garg@linaro.org>
 <20200425112950.3a4815b6@why> <6fd3d96181ec53f735ef1b6a79d28da1@kernel.org>
 <CAFA6WYPNNNZeX5zpadayfiZ7P_mHmiREpUd5LZ3Jp+TjGVqoEw@mail.gmail.com>
 <ac57cb4bbb6507ee98f199d68a514503@kernel.org>
 <CAFA6WYMheJxeKVC_YWN9owNJhcWTBsaOCvZXxq=GVj5ROJ0cvg@mail.gmail.com>
 <20200430101322.420e4052@why>
 <CAFA6WYO+NGLfNkOah4YzXx5XuaDh=QtWHgnMBwwMFY1zRt15GQ@mail.gmail.com>
 <CAFA6WYPxiwxpJitX7fCSESUvQSa9Dq89GwL4e3w33ooetV=ysw@mail.gmail.com>
 <CAFA6WYOn+DLf77C1+e5bq-NdT+o4=o32oPu2b3bxD_U+mLQ3WQ@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.3
Message-ID: <306aecc560a9503e500fbf1f512c6d30@kernel.org>
X-Sender: maz@kernel.org
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: sumit.garg@linaro.org, daniel.thompson@linaro.org, jason@lakedaemon.net, catalin.marinas@arm.com, dianders@chromium.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, jason.wessel@windriver.com, kgdb-bugreport@lists.sourceforge.net, tglx@linutronix.de, will@kernel.org, julien.thierry.kdev@gmail.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-05 05:09, Sumit Garg wrote:
> On Fri, 1 May 2020 at 18:33, Sumit Garg <sumit.garg@linaro.org> wrote:

[...]

> In case there are no major objections to this approach, I will post
> complete v2 patch-set (alongwith Marc's patches) for detailed review.

As this is still a work in progress (I'm currently wrestling with
the stupid RPi driver), whatever you have is unlikely to apply on
top of the final series.

I'm not going to stop you from posting the patches, it is just that
they will be obsolete by the end of the week...

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
