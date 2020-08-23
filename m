Return-Path: <SRS0=TdnH=CB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F1B9C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 11:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 267732067C
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Aug 2020 11:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598181708;
	bh=dqFcBd9XOYz2kjDgxg4O7jYKbYE30Yv3mEHfVpQJ/Is=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=2O0RbPWU3sxkRqr9FREFsjvfshgso8+y0Zu2tgtznqKqGbwRaeoCQl3zQ4gY8WOIB
	 bGto4Q5zIRJ0+nkuqrAob4o57pEIvXcQ7+muMbAfBVr9kSRu+LfqGfYUirV+vBNXLX
	 rbUpvpj9PWPDM4a80QuihSZlU9AFYxzL6cORCIQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgHWLVq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Aug 2020 07:21:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:57656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726953AbgHWLVX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Aug 2020 07:21:23 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1048E20768;
        Sun, 23 Aug 2020 11:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598181683;
        bh=dqFcBd9XOYz2kjDgxg4O7jYKbYE30Yv3mEHfVpQJ/Is=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kAuQlspOoXeC06pzdMESDNezLN9rUWyWfllsOsUHR3ls8sFDdvhUPb4m3UaBQa85S
         zvc9+FO1zehyoywa20rJjiXMQQ9DzBqYhjUgzpJhZCgpXKUOsLhFvqSegp9aK9+Km8
         3TJjkYkbgtiBQ8HXcawsiR5xAwSGqCyZ27euR2tE=
Date:   Sun, 23 Aug 2020 13:21:16 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Oded Gabbay <oded.gabbay@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [git pull] habanalabs fixes pull request for kernel 5.9-rc2/3
Message-ID: <20200823112116.GA354856@kroah.com>
References: <20200822101250.GA16935@ogabbay-VM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200822101250.GA16935@ogabbay-VM>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 22, 2020 at 01:12:50PM +0300, Oded Gabbay wrote:
> Hello Greg,
> 
> This is the pull request for habanalabs driver fixes for 5.9-rc2/3.
> Mostly security fixes but also some functionality fixes. More details are
> in the tag.
> 
> Thanks,
> Oded
> 
> The following changes since commit 51072c0f5b5e98a035c6f63b83ba2afedbb7accd:
> 
>   mei: hdcp: fix mei_hdcp_verify_mprime() input parameter (2020-08-18 15:39:38 +0200)
> 
> are available in the Git repository at:
> 
>   git://people.freedesktop.org/~gabbayo/linux tags/misc-habanalabs-fixes-2020-08-22

Pulled and pushed out, thanks.

greg k-h
