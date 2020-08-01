Return-Path: <SRS0=dmjt=BL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FB7FC433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 19:07:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41BCB206D4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Aug 2020 19:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727116AbgHATHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Aug 2020 15:07:47 -0400
Received: from smtprelay0175.hostedemail.com ([216.40.44.175]:42654 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725883AbgHATHr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Aug 2020 15:07:47 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 3DF39180A8121;
        Sat,  1 Aug 2020 19:07:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: thing29_0b107ba26f8e
X-Filterd-Recvd-Size: 1464
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Sat,  1 Aug 2020 19:07:45 +0000 (UTC)
Message-ID: <46c11b84dcf83d185ba771f92d2348aa82621dec.camel@perches.com>
Subject: Re: [PATCH 0/4] Checkpatch tool errors clean up
From:   Joe Perches <joe@perches.com>
To:     Jules Irenge <jbi.octave@gmail.com>, linux-kernel@vger.kernel.org
Date:   Sat, 01 Aug 2020 12:07:44 -0700
In-Reply-To: <20200801184603.310769-1-jbi.octave@gmail.com>
References: <0/4> <20200801184603.310769-1-jbi.octave@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-08-01 at 19:45 +0100, Jules Irenge wrote:
> Hi
> I am proposing these 4 patches. 
> I am currently learning the core kernel the hard way. 
> I will appreciate any feedback negative or positive.
> Thanks 

Generally, whitespace only changes outside of drivers/staging
are not encouraged.

> Jules Irenge (4):
>   acct: Add required space between variable and operator
>   audit: uninitialize global variable audit_sig_sid
>   audit: uninitialize static variables
>   context_tracking: uninitialize static variables
> 
>  kernel/acct.c             |  2 +-
>  kernel/audit.c            | 10 +++++-----
>  kernel/context_tracking.c |  2 +-
>  3 files changed, 7 insertions(+), 7 deletions(-)
> 

