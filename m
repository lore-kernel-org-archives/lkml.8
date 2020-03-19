Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2AFC4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 18:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0134020724
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 18:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="IFODB9vs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgCSS1g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 14:27:36 -0400
Received: from esa5.hc3370-68.iphmx.com ([216.71.155.168]:5394 "EHLO
        esa5.hc3370-68.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726663AbgCSS1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 14:27:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=citrix.com; s=securemail; t=1584642455;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=k+QXQWWqWPfpSUF6R210wEUr307Wfd4gLmMnIgrpKhI=;
  b=IFODB9vsFPtnLxwuT2mSLRwm8f3+H52EkbY3bafz6fpjfpeEoOMws08p
   LEeF06dqqSF+JQxLddSRaxA891y+JV9rSvbZbM1JJDP+sp8uXIGqSp93L
   Ml6mp4l6cicE58gcJ8gW5353OEQ/NcP3oRnzwQGN2n8lJt6FojTWVkx/h
   k=;
Authentication-Results: esa5.hc3370-68.iphmx.com; dkim=none (message not signed) header.i=none; spf=None smtp.pra=roger.pau@citrix.com; spf=Pass smtp.mailfrom=roger.pau@citrix.com; spf=None smtp.helo=postmaster@mail.citrix.com
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  roger.pau@citrix.com) identity=pra; client-ip=162.221.158.21;
  receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible
Received-SPF: Pass (esa5.hc3370-68.iphmx.com: domain of
  roger.pau@citrix.com designates 162.221.158.21 as permitted
  sender) identity=mailfrom; client-ip=162.221.158.21;
  receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="roger.pau@citrix.com";
  x-conformance=sidf_compatible; x-record-type="v=spf1";
  x-record-text="v=spf1 ip4:209.167.231.154 ip4:178.63.86.133
  ip4:195.66.111.40/30 ip4:85.115.9.32/28 ip4:199.102.83.4
  ip4:192.28.146.160 ip4:192.28.146.107 ip4:216.52.6.88
  ip4:216.52.6.188 ip4:162.221.158.21 ip4:162.221.156.83
  ip4:168.245.78.127 ~all"
Received-SPF: None (esa5.hc3370-68.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@mail.citrix.com) identity=helo;
  client-ip=162.221.158.21; receiver=esa5.hc3370-68.iphmx.com;
  envelope-from="roger.pau@citrix.com";
  x-sender="postmaster@mail.citrix.com";
  x-conformance=sidf_compatible
IronPort-SDR: /Kv2ZX6+mfUIURi0i7ez7c3IfIoW781J8/z/fwXs5erGIcej/3BXa3TVU3exGfMxychG/oIykG
 XbXQA0Uo4MYzfyYPDW8A1HXRii0N5TYWsvyGXsxHraHB5aUoMw6lClyvRhkOPAKCzpz36iYNyw
 d3S+dc41KQNsgj4JO1rCZ0mlC5YQQ9skJYVXAbIh3oA0vb8exFCvGiAaDWO7jbzQRvCKDiIQbE
 N2M1m51Qk3hjsnvSb9RRhm4qKshMZudt7HK3f+PscJ/AUWL8tU9DYNSbueqyOnUA14vcVo6oK/
 25Y=
X-SBRS: 2.7
X-MesageID: 14638208
X-Ironport-Server: esa5.hc3370-68.iphmx.com
X-Remote-IP: 162.221.158.21
X-Policy: $RELAYED
X-IronPort-AV: E=Sophos;i="5.70,572,1574139600"; 
   d="scan'208";a="14638208"
Date:   Thu, 19 Mar 2020 19:27:27 +0100
From:   Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, <x86@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Tony Luck <tony.luck@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Jan Beulich <jbeulich@suse.com>,
        "Sean Christopherson" <sean.j.christopherson@intel.com>
Subject: PING: [PATCH] x86/apic: simplify disconnect_bsp_APIC setup of
 LVT{0/1}
