Return-Path: <SRS0=rxDU=A5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29819C433E2
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 21:07:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0560D22D0B
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Jul 2020 21:07:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727986AbgGRVHd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Jul 2020 17:07:33 -0400
Received: from relay12.mail.gandi.net ([217.70.178.232]:46481 "EHLO
        relay12.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726382AbgGRVHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Jul 2020 17:07:33 -0400
Received: from localhost (91-175-115-186.subs.proxad.net [91.175.115.186])
        (Authenticated sender: gregory.clement@bootlin.com)
        by relay12.mail.gandi.net (Postfix) with ESMTPSA id 15AD2200004;
        Sat, 18 Jul 2020 21:07:29 +0000 (UTC)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Marcin Wojtas <mw@semihalf.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        Tomasz Nowicki <tn@semihalf.com>,
        Hanna Hawa <hannah@marvell.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, kernel-team@android.com,
        nadavh@marvell.com, iommu@lists.linux-foundation.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 0/4] Add system mmu support for Armada-806
In-Reply-To: <CAPv3WKc5hNhDCjgrX8uuJJm9MRS520QcD1NYTY1LWFHEBqJMfg@mail.gmail.com>
References: <20200715070649.18733-1-tn@semihalf.com> <159488817559.3788855.4350396507732052751.b4-ty@kernel.org> <20200716120202.GA7485@willie-the-truck> <CAPv3WKc5hNhDCjgrX8uuJJm9MRS520QcD1NYTY1LWFHEBqJMfg@mail.gmail.com>
Date:   Sat, 18 Jul 2020 23:07:29 +0200
Message-ID: <87mu3w352m.fsf@FE-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> czw., 16 lip 2020 o 14:02 Will Deacon <will@kernel.org> napisał(a):
>>
>> On Thu, Jul 16, 2020 at 01:00:43PM +0100, Will Deacon wrote:
>> > On Wed, 15 Jul 2020 09:06:45 +0200, Tomasz Nowicki wrote:
>> > > The series is meant to support SMMU for AP806 and a workaround
>> > > for accessing ARM SMMU 64bit registers is the gist of it.
>> > >
>> > > For the record, AP-806 can't access SMMU registers with 64bit width.
>> > > This patches split the readq/writeq into two 32bit accesses instead
>> > > and update DT bindings.
>> > >
>> > > [...]
>> >
>> > Applied to will (for-joerg/arm-smmu/updates), thanks!
>> >
>> > [1/3] iommu/arm-smmu: Call configuration impl hook before consuming features
>> >       https://git.kernel.org/will/c/6a79a5a3842b
>> > [2/3] iommu/arm-smmu: Workaround for Marvell Armada-AP806 SoC erratum #582743
>> >       https://git.kernel.org/will/c/f2d9848aeb9f
>> > [3/3] dt-bindings: arm-smmu: add compatible string for Marvell Armada-AP806 SMMU-500
>> >       https://git.kernel.org/will/c/e85e84d19b9d
>>
>> (note that I left patch 4 for arm-soc, as that's just updating .dts files)
>>
>
> Hi Gregory,
>
> Can you please help with the review/merge of patch #4?

Sure!

I've followed the series since the v1 even if I didn't commetn and I am
happy that it finally managed to be merged. I can now remove it from
my TODO list! :)

Gregory


>
> Best regards,
> Marcin

-- 
Gregory Clement, Bootlin
Embedded Linux and Kernel engineering
http://bootlin.com
