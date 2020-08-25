Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56034C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:52:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32CA72075F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 12:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgHYMwr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 08:52:47 -0400
Received: from foss.arm.com ([217.140.110.172]:58142 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726784AbgHYMwq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 08:52:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D8B41FB;
        Tue, 25 Aug 2020 05:52:46 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 258963F66B;
        Tue, 25 Aug 2020 05:52:44 -0700 (PDT)
Date:   Tue, 25 Aug 2020 13:52:30 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Steven Price <steven.price@arm.com>
Cc:     Marc Zyngier <maz@kernel.org>, Keqian Zhu <zhukeqian1@huawei.com>,
        kvm@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH 0/5] KVM: arm64: Add pvtime LPT support
Message-ID: <20200825125230.GA33677@C02TD0UTHF1T.local>
References: <20200817084110.2672-1-zhukeqian1@huawei.com>
 <8308f52e4c906cad710575724f9e3855@kernel.org>
 <f14cfd5b-c103-5d56-82fb-59d0371c6f21@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f14cfd5b-c103-5d56-82fb-59d0371c6f21@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 19, 2020 at 09:54:40AM +0100, Steven Price wrote:
> On 18/08/2020 15:41, Marc Zyngier wrote:
> > On 2020-08-17 09:41, Keqian Zhu wrote:

> We are discussing (re-)releasing the spec with the LPT parts added. If you
> have fundamental objections then please me know.

Like Marc, I argued strongly for the removal of the LPT bits on the
premise that it didn't really work (e.g. when transistioning between SW
agents) and so it was a pure maintenance burden.

I don't think the technical arguments have changed, and I don't think
it's a good idea to try to ressurect this. Please rope me in if
this comes up in internal discussions.

Mark.
