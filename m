Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3FB8C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F9FC207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="HamYMkz3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728085AbgETASR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 20:18:17 -0400
Received: from terminus.zytor.com ([198.137.202.136]:51569 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726344AbgETASR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 20:18:17 -0400
Received: from carbon-x1.hos.anvin.org ([IPv6:2601:646:8600:3281:e7ea:4585:74bd:2ff0])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 04K0HX411072698
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 19 May 2020 17:17:33 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 04K0HX411072698
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020042201; t=1589933856;
        bh=pzjrg1D/87oLc0VRBPeM1/XkcV73EGEp+ELgwdVZVik=;
        h=Subject:To:References:From:Date:In-Reply-To:From;
        b=HamYMkz3aUvFBEnxHScelDoTxhchPW7LGv+blgvuTMUZVHDmfDUv74AYIKJI1ro2U
         zN+/K51Q17cFwmQLfzLD7zRXP9AjXocPMLKEOHOd7J4FzTsh7jwvFW7Dqn8palb7MG
         TdUZwiPmdwe4+E/nU0giQjER5XaBj/4d+oMLzWvXHzqB8qBb9fummM1+e8tRhdMyxW
         YJ17NbiV9peJ65dgDAc4nBLI2/x7cVg+Rxr2LLSIcUZHbIU1YHLLKar9DgJOSTqJCI
         8oicAFRP/wJDM3D0mFa476rRb3O1H9XLiyGVwljcOIGeK8U1NSNMSTEV8Zpfar9COU
         AN1hLUSkxgemg==
Subject: Re: umip: AMD Ryzen 3900X, pagefault after emulate SLDT/SIDT
 instruction
To:     Andreas Rammhold <andi@notmuch.email>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Babu Moger <Babu.Moger@amd.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jason Yan <yanaijie@huawei.com>,
        Brendan Shanks <bshanks@codeweavers.com>,
        linux-kernel@vger.kernel.org
References: <20200519143815.cpsd2xfx2kl3khsq@wrt>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <a0f55ad9-f85b-3b2a-e75d-43d4a54063fb@zytor.com>
Date:   Tue, 19 May 2020 17:17:28 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200519143815.cpsd2xfx2kl3khsq@wrt>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-05-19 07:38, Andreas Rammhold wrote:
> Hi,
> 
> I've been running into a weird problem with UMIP on a current Ryzen
> 3900x with kernel 5.6.11 where a process receives a page fault after the
> kernel handled the SLDT (or SIDT) instruction (emulation).
> 
> The program I am running is run through WINE in 32bit mode and tries to
> figure out if it is running in a VMWare machine by comparing the results
> of SLDT against well known constants (basically as shown in the
> [example] linked below).
> 

Extremely weird. What is it expecting to happen -- or rather, what do you
*want* it to do?

	-hpa

