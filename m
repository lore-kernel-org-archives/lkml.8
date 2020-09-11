Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E773EC2D0E0
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 10:38:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6EDF208FE
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 10:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=xs4all.nl header.i=@xs4all.nl header.b="KbXSwGTG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725786AbgIKKij (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 06:38:39 -0400
Received: from lb1-smtp-cloud9.xs4all.net ([194.109.24.22]:36317 "EHLO
        lb1-smtp-cloud9.xs4all.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725894AbgIKKhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 06:37:53 -0400
Received: from cust-b5b5937f ([IPv6:fc0c:c16d:66b8:757f:c639:739b:9d66:799d])
        by smtp-cloud9.xs4all.net with ESMTPA
        id GgR3kunesXgwIGgR5kdnBP; Fri, 11 Sep 2020 12:37:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xs4all.nl; s=s1;
        t=1599820663; bh=qnwGW4tzcamsjh4ceHBYUFA7MA/UMAdYxUYrY4gIzZI=;
        h=Subject:To:From:Message-ID:Date:MIME-Version:Content-Type:From:
         Subject;
        b=KbXSwGTGwvDpPWj8iHd0MIpnF0D+NkWxmKeYO3C9bRGJ9P/MrBr6Skwhz3fJiOZCP
         e5eVU3z8Wu8yEyfh/16do7AeJXHzp/gCOSiUcaAO4W8j8IIlf/dgkPFEfo4syuWtLy
         LjlC6FwX5OxyKNw/+8g0UQGuex++sat0+eLYWdPh0eYRH+6w2GYlhv06miLp86JI7Q
         teKNdAJq/zEyDM/fEtb9YdUm3ZpwzuKSvsq/H9esoPGxhe2zdg2gHtWRpjwDQYqacY
         G8pxQ2jUo/52r4JVkz8gpo0Ck5Q3S8ObvD/ruVDq7CLef0tCqyKJyqyh6WhMVopuHA
         M887QVabM6g+g==
Subject: Re: [PATCH] media/v4l2: remove V4L2-FLAG-MEMORY-NON-CONSISTENT flag
To:     Christoph Hellwig <hch@lst.de>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tomasz Figa <tfiga@chromium.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200911030758.73745-1-sergey.senozhatsky@gmail.com>
 <20200911100919.GA1945@lst.de>
From:   Hans Verkuil <hverkuil-cisco@xs4all.nl>
Message-ID: <262a3acd-9070-8992-f13f-1f02bfe18eb8@xs4all.nl>
Date:   Fri, 11 Sep 2020 12:37:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200911100919.GA1945@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAs7YpXWgtS+19Z//D95R5frXePYzprL9NLIORvs+FCWi0aHSHvrVp9PR3w6WbDiLls5aQUj5t1kRHqKJtRgqDq9IErzQHx9xOOAJLWQvwq78JThvGhJ
 7P4ASVSaeWLQix4k238ISU8jqFq+GysIa6+SqtLaktFqYRDBUD7GcDO8MflgBnLADNFWtxNGPykGWyEzSsnBwsfvcTlyNSKTsW12/vYvrLPzXWw3fbb9cbKl
 2T+pdlQXszw5eU3wJXP5q8e/4iotUeoteA4CymeTswlyOxYQ47nafslnLd4kYfpEoZskqad234nODcY4GpmhzhOM0Z8Dqg93btCANbq0HAzmrBIp4+XoqqiW
 9n37I1AEiUES6Eo1ru7wPV+gwrAepn2ZHuhWuh9EQ1xvIQKXnAcGDaiFnpfzlhTD9Z5qGxOxHzy/GWpU4DJnZZf1fT9VkQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/09/2020 12:09, Christoph Hellwig wrote:
> Btw, the subject should probably read something like:
> 
> media/v4l2: remove the V4L2_FLAG_MEMORY_NON_CONSISTENT flag
> 
> I messed up the spelling because I copied it from the documentation.
> 


I'll take care of that. I also discovered that one call to vb2_core_reqbufs()
wasn't updated (in drivers/media/dvb-core/dvb_vb2.c). I've fixed that as well.

All my regression tests passed, so I plan to post a PR for 5.9 reverting this
feature soon.

Many thanks to everyone for 1) discovering this problem and 2) creating a patch
to revert this.

Regards,

	Hans
