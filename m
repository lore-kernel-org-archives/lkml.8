Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F74C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 02:06:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 73E51207C3
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 02:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591668402;
	bh=papM9bdqtASJSJWgzY96IDpNtIjXVPC8jiJhqHOTvjk=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=0po5c2eXylazsxrNew88YdIEA9DdX5Nbc0Gekl9JXllMl4+P/Vo0VJhneSFfVgNc5
	 xZtvb0ysw4cDII5d8YjasWKUqjcQd1IJY2LwN7s4xIlO5XIk1XO8uUlsVbF9H6g2Mu
	 VaSKYmozenevgrQArq1OmYXEfPR3cu9Demt7Ly4Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbgFICGl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 22:06:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:45844 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726749AbgFICGk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 22:06:40 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8FC6206D5;
        Tue,  9 Jun 2020 02:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591668400;
        bh=papM9bdqtASJSJWgzY96IDpNtIjXVPC8jiJhqHOTvjk=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=bapl6munPmbh1b61gmITTkZ6yK4e93+dSB9+BBnmdiW3Nlp+midLbzFNgFrf1rlOr
         0cWbeFd+ha+jvT40H1UUgS5P1ZOr8/dQBuSXXVG0/CmOuu1xKbSs1K19u+C3uzM2nh
         9h9K3kJzIXJfe4cmo8KB5wbetwWuDOxr1nwoi2A8=
Date:   Mon, 8 Jun 2020 22:06:38 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 5.6 001/606] hwmon: (da9052) Synchronize access
 with mfd
Message-ID: <20200609020638.GT1407771@sasha-vm>
References: <20200608231211.3363633-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200608231211.3363633-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uh, I messed something up for the 5.6 series, sorry :(

-- 
Thanks,
Sasha
