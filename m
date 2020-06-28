Return-Path: <SRS0=fM4p=AJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC22C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 05:12:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D64020782
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Jun 2020 05:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="jcLYWn6B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgF1FMc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Jun 2020 01:12:32 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:50914 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725959AbgF1FMb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 01:12:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1593321151; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: Date: Subject: In-Reply-To: References: Cc:
 To: From: Sender; bh=YTaaN3Hxz2vWl27vpHURFA7UvYiADqyHcDWxUUkAnok=; b=jcLYWn6BNS+gFrlWpnKoU6d/q6GMwLxChkwdwGQm6sOSrNcGGRTng1qqqBEfgArLxpaw0xCy
 z41wXaDEombtNWe0fiH0QAhGY7eAaDXCd2U8h0bo3LCyTePNkvXhOJ3sDa5x4R7RznBRQSp8
 hh8yXSu08MB8YLTN+xlYi3GYAwo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-west-2.postgun.com with SMTP id
 5ef826b7e144dd51152e8030 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 28 Jun 2020 05:12:23
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C6B5FC433CB; Sun, 28 Jun 2020 05:12:22 +0000 (UTC)
Received: from Pillair (unknown [183.83.71.149])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 97943C433C6;
        Sun, 28 Jun 2020 05:12:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 97943C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pillair@codeaurora.org
From:   "Rakesh Pillai" <pillair@codeaurora.org>
To:     "'Ben Greear'" <greearb@candelatech.com>,
        <ath10k@lists.infradead.org>
Cc:     <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <1593238973-23237-1-git-send-email-pillair@codeaurora.org> <926301ed-e27f-0d8f-0177-6484bfffa40c@candelatech.com>
In-Reply-To: <926301ed-e27f-0d8f-0177-6484bfffa40c@candelatech.com>
Subject: RE: [PATCH] ath10k: Add history for tracking certain events
Date:   Sun, 28 Jun 2020 10:42:15 +0530
Message-ID: <000201d64d0a$b3d39d10$1b7ad730$@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQJ0JDYcv05C8nhyAbHgeWn72AC7twKruW4sp5xugGA=
Content-Language: en-us
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Ben Greear <greearb@candelatech.com>
> Sent: Saturday, June 27, 2020 8:58 PM
> To: Rakesh Pillai <pillair@codeaurora.org>; ath10k@lists.infradead.org
> Cc: linux-wireless@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] ath10k: Add history for tracking certain events
> 
> 
> 
> On 06/26/2020 11:22 PM, Rakesh Pillai wrote:
> > For debugging many issues, a history of the
> > below mentioned events can help get an idea
> > of what exactly was going on just before any
> > issue occurred in the system. These event
> > history will be collected only when the host
> > driver is run in debug mode (i.e. with the
> > config ATH10K_DEBUG enabled).
> 
> This should be disabled by default unless user specifically pokes some
> debugfs
> value to turn it on so that it does not impact performance.

Hi Ben,
This history is enabled only if the user compiles the kernel with
ATH10K_DEBUG.
Making it runtime, adds a lot of "if" conditions for this history record.
Do you suggest to add support to enable/disable it runtime even in
ATH10K_DEBUG ?

> 
> Thanks,
> Ben
> 
> >
> > Add history for tracking the below events
> > - register read
> > - register write
> > - IRQ trigger
> > - IRQ Enable
> > - IRQ Disable
> > - NAPI poll
> > - CE service
> > - WMI cmd
> > - WMI event
> > - WMI tx completion
> >
> > This will help in debugging any crash or any
> > improper behaviour.
> 
> 
> --
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com

