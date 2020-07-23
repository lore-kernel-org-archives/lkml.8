Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E881AC433E5
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:35:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2D93207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 14:35:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UonPmNKR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gr7awscG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729220AbgGWOf5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 10:35:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58462 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbgGWOf5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 10:35:57 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595514955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y234A0N+4L8sN2FORcO+Y6jvXnKOK0C6odNkjkL7vtc=;
        b=UonPmNKR4l7pudqSjAmA2Uq4BuGqrVcHUrl8t4wonBad1pnli+ovzq/158q/6rtxxyLVBz
        mlWu6uW41P3JyzXAD89QnQBtoUsHLa5f12U4/yh7Ytx+y2O7SwhwUhlrcP0DbfQJ69Ke8v
        5S373KOS+wQamQCHari44BM+XkJxV2cBsj5/fCv36fIbGlYaoYR3IlOCK1PCksRvIYKGsH
        Tzky/NhAQTCBVK8EbBMc2mxVSvQCY2q0bdJ14tKsQsRkgvKbJCthbqyaDrM4szM5d1j3P3
        yP8axeXluzYvz91QgFBvPdsnbZIabTvAewjqZwpyXA3CHEmKMG9ihmfFIZmWmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595514955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=y234A0N+4L8sN2FORcO+Y6jvXnKOK0C6odNkjkL7vtc=;
        b=Gr7awscGMa4ckB+KdifUwm436D4jC6LmA86yaN5az0aQ5wWgHiP7VlRAIhEkCByvm8Mdp0
        WpBAehSD3Gi+BmAg==
To:     jun qian <qianjun.kernel@gmail.com>
Cc:     kernel test robot <lkp@intel.com>, peterz@infradead.org,
        will@kernel.org, luto@kernel.org, linux-kernel@vger.kernel.org,
        Uladzislau Rezki <urezki@gmail.com>,
        Yafang Shao <laoar.shao@gmail.com>, lkp@lists.01.org
Subject: Re: [Softirq] a76eadba0d: WARNING:at_net/mac80211/rx.c:#ieee80211_rx_napi[mac80211]
In-Reply-To: <CAKc596KA2moT7fgO+Ount5trEbtrYsuLbde5S5Ou-c4EQbHb3g@mail.gmail.com>
References: <20200723091715.GL19262@shao2-debian> <87v9iexztl.fsf@nanos.tec.linutronix.de> <CAKc596KA2moT7fgO+Ount5trEbtrYsuLbde5S5Ou-c4EQbHb3g@mail.gmail.com>
Date:   Thu, 23 Jul 2020 16:35:55 +0200
Message-ID: <874kpyxpro.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

jun qian <qianjun.kernel@gmail.com> writes:
> On Thu, Jul 23, 2020 at 6:58 PM Thomas Gleixner <tglx@linutronix.de> wrote:
>> That drops everything which has not yet been processed and the above
>> warning is due to this.
>>
> wow, I made a mistake, thank you for finding the cause of the problem
> so quickly.
>
> How about the following code.   we need to clear the corresponding
> pending bit at the
> right time Instead of all the pending bits cleared in the start.
>
> pending = softirq_pending();
>
> while ((softirq_bit = ffs(pending))) {
>
>         pending >>= softirq_bit;
>
>         set_softirq_pending(pending);  //Only clear the corresponding
> bit which will be processed.

How is that supposed to be correct. pending has been shifted
right. Something like this should work:

 		h++;
 		pending >>= softirq_bit;

		if (timeout()) {
			/*
			 * Ensure that the remaining pending bits
			 * are handled.
			 */
			or_softirq_pending(pending << (vec_nr + 1));
			break;
		}
 	}

Thanks,

        tglx