Message-ID: <20200319182727.GN24449@Air-de-Roger.citrite.net>
References: <20200127175758.82410-1-roger.pau@citrix.com>
 <20200219123650.GL3886@Air-de-Roger>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200219123650.GL3886@Air-de-Roger>
X-ClientProxiedBy: AMSPEX02CAS01.citrite.net (10.69.22.112) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 01:36:54PM +0100, Roger Pau Monné wrote:
> Ping?

Ping x2.

Thanks.

> On Mon, Jan 27, 2020 at 06:57:58PM +0100, Roger Pau Monne wrote:
> > There's no need to read the current values of LVT{0/1} for the
> > purposes of the function, which seem to be to save the currently
> > selected vector: in the destination modes used (ExtINT and NMI) the
> > vector field is ignored and hence can be set to 0.
> > 
> > Note that clear_local_APIC as called by init_bsp_APIC would have
> > already wiped those registers by writing APIC_LVT_MASKED, and hence
> > there's nothing useful to preserve if that was the intent. Also note
> > that there are other places where LVT{0/1} is written to without doing
> > a read-modify-write (init_bsp_APIC and clear_local_APIC), so if
> > writing 0s to the reserved parts would cause issues they would be also
> > triggered by writes elsewhere.
> > 
> > Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
> > ---
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: "H. Peter Anvin" <hpa@zytor.com>
> > Cc: x86@kernel.org
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Tony Luck <tony.luck@intel.com>
> > Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> > Cc: Jan Beulich <jbeulich@suse.com>
> > Cc: Sean Christopherson <sean.j.christopherson@intel.com>
> > ---
> >  arch/x86/kernel/apic/apic.c | 14 ++------------
> >  1 file changed, 2 insertions(+), 12 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> > index 28446fa6bf18..ce0c65340b4c 100644
> > --- a/arch/x86/kernel/apic/apic.c
> > +++ b/arch/x86/kernel/apic/apic.c
> > @@ -2292,12 +2292,7 @@ void disconnect_bsp_APIC(int virt_wire_setup)
> >  		 * For LVT0 make it edge triggered, active high,
> >  		 * external and enabled
> >  		 */
> > -		value = apic_read(APIC_LVT0);
> > -		value &= ~(APIC_MODE_MASK | APIC_SEND_PENDING |
> > -			APIC_INPUT_POLARITY | APIC_LVT_REMOTE_IRR |
> > -			APIC_LVT_LEVEL_TRIGGER | APIC_LVT_MASKED);
> > -		value |= APIC_LVT_REMOTE_IRR | APIC_SEND_PENDING;
> > -		value = SET_APIC_DELIVERY_MODE(value, APIC_MODE_EXTINT);
> > +		value = APIC_LVT_REMOTE_IRR | APIC_SEND_PENDING | APIC_DM_EXTINT;
> >  		apic_write(APIC_LVT0, value);
> >  	} else {
> >  		/* Disable LVT0 */
> > @@ -2308,12 +2303,7 @@ void disconnect_bsp_APIC(int virt_wire_setup)
> >  	 * For LVT1 make it edge triggered, active high,
> >  	 * nmi and enabled
> >  	 */
> > -	value = apic_read(APIC_LVT1);
> > -	value &= ~(APIC_MODE_MASK | APIC_SEND_PENDING |
> > -			APIC_INPUT_POLARITY | APIC_LVT_REMOTE_IRR |
> > -			APIC_LVT_LEVEL_TRIGGER | APIC_LVT_MASKED);
> > -	value |= APIC_LVT_REMOTE_IRR | APIC_SEND_PENDING;
> > -	value = SET_APIC_DELIVERY_MODE(value, APIC_MODE_NMI);
> > +	value = APIC_LVT_REMOTE_IRR | APIC_SEND_PENDING | APIC_DM_NMI;
> >  	apic_write(APIC_LVT1, value);
> >  }
> >  
> > -- 
> > 2.25.0
> > 
