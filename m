Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DC5C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 15:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0B9020663
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 15:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584459831;
	bh=3M6KQ+x/xS3b9actzvjEtiSqxHD+FssQ/SJMBjO96DM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=oOzIZoz+ktP6bp+QGUgk0G6o1Iywbh8YhI+6D/40B1gpcOqPVebACiuEpDOE/zxQl
	 eikBAFfTYbkJwp9ecVBq0XvUDASh7mjQ05hVY/cOSv4kW/waCdzKI6Z3ozMa8ZiPTI
	 wzBgE3YjWfOUgXAFiMHmCK0vWKmQXfY1jae2UnWQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgCQPnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 11:43:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:56244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726294AbgCQPnu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 11:43:50 -0400
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 098E120714;
        Tue, 17 Mar 2020 15:43:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584459829;
        bh=3M6KQ+x/xS3b9actzvjEtiSqxHD+FssQ/SJMBjO96DM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=z4RDNg/j8xNMU4GKgnD8q+wVtufDQchEqw5q4MftWja5Hh2cyJd0f3SxKXwfi7W6C
         S/6v7whedviS9T5cTpBV2mEa7gjORKGgiWKkkQAv31wlSg9H/RzLPRnqqvMpIVbQAk
         k/EYSilHOaA3qM3fojeBHgV8yaX0YxUWwmDYcW44=
Date:   Wed, 18 Mar 2020 00:43:43 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     masahiro31.yamada@kioxia.com
Cc:     axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] nvme: Add compat_ioctl handler for
 NVME_IOCTL_SUBMIT_IO
Message-ID: <20200317154343.GA29084@redsun51.ssa.fujisawa.hgst.com>
References: <92c670379c264775b8bb28a2bd3b380b@TGXML281.toshiba.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92c670379c264775b8bb28a2bd3b380b@TGXML281.toshiba.local>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 05, 2020 at 11:13:29AM +0000, masahiro31.yamada@kioxia.com wrote:
> Currently 32 bit application gets ENOTTY when it calls
> compat_ioctl with NVME_IOCTL_SUBMIT_IO in 64 bit kernel.
> 
> The cause is that the results of sizeof(struct nvme_user_io),
> which is used to define NVME_IOCTL_SUBMIT_IO,
> are not same between 32 bit compiler and 64 bit compiler.
> 
> * 32 bit: the result of sizeof nvme_user_io is 44.
> * 64 bit: the result of sizeof nvme_user_io is 48.
> 
> 64 bit compiler seems to add 32 bit padding for multiple of 8 bytes.
> 
> This patch adds a compat_ioctl handler.
> The handler replaces NVME_IOCTL_SUBMIT_IO32 with NVME_IOCTL_SUBMIT_IO
> in case 32 bit application calls compat_ioctl for submit in 64 bit kernel.
> Then, it calls nvme_ioctl as usual.
> 
> Signed-off-by: Masahiro Yamada (KIOXIA) <masahiro31.yamada@kioxia.com>

Thank you, applied for 5.7.
