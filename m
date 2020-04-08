Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3756BC2BA16
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:33:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D306206F7
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="n4QpMHi1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729078AbgDHPdp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:33:45 -0400
Received: from mail.efficios.com ([167.114.26.124]:35536 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbgDHPdp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:33:45 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id D3CE02662C8;
        Wed,  8 Apr 2020 11:33:43 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id sNMRWeaKy_Z8; Wed,  8 Apr 2020 11:33:43 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9AE332662C7;
        Wed,  8 Apr 2020 11:33:43 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 9AE332662C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1586360023;
        bh=wNPmhiWClfZbe3BvKq04pjZqsbhkRScL0PGXJtwu+sY=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=n4QpMHi1+2g4GxhjP4TaBb98EhrjAI4ovWazA3gIpB3vyQn3BU8Pm+CZQiuOlnR9D
         b2UCWh8QEa7k4/S3DmNZgmUts80fT+MINJSkJ78bCqQDOmE+feCeUGcDm58A7Xt2St
         T3OZxxEjThreLcyCOMA+sOTavg69A76hpL/LREK+/H9Bxo9pkSdQ+nBaGHBmyLOeL1
         q8HYZD9gw6+vEWDSwTk+fQ11WJjhNk35+hhnCvhkCU6mIi06LShtVh2rnOR4eIaST+
         xEtmAu6qOvVi4pkqGd4ONUi5tDo+4lA5A+n7hJ+Boz/CvK54ntC2d+C+voE63EvfU7
         dWYBUctqEuViA==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id IJq0e79VJ8P5; Wed,  8 Apr 2020 11:33:43 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 8B7422662C6;
        Wed,  8 Apr 2020 11:33:43 -0400 (EDT)
Date:   Wed, 8 Apr 2020 11:33:43 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     lttng-dev@lists.lttng.org,
        diamon-discuss@lists.linuxfoundation.org,
        linux-trace-users@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Message-ID: <173230590.27143.1586360023462.JavaMail.zimbra@efficios.com>
Subject: [RELEASE] LTTng-modules 2.10.5 and 2.11.3 (Linux kernel tracer)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3918 (ZimbraWebClient - FF74 (Linux)/8.8.15_GA_3895)
Thread-Index: Qs412dd2KVEF6YrsB5UEkpo2pEDxlQ==
Thread-Topic: LTTng-modules 2.10.5 and 2.11.3 (Linux kernel tracer)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LTTng modules provide Linux kernel tracing capability to the LTTng
tracer toolset.

This announcement covers the 2.10.15 and 2.11.3 stable branch releases
for the LTTng-modules project. The 2.10.15 version will be the last for
the 2.10 branch given that the 2.12 final release is expected today.

Those releases include changes to support updated Ubuntu and CentOS
(RHEL) kernels. The unused ftrace integration has been removed, and
some dependencies on kallsyms were replaced by use of exported kernel
symbols.

Thanks,

Mathieu


Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
