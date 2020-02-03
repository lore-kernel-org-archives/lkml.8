Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E2A7C33C9E
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 04:53:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08963207E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 04:53:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=russell.cc header.i=@russell.cc header.b="TotxA/Mk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iMY/H/Cy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbgBCEu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 23:50:28 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:55473 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727451AbgBCEu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 23:50:27 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 21891725;
        Sun,  2 Feb 2020 23:50:26 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 02 Feb 2020 23:50:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm1; bh=
        bFOUHt7V3C4f1TpU4gQyO6wPuUUc6O2MFNH7/EMga9Y=; b=TotxA/MkYWmTcJAk
        iEa8IfjfrpQHh/fIOtqge0pfHDmUhttrkia5OwjxpGNFlvfc5jc5KN7qmEif5CnF
        tg4mSF9rOj/BFlu8/gO/cQeevwy5Ri1GJEKf4bcWkOyT4PFq5/AL7lGIfLAl6p1z
        RwUq2J9kt/X45MZVQA7qnDjxX79QQ0Ry7lAAIP0Kii6BOJ2M0e7wSCrfVwDorsB7
        nlSHDAT34qPuxfNizWOR/TmVuSiBABN7QM8uJOrpJ4SHgcxpmdVtuWdSIw6YddT5
        0yiBurE32MxAyGDPLFvXnzjqnJ+yZquS4UWEZQJICXE0KMmyauAgRLbbHJnI8MAT
        C6X1iA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=bFOUHt7V3C4f1TpU4gQyO6wPuUUc6O2MFNH7/EMga
        9Y=; b=iMY/H/Cyr70rWB30iy2bxK99ytKSA+1JzLtXQRUzGpg2v8YUhtuMe+nDY
        AuwlKz5elc9XaW9hH57P/xTa0FOP5X5lrq3Viom3XLtIycWZuOdG6Ln0TFt/5wo6
        Lk7aL8iLYmsK61grO1iZlVXBEUZO/7IQ+ZJTc01ocBkc4m3Ewuz6x8Z/sxjMiEvF
        ysE35gQCdJ8Q+F+vSoPAMSORUrEjCEX7xAUPix1V8zxx87GyUgBIRgm7jssGhs8f
        ckgzs2djm5nNnZTuG+Kw6rFwd+mLGj0LGdBhmRiDYD1pVtBuASxBUy+m+g2vCXfV
        hGP6Gp3enxMZsYxMqO3RWVP5ocQQg==
X-ME-Sender: <xms:kKY3Xl1Tw-4kUHM1ytFMGWq4rc_k1VTMf1DnBBtlqfuUn_v0D44u6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrgeeigdejgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculddutddmnecujfgurhepkffuhffvffgjfhgtfggggfesthejredttder
    jeenucfhrhhomheptfhushhsvghllhcuvehurhhrvgihuceorhhushgtuhhrsehruhhssh
    gvlhhlrdgttgeqnecukfhppeduvddvrdelledrkedvrddutdenucevlhhushhtvghrufhi
    iigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehruhhstghurhesrhhushhsvghllh
    drtggt
X-ME-Proxy: <xmx:kKY3XgUC8UbMVYlq_LRjyG3PhAjyQY-3fRhMEckL7ci861M5AuPg0A>
    <xmx:kKY3Xg5HtbBlZ14vuy6l80-LDNB2uerE4zxbXU32EsOCMoVO-O6qrg>
    <xmx:kKY3XnLe7M4v3h2t3vkakRgHMrYrXusWPz742Ss2l_LM5zVg3xOH-w>
    <xmx:kaY3XgE5h4blsJe8-0UBYNnCTQPg-3w7_T0GL0mV-ItYd9BLsf2kxA>
Received: from crackle.ozlabs.ibm.com (unknown [122.99.82.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5C8A4328005D;
        Sun,  2 Feb 2020 23:50:22 -0500 (EST)
Message-ID: <3078df74c232e54aef3e8bb3523587a3053ab0ec.camel@russell.cc>
Subject: Re: [PATCH v2 2/7] powerpc/kprobes: Mark newly allocated probes as
 RO
From:   Russell Currey <ruscur@russell.cc>
To:     Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 03 Feb 2020 15:50:19 +1100
In-Reply-To: <01fdf1b7375b3e1e43a634bf6719b576c4c5db11.1580477672.git.christophe.leroy@c-s.fr>
References: <84be5ad6a996adf5693260749dcb4d8c69182073.1580477672.git.christophe.leroy@c-s.fr>
         <01fdf1b7375b3e1e43a634bf6719b576c4c5db11.1580477672.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-01-31 at 13:34 +0000, Christophe Leroy wrote:
> With CONFIG_STRICT_KERNEL_RWX=y and CONFIG_KPROBES=y, there will be
> one
> W+X page at boot by default.  This can be tested with
> CONFIG_PPC_PTDUMP=y and CONFIG_PPC_DEBUG_WX=y set, and checking the
> kernel log during boot.
> 
> powerpc doesn't implement its own alloc() for kprobes like other
> architectures do, but we couldn't immediately mark RO anyway since we
> do
> a memcpy to the page we allocate later.  After that, nothing should
> be
> allowed to modify the page, and write permissions are removed well
> before the kprobe is armed.
> 
> The memcpy() would fail if >1 probes were allocated, so use
> patch_instruction() instead which is safe for RO.
> 
> Reviewed-by: Daniel Axtens <dja@axtens.net>
> Signed-off-by: Russell Currey <ruscur@russell.cc>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
> v2: removed the redundant flush
> ---
>  arch/powerpc/kernel/kprobes.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/kprobes.c
> b/arch/powerpc/kernel/kprobes.c
> index 2d27ec4feee4..d3e594e6094c 100644
> --- a/arch/powerpc/kernel/kprobes.c
> +++ b/arch/powerpc/kernel/kprobes.c
> @@ -24,6 +24,7 @@
>  #include <asm/sstep.h>
>  #include <asm/sections.h>
>  #include <linux/uaccess.h>
> +#include <linux/set_memory.h>
>  
>  DEFINE_PER_CPU(struct kprobe *, current_kprobe) = NULL;
>  DEFINE_PER_CPU(struct kprobe_ctlblk, kprobe_ctlblk);
> @@ -124,13 +125,12 @@ int arch_prepare_kprobe(struct kprobe *p)
>  	}
>  
>  	if (!ret) {
> -		memcpy(p->ainsn.insn, p->addr,
> -				MAX_INSN_SIZE *
> sizeof(kprobe_opcode_t));
> +		patch_instruction(p->ainsn.insn, *p->addr);
>  		p->opcode = *p->addr;
> -		flush_icache_range((unsigned long)p->ainsn.insn,
> -			(unsigned long)p->ainsn.insn +
> sizeof(kprobe_opcode_t));
>  	}
>  
> +	set_memory_ro((unsigned long)p->ainsn.insn, 1);
> +


Since this can be called multiple times on the same page, can avoid by
implementing:

void *alloc_insn_page(void)
{
	void *page;

	page = vmalloc_exec(PAGE_SIZE);
	if (page)
		set_memory_ro((unsigned long)page, 1);

	return page;
}

Which is pretty much the same as what's in arm64.  Works for me and
passes ftracetest, I was originally doing this but cut it because it
broke with the memcpy, but works with patch_instruction().

>  	p->ainsn.boostable = 0;
>  	return ret;
>  }

