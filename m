Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52102C35E04
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 20:38:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A52D20675
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 20:38:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Lrqn5mIL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731857AbgBYUiq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 15:38:46 -0500
Received: from mail.efficios.com ([167.114.26.124]:41186 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728119AbgBYUiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 15:38:46 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 6AF7F266F03;
        Tue, 25 Feb 2020 15:38:45 -0500 (EST)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 5SmdEEFEH_rY; Tue, 25 Feb 2020 15:38:45 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 2E3AA266AC1;
        Tue, 25 Feb 2020 15:38:45 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 2E3AA266AC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1582663125;
        bh=IbwSBYKvGUKh2iebU/pTGnN1/ZnFnCch+FdHVce+Itc=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=Lrqn5mILwQgGPRrHfkFU8f8gz/sC+E5/zpgRzxKxVLFyGv8CCRgEVPWRLGNjTAZ35
         LGDEOKEPJ1nvqkl7S+EUW/iNpu9jKH61yjIn3KsOOv05NnVNVPF1UDLo1vX4FLWnIk
         y1RRRH0ArVCxED29TT4bV18a52gFsbiI6C1kKsUEBftPAYLYsXez4aq0QDmnicxWyc
         9BJu+dWDNO7lhUKjqjFLk+Ny9cstlWEypCkaD/DXQ6o11U5tvmDRTuWZFYU8+lLvXk
         mnX3EWUquOYBjbj94IkxEJf95X6ea8oxY0tlEcSkq/xquHSkB6XMU49aK+w8zIwffh
         lroUodq+FDbUg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Kb0JH_pQwHfX; Tue, 25 Feb 2020 15:38:45 -0500 (EST)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 1CF27266AC0;
        Tue, 25 Feb 2020 15:38:45 -0500 (EST)
Date:   Tue, 25 Feb 2020 15:38:45 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     lttng-dev@lists.lttng.org,
        diamon-discuss@lists.linuxfoundation.org,
        linux-trace-users@vger.kernel.org, lwn@lwn.net,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1487536566.7003.1582663125006.JavaMail.zimbra@efficios.com>
Subject: [RELEASE] LTTng-modules 2.12.0-rc2, 2.11.2, 2.10.14 (Linux kernel
 tracer)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3901 (ZimbraWebClient - FF72 (Linux)/8.8.15_GA_3895)
Thread-Index: 11xHlSIFE/OCwf7nbZ+bIJIAkW7acA==
Thread-Topic: LTTng-modules 2.12.0-rc2, 2.11.2, 2.10.14 (Linux kernel tracer)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This release announcement covers all actively maintained branches of the
LTTng-modules Linux kernel tracer, namely:

- LTTng-modules 2.10.14 and 2.11.2 (stable branches),
- LTTng-modules 2.12.0-rc2 (branch currently in release candidate cycle).

The LTTng modules provide Linux kernel tracing capability to the LTTng
tracer toolset.

* New and noteworthy in these releases:

- Support for kernel 5.6 (currently at 5.6-rc3). It features changes in the
  tracepoint instrumentation, and changes in the timekeeping area in
  preparation for y2038. The plan here to handle timekeeping changes
  and keep backward compatibility is to add forward declarations of
  deprecated types locally in lttng-modules for the stable branches.

  For the master branch and future 2.13+ releases,  we plan to introduce a
  type compatibility layer within lttng-modules with typedefs mapping to the
  new types when building against recent kernels, and provide backward
  compatible typedefs when building against older kernels. Currently,
  lttng-modules builds against all vanilla and most distribution Linux
  kernels from v3.0 onwards.

- Fix NULL pointer dereference race in the lttng-statedump module. The
  return value of task_active_pid_ns() should be checked for NULL to handle
  tasks which have exited but were not waited-for yet, which are thus in a
  "dead" state. The statedump triggers at trace start and when the command
  "lttng regenerate statedump" is issued.

Thanks,

Mathieu


Project website: https://lttng.org
Documentation: https://lttng.org/docs
Download link: https://lttng.org/download

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
