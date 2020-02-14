Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA27FC3B192
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 01:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94DC522314
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 01:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581643199;
	bh=cNE6bNVu1fk/XRcJo18cf+EwcJs7tFrXWAf5isoOqYs=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=tTo1Y4N+yMrHe18lHkxZ3yRRvviifLMIEsDLhqzhkXVnDLvk3FItYPwDpTqzp2BOK
	 BihYS1cXbv45OuAQ8lG55H6/z6Ts6NxGC5NFDmqib66wlPM6UL3jNI9xQTUsnEm6ye
	 MNGJFHn3Cc32WYYsJEmWzElMmU51s5GTAMoQPVI8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbgBNBT7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 20:19:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:45658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727604AbgBNBT6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 20:19:58 -0500
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A00020848;
        Fri, 14 Feb 2020 01:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581643197;
        bh=cNE6bNVu1fk/XRcJo18cf+EwcJs7tFrXWAf5isoOqYs=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=Aw65tvMSTNlHQ1ycTlCYb2oL306UJeUreXVEnrCMap+X6OlCWKOya+1q0Lx6vRm7i
         HgIsf93zJhngOuLUHqHkv19QZ6/mmFd54CExILEIJ49P3JslUeg7Zmi2gYZf3367uC
         EU65r24uY+ZZC2UHv6qvjFSR9wDUFQ43yfwGcGa8=
Date:   Thu, 13 Feb 2020 20:19:56 -0500
From:   Sasha Levin <sashal@kernel.org>
To:     dsterba@suse.cz, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Filipe Manana <fdmanana@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
Subject: Re: [PATCH 4.9 089/116] btrfs: flush write bio if we loop in
 extent_write_cache_pages
Message-ID: <20200214011956.GC1734@sasha-vm>
References: <20200213151842.259660170@linuxfoundation.org>
 <20200213151917.511897953@linuxfoundation.org>
 <20200213210109.GS2902@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200213210109.GS2902@suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 13, 2020 at 10:01:09PM +0100, David Sterba wrote:
>On Thu, Feb 13, 2020 at 07:20:33AM -0800, Greg Kroah-Hartman wrote:
>> From: Josef Bacik <josef@toxicpanda.com>
>>
>> [ Upstream commit 96bf313ecb33567af4cb53928b0c951254a02759 ]
>
>This commit does not exist in my tree, the correct upstream commit of
>the backported patch should be 42ffb0bf584ae5b6b38f72259af1e0ee417ac77f.
>
>> --- a/fs/btrfs/extent_io.c
>> +++ b/fs/btrfs/extent_io.c
>> @@ -4060,6 +4060,14 @@ static int extent_write_cache_pages(struct extent_io_tree *tree,
>>  		 */
>>  		scanned = 1;
>>  		index = 0;
>> +
>> +		/*
>> +		 * If we're looping we could run into a page that is locked by a
>> +		 * writer and that writer could be waiting on writeback for a
>> +		 * page in our current bio, and thus deadlock, so flush the
>> +		 * write bio here.
>> +		 */
>> +		flush_write_bio(data);
>
>This has been modified to apply, flush_write_bio does not return a value
>in 4.9, perhaps this led to the different commit id.

Ah yes. This patch was tricky because there were two "big" things that
broke on the backport:

1. flush_write_bio() returning a value.
2. The 'data' -> 'epd' rename.

96bf313ecb3 comes from when both of the above conditions overlapped, and
I forgot that I'm basing my second backport change on something that was
already modified.

-- 
Thanks,
Sasha
