Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519CFC4BA13
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3557421D7E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbgBZOjp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 09:39:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:34780 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727362AbgBZOjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 09:39:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 65F45AC69;
        Wed, 26 Feb 2020 14:39:43 +0000 (UTC)
Message-ID: <1582727977.17520.30.camel@suse.com>
Subject: Re: [PATCH v2 0/8] Add MA USB Host driver
From:   Oliver Neukum <oneukum@suse.com>
To:     Vladimir Stankovic <vladimir.stankovic@displaylink.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        mausb-host-devel <mausb-host-devel@displaylink.com>
Date:   Wed, 26 Feb 2020 15:39:37 +0100
In-Reply-To: <013d6b8e-3e61-b41d-614a-8c115f2e2c9f@displaylink.com>
References: <013d6b8e-3e61-b41d-614a-8c115f2e2c9f@displaylink.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, den 26.02.2020, 09:57 +0000 schrieb Vladimir Stankovic:
> MA USB Host driver provides USB connectivity over an available
> network, allowing host device to access remote USB devices attached
> to one or more MA USB devices (accessible via network).

Hi,

you are limiting this to IPv4. IIRC MA-USB allows for direct use
of WiFi. Do you see a way of adding this in due course?

	Regards
		Oliver

