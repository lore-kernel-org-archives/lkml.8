Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CA9C28CBC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 19:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6A2820A8B
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 19:30:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kocurkovo.cz header.i=@kocurkovo.cz header.b="YkDubO0l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728171AbgEITa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 15:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727938AbgEITa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 15:30:28 -0400
Received: from mail.kocurkovo.cz (unknown [IPv6:2a02:2b88:2:1::5b29:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0342DC061A0C
        for <linux-kernel@vger.kernel.org>; Sat,  9 May 2020 12:30:27 -0700 (PDT)
Received: by mail.kocurkovo.cz (Postfix, from userid 1000)
        id 32BF3E5C; Sat,  9 May 2020 21:30:22 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.kocurkovo.cz 32BF3E5C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kocurkovo.cz;
        s=mail; t=1589052622;
        bh=3NqGALpJejJs6fZ2p4UE2vn0NWmO4nMUqcpgpgZA2OU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YkDubO0lgoq4RjOfZ4pS4p8/SWmkZcksTIYnf0vfbdLCguIWi7jvDYlQiMUjkCBoG
         g4b1WYrHDfM0Xr0B8bPIXso1ISuEDDVBz2nYLDJXtAEYJCGU6hYwmeWWVLNMaOb0AS
         oDUc8qo4vFcjM1g8OHazyukew77MMq1h37zioEGk=
Date:   Sat, 9 May 2020 21:30:22 +0200
From:   Matej Dujava <mdujava@kocurkovo.cz>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6656: vt6655: clean Makefiles
Message-ID: <20200509193022.GA4665@new.kocurkovo.cz>
Mail-Followup-To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Forest Bond <forest@alittletooquiet.net>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <1589015247-738-1-git-send-email-mdujava@kocurkovo.cz>
 <20200509170714.GC2482887@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200509170714.GC2482887@kroah.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 09, 2020 at 07:07:14PM +0200, Greg Kroah-Hartman wrote:
>On Sat, May 09, 2020 at 11:07:27AM +0200, Matej Dujava wrote:
>> This patch is removing CFLAGS that are defining flags that are not used.
>
>You are also modifying the indentation and moving lines around for no
>reason :(
>
>Please only do one thing for a patch, and always describe everything you
>do in the changelog text.

sorry, I will split it into two separate patches and resend as v2

Thanks,
Matej

>
>Can you fix this up and send a v2?
>
>thanks,
>
>greg k-h
