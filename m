Return-Path: <SRS0=o+hd=CR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97289C43461
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53FA92137B
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Sep 2020 17:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599584546;
	bh=qu/VD/1ayytWRjDRyQndb7jEuf1+9w8WPZlWAXNLxKE=;
	h=Subject:To:References:Cc:From:Date:In-Reply-To:List-ID:From;
	b=ZVOVKTc0Q2x3Lxa7Fbk0r33CjR+brP4noKWHU9kb4wtFsQQ308d2JdJPLZQH8m29W
	 cmW5tFEBa6nj8aJMnrvLcUD4SVd+4nrYVKQPBzO1UTztmDY/gC0otG+wd00+D6jinH
	 HRkLSqsRVzGIFpBsBVOfE4gLAJq31N5I19GwiFE0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731858AbgIHRCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 13:02:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:58440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731797AbgIHQUH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 12:20:07 -0400
Received: from [192.168.0.108] (unknown [117.89.211.136])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B8D92229C9;
        Tue,  8 Sep 2020 14:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599577154;
        bh=qu/VD/1ayytWRjDRyQndb7jEuf1+9w8WPZlWAXNLxKE=;
        h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
        b=faOgOH+DcFRZTm9HX6sKgDwiXJ3s8Y7cBZ5xeg8L6BgMvwDSYWJZIOdxTW51IMTM9
         6nYU5Hcq+kQvO3dhQZF6lPbmWvjvXcgoZ3OYk18oRrKIIGe1nTqvXvCw3fxIMFQ7Wj
         DOy+QPrp4AuiAsuVNXd7MPNHUxOPHb5QDrCkkf08=
Subject: Re: [f2fs-dev] [PATCH v3 2/2] f2fs: change return value of
 f2fs_disable_compressed_file to bool
To:     Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20200908024411.2692388-1-daeho43@gmail.com>
 <20200908024411.2692388-2-daeho43@gmail.com>
Cc:     Daeho Jeong <daehojeong@google.com>
From:   Chao Yu <chao@kernel.org>
Message-ID: <590f0fe7-a4f2-9939-fbb2-35f52179135b@kernel.org>
Date:   Tue, 8 Sep 2020 22:59:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20200908024411.2692388-2-daeho43@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-9-8 10:44, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
>
> The returned integer is not required anywhere. So we need to change
> the return value to bool type.
>
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,
