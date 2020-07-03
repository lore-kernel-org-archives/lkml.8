Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF08C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:16:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50A36208C7
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 17:16:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="Zb3dtx20"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726501AbgGCRQK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 13:16:10 -0400
Received: from esa2.hc3370-68.iphmx.com ([216.71.145.153]:5193 "EHLO
        esa2.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbgGCRQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 13:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1593796570;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=dqeiGuK5cYVNFmkGldspUWwR9pAfBDVSylO2ZhDXxgA=;
  b=Zb3dtx20Kc58Xpe4WTnmkp9Fwu7vbdGCg/YyvlN5I1c4ydxdGCyBciaz
   ++RflQIk8Kk99c1QBKv1IHb7D2jXuUz9TPZIpG/afvjxJwm9RnzkNZzAF
   oN+oLFzeNTyFiRD+nIIUdRVzNmnyG7/iTgbdOD+1j4TnEK+TUdEmvgJEq
   E=;
Authentication-Results: esa2.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none
IronPort-SDR: Wmjh8XanJ46odrm8NoGJflxLrYjP3hhL6XwFpCOGk+igvaFduGuN3NR99lPlmnofEXknmtK5yj
 mwzzdR267dX4eqgtColQf885PR+XTcgtUzCf82Mt1LA8qqfWWE254d1aH161crac2N1+PkIEN6
 wreuB3wIIqvAcUFETs2YmxbDlJ4sGPI+Yeshdyq6/EprEzutj1L7lcvj25/3tjJ+lw4TSd+04W
 xIozewpd6O9j6mWYLM7dpXhA+kAcYIDXJqv5VzNXdBnnYImLbofcLHVKwymQFkU87HH8zq1SYK
 Onk=
X-SBRS: 2.7
X-MesageID: 21581824
X-Ironport-Server: esa2.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.75,308,1589256000"; 
   d="scan'208";a="21581824"
Subject: Re: FSGSBASE seems to be busted on Xen PV
To:     Andy Lutomirski <luto@kernel.org>,
        xen-devel <xen-devel@lists.xenproject.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Jan Beulich <jbeulich@suse.com>,
        "Boris Ostrovsky" <boris.ostrovsky@oracle.com>
CC:     X86 ML <x86@kernel.org>
References: <CALCETrVfi1Rnt5nnrHNivdxE7MqRPiLXvon4-engqo=LCKiojA@mail.gmail.com>
From:   Andrew Cooper <andrew.cooper3@citrix.com>
Message-ID: <e78d2ee5-66cf-2ed8-c04f-71dd92efdfe1@citrix.com>
Date:   Fri, 3 Jul 2020 18:16:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CALCETrVfi1Rnt5nnrHNivdxE7MqRPiLXvon4-engqo=LCKiojA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/07/2020 18:10, Andy Lutomirski wrote:
> Hi Xen folks-
>
> I did some testing of the upcoming Linux FSGSBASE support on Xen PV,
> and I found what appears to be some significant bugs in the Xen
> context switching code.  These bugs are causing Linux selftest
> failures, and they could easily cause random and hard-to-debug
> failures of user programs that use the new instructions in a Xen PV
> guest.
>
> The bugs seem to boil down to the context switching code in Xen being
> clever and trying to guess that a nonzero FS or GS means that the
> segment base must match the in-memory descriptor.  This is simply not
> true if CR4.FSGSBASE is set -- the bases can have any canonical value,
> under the full control of the guest, and Xen has absolutely no way of
> knowing whether the values are expected to be in sync with the
> selectors.  (The same is true of FSGSBASE except that guest funny
> business either requires MSR accesses or some descriptor table
> fiddling, and guests are perhaps less likely to care)
>
> Having written a bunch of the corresponding Linux code, I don't
> there's any way around just independently saving and restoring the
> selectors and the bases.  At least it's relatively fast with FSGSBASE
> enabled.
>
> If you can't get this fixed in upstream Xen reasonably quickly, we may
> need to disable FSGSBASE in a Xen PV guest in Linux.

This has come up several times before, but if its actually breaking
userspace then Xen needs to change.

I'll see about making something which is rather more robust.

~Andrew
