Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8B8C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 17:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 142D1204EA
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 17:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CdPSlD8l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726859AbgHGRiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 13:38:16 -0400
Received: from linux.microsoft.com ([13.77.154.182]:32768 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725900AbgHGRiP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 13:38:15 -0400
Received: by linux.microsoft.com (Postfix, from userid 1046)
        id 73BD520B4908; Fri,  7 Aug 2020 10:38:15 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 73BD520B4908
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1596821895;
        bh=C/YZdQC0Ww0BuTHSLWbA5PvW86cdDm7U0d2NW1ollxU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CdPSlD8lhAYSTqoYgZnjbWjvmDfDKnlX2apmVVil9NWagpKMNeEu/cUpl3RZQwVXk
         MhUbuOc/DdxASXpR4LfjY52RnBEvfglDsi5Zi0k/sTfFeqglZiWucXcZLSye+0f+4N
         nQlGWJBwLY2Z8dm8aXBTrq9pM2c9P/XnqAgnyCRA=
From:   Dhananjay Phadke <dphadke@linux.microsoft.com>
To:     ray.jui@broadcom.com
Cc:     bcm-kernel-feedback-list@broadcom.com, dphadke@linux.microsoft.com,
        linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        rayagonda.kokatanur@broadcom.com, rjui@broadcom.com, wsa@kernel.org
Subject: Re: [PATCH] i2c: iproc: fix race between client unreg and isr
Date:   Fri,  7 Aug 2020 10:38:15 -0700
Message-Id: <1596821895-105875-1-git-send-email-dphadke@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <574e1d63-cfe0-8e0b-1b45-f91ee9b3cb84@broadcom.com>
References: <574e1d63-cfe0-8e0b-1b45-f91ee9b3cb84@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ray Jui wrote:
> 
> Any progress yet?
> 

> I don't know if Dhananjay is actively working on this or not.
> 
> Rayagonda, given that you have the I2C slave setup already, do you think
> you can help to to test and above sequence from Wolfram (by using the
> widened delay window as instructed)?
> 
> Thanks,
> 
> Ray

Sorry I was out for a while, I've tested the fix with delay and original
i2c client test, will send v2 patch shortly.

Thanks,
Dhananjay
