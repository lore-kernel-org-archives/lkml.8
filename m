Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2747CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 033572086A
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 10:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NR1oEuUI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X2m722nO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbgGWK6t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 06:58:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57330 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728287AbgGWK6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 06:58:49 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595501927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SAkg0hRUGM84cfj7xyLPVMU8cCtxGEg+z0smkN7cgHU=;
        b=NR1oEuUINtF6tOvwtLyh4bvSzJsGz5MPWJU2dUvtBPIfSE+V5+mUwV1MpQhf+rRriHEVE4
        1HzyLXDrdrM5UonRnPcwTEjFnF32auN7qb9xSqoBk49QnNjdOaYpHO1Q4+FPI2RtDbX4ah
        qVgFeeCiTECHP+1SjsBO6PZBjhNZseTzHw9Yx1W9vRsfbtHTZT3GAAjN36o5dLznye3q5Q
        yFyLMZfS6J9bYADwVB6y84Rvf0FAGsk3M5oXQpVRyN7u7lWXParP6rgxwCNovfdCHNL+DG
        ZusVSQrH3aP40wq6mcUCUSx5KcKvluJ+vmZSEU/SS/j5BsKkoTbCkIDydMU1vQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595501927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SAkg0hRUGM84cfj7xyLPVMU8cCtxGEg+z0smkN7cgHU=;
        b=X2m722nOUT0Rsd4CwSIYHdqyN0BvEZd3F45Cx+6cTbEcGHehMw2LybUdb+zxxRbS0kbaAX
        +SCPqDx/ZGR4RbDQ==
To:     kernel test robot <lkp@intel.com>, qianjun.kernel@gmail.com
Cc:     peterz@infradead.org, will@kernel.org, luto@kernel.org,
        linux-kernel@vger.kernel.org, urezki@gmail.com,
        laoar.shao@gmail.com, jun qian <qianjun.kernel@gmail.com>,
        0day robot <lkp@intel.com>, lkp@lists.01.org
Subject: Re: [Softirq] a76eadba0d: WARNING:at_net/mac80211/rx.c:#ieee80211_rx_napi[mac80211]
In-Reply-To: <20200723091715.GL19262@shao2-debian>
References: <20200723091715.GL19262@shao2-debian>
Date:   Thu, 23 Jul 2020 12:58:46 +0200
Message-ID: <87v9iexztl.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kernel test robot <lkp@intel.com> writes:
> [  106.856151] WARNING: CPU: 5 PID: 4569 at net/mac80211/rx.c:4708 ieee80211_rx_napi+0x44d/0x560 [mac80211]

Bah. I clearly should have noticed when looking at the patch.

     pending = softirq_pending();

     set_softirq_pending(0);

     while (pending) {
           ....

           if (timeout)
           	break;
     }

That drops everything which has not yet been processed and the above
warning is due to this.

Thanks,

        tglx

