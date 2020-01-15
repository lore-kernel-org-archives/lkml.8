Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE44EC33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:36:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93F9C222C3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgAOOgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 09:36:31 -0500
Received: from foss.arm.com ([217.140.110.172]:38312 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbgAOOgb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:36:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 11C2931B;
        Wed, 15 Jan 2020 06:36:31 -0800 (PST)
Received: from [10.1.196.105] (eglon.cambridge.arm.com [10.1.196.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D2FBC3F68E;
        Wed, 15 Jan 2020 06:36:28 -0800 (PST)
Subject: Re: [PATCH v8 00/25] arm64: MMU enabled kexec relocation
To:     Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     Will Deacon <will@kernel.org>, James Morris <jmorris@namei.org>,
        Sasha Levin <sashal@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        kexec mailing list <kexec@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Bhupesh Sharma <bhsharma@redhat.com>,
        linux-mm <linux-mm@kvack.org>,
        Mark Rutland <mark.rutland@arm.com>, steve.capper@arm.com,
        rfontana@redhat.com, Thomas Gleixner <tglx@linutronix.de>
References: <20191204155938.2279686-1-pasha.tatashin@soleen.com>
 <20200108173225.GA21242@willie-the-truck>
 <CA+CK2bBDhF4YuFOeagzZ48-BigDmOVuBKZTAC8fd6tojcJN-0g@mail.gmail.com>
From:   James Morse <james.morse@arm.com>
Message-ID: <033681cb-9fd2-673d-d282-e7c0973e4523@arm.com>
Date:   Wed, 15 Jan 2020 14:36:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <CA+CK2bBDhF4YuFOeagzZ48-BigDmOVuBKZTAC8fd6tojcJN-0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 08/01/2020 17:59, Pavel Tatashin wrote:
> On Wed, Jan 8, 2020 at 12:32 PM Will Deacon <will@kernel.org> wrote:
>> On Wed, Dec 04, 2019 at 10:59:13AM -0500, Pavel Tatashin wrote:
>>> Many changes compared to version 6, so I decided to send it out now.
>>> James Morse raised an important issue to which I do not have a solution
>>> yet. But would like to discuss it.

(Christmas was badly timed relative to my holiday, so its taken a while for me to catch up)

The memory out of range of the idmap?
I've posted an RFC here[0] that makes hibernate idmap is ttbr0 page. This should let you
reuse that code and test it without a machine with a funny memory layout.


Thanks,

James

[0] https://lore.kernel.org/linux-arm-kernel/20200115143322.214247-1-james.morse@arm.com/
