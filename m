Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FE9C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 23:45:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E2D62076C
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 23:45:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="cRCHyk3m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388477AbgEXXpO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 19:45:14 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42327 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388104AbgEXXpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 19:45:14 -0400
Received: from [IPv6:2601:646:8600:3281:f972:cb22:f020:43c1] ([IPv6:2601:646:8600:3281:f972:cb22:f020:43c1])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 04ONimbP2562583
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Sun, 24 May 2020 16:44:50 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 04ONimbP2562583
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020042201; t=1590363890;
        bh=E+emqPKrqfIi6SizEvzxugSNYEecvMrONFrGtUSZxK8=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=cRCHyk3mIdT3I8E5v1FtQIed96KBwvV1C6Bbkx2do/f9iqThwIg671xUTf8BaKaVM
         e0msKLmshpcilp7FJ6S8SUviN7XNNSUljBfqgmvrJQB9tAYqXyF+XcYqUry8BzxcCQ
         5FWIGMDN9p0ZT0pagmwi2GBdK1DWn66pkmwFzKluNpromWpDol4FO+A0f9uBYrXzA0
         NchXl1eDgEeUU3GbTnMSXMH4dC22+EwdgOs+a6GeuzLI8qMD/mVHFA3tmYYNJZRY/h
         Zj7CkPs5DrUyTjy9RjVjRXTnBC/CHH1pmBjE/1c4fJy6X+8Bx9YZ875008a4FAZf7T
         ETH5olpksfpNw==
Date:   Sun, 24 May 2020 16:44:40 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20200524211945.GX33628@sasha-vm>
References: <0186c22a8a6be1516df0703c421faaa581041774.camel@linux.intel.com> <20200515164013.GF29995@sasha-vm> <c566b89cc3ef6c164160cc56a820abac3fd70839.camel@linux.intel.com> <20200518153407.GA499505@tassilo.jf.intel.com> <371e6a92cad25cbe7a8489785efa7d3457ecef3b.camel@linux.intel.com> <87v9ksvoaq.fsf@nanos.tec.linutronix.de> <20200519164853.GA19706@linux.intel.com> <7eb45e02-03bf-0af0-c915-794bf49d66d7@cs.unc.edu> <87h7w7qy18.fsf@nanos.tec.linutronix.de> <A9483B8B-C0DD-46CB-AD5D-D12EC61BB331@zytor.com> <20200524211945.GX33628@sasha-vm>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: Re: [PATCH v12 00/18] Enable FSGSBASE instructions
To:     Sasha Levin <sashal@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Don Porter <porter@cs.unc.edu>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        bp@alien8.de, luto@kernel.org, dave.hansen@intel.com,
        tony.luck@intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
From:   hpa@zytor.com
Message-ID: <F8D68F56-8928-489A-92AD-175048B22A6F@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 24, 2020 2:19:45 PM PDT, Sasha Levin <sashal@kernel=2Eorg> wrote:
>On Sun, May 24, 2020 at 12:45:18PM -0700, hpa@zytor=2Ecom wrote:
>>There are legitimate reasons to write a root-hole module, the main one
>being able to test security features like SMAP=2E I have requested before
>a TAINT flag specifically for this purpose, because TAINT_CRAP is
>nowhere near explicit enough, and is also used for staging drivers=2E
>Call it TAINT_TOXIC or TAINT_ROOTHOLE; it should always be accompanied
>with a CRIT level alert=2E
>
>What I don't like about our current system of TAINT_* flags is that
>while we can improve it as much as we want, no one outside of the
>kernel
>tree seems to be using it=2E While Thomas may have been commenting on
>Graphene's behaviour, look at any other code that did the same thing:
>
>- Graphene:
>https://github=2Ecom/oscarlab/graphene-sgx-driver/blob/master/gsgx=2Ec
>- Occlum:
>https://github=2Ecom/occlum/enable_rdfsbase/blob/master/enable_rdfsbase=
=2Ec
>- SGX-LKL:
>https://github=2Ecom/lsds/sgx-lkl/blob/master/tools/kmod-set-fsgsbase/mod=
_set_cr4_fsgsbase=2Ec
>
>None of which set even the CRAP flag=2E

That's a separate problem, but I would personally want to have it for my o=
wn test modules in case one ever escapes=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
