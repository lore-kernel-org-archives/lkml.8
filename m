Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D81E3C3F2D1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 03:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5AEF2072D
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 03:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="UBgUHubs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgCFDDt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 22:03:49 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:54426 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726300AbgCFDDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 22:03:49 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583463828; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=ZOMWZQxHKmTjCuz4rH2EIO4fJcoj+hJ0hT38eLMHzdU=; b=UBgUHubs58fRMqNBSjtQtofYDSSA7YH9CLjtTdXrKLkbuvqeUDD7kCk8oL1XgFMYneLXzpPF
 0J+Z2D8kP0EvK/LRJhPlkY3mmGU7SfqvUtUVu6EzVfR3vwiLzhpjoq9JyqR78vKgzQgfmAo9
 Zlj0n1XdacUfJ0uq7rosWxaOGIk=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e61bd84.7f4a19a25fb8-smtp-out-n01;
 Fri, 06 Mar 2020 03:03:32 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C6C3BC4479D; Fri,  6 Mar 2020 03:03:32 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: stummala)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9FA0DC43383;
        Fri,  6 Mar 2020 03:03:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9FA0DC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=stummala@codeaurora.org
Date:   Fri, 6 Mar 2020 08:33:27 +0530
From:   Sahitya Tummala <stummala@codeaurora.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/2] f2fs: Add a new CP flag to help fsck fix resize
 SPO issues
Message-ID: <20200306030327.GH20234@codeaurora.org>
References: <1583245766-3351-1-git-send-email-stummala@codeaurora.org>
 <1583245766-3351-2-git-send-email-stummala@codeaurora.org>
 <e164f166-5c3f-a2ce-aec6-ff01ecb902e8@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e164f166-5c3f-a2ce-aec6-ff01ecb902e8@huawei.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chao,

On Fri, Mar 06, 2020 at 09:19:39AM +0800, Chao Yu wrote:
> On 2020/3/3 22:29, Sahitya Tummala wrote:
> > Add and set a new CP flag CP_RESIZEFS_FLAG during
> > online resize FS to help fsck fix the metadata mismatch
> > that may happen due to SPO during resize, where SB
> > got updated but CP data couldn't be written yet.
> > 
> > fsck errors -
> > Info: CKPT version = 6ed7bccb
> >         Wrong user_block_count(2233856)
> > [f2fs_do_mount:3365] Checkpoint is polluted
> 
> I'm not against this patch, however without this change, could
> fsck have any chance to repair old image?

Sure, I will update the fsck patch to handle it.

thanks,
> 
> > 
> > Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
