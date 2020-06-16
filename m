Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE177C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B89F0207C4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 14:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592317060;
	bh=+O0CnnRUJdu+JCJnU5gJSNhUSjE9EWQ0ZLIhtsKRDzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZKQpG576plXfNRMVB2x03658wp5dRcm4wqrxiMw1uvD4bHqP80eeXF823tq9CqNS1
	 dnQ87wZ1GGOLbZVS8Nw9rJ3slr6tkSXi7TaUggM5roDvbHq9P859otvI5LcchdnWse
	 3jWHDxqhxCQdVwNXkFm/Pn7GOuU9nuEM0gG614h0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729194AbgFPORj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 10:17:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:49260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728553AbgFPORi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 10:17:38 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1B7220707;
        Tue, 16 Jun 2020 14:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592317058;
        bh=+O0CnnRUJdu+JCJnU5gJSNhUSjE9EWQ0ZLIhtsKRDzU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BQPe3lFHPo1RlAvbHTkhWgBPlsHijmgvFeif+FE3JqnHt4E5t2mEXZK6HZr4q/kHb
         V4mfO16Sn3eU8TNUHl1wU+i3cY8uZRFldCOoRz5CiLq7jjry2IA+WCHUu24ASxPOew
         Un28yHkCOjtxzgAmrfvBWy1gMtBi+mPUeIIB30hQ=
Date:   Tue, 16 Jun 2020 09:22:57 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: Re: [PATCH][next] staging: rts5208: Use array_size() helper in
 vmalloc()
Message-ID: <20200616142257.GL10051@embeddedor>
References: <20200615230811.GA18818@embeddedor>
 <20200616101312.GM4151@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616101312.GM4151@kadam>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 01:13:12PM +0300, Dan Carpenter wrote:
> On Mon, Jun 15, 2020 at 06:08:11PM -0500, Gustavo A. R. Silva wrote:
> > and memset()
> 
> Please don't start the commit message in the middle of a sentence.  It's
> 

That was, certainly, unintentional. Thanks for letting me know.

--
Gustavo
