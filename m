Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90EF3C83001
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 00:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D95E2072A
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 00:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726369AbgD1AU2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 20:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726016AbgD1AU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 20:20:28 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C17C0610D5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Apr 2020 17:20:28 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jTDz0-00059c-SZ; Tue, 28 Apr 2020 02:20:19 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 56C23100FC0; Tue, 28 Apr 2020 02:20:18 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Luck\, Tony" <tony.luck@intel.com>,
        "Raj\, Ashok" <ashok.raj@intel.com>
Cc:     "Yu\, Fenghua" <fenghua.yu@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        "Hansen\, Dave" <dave.hansen@intel.com>,
        "Pan\, Jacob jun" <jacob.jun.pan@intel.com>,
        "Jiang\, Dave" <dave.jiang@intel.com>,
        "Mehta\, Sohil" <sohil.mehta@intel.com>,
        "Shankar\, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>,
        "iommu\@lists.linux-foundation.org" 
        <iommu@lists.linux-foundation.org>
Subject: RE: [PATCH 6/7] x86/traps: Fix up invalid PASID
In-Reply-To: <3908561D78D1C84285E8C5FCA982C28F7F6070AA@ORSMSX115.amr.corp.intel.com>
References: <1585596788-193989-1-git-send-email-fenghua.yu@intel.com> <1585596788-193989-7-git-send-email-fenghua.yu@intel.com> <87mu6ys20d.fsf@nanos.tec.linutronix.de> <20200427224646.GA103955@otc-nc-03> <3908561D78D1C84285E8C5FCA982C28F7F6070AA@ORSMSX115.amr.corp.intel.com>
Date:   Tue, 28 Apr 2020 02:20:18 +0200
Message-ID: <877dy0pikd.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Luck, Tony" <tony.luck@intel.com> writes:
>> Just for the record I also suggested to have a proper errorcode in the
>> #GP for ENQCMD and I surely did not suggest to avoid decoding the user
>> instructions.
>
> Is the heuristic to avoid decoding the user instructions OK (you are just pointing
> out that you should not be given credit for this part of the idea)?

I surely suggested the approach, but at the same time I asked for the
error code and did not say that instruction checking needs to be
avoided.

This comment was just to make it clear that there were other options
discussed. IOW, the changelog should have some explicit explanations
why:

 - the error code idea does not work (according to HW folks)

 - the instruction decoding has no real benefit because $REASONS

Thanks,

        tglx


