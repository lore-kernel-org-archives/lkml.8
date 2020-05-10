Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33A94C54E4B
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 14:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08BFB2082E
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 14:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589120192;
	bh=JoXp1b+KeTY8KVDJyv8y3dbmFWJNkib3A2oc5JnvfEQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FQa0PpzGmWlwzyXLD6RmMvpP3TMuuLJ5deUatCgRfM9RwR3VfkVbcTGzmnSB6Z1v8
	 HwhuHMqRwWzwdynYzn8rvcpuJp5NSuy6viIZAmPVIh3cfIa3SufDcoW7OW45dMQtOb
	 vcBR4zh2Bn36p2Huws04gW+4Jm1T38eQvKOKR5Lw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728932AbgEJOQ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 10:16:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726085AbgEJOQ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 10:16:27 -0400
Received: from localhost (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E08120731;
        Sun, 10 May 2020 14:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589120186;
        bh=JoXp1b+KeTY8KVDJyv8y3dbmFWJNkib3A2oc5JnvfEQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2Ys+BElbLFkYaEcntCMxB6tbjlSRHT/sczkAEQ+6GiI6WDolNHq+wZc3tH6DlE4Tn
         687RgNLZp5mI7ijY/Fm/cAWKFGaAxsAEcv8c2K3bggRsPVi7X0hm43/o4MvSJOXfwj
         Dxg1aW/OceEzrlVnOlluf52yDv0x1563SXEuuozo=
Date:   Sun, 10 May 2020 10:16:25 -0400
From:   Sasha Levin <sashal@kernel.org>
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org, hpa@zytor.com, tony.luck@intel.com,
        ak@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Subject: Re: [PATCH v11 00/18] Enable FSGSBASE instructions
Message-ID: <20200510141625.GL13035@sasha-vm>
References: <20200509173655.13977-1-sashal@kernel.org>
 <c4f62190-260a-c6e3-f1f6-6498660a7d1f@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <c4f62190-260a-c6e3-f1f6-6498660a7d1f@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 09, 2020 at 06:40:02PM -0700, Dave Hansen wrote:
>On 5/9/20 10:36 AM, Sasha Levin wrote:
>> Changes from v10:
>>
>>  - Rewrite the commit message for patch #1.
>>  - Document communication/acks from userspace projects that are
>>    potentially affected by this.
>
>I'm glad someone's pushing this forward.  But, I'm also very curious how
>you came to be submitting this series.  Is this a team effort between
>you, the And[iy]s and Chang?  Or, were you just trying to help out?
>
>I was hoping to see some acknowledgement of this situation in the cover
>letter but didn't see anything.

What happened here was that v9 needed to be rebased on top of v5.7 which
required some changes. I did the rebase and sent it to Andi and Chang
who have suggested that I'll just send it out myself. There was no
planning beyond that.

My interest in this is that we have a few workloads that value the
ability to access FS/GS base directly and show nice performance
improvement with this patchset. I'm not a fan of carrying stuff out of
tree :)

-- 
Thanks,
Sasha
