Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A52C433E3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 13:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E44620657
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 13:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731178AbgGONAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 09:00:53 -0400
Received: from foss.arm.com ([217.140.110.172]:56108 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726335AbgGONAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 09:00:53 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB6D531B;
        Wed, 15 Jul 2020 06:00:52 -0700 (PDT)
Received: from bogus (unknown [10.37.12.81])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 23CCB3F66E;
        Wed, 15 Jul 2020 06:00:50 -0700 (PDT)
Date:   Wed, 15 Jul 2020 14:00:43 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        jdelvare@suse.com, linux@roeck-us.net,
        Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [RESEND][PATCH] hwmon: scmi: fix potential buffer overflow in
 scmi_hwmon_probe()
Message-ID: <20200715130043.GA28391@bogus>
References: <20200715121338.GA18761@e119603-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715121338.GA18761@e119603-lin.cambridge.arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 01:13:38PM +0100, Cristian Marussi wrote:
> SMATCH detected a potential buffer overflow in the manipulation of
> hwmon_attributes array inside the scmi_hwmon_probe function:
>
> drivers/hwmon/scmi-hwmon.c:226
>  scmi_hwmon_probe() error: buffer overflow 'hwmon_attributes' 6 <= 9
>
> Fix it by statically declaring the size of the array as the maximum
> possible as defined by hwmon_max define.
>

Makes sense to me,

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

There may be other such instances. I am not sure if Guenter has ignored
them intentionally or just no one has fixed them so far.

--
Regards,
Sudeep
