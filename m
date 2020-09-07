Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79ADDC433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41B6A20757
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 16:17:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730500AbgIGQRX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 12:17:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730517AbgIGQQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 12:16:58 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2861C061573
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 09:16:57 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1kFJp7-0002Ke-ID; Mon, 07 Sep 2020 18:16:53 +0200
Message-ID: <68d7b3327052757d0cd6359a6c9015a85b437232.camel@pengutronix.de>
Subject: tracer_init_tracefs really slow
From:   Lucas Stach <l.stach@pengutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Date:   Mon, 07 Sep 2020 18:16:52 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

one of my colleagues has taken a look at device boot times and stumbled
across a pretty big amount of kernel boot time being spent in
tracer_init_tracefs(). On this particular i.MX6Q based device the
kernel spends more than 1 second in this function, which is a
significant amount of the overall kernel inititalization time. While
this machine is no rocket with its Cortex A9 @ 800MHz, the amount of
CPU time being used there is pretty irritating.

Specifically the issue lies within trace_event_eval_update where ~1100
trace_event_calls get updated with ~500 trace_eval_maps. I haven't had
a chance yet to dig any deeper or try to understand more of what's
going on there, but I wanted to get the issue out there in case anyone
has some cycles to spare to help us along.

The obvious questions for now are:
1. Why is this function so damn expensive (at least on this whimpy ARM
machine)? and
2. Could any of this be done asynchronously, to not block the kernel in
early init?

Regards,
Lucas

