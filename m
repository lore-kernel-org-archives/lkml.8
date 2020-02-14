Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28793C35242
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 21:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC9FA222C2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 21:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dUh1QkWe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388478AbgBNV35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 16:29:57 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23597 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2387958AbgBNV35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 16:29:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581715796;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Kzi89iF04QxCLMnFCGjJjn2+0t6DNJ4N+OMGiy9A90U=;
        b=dUh1QkWervqgExkkxTdhiPM3gqCBjfvBzH+rymqX+5mhBXltybhg0RcdrdJjwn83XpYI+v
        opRGyvtrrGqGFoBPSjsMl4ijd94p1YLHDLdmhAgpH+M35fN9ZsLGoM1+efUn5i1DEIvPUK
        PYHE1vLBbFIb6rL9msGng0rz/pnO1+o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-237-sW6XycnXOlCOwyWhijM0uQ-1; Fri, 14 Feb 2020 16:29:54 -0500
X-MC-Unique: sW6XycnXOlCOwyWhijM0uQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4CDE51005510;
        Fri, 14 Feb 2020 21:29:52 +0000 (UTC)
Received: from prarit.bos.redhat.com (prarit-guest.7a2m.lab.eng.bos.redhat.com [10.16.222.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB6B05C1C3;
        Fri, 14 Feb 2020 21:29:50 +0000 (UTC)
Subject: Re: [PATCH] x86/mce: Do not log spurious corrected mce errors
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Krupp <centos@akr.yagii.de>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-edac@vger.kernel.org
References: <20200214123407.4184-1-prarit@redhat.com>
 <20200214173644.GA7913@agluck-desk2.amr.corp.intel.com>
From:   Prarit Bhargava <prarit@redhat.com>
Message-ID: <0adb58a9-45d4-85c0-f3b3-517a19d2534e@redhat.com>
Date:   Fri, 14 Feb 2020 16:29:50 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200214173644.GA7913@agluck-desk2.amr.corp.intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2/14/20 12:36 PM, Luck, Tony wrote:
> On Fri, Feb 14, 2020 at 07:34:07AM -0500, Prarit Bhargava wrote:
>>  #ifdef CONFIG_X86_MCE_AMD
>>  extern bool amd_filter_mce(struct mce *m);
>> +extern bool intel_filter_mce(struct mce *m);
>>  #else
> 
> Something very weird is going on here. Why does
> CONFIG_X86_MCE_AMD have to be set to enable some
> *Intel* filter operation?

That's a mistake.  I'll fix that in v2.

P.

> 
> -Tony
> 

