Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9C6C2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 05:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1585222C2
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 05:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rYlQFffG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgBGFo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 00:44:58 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:38941 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726607AbgBGFo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 00:44:57 -0500
Received: by mail-vs1-f67.google.com with SMTP id p14so491877vsq.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 21:44:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=e200ZIr45QZwjhxE0p64Y/t8bb1LdIKR2JaPQ134Hzk=;
        b=rYlQFffGb9MWKAqYlJoC3OmXAaCxumCm0/WRFD+oen8WCZ3kp5RvlXQeQBXTraRcGc
         yqHs7XroU2ySNq4AA9gZ1b6i+2Hkn+Wy9ozRssVnw9Suyz1Lp6hyifV/4kKdQdkRQVb1
         TfPwqrBPTdYOSwVrvMqy3xUh7LTpaJ38IjwvFEcfr1GogGE+wuwh0F4zotrhTKwK/jWx
         sD7DbrsqIDVlvgdX0VJ50OuR5j7FB5AQmUtZN105w8LRagy4iHakZvaBdIygW8bgYGou
         CTcAVW+MwD6FzPx01OY1gtsuf3b71LkZfDQQXKa/G2YC9SOWkGerfJ+bmuHm/IQTeUhl
         1IwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=e200ZIr45QZwjhxE0p64Y/t8bb1LdIKR2JaPQ134Hzk=;
        b=s2dLH180RdMpjuiQfGFPFdnJo7mfLnRUzlv86xxJMeoWwEet2xroTFvZOfakzlzBpc
         Sr3tmj0nE5amPpofdiGqypLNv28gesV5JOpPQL4ZCDIpvp6lrrGszPbjAXtVs8tTrWks
         uqk2IiXidbLjz1m6HLqAYPZWiFyTzdj/KDsu20G4/hz86IJz9WguAPzYA0n3NU0RTBMN
         eDDwYMh2yqor6aDm7vufrRxnUZMXQ9LdonpGPE5Sp4FHca56gT1voFpn+Dj8iM6FCVeR
         091/6XOoFol3dzqdO/3saom13vEPJiISwXublhrZzOnwTg1Hwg7FEq1CzhJrO3UQeYAU
         Dcqw==
X-Gm-Message-State: APjAAAXML0Aw/psyWxnN4on61Mu8J8aUYs3TzJpxsIROlj5iQ/U5j5t5
        utYIQquPyjCO2SgOysbXDB6r+aA/kYIKyWJcKUos2aDD
X-Google-Smtp-Source: APXvYqwK9pzG7ejcagqH4OhPhBkjPSn/aUv+drcXJ/TrBw3kINul7k6w6n1xaXX5heZxetd36/553lKCPQtb6QkBk9o=
X-Received: by 2002:a67:5f82:: with SMTP id t124mr4113643vsb.184.1581054296405;
 Thu, 06 Feb 2020 21:44:56 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ab0:4186:0:0:0:0:0 with HTTP; Thu, 6 Feb 2020 21:44:55 -0800 (PST)
From:   Kent Dorfman <kent.dorfman766@gmail.com>
Date:   Fri, 7 Feb 2020 00:44:55 -0500
Message-ID: <CAK4PFCXqPw2GwaaqLKAsinShVYDLZP3BpWN8Jc5sxyvmy9=H3Q@mail.gmail.com>
Subject: network stack rate shaping queues
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A general question:

Do the network rate shaping queues apply to all network traffic in the
system, or just to the AF_INET address family?

What if we have other classes of network drivers (non ethernet) that
also use a BSD socket interface, but a different address family?  Are
those messages also subject to the rate shaping, or are they generally
FIFO to the driver queue?

My concern is specific  to the 4.x kernel.
