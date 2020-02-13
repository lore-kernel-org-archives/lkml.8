Return-Path: <SRS0=Zbf8=4B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F400C2BA83
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 11:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D9F2073C
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Feb 2020 11:22:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729900AbgBMLWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Feb 2020 06:22:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:51641 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729428AbgBMLWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Feb 2020 06:22:37 -0500
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j2CZc-0007zB-6b; Thu, 13 Feb 2020 12:22:24 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id CEDC31013A6; Thu, 13 Feb 2020 12:22:23 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Dan Williams <dan.j.williams@intel.com>, mingo@redhat.com
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, vishal.l.verma@intel.com,
        hch@lst.de, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, x86@kernel.org
Subject: Re: [PATCH v4 4/6] x86/mm: Introduce CONFIG_KEEP_NUMA
In-Reply-To: <157966229575.2508551.1892426244277171485.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <157966227494.2508551.7206194169374588977.stgit@dwillia2-desk3.amr.corp.intel.com> <157966229575.2508551.1892426244277171485.stgit@dwillia2-desk3.amr.corp.intel.com>
Date:   Thu, 13 Feb 2020 12:22:23 +0100
Message-ID: <877e0q3f68.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Williams <dan.j.williams@intel.com> writes:
> +#ifdef CONFIG_KEEP_NUMA
> +#define __initdata_numa
> +#else
> +#define __initdata_numa __initdata
> +#endif

TBH, I find this conditional annotation mightingly confusing.

__initdata_numa still suggest that this is __initdata, just a different
section and some extra rules or whatever.

Something like __initdata_or_keepnuma (sorry I could not come up with
something prettier, but you get the idea.

Thanks,

        tglx
