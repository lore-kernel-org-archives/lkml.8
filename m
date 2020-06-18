Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C37FDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F9852070A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 15:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XKsYIr30"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731526AbgFRPo6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 11:44:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24595 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728414AbgFRPo4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 11:44:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592495095;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F6Rg+f35w0pLQB9V9aLOSsaBariUhNumLWf2TXytslQ=;
        b=XKsYIr30IBQ9rTEMGIbxjzEGFBAmCixZvCDgJTmwabAhkcH5lroeewCPGFH5na5DtqFe2v
        uVnZhfXR1W9lYGDRzpIXgwODLx0UirJAyakBJMmFcWhSrlTvlVPokXI7sG5xA3XyysRIxp
        w7oBp53ysxucBPqU1gmMp+S6RkU/qDw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-PzndCp1QO56aV3iCXybqhw-1; Thu, 18 Jun 2020 11:44:51 -0400
X-MC-Unique: PzndCp1QO56aV3iCXybqhw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B0C1E18585A1;
        Thu, 18 Jun 2020 15:44:49 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DD81B71660;
        Thu, 18 Jun 2020 15:44:45 +0000 (UTC)
Date:   Thu, 18 Jun 2020 11:44:45 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     JeongHyeon Lee <jhs2.lee@samsung.com>
Cc:     agk@redhat.com, dm-devel@redhat.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: New mode DM-Verity error handling
Message-ID: <20200618154444.GB18007@redhat.com>
References: <CGME20200618070250epcas1p409eb2ddd19ecc5d55c219ac3dc884f25@epcas1p4.samsung.com>
 <98eac3fc-c399-625d-5730-29853b3a0771@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98eac3fc-c399-625d-5730-29853b3a0771@samsung.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 18 2020 at  2:56am -0400,
JeongHyeon Lee <jhs2.lee@samsung.com> wrote:

> Hello, Dear devcice-mapper maintainers.
> 
> I'm JeongHyeon Lee, work in Samsung. I'm chage of DM-Verity feature with 
> Mr. sunwook eom.
> I have a patch or suggestion about DM-Verity error handling.
> 
> Our device (smart phone) need DM-Verity feature. So I hope there is new 
> mode DM-Verity error handling.
> This new mode concept is When detect corrupted block, will be go to panic.
> 
> Because our team policy is found device DM-Verity error, device will go 
> panic.
> And then analyze what kind of device fault (crash UFS, IO error, DRAM 
> bit flip etc)
> 
> In addition to the smart phone, I would like to have an option that 
> users or administrators can use accordingly.
> There are patch contents in the attachment. I would really appreciate it 
> if you could check it.
> 
> I will look forward to hearing from yours.
> Thank you :)
> 

I do not accept that panicing the system because of verity failure is
reasonable.

In fact, even rebooting (via DM_VERITY_MODE_RESTART) looks very wrong.

The device should be put in a failed state and left for admin recovery.

Mike

