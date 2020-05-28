Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED184C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5D33207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 10:36:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387941AbgE1KgV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 06:36:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387901AbgE1KgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 06:36:18 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C764AC05BD1E
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 03:36:17 -0700 (PDT)
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1jeFtU-0004KH-VU; Thu, 28 May 2020 12:36:13 +0200
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id 651DB100D01; Thu, 28 May 2020 12:36:12 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Andi Kleen <ak@linux.intel.com>, Don Porter <porter@cs.unc.edu>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        bp@alien8.de, luto@kernel.org, hpa@zytor.com,
        dave.hansen@intel.com, tony.luck@intel.com,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com
Subject: Re: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
In-Reply-To: <20200523041928.GU499505@tassilo.jf.intel.com>
References: <20200511045311.4785-1-sashal@kernel.org> <0186c22a8a6be1516df0703c421faaa581041774.camel@linux.intel.com> <20200515164013.GF29995@sasha-vm> <c566b89cc3ef6c164160cc56a820abac3fd70839.camel@linux.intel.com> <20200518153407.GA499505@tassilo.jf.intel.com> <371e6a92cad25cbe7a8489785efa7d3457ecef3b.camel@linux.intel.com> <87v9ksvoaq.fsf@nanos.tec.linutronix.de> <20200519164853.GA19706@linux.intel.com> <7eb45e02-03bf-0af0-c915-794bf49d66d7@cs.unc.edu> <20200523041928.GU499505@tassilo.jf.intel.com>
Date:   Thu, 28 May 2020 12:36:12 +0200
Message-ID: <87a71spcrn.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

Andi Kleen <ak@linux.intel.com> writes:
>> Setting the fs register in userspace is an essential feature for running
>> legacy code in SGX.  We have been following LKML discussions on this
>> instruction for years, and hoping this feature would be supported by Linux,
>
> If you need a feature you should comment on it. One of the reasons
> it took so long is that the users didn't speak up.

nice try to rewrite history.

You know very well that the only reason why FSGSBASE support is not
upstream is Intel.

It has absolutely nothing to do with users not speaking up, unless you
mean the Intel SGX people.

Thanks,

        tglx
