Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF189C43331
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 13:24:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC0C72078A
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 13:24:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbgCYNYm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 09:24:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727027AbgCYNYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 09:24:42 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D2CC2077D;
        Wed, 25 Mar 2020 13:24:41 +0000 (UTC)
Date:   Wed, 25 Mar 2020 09:24:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     He Zhe <zhe.he@windriver.com>
Cc:     acme@redhat.com, tstoyanov@vmware.com, hewenliang4@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] tools lib traceevent: Take care of return value of
 asprintf
Message-ID: <20200325092440.2076128c@gandalf.local.home>
In-Reply-To: <5f7589c3-323d-1a5c-685c-9becd87a690b@windriver.com>
References: <1582163930-233692-1-git-send-email-zhe.he@windriver.com>
        <5f7589c3-323d-1a5c-685c-9becd87a690b@windriver.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Mar 2020 21:05:46 +0800
He Zhe <zhe.he@windriver.com> wrote:

> Can this be considered for the moment?
> 

Thanks for the reminder. This patch was pushed down in my queue by lots of
other patches I need to review. I'll try to take a look at it this week.

-- Steve
