Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B26C33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 21:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9D042467A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 21:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730364AbgAOVzv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 16:55:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49350 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728896AbgAOVzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 16:55:51 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1irqdc-0001p8-3H; Wed, 15 Jan 2020 22:55:44 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 76055101228; Wed, 15 Jan 2020 22:55:43 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Fenghua Yu <fenghua.yu@intel.com>,
        "Moger\, Babu" <Babu.Moger@amd.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Tony Luck <tony.luck@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        James Morse <james.morse@arm.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v9 00/13] selftests/resctrl: Add resctrl selftest
In-Reply-To: <20200115211749.GA51626@romley-ivt3.sc.intel.com>
References: <1576535207-2417-1-git-send-email-fenghua.yu@intel.com> <7aacc3e8-4072-c6b9-5d0f-f687a40ad315@amd.com> <CY4PR12MB1574ACDEE30CDCD8113CECA795390@CY4PR12MB1574.namprd12.prod.outlook.com> <20200115211749.GA51626@romley-ivt3.sc.intel.com>
Date:   Wed, 15 Jan 2020 22:55:43 +0100
Message-ID: <87k15sxu3k.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fenghua Yu <fenghua.yu@intel.com> writes:
>
> Hi, Boris, Thomas, Ingo, et al,
>
> Any comment on this patch set?

No objections from my side, but you forgot to CC the relevant
maintainer/mailinglist for tools/testing/selftests/. CC'ed now.

Thanks,

        tglx
