Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93222C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AE83207C4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 18:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388022AbgERS3E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 14:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388013AbgERS3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 14:29:01 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BF7DC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 11:29:01 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jakVO-0001gb-TK; Mon, 18 May 2020 20:28:51 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 3A905100606; Mon, 18 May 2020 20:28:50 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Sasha Levin <sashal@kernel.org>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, bp@alien8.de, luto@kernel.org,
        hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ak@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Subject: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
In-Reply-To: <20200518151604.GC33628@sasha-vm>
References: <20200511045311.4785-1-sashal@kernel.org> <0186c22a8a6be1516df0703c421faaa581041774.camel@linux.intel.com> <20200515164013.GF29995@sasha-vm> <87o8qly3jo.fsf@nanos.tec.linutronix.de> <20200518151604.GC33628@sasha-vm>
Date:   Mon, 18 May 2020 20:28:50 +0200
Message-ID: <87sgfxw10d.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sasha Levin <sashal@kernel.org> writes:
> On Mon, May 18, 2020 at 11:51:07AM +0200, Thomas Gleixner wrote:
>>Sasha Levin <sashal@kernel.org> writes:
>>> On Fri, May 15, 2020 at 12:24:14PM +0300, Jarkko Sakkinen wrote:
>>>>
>>>>Can you put me to the CC-loop for this patches. Some SGX-enabled
>>>>frameworks such as Graphene use out-of-tree changes to achieve this.
>>>>That's where the interest to possibly test this comes from.
>>>
>>> Indeed, we've seen a few hacks that basically just enable FSGSBASE:
>>>
>>>  - https://github.com/oscarlab/graphene-sgx-driver
>>>  - https://github.com/occlum/enable_rdfsbase
>>
>>I'm really amazed by all these security experts enabling a full root
>>hole. It clearly puts the SGX hypocrisy into perspective.
>
> We can bash Intel all we want here, but sadly there are users in the

This is not about bashing Intel.

> "wild" who just enable these root holes thinking they're secure, and
> those users are the ones running very sensitive workloads. Here's an
> example from a book called "Responsible Genomic Data Sharing":
>
> 	https://books.google.com/books?id=y6zWDwAAQBAJ&pg=PA184#v=onepage&q&f=false
>
> That explains how to use Graphene-SGX which just enables FSGSBASE with
> root holes.

It's about these SGX promoting security experts which try to tell
everyone else that he has no clue about security.

Thanks,

        tglx


