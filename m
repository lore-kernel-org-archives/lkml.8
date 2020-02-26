Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8B43C4BA12
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:49:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1A124680
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 14:49:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WB0T68gN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727918AbgBZOtC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 09:49:02 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:58073 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727584AbgBZOtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 09:49:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582728541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C/fit9buLQoyBITMniA3SZzT0SvwKSgZb4ufJ9DR0s0=;
        b=WB0T68gNA5C6tPHTc8ni7IqWLAh8C6nkEuuRUTcg4ADMkoJg1KtlCCzq0CeFtIHCptEvWT
        GigPOvqMBvru2NwVyCJrgDjg6PkzGWJvcTuwReAY0P7GviZTG05peGpC/8tLK9sK2Xmuqv
        4DsGmvYxO78EZ58hGAnfHi35ZqlpjpY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-125-clHqMRhWO7uWL9xrfeXjXw-1; Wed, 26 Feb 2020 09:48:59 -0500
X-MC-Unique: clHqMRhWO7uWL9xrfeXjXw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3A00B13E2;
        Wed, 26 Feb 2020 14:48:57 +0000 (UTC)
Received: from ovpn-117-20.ams2.redhat.com (ovpn-117-20.ams2.redhat.com [10.36.117.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0FA978B759;
        Wed, 26 Feb 2020 14:48:50 +0000 (UTC)
Message-ID: <6bda45c24afb5bbd069af6f57b07880cd2f5af52.camel@redhat.com>
Subject: Re: [PATCH v3 1/2] kstats: kernel metric collector
From:   Paolo Abeni <pabeni@redhat.com>
To:     Luigi Rizzo <lrizzo@google.com>, linux-kernel@vger.kernel.org,
        mhiramat@kernel.org, akpm@linux-foundation.org,
        gregkh@linuxfoundation.org, naveen.n.rao@linux.ibm.com,
        ardb@kernel.org, rizzo@iet.unipi.it, giuseppe.lettieri@unipi.it,
        toke@redhat.com, hawk@kernel.org, mingo@redhat.com,
        acme@kernel.org, rostedt@goodmis.org, peterz@infradead.org
Date:   Wed, 26 Feb 2020 15:48:49 +0100
In-Reply-To: <20200226135027.34538-2-lrizzo@google.com>
References: <20200226135027.34538-1-lrizzo@google.com>
         <20200226135027.34538-2-lrizzo@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm sorry for the lack of feedback on earlier iteration, I've simply
been too slow.

On Wed, 2020-02-26 at 05:50 -0800, Luigi Rizzo wrote:
[...]
> +static void ks_print(struct seq_file *p, int slot, int cpu, u64 sum,
> +		     u64 tot, unsigned long samples, unsigned long avg)
> +{
> +	unsigned long frac = (tot == 0) ? 0 : ((sum % tot) * 1000000) / tot;

I think/fear kbuildbot will still trigger some build issues on 32bit
arches on the above line.

I think div64_u64_rem() should be used in place of '%' for and 
div64_u64() in place of '/' when operating on 64bits integers. 

There are a few more occurences below.

[...]
> ++	/* preempt_disable makes sure samples and sum modify the same slot.
> +	 * this_cpu_add() uses a non-interruptible add to protect against
> +	 * hardware interrupts which may call kstats_record.
> +	 */
> +	preempt_disable();
> +	this_cpu_add(ks->slots[slot].samples, 1);

I think 'this_cpu_inc()' could be used here.

> +	this_cpu_add(ks->slots[slot].sum,
> +		     bucket < SUM_SCALE ? val : (val >> (bucket - SUM_SCALE)));
> +	preempt_enable();
> +}
> +EXPORT_SYMBOL(kstats_record);

Thanks for sharing, this infra will be likely quite useful to me :)

Cheers,

Paolo

