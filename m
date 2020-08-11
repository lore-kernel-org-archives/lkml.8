Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0E9BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 19:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9FB0D20781
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 19:27:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="bQnjgjkX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726430AbgHKT1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 15:27:43 -0400
Received: from mail.efficios.com ([167.114.26.124]:51814 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgHKT1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 15:27:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E2D012CF884;
        Tue, 11 Aug 2020 15:27:41 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id EEcEEr-s-SrR; Tue, 11 Aug 2020 15:27:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B8C212CF377;
        Tue, 11 Aug 2020 15:27:41 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com B8C212CF377
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1597174061;
        bh=1v1MPa4sJ4QtOimq78HFS1qQehsF7FDbbbQfoAzyZkM=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=bQnjgjkX6758iIL0rHhA5qtkYu5xRubBkmn5MdY20ijsZvNt8qk1pEybrbugWyHm5
         nw7Lu3WvJDqrsGT/TSQEArM2JYyU+jE0R9oMVV+qWLeHsmemZBAubLAE91C9eqn2Xm
         tt1fulxxgKxwlKgzT91D5DHaq0GvkCKu/cZmcrTSXxQOkQk56ZaYhPxJueIFaixbvj
         LW4ewRCV8y+EBY1L7dzFLRMpYQGBVRvQPPLcPbt4JbHVVyhBGNjs46jKAv7kd5UIec
         RPVW6YELbvGW1ELzh1+3/Yg02QAcgxVNqSExjvYjEl/FhhQ2KzoFK+UrsGx5EUZuVt
         cS437scaSANrw==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id KqBoS2y1UI96; Tue, 11 Aug 2020 15:27:41 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id AD6852CF376;
        Tue, 11 Aug 2020 15:27:41 -0400 (EDT)
Date:   Tue, 11 Aug 2020 15:27:41 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     David Ahern <dsahern@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Michael Jeanson <mjeanson@efficios.com>,
        David Ahern <dsahern@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>
Message-ID: <731739593.4827.1597174061640.JavaMail.zimbra@efficios.com>
In-Reply-To: <511074db-a005-9b64-9b5a-6367d1ac0af6@gmail.com>
References: <42cb74c8-9391-cf4c-9e57-7a1d464f8706@gmail.com> <20200806185121.19688-1-mjeanson@efficios.com> <20200811.102856.864544731521589077.davem@davemloft.net> <f43a9397-c506-9270-b423-efaf6f520a80@gmail.com> <699475546.4794.1597173063863.JavaMail.zimbra@efficios.com> <511074db-a005-9b64-9b5a-6367d1ac0af6@gmail.com>
Subject: Re: [PATCH] selftests: Add VRF icmp error route lookup test
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3959 (ZimbraWebClient - FF79 (Linux)/8.8.15_GA_3953)
Thread-Topic: selftests: Add VRF icmp error route lookup test
Thread-Index: FIir5KvbcOkTO8IkhWWlwDf7GMEQ3g==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Aug 11, 2020, at 3:14 PM, David Ahern dsahern@gmail.com wrote:

> On 8/11/20 1:11 PM, Mathieu Desnoyers wrote:
>> One thing I am missing before this series can be considered for upstreaming
>> is an Acked-by of the 2 fixes for ipv4 and ipv6 from you, as maintainer
>> of l3mdev, if you think the approach I am taking with those fixes makes sense.
> 
> Send the set, and I will review as vrf/l3mdev maintainer. I need working
> tests and patches to see the before and after.

Allright, I'm rebasing on the net tree as we speak, and the patches will
be on their way shortly.

Thanks,

Mathieu


-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
