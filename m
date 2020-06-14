Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E470C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 07:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF8AD20747
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 07:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592118821;
	bh=G0YkOo/zB1bFhEFNAvhbmUwDkAVvzsSd01JJOtcdihM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YSmle0WrbxHQEqHhJrZ2QHNMZyn5eM0hjXSR3ABxD5PlSdf+08o9J5trIa1OCAZDl
	 K8uDYgURXf32KhO5i/HMXRTLccybzfioNa+/mIzWkyJvqRHh6bx1Vwa4tvoEkfUXqg
	 yQNcCepGQwhRcjqRKarXkSyuPThN3eiL8As669KY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726772AbgFNHNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Jun 2020 03:13:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:33368 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725265AbgFNHNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Jun 2020 03:13:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE33420714;
        Sun, 14 Jun 2020 07:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592118818;
        bh=G0YkOo/zB1bFhEFNAvhbmUwDkAVvzsSd01JJOtcdihM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=absDd/JLqierYmu1LqtPo2LMI7JuTj4umdM9bXqwxtxIUU8GXB1zS18t9qaydSz4p
         AmW3AgUxqPir6IBaoUHFlVbmi4L6GtaacX8QkTK64jO0PBj9aCiYbg6wM2aWHGjuED
         KhOLrZVrEBSfcHFjKPWBQLntZ+wQYWYfXQab+2E8=
Date:   Sun, 14 Jun 2020 09:13:35 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Markus Elfring <Markus.Elfring@web.de>
Cc:     weifenghai <zzuedu2000@163.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>, Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH] Fix code style in css_task_iter_next_css_set()
Message-ID: <20200614071335.GB2629255@kroah.com>
References: <52681580-7ab4-a73c-6c86-bc9872de4fe8@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52681580-7ab4-a73c-6c86-bc9872de4fe8@web.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 12, 2020 at 09:56:26PM +0200, Markus Elfring wrote:
> > One line similar code before in this function
> 
> I suggest to improve the commit message.
> How do you think about a wording variant like the following?
> 
>    Combine two assignments for the variable “l” into one statement.
> 
> Regards,
> Markus

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot
