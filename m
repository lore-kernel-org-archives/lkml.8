Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33860C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 06:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 041B520663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 06:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728428AbgGOGf7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 02:35:59 -0400
Received: from 3.mo177.mail-out.ovh.net ([46.105.36.172]:46780 "EHLO
        3.mo177.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725823AbgGOGf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 02:35:59 -0400
X-Greylist: delayed 408 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Jul 2020 02:35:58 EDT
Received: from player774.ha.ovh.net (unknown [10.108.54.141])
        by mo177.mail-out.ovh.net (Postfix) with ESMTP id 2489B13861E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 08:29:09 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net [82.253.208.248])
        (Authenticated sender: groug@kaod.org)
        by player774.ha.ovh.net (Postfix) with ESMTPSA id 0AEF8146AA8E2;
        Wed, 15 Jul 2020 06:29:02 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-103G0052bfd424a-5f63-4d60-b697-d28668566bf1,D756FEFB7EDC1B892B7A3E282F77C60775DBB805) smtp.auth=groug@kaod.org
Date:   Wed, 15 Jul 2020 08:28:59 +0200
From:   Greg Kurz <groug@kaod.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] powerpc/xive: Remove unused inline function
 xive_kexec_teardown_cpu()
Message-ID: <20200715082859.4b61560e@bahia.lan>
In-Reply-To: <20200715025040.33952-1-yuehaibing@huawei.com>
References: <20200715025040.33952-1-yuehaibing@huawei.com>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 11687966933504858421
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrfedugddutdelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpeffhffvuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeehkefhtdehgeehheejledufeekhfdvleefvdeihefhkefhudffhfeuuedvffdthfenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrjeejgedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrgh
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jul 2020 10:50:40 +0800
YueHaibing <yuehaibing@huawei.com> wrote:

> commit e27e0a94651e ("powerpc/xive: Remove xive_kexec_teardown_cpu()")
> left behind this, remove it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---

Reviewed-by: Greg Kurz <groug@kaod.org>

>  arch/powerpc/include/asm/xive.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/xive.h b/arch/powerpc/include/asm/xive.h
> index d08ea11b271c..309b4d65b74f 100644
> --- a/arch/powerpc/include/asm/xive.h
> +++ b/arch/powerpc/include/asm/xive.h
> @@ -155,7 +155,6 @@ static inline void xive_smp_probe(void) { }
>  static inline int  xive_smp_prepare_cpu(unsigned int cpu) { return -EINVAL; }
>  static inline void xive_smp_setup_cpu(void) { }
>  static inline void xive_smp_disable_cpu(void) { }
> -static inline void xive_kexec_teardown_cpu(int secondary) { }
>  static inline void xive_shutdown(void) { }
>  static inline void xive_flush_interrupt(void) { }
>  

