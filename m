Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDABC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 23:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBF3E20738
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 23:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598399917;
	bh=j6Og6H7E6tMA09gTSQoWm477QKg5G+1faoMcMRsz+CQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ryn7ScTyePcFaeW2NfVmBTnBMFfeUeYxvqGUzqKY2xKC04yW1ZqXOcQhSARCKeFr+
	 tVhLihnIXPTzQGHQQ2RMwuxdgf+dubeQXd3YWZI9iyBnejC6c94P3GcYmYxDtU6b5E
	 m/H8gBYGNg34lJiaot4ILCfu1LgTjVdyYE+HnZAQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgHYX6g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 19:58:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56648 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726391AbgHYX6d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 19:58:33 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45DC32075F;
        Tue, 25 Aug 2020 23:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598399913;
        bh=j6Og6H7E6tMA09gTSQoWm477QKg5G+1faoMcMRsz+CQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2IRhYyJsxM8cBPSy9ZUjSSu1mhLDpmT6rZQ7JUMbucHrnh90AUnPm09eN54zeSAxj
         fu3eLA3Qqwqk2BDp8FzmvahJrBlKkm4bxB30F6x1xpz3iSPzRkDCfCjFzhPBkNwqvk
         LPjixUXa9dQzEgBwiQJXsSOWYgLhWOECK3TcAGSk=
Date:   Tue, 25 Aug 2020 19:58:32 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Pavel Machek <pavel@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        David Sterba <dsterba@suse.com>,
        Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH 4.19 09/71] btrfs: sysfs: use NOFS for device creation
Message-ID: <20200825235832.GJ8670@sasha-vm>
References: <20200824082355.848475917@linuxfoundation.org>
 <20200824082356.348762357@linuxfoundation.org>
 <20200825181930.GA989@bug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20200825181930.GA989@bug>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25, 2020 at 08:19:30PM +0200, Pavel Machek wrote:
>Hi!
>
>> From: Josef Bacik <josef@toxicpanda.com>
>>
>> Dave hit this splat during testing btrfs/078:
>
>...
>
>> CC: stable@vger.kernel.org # 4.14+
>
>This commit is in mainline, as a47bd78d0c44621efb98b525d04d60dc4d1a79b0, but is not marked
>as such.

Fixed, thanks!

-- 
Thanks,
Sasha
