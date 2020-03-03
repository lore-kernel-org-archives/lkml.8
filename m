Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19359C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 23:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1A67208C3
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 23:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=dashjr.org header.i=@dashjr.org header.b="vU3iV77s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgCCXMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 18:12:18 -0500
Received: from zinan.dashjr.org ([192.3.11.21]:38348 "EHLO zinan.dashjr.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726766AbgCCXMS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 18:12:18 -0500
X-Greylist: delayed 460 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Mar 2020 18:12:17 EST
Received: from ishibashi.lan (unknown [12.190.236.222])
        (Authenticated sender: luke-jr)
        by zinan.dashjr.org (Postfix) with ESMTPSA id 32F3E38A0DB8
        for <linux-kernel@vger.kernel.org>; Tue,  3 Mar 2020 23:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dashjr.org; s=zinan;
        t=1583276676; bh=f6t72RQCwA5bUyp9woz4HWHvoHO3Yr/X++Pvw8U6VmA=;
        h=From:To:Subject:Date;
        b=vU3iV77sSMhn7VIyYaJbX6wDARFWiAr4R0CVkErEw8bLZUL8k5os9zDUdQQwiE8Z/
         aUilKRAV7H65nD30lZml5hcitIeTvLIQOb5usscfjrATa0RDpv5SSsI1gGFP1ZbNiI
         kBcA5UqrcF9q9t7nXNGUhovaU3tKcTreAM1GAW0w=
X-Hashcash: 1:25:200303:linux-kernel@vger.kernel.org::QEc3e4TtDLfHZvPM:dySN=
From:   Luke Dashjr <luke@dashjr.org>
To:     linux-kernel@vger.kernel.org
Subject: Bug? Non-privileged processes can in some cases spoof the wrong sending IP
Date:   Tue, 3 Mar 2020 23:03:35 +0000
User-Agent: KMail/1.9.10
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <202003032303.36017.luke@dashjr.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It seems non-privileged processes can bind an IP on one interface, and then 
send to addresses not routed through that interface, to spoof that IP on an 
unrelated network (eg, the default route).

Shouldn't there be something to prevent this? Presumably it's not expected 
behaviour, since you can't just bind to any arbitrary addresses...?

(FWIW I can see cases where this might be considered a security issue, but the 
MAINTAINERS file explicitly said address leaks don't count...)

Luke

P.S. I discovered this because Chromium's WebRTC implementation attempts to 
send UDP from configured IPv4 address; and then Linux's MASQUERADE also 
doesn't check that it have the correct return path, so it tried to NAT my WAN 
to my WAN, which resulted in sending out from the origin IP instead of my 
own, and triggered my modem to disconnect me. (I guess this scenario is a bit 
too convoluted to be considered a general DoS risk)
