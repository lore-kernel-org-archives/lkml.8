Return-Path: <SRS0=t9Lj=3Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F022DC35247
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:20:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDBB1222D9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Feb 2020 17:20:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727539AbgBDRUG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 12:20:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:59298 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727310AbgBDRUG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 12:20:06 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 97A2FADAD;
        Tue,  4 Feb 2020 17:20:04 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 04 Feb 2020 18:20:03 +0100
From:   Roman Penyaev <rpenyaev@suse.de>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Max Neunhoeffer <max@arangodb.com>,
        Christopher Kohlhoff <chris.kohlhoff@clearpool.io>,
        Davidlohr Bueso <dbueso@suse.de>,
        Jason Baron <jbaron@akamai.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] epoll: fix possible lost wakeup on epoll_ctl() path
In-Reply-To: <20200204083237.7fa30aea@cakuba.hsd1.ca.comcast.net>
References: <20200203205907.291929-1-rpenyaev@suse.de>
 <51f29f23a4d996810bfad12b9634ee12@suse.de>
 <20200204083237.7fa30aea@cakuba.hsd1.ca.comcast.net>
Message-ID: <549916868753e737316f509640550b66@suse.de>
X-Sender: rpenyaev@suse.de
User-Agent: Roundcube Webmail
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-02-04 17:32, Jakub Kicinski wrote:
> On Tue, 04 Feb 2020 11:41:42 +0100, Roman Penyaev wrote:
>> Hi Andrew,
>> 
>> Could you please suggest me, do I need to include Reported-by tag,
>> or reference to the bug is enough?
> 
> Sorry to jump in but FWIW I like the Reported-and-bisected-by tag to
> fully credit the extra work done by the reporter.

Reported-by: Max Neunhoeffer <max@arangodb.com>
Bisected-by: Max Neunhoeffer <max@arangodb.com>

Correct?

--
Roman
