Return-Path: <SRS0=ZTvs=4H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4114C34031
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 929CE206DB
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Feb 2020 02:04:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgBSCEo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Feb 2020 21:04:44 -0500
Received: from smtprelay0211.hostedemail.com ([216.40.44.211]:49773 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726595AbgBSCEo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Feb 2020 21:04:44 -0500
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave05.hostedemail.com (Postfix) with ESMTP id F41871802CCC6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Feb 2020 02:04:42 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 22D24181D3025;
        Wed, 19 Feb 2020 02:04:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: fold38_80482e8b11150
X-Filterd-Recvd-Size: 991
Received: from joe-laptop.perches.com (unknown [47.151.143.254])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Wed, 19 Feb 2020 02:04:41 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Steven Rostedt <rostedt@goodmis.org>
Subject: [RFC PATCH 0/2] trace: Move trace data to new section _ftrace_data
Date:   Tue, 18 Feb 2020 18:03:16 -0800
Message-Id: <cover.1582077698.git.joe@perches.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the trace data to a separate section to make it easier to
examine the amount of actual data in an object file.

Joe Perches (2):
  trace: Move data to new section _ftrace_data
  trace_events/trace_export: Use __section

 include/trace/trace_events.h | 36 +++++++++++++++++++++---------------
 kernel/trace/trace_export.c  | 13 ++++++++-----
 2 files changed, 29 insertions(+), 20 deletions(-)

-- 
2.24.0

