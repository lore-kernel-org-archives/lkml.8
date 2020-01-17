Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 134C5C33CB6
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 02:23:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE3462064C
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 02:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="TvhvRYJm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388148AbgAQCXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 21:23:50 -0500
Received: from forward501o.mail.yandex.net ([37.140.190.203]:59631 "EHLO
        forward501o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726726AbgAQCXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 21:23:49 -0500
Received: from mxback26j.mail.yandex.net (mxback26j.mail.yandex.net [IPv6:2a02:6b8:0:1619::226])
        by forward501o.mail.yandex.net (Yandex) with ESMTP id C63321E80128;
        Fri, 17 Jan 2020 05:23:46 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback26j.mail.yandex.net (mxback/Yandex) with ESMTP id ZU3RfPQi61-Nje07Xe4;
        Fri, 17 Jan 2020 05:23:46 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1579227826;
        bh=u1Ex/dm008pS0Rs3HBPfLNJc8QRnk3C4G8W3JONuMQ0=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=TvhvRYJmVavbRIFYjpuWxnmMqAq6Hqy3kRZignk0nQTItrm2EQ0tXyql7Cxxtd7Ve
         fyILr7EMwJo/6vD7ghdo5ju+bgYl2lyEAs+oopfXK+Grx4cFqCMcdGcy/QAu6Qs+4L
         2Y6CrVLxDEK0Mv46Us5mR7lJ3CF7WpO7x310VAEA=
Authentication-Results: mxback26j.mail.yandex.net; dkim=pass header.i=@flygoat.com
Received: by sas1-e05fd3bc78f9.qloud-c.yandex.net with HTTP;
        Fri, 17 Jan 2020 05:23:45 +0300
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
Envelope-From: yjx@flygoat.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>
Cc:     "chenhc@lemote.com" <chenhc@lemote.com>,
        "paul.burton@mips.com" <paul.burton@mips.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "maz@kernel.org" <maz@kernel.org>
In-Reply-To: <875zhaeupr.fsf@nanos.tec.linutronix.de>
References: <20200113101251.37471-1-jiaxun.yang@flygoat.com> <20200117001706.40620-1-jiaxun.yang@flygoat.com> <875zhaeupr.fsf@nanos.tec.linutronix.de>
Subject: Re: [PATCH v1 1/2] genirq: Check for level based percpu irq
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Fri, 17 Jan 2020 10:23:45 +0800
Message-Id: <1440861579227825@sas1-e05fd3bc78f9.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



17.01.2020, 09:29, "Thomas Gleixner" <tglx@linutronix.de>:
> Jiaxun Yang <jiaxun.yang@flygoat.com> writes:
>>  MIPS processors implemented their IPI IRQ and CPU interrupt line
>>  as level triggered IRQ. However, our current percpu_irq flow is trying
>>  do it in a level triggered manner.
>

Hi Thomas,

Thanks for your kind explanation.

That appears to be my misunderstanding of the trigger type.

Paul, I have confirmed it seems fine to handle percpu IRQ without mask
it on both Ingenic and Loongson processors. How about other MIPS Cores?
Could you please help check that?

Thanks.

--
Jiaxun Yang
