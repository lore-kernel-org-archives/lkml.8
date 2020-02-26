Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BBEC4BA13
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 12:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82C4920838
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 12:35:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbgBZMfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 07:35:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:46086 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726334AbgBZMfl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 07:35:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 34412AD55;
        Wed, 26 Feb 2020 12:35:40 +0000 (UTC)
Message-ID: <1582720533.17520.26.camel@suse.com>
Subject: Re: [PATCH v2 5/8] usb: mausb_host: Introduce PAL processing
From:   Oliver Neukum <oneukum@suse.com>
To:     Vladimir Stankovic <vladimir.stankovic@displaylink.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        mausb-host-devel <mausb-host-devel@displaylink.com>
Date:   Wed, 26 Feb 2020 13:35:33 +0100
In-Reply-To: <659eab4d-a995-d372-2c46-8b3d72ba13bc@displaylink.com>
References: <659eab4d-a995-d372-2c46-8b3d72ba13bc@displaylink.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, den 26.02.2020, 09:58 +0000 schrieb Vladimir Stankovic

+int mausb_enqueue_event_from_user(u8 madev_addr, u16 num_of_events,
+                                 u16 num_of_completed)
+{
+       unsigned long flags;
+       struct mausb_device *dev;
+
+       spin_lock_irqsave(&mss.lock, flags);

You save the flags.

+       dev = mausb_get_dev_from_addr_unsafe(madev_addr);
+
+       if (!dev) {
+               spin_unlock_irqrestore(&mss.lock, flags);
+               return -EINVAL;
+       }
+
+       spin_lock_irqsave(&dev->num_of_user_events_lock, flags);

You overwrite the flags.

+       dev->num_of_user_events += num_of_events;
+       dev->num_of_completed_events += num_of_completed;
+       spin_unlock_irqrestore(&dev->num_of_user_events_lock, flags);

Your restore the flags.

+       queue_work(dev->workq, &dev->work);
+       spin_unlock_irqrestore(&mss.lock, flags);

You restore the overwritten flags.

This cannot be right.

	Regards
		Oliver

