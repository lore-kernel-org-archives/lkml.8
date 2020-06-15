Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378F9C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 12:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 092072076A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 12:56:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Fq/hQ2DM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730348AbgFOM4E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 08:56:04 -0400
Received: from mail.skyhub.de ([5.9.137.197]:53154 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730019AbgFOM4C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 08:56:02 -0400
Received: from zn.tnic (p200300ec2f063c0085fbd8d4455f52fc.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:3c00:85fb:d8d4:455f:52fc])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4813F1EC0328;
        Mon, 15 Jun 2020 14:55:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592225759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=/AESQdNn9F5DJNAvN7Ekrb2QHr0FUj+XXTKW2C8uMmo=;
        b=Fq/hQ2DMKfbOxaJYqCYfztNBgi5oh0HsOx0x7L8VJ4cvNsn8HLUiHwhWxpSTqc4Eyh2BU2
        xRVbBQPrR+Rm8jodEQy0DsYSC7qHKiSva2/xftRAGym3Xdj+qsY8nQ7855vYkCCA2LEo2n
        0CXcuIWGshqqPcwJ9viqJNhwPGKSnlI=
Date:   Mon, 15 Jun 2020 14:55:52 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Vaibhav Jain <vaibhav@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Oliver O'Halloran <oohall@gmail.com>,
        Santosh Sivaraj <santosh@fossix.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Piotr Maziarz <piotrx.maziarz@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v13 2/6] seq_buf: Export seq_buf_printf
Message-ID: <20200615125552.GI14668@zn.tnic>
References: <20200615124407.32596-1-vaibhav@linux.ibm.com>
 <20200615124407.32596-3-vaibhav@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200615124407.32596-3-vaibhav@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 06:14:03PM +0530, Vaibhav Jain wrote:
> 'seq_buf' provides a very useful abstraction for writing to a string
> buffer without needing to worry about it over-flowing. However even
> though the API has been stable for couple of years now its still not
> exported to kernel loadable modules limiting its usage.
> 
> Hence this patch proposes update to 'seq_buf.c' to mark
> seq_buf_printf() which is part of the seq_buf API to be exported to
> kernel loadable GPL modules. This symbol will be used in later parts
> of this patch-set to simplify content creation for a sysfs attribute.
> 
> Cc: Piotr Maziarz <piotrx.maziarz@linux.intel.com>
> Cc: Cezary Rojewski <cezary.rojewski@intel.com>
> Cc: Christoph Hellwig <hch@infradead.org>
> Cc: Steven Rostedt <rostedt@goodmis.org>
> Cc: Borislav Petkov <bp@alien8.de>
> Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
> Changelog:
> 
> v12..v13:
> * None
> 
> v11..v12:
> * None

Can you please resend your patchset once a week like everyone else and
not flood inboxes with it?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
