Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B566EC433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 72DDC20767
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 12:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=wp.pl header.i=@wp.pl header.b="ulJCHIZz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgIAMQd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 08:16:33 -0400
Received: from mx4.wp.pl ([212.77.101.12]:55054 "EHLO mx4.wp.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728054AbgIAMGd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 08:06:33 -0400
Received: (wp-smtpd smtp.wp.pl 16579 invoked from network); 1 Sep 2020 14:06:24 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=1024a;
          t=1598961984; bh=3huBavgT4ySq87VOuq/vV16pJjwKJIO2mPQe6DkFArk=;
          h=Subject:To:From;
          b=ulJCHIZzbqTaf7Nrq0fSSwY1A/u/o+MEC31Yw73+O4/jXjUrB4j0LgL/NKm+907pr
           PXBYn3SZhaNbilaYkxTeefodZUu0dCTG6fL2FMeeFKl0LLTjV1Ze6y94RWHtBeG7f5
           2NRmgdtCt2JJqKV0htUPTzZvC+9gPGCQwmMaa5jA=
Received: from 188.146.234.2.nat.umts.dynamic.t-mobile.pl (HELO [192.168.1.110]) (antoni.przybylik@wp.pl@[188.146.234.2])
          (envelope-sender <antoni.przybylik@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <devel@driverdev.osuosl.org>; 1 Sep 2020 14:06:24 +0200
Subject: Fwd: Re: [PATCH] staging: gdm724x: gdm_tty: corrected macro by adding
 brackets
References: <e11b8f5e-1b85-fe24-36d5-c8d707ce4e66@wp.pl>
To:     Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
From:   "antoni.przybylik@wp.pl" <antoni.przybylik@wp.pl>
X-Forwarded-Message-Id: <e11b8f5e-1b85-fe24-36d5-c8d707ce4e66@wp.pl>
Message-ID: <15764d01-0602-18c6-e2b1-089b71a2061d@wp.pl>
Date:   Tue, 1 Sep 2020 14:06:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <e11b8f5e-1b85-fe24-36d5-c8d707ce4e66@wp.pl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-WP-MailID: 612e0fd7c75c72b6c399a159ae2e4411
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [oYPU]                               
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.09.2020 13:08, Greg KH wrote:
> On Tue, Sep 01, 2020 at 12:43:11PM +0200, antoniprzybylik wrote:
>> Such macros are dangerous. Consider following example:
>> 	#define GDM_TTY_READY(gdm) (gdm && gdm->tty_dev && gdm->port.count)
>> 	GDM_TTY_READY(a + b)
>> This macro will be expanded in such a way:
>> 	(a + b && a + b->tty_dev && a + b->port.count)
>> And it will lead to errors.
> This is for a pointer, no one would ever do that :)

Nobody adds a pointer to a pointer, but it's common to add to it some 
value like that:

GDM_TTY_READY(myptr + 0x1000)

> But, if you really worry about this, turn it into an inline function,
> that way you get the proper typedef safety, which is what something like
> this should really be, not a macro.

How to do it? Do I need to send another patch?

Antoni Przybylik

