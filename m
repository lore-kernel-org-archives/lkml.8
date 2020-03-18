Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4768C4332D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 23:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65E382076E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 23:18:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="N3xS2LXB";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="JxCuXWA1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727128AbgCRXSZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 19:18:25 -0400
Received: from smtp.uniroma2.it ([160.80.6.16]:46379 "EHLO smtp.uniroma2.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726733AbgCRXSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 19:18:24 -0400
Received: from smtpauth-2019-1.uniroma2.it (smtpauth.uniroma2.it [160.80.5.46])
        by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 02INHLjU003536;
        Thu, 19 Mar 2020 00:17:26 +0100
Received: from utente-Aspire-V3-572G.campusx-relay3.uniroma2.it (wireless-125-133.net.uniroma2.it [160.80.133.125])
        by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id 680FF120057;
        Thu, 19 Mar 2020 00:17:16 +0100 (CET)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
        s=ed201904; t=1584573436; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=L9Jk2zEYlbg0F6JH6HWkhpaQt2AaMKx/YMFzfOa6ft8=;
        b=N3xS2LXBoOlTT1hkSKBLmYPkb6pau9KTC8hPK2xFQe0tsQCyqTD8RUZWWodF2cQY/fCwrx
        nhtgUgFArDclzwAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
        t=1584573436; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:content-type:
         content-transfer-encoding:in-reply-to:references;
        bh=L9Jk2zEYlbg0F6JH6HWkhpaQt2AaMKx/YMFzfOa6ft8=;
        b=JxCuXWA1qfwhB/W+5xIKympnDqj1LFxeU3MUsFyKv55OFcAMwIZyEEamplE+ZH7XX47cTA
        jwb6+blobh6i1ACPSRTV6l1+RALmA4bMDlcoBGgNnui9i8ZsMe7ooHwoZVHIlVawPgNS9d
        5aDjJ7qXY1N1/50+L/hZWhWoYnLqTWPOYFCj86SRRD+iTjnyIQ9HA2gUEU9zWshsw1b3jP
        Ww4U0cE0OkGbD9YqqU1Hp0ZFpCI6g4ecUA2xurGYQIlwi/wOEbTZOn7jrFJKi1AmcbcplL
        KssHS/GcayiQ9Ev1+9geX61YW0UJgM/+fP1+eWq8elro3OlDxX3D7GXWXwZ8fA==
From:   Carmine Scarpitta <carmine.scarpitta@uniroma2.it>
To:     davem@davemloft.net
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        ahmed.abdelsalam@gssi.it, david.lebrun@uclouvain.be,
        dav.lebrun@gmail.com, stefano.salsano@uniroma2.it,
        andrea.mayer@uniroma2.it, paolo.lungaroni@cnit.it,
        hiroki.shirokura@linecorp.com,
        Carmine Scarpitta <carmine.scarpitta@uniroma2.it>
Subject: [v2,net-next 0/2] Add support for SRv6 End.DT4 action
Date:   Thu, 19 Mar 2020 00:16:33 +0100
Message-Id: <20200318231635.15116-1-carmine.scarpitta@uniroma2.it>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch series adds the support for SRv6 End.DT4 action.
End.DT4 decapsulates the received packets and does IPv4 routing
lookup in a specific routing table.

The IPv4 routing subsystem does not allow to specify the routing
table in which the lookup has to be performed.

Patch 1 enables to perform IPv4 FIB lookup in a predefined FIB table.
Patch 2 adds the support for SRv6 End.DT4 action.

v2:
- Fix an issue of "fi" member of struct "fib_result" used
  uninitialized
- Wrap the check of the "tbl_known" flag in a "#ifdef
  CONFIG_IP_MULTIPLE_TABLES" directive

Thanks,
Carmine Scarpitta

Carmine Scarpitta (2):
  Perform IPv4 FIB lookup in a predefined FIB table
  Add support for SRv6 End.DT4 action

 include/net/route.h   |  2 +-
 net/ipv4/route.c      | 23 ++++++++++++++------
 net/ipv6/seg6_local.c | 49 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+), 7 deletions(-)

-- 
2.17.1

