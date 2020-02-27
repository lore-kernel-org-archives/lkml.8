Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD767C11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:23:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8BAE24697
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=telus.net header.i=@telus.net header.b="wJAreRVN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730198AbgB0QXE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 11:23:04 -0500
Received: from cmta17.telus.net ([209.171.16.90]:51125 "EHLO cmta17.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729854AbgB0QXD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 11:23:03 -0500
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Feb 2020 11:23:03 EST
Received: from dougxps ([173.180.45.4])
        by cmsmtp with SMTP
        id 7LoIj0r2W8J587LoKj8Wbc; Thu, 27 Feb 2020 09:14:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telus.net; s=neo;
        t=1582820094; bh=ZC3zJhTmdVTP1C9nevNvq9j43Pk1T2WbFXhYeqpuxHw=;
        h=From:To:Cc:References:In-Reply-To:Subject:Date;
        b=wJAreRVN+25+kQJ9FKt2AZoHr5Fbpb5X95eDxiF9nfDgTFT6tQln3avn6613KJyYm
         8EOV0E+qfU4mZuFYrwpzYllwVOQ5Y6dkBNz08SsdwwCjVJQQN1yJN5cQh6yGGp5XVQ
         HW1d5YogNyhugYkgF5jps3ziG4Xe9bYtRjr7mBMIBiFBo11vzFn0qtwVyU7JPt/aFt
         jmt9s0xrxznbW5UmP9TFPibFam4KSs4Ln5ewPiXaZ+eiPPVas9UADyQnaTiD/UUQV5
         bDWtgUaeVSmnDAykhXlc79sk67puiduMZqcq0btF2AWNSI8iiqoGcvhWF9dWt4JVqD
         gKugYrCnBHVHw==
X-Telus-Authed: none
X-Authority-Analysis: v=2.3 cv=FN5lONgs c=1 sm=1 tr=0
 a=zJWegnE7BH9C0Gl4FFgQyA==:117 a=zJWegnE7BH9C0Gl4FFgQyA==:17
 a=Pyq9K9CWowscuQLKlpiwfMBGOR0=:19 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=kj9zAlcOel0A:10 a=MnG76wI25wRpZeYXPywA:9 a=CjuIK1q_8ugA:10
From:   "Doug Smythies" <dsmythies@telus.net>
To:     <ego@linux.vnet.ibm.com>,
        "'Pratik Rajesh Sampat'" <psampat@linux.ibm.com>
Cc:     <linux-kernel@vger.kernel.org>, <rafael.j.wysocki@intel.com>,
        <peterz@infradead.org>, <daniel.lezcano@linaro.org>,
        <svaidy@linux.ibm.com>, <pratik.sampat@in.ibm.com>,
        <pratik.r.sampat@gmail.com>
References: <20200222070002.12897-1-psampat@linux.ibm.com> <20200225051306.GG12846@in.ibm.com>
In-Reply-To: <20200225051306.GG12846@in.ibm.com>
Subject: RE: [RFC 0/1] Weighted approach to gather and use history in TEO governor
Date:   Thu, 27 Feb 2020 08:14:49 -0800
Message-ID: <000001d5ed89$0b711340$225339c0$@net>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 12.0
Content-Language: en-ca
Thread-Index: AdXrmkakMiSHE641SeKupowM12f2bgB6Kizg
X-CMAE-Envelope: MS4wfMmfb5/ZngCXiI31Z1tX/Z0FU5WOm+rfzFUApn367J+61c0WssiDiVFtuaacfnVHSXDyqfcKLoLIQpV4BdIbU8NhtCsKRObAIHg8BLsMjq7S+wYCUg7v
 yffjKTzj9Rvc68vgb58yaiDK3Yw2+2CP/d6gWVZaM6HlNfpWKPLxDYXkA0uiZmInuyVMuuiTx07cNPyDn+ZUxQwfH2z71wMQbYxS/cFMTB/ZpriFUtxCJTSI
 DfcGzFQVIiewy0D/YBniAe0SPeAPO9Qe7eLwWCLdlm32UXdQ+D6AlVB5/jRcnprnifw+YuLzqc0WJmRuXQLaSGFzbgIr2xc/XkCFuqu3N8Gnn8XAQUZjZTCH
 Ib3q7kN6jXMDrfCa0Z81f9Px9g+S6mUDZOOqfCIpcohCZhO6oJ2KXvOd/cRe8sGWP/JyqqknW+or9KwpFIs5dhgXYO6hLM/e1NXNDeKQOO846tG1oPY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020.02.24 21:13 Gautham R Shenoy wrote:

...

> Could you also provide power measurements for the duration when the
> system is completely idle for each of the variants of TEO governor ?
> Is it the case that the benefits that we are seeing above are only due
> to Wt. TEO being more conservative than TEO governor by always
> choosing a shallower state ?

For what it's worth:

CPU: Intel: i7-2600K  
Kernel: 5.6-rc2 (teo) and + this patch set (wtteo)
Note: in general, "idle" on this system is considerably more "idle" than most systems.
Sample period: 5 minutes.
CPU scaling driver: intel_cpufreq
Governor: performance
Deepest idle state: 4 (C6)

teo:
Test duration 740 minutes (12.33 hours).
Average processor package power: 3.84 watts
Idle state 0:    4.19 / minute
Idle state 1:   29.26 / minute
Idle state 2:   46.71 / minute
Idle state 3:    7.42 / minute
Idle state 4: 1124.55 / minute
Total: 2.525 idle entries per cpu per second

wtteo:
Test duration 1095 minutes (18.25 hours).
Average processor package power: 3.84 watts
Idle state 0:    7.98 / minute
Idle state 1:   30.49 / minute
Idle state 2:   52.51 / minute
Idle state 3:    8.65 / minute
Idle state 4: 1125.33 / minute
Total: 2.552 idle entries per cpu per second

The above/below data for this test is incomplete because my program
doesn't process it if there are not enough state entries per sample period.
(I need to fix that for this type of test.)

I have done a couple of other tests with this patch set,
but nothing to report yet, as the differences have been minor so far.

... Doug


