Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64D1BC2BB1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 06:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A6C52071B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 06:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1583994115;
	bh=j2gvSkX0T3pHQ1GHBq7Q8WK3w/7sJFPcYJmOxoQlDQo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r95Dx8aSw5OeXO2TvOPt/8OBUazzUf9dN89RoFJBPdW61SUpBRNLcaiu7TWOqSDI6
	 boTPYS9ttv+DTThVq/MilMAGZ57H6BKzRRscNeFSUewWSlA79OTvsNdHEqrwgu6esV
	 Ejp4FDjFMw97vDpgQDbTy6zIRvEEo6+6XWH/ElCs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387976AbgCLGVy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 02:21:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:33098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387848AbgCLGVx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 02:21:53 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF1BA206E7;
        Thu, 12 Mar 2020 06:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583994113;
        bh=j2gvSkX0T3pHQ1GHBq7Q8WK3w/7sJFPcYJmOxoQlDQo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0N7OJXmBHt8ONAZ1tITsN0gvA18lUWoq/wDPvwtfnXZ3NHl6vqAncO+tDbwA9cqYK
         3gs4lfg9atNIiO2HjzbV5mBXpzOTf/fCCZlAKHein784NNH39K8osJY81rC3YfF9js
         G6htsngwUOuTS4SEOSWMG3Wg2nUsMyNZLeD8FsoU=
Date:   Thu, 12 Mar 2020 07:21:50 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
        stable@vger.kernel.org
Subject: Re: [PATCH 5.5 000/190] 5.5.9-rc2 review
Message-ID: <20200312062150.GB4128239@kroah.com>
References: <20200311181532.692464938@linuxfoundation.org>
 <1b23a866-f9ac-a358-c8f4-a7535eae4c4f@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b23a866-f9ac-a358-c8f4-a7535eae4c4f@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 11, 2020 at 02:40:23PM -0700, Guenter Roeck wrote:
> On 3/11/20 11:19 AM, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 5.5.9 release.
> > There are 190 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Fri, 13 Mar 2020 18:14:21 +0000.
> > Anything received after that time might be too late.
> > 
> 
> Build results:
> 	total: 157 pass: 157 fail: 0
> Qemu test results:
> 	total: 423 pass: 423 fail: 0


Nice!  Now to fix up 5.4.y...
