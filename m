Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68946C2BA19
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 12:37:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3889421D7F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 12:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=prok.pw header.i=@prok.pw header.b="bMzBCQCX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728024AbgDFMhG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 08:37:06 -0400
Received: from smtp17.mail.ru ([94.100.176.154]:36636 "EHLO smtp17.mail.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727989AbgDFMhG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 08:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=prok.pw; s=mailru;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID; bh=iiNfHbyZdz43eY/ca1ZTDKaSuSr+HPfVBFPF8k2SFn4=;
        b=bMzBCQCXt7YcOnWEiuhQXHkHpXme3hxQbJAlobZMGZw+aeYrz/mPui9HSIugXP8UadagmbMKI20AZj4XGVDFimnewZ39tt+ZDRgBm2X6gtof/SSdP5mVIAbFMew58FNAe/ZG76W7pVr8pFEQZezGgA66R/U58zR9BuHoi1BapQI=;
Received: by smtp17.mail.ru with esmtpa (envelope-from <me@prok.pw>)
        id 1jLQzt-0000PQ-Fc; Mon, 06 Apr 2020 15:37:02 +0300
Message-ID: <a406bd0ab573e17c1004d3d91948938c209cf94d.camel@prok.pw>
Subject: Re: [PATCH 1/2] x86/boot/compressed/64: Remove .bss/.pgtable from
 bzImage
From:   Sergey Shatunov <me@prok.pw>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Arvind Sankar <nivedita@alum.mit.edu>
Cc:     bp@alien8.de, hpa@zytor.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        mingo@redhat.com, Thomas Gleixner <tglx@linutronix.de>,
        x86@kernel.org, linux-efi <linux-efi@vger.kernel.org>
Date:   Mon, 06 Apr 2020 19:36:57 +0700
In-Reply-To: <CAMj1kXHWhPmnaCS74n=1MYLfnsKqf+UAfmaLGQYx9jH3YsXvfg@mail.gmail.com>
References: <20200109150218.16544-1-nivedita@alum.mit.edu>
         <20200405154245.11972-1-me@prok.pw>
         <20200405231845.GA3095309@rani.riverdale.lan>
         <CAMj1kXHWhPmnaCS74n=1MYLfnsKqf+UAfmaLGQYx9jH3YsXvfg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Authentication-Results: smtp17.mail.ru; auth=pass smtp.auth=me@prok.pw smtp.mailfrom=me@prok.pw
X-7564579A: 78E4E2B564C1792B
X-77F55803: 0A44E481635329DB0E1AA8A03B392317D32E5E48865217365060145B739F5F5C7141CD936E95A8CDF688BCB05C26794D00EEFFA3BE1FE4186B5281BCEF864E538028E4E492F5D27DF3F88509D94693E6
X-7FA49CB5: 0D63561A33F958A580C73DA523369336E96807BD70808086B9B34D7F4F05369A8941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F446042972877693876707352033AC447995A7AD18CB629EEF1311BF91D2E47CDBA5A965834E70A05D1297E1BBBA3038C0950A5D3613377AFFFEAFD269176DF2183F8FC7C0207D9C0C136568F07B076A6E789B0E97A8DF7F3B2552694A0E14360347543F5849FD398EE364050F140C956E756FBB7A287C8E22D4AE2A51B3661434B16C20AC446828A5085A663B75ECD9A6C639B01B78DA827A17800CE7F2C1598F50A6BE78731C566533BA786A40A5AABA2AD371193C9F3DD0FB1AF5EB82E77451A5C57BD33C9F3DD0FB1AF5EB4E70A05D1297E1BBCB5012B2E24CD356
X-D57D3AED: Y8kq8+OzVozcFQziTi/Zi1xwo7H2ZNxGP5qz8aO2mjTJzjHGC4ogvVuzB3zfVUBtENeZ6b5av1fnCBE34JUDkWdM6QxE+Ga5d8voMtmXfSo0zU/dgAo80gyxHfUpwjuv
X-Mailru-Internal-Actual: A:0.8248366176939
X-Mailru-Sender: C70B145DBB19DC3370B3FB291950C1B52184C016B27618789BBACE8634A6DD1B21401CF93FD6FA558BA0E2A9D6159BD266FEC6BF5C9C28D9A91CF0FA91B32267255DC5169939796B8DAAFE1477B51D223453F38A29522196
X-Mras: Ok
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-04-06 at 10:44 +0200, Ard Biesheuvel wrote:
> On Mon, 6 Apr 2020 at 01:18, Arvind Sankar <nivedita@alum.mit.edu>
> wrote:
> > On Sun, Apr 05, 2020 at 10:42:46PM +0700, Sergey Shatunov wrote:
> > > This patch causes some strange things happens with my laptop.
> > > 
> > > Cold boot crashed in some early initilization logic with message
> > > 'Failed to execute /esp/.../linux.efi: Buffer Too Small'.
> > > After couple reboots into firmware setup (bios) or hot reboot
> > > from other working kernel (without that commit) helps it to boot.
> > > During bisecting couple times I saw different message:
> > > 'exit_efi() failed; efi_main() failed', but above tricks helps it
> > > too.
> 
> Could you please try adding 'efi=no_disable_early_pci_dma' to the
> kernel command line? The lack of BSS zeroization may result in that
> option to get inadvertently enabled, and it is known to break
> exit_boot() on some systems.

With 'efi=no_disable_early_pci_dma' it works again.

