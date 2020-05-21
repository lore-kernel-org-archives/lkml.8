Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6F78C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 10:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 94A62207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 10:14:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590056084;
	bh=D9Q72b7qUgPDDR206w4ichbVQq6A8rfnDC2+Hv+edCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=qIbZaAohK2gLV/Rssqfvsep/4ygfHs+JGLOF5vUg5I5zv6ix2E3PxHFbvPEV/EDCt
	 8gVYEsbq4xAvuq6A8fxED2ZnHSpgJhHWZtBtmCNqX8Ixm5l0IICdOgXLTEdhH+K9az
	 p0G2aDWSLYVU/ugpYpqU60NeN+v7kAisHYPyqsLM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728421AbgEUKOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 06:14:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbgEUKOn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 06:14:43 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 081862072C;
        Thu, 21 May 2020 10:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590056082;
        bh=D9Q72b7qUgPDDR206w4ichbVQq6A8rfnDC2+Hv+edCc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Dmg4JoXUCdd6Bq6CUMCM52AvT1HD5NxqVWfhuQQk2ejzC7BcgrwdvasbhSGDNmfAH
         r2Q6jEgv9Oyah98CWOOxvb63BYPLCyuBkEGCMeck/m5YEIPxKwbTNNoz6O5ZO/p5BV
         Dj7TuRATLbQXuL+HfJ62WO6JZTYSfOMB6SU8uOUo=
Date:   Thu, 21 May 2020 11:14:38 +0100
From:   Will Deacon <will@kernel.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Steven Price <steven.price@arm.com>, harb@amperecomputing.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/7] firmware: smccc: Add basic SMCCC v1.2 +
 ARCH_SOC_ID support
Message-ID: <20200521101437.GB5360@willie-the-truck>
References: <20200518091222.27467-1-sudeep.holla@arm.com>
 <158999823818.135150.13263761266508812198.b4-ty@kernel.org>
 <CAK8P3a0bx2eOFSqM7ihNkJBWU_KKSh0vGJZZdvpkH=1nppingw@mail.gmail.com>
 <20200521070629.GB1131@bogus>
 <CAK8P3a1h1MR4Mq2sSV_FDUodrfaKRFtyOuOOGPWAbPYbzjc4YQ@mail.gmail.com>
 <20200521075755.GA4668@willie-the-truck>
 <20200521081055.GD1131@bogus>
 <CAK8P3a3dV0B26XE3oFQGTFf8EWV0AHoLudNtpSSB_t+pCfkOkQ@mail.gmail.com>
 <20200521091736.GA5091@willie-the-truck>
 <20200521092627.GB6425@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200521092627.GB6425@bogus>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 21, 2020 at 10:26:27AM +0100, Sudeep Holla wrote:
> On Thu, May 21, 2020 at 10:17:39AM +0100, Will Deacon wrote:
> > On Thu, May 21, 2020 at 11:06:23AM +0200, Arnd Bergmann wrote:
> > > On Thu, May 21, 2020 at 10:11 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > > > /me confused. Do you need the fix for this warning or you are happy to ignore?
> > > 
> > > I want a fix for that, as I hope we can eventually turn this warning on by
> > > default and stop playing whack-a-mole when they come up. Most of these
> > > warnings are harmless, but occasionally the prototypes don't match exactly
> > > and cause real bugs depending on the configuration, and ensuring both
> > > sides include a common header file is an easy way to make it work
> > > more reliably.
> > > 
> > > Note that the warning should come up for either W=1 or C=1, and I also
> > > think that
> > > new code should generally be written sparse-clean and have no warnings with
> > > 'make C=1' as a rule.
> > 
> > Fair enough. Is anybody working on a tree-wide sweep for this, like we've
> > done for other things such as zero-length arrays? If so, I can start
> > enforcing this in the arch code as well (I haven't been so far, even though
> > I do run sparse on every commit).
> > 
> > Anyway, I've dropped the last patch from the branch, and we can put a fix
> > for the missing prototype on top.
> > 
> 
> Thanks Will, sorry for the trouble. Though I can send the fix for the
> missing prototype right away, I would like to get my clang setup working
> as an opportunity. clang-8 that I have is failing vanilla v5.7-rc6
> when expanding arm_smccc_1_1_*

No trouble at all, really. I also saw this from Nathan the other day, which
may help you get up and running with clang:

https://lore.kernel.org/r/20200520024736.GA854786@ubuntu-s3-xlarge-x86

(but I haven't tried it myself, as I'm just using the Android binary)

Will
