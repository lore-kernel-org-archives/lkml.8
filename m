Return-Path: <SRS0=wIUh=66=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95307C433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 23:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 714D020767
	for <linux-kernel@archiver.kernel.org>; Sat, 16 May 2020 23:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589670633;
	bh=OJgqkK0rKAP+mwon52BaWOh3v322o3dOF5imDlRm2IE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=0qYyVEfrdSLDumBUX51c2PpqJVri9JNPA0nA6Ojcafdq4EcpXp+z2F0xZFHS/oRDN
	 LlSBUv3XxCGSvttlUNkZdDhijTzVmEO20NLqfjQv6RXpIeC6y4wHnlF0vXVRSmrXkf
	 DueYAudrqxgmT6UPJ2ypbcIebunltzcz7rPuA+b0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbgEPXKb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 May 2020 19:10:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:37394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbgEPXKb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 May 2020 19:10:31 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9269206D4;
        Sat, 16 May 2020 23:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589670630;
        bh=OJgqkK0rKAP+mwon52BaWOh3v322o3dOF5imDlRm2IE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w1yNczdk+bhXx0qPJVnr29TxeJolNtEt0Oj9mCsb+Cd3FdsKV7nKJ97DKj4p6JgcR
         0TtkLLmwXTfu7652sqC8cJsCX7hYS/0bRrSIHLZq4kxQA57dg8KXVrydAcKJzU06Xb
         tNQRX/nXebKrP7ZV8OBQqq7gcaOctJpZEpjLXMaM=
Date:   Sat, 16 May 2020 19:10:29 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-nfs@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.4 26/35] SUNRPC: defer slow parts of
 rpc_free_client() to a workqueue.
Message-ID: <20200516231029.GI29995@sasha-vm>
References: <20200507142830.26239-1-sashal@kernel.org>
 <20200507142830.26239-26-sashal@kernel.org>
 <878si3cuki.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <878si3cuki.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 08, 2020 at 07:18:53AM +1000, NeilBrown wrote:
>On Thu, May 07 2020, Sasha Levin wrote:
>
>> From: NeilBrown <neilb@suse.de>
>>
>> [ Upstream commit 7c4310ff56422ea43418305d22bbc5fe19150ec4 ]
>
>This one is buggy - it introduces a use-after-free.  Best delay it for
>now.

I've dropped it, thanks!

-- 
Thanks,
Sasha
