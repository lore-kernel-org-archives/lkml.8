Return-Path: <SRS0=5pK+=BB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 291DEC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 14:56:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3A8A20787
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jul 2020 14:56:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HfmMA8HN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732697AbgGVO4t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 10:56:49 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51762 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730465AbgGVO4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 10:56:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595429808;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6gVk//BUazCMtzlozAWa7nTU6Yu6g/1ZlLTzqK6oLIM=;
        b=HfmMA8HNSLmec0QeKebqetb5KkjzgE0KJ/a2nq65bi/81hljQfUOWwoeYIh4Uu08/vIf5H
        nqBPil0FO7neiC7v1tTfvFPBgMIlAhYDlRFlD2T1ZTvxnavUlzmYGv9GhGY5FV6iOkIvfI
        tP/8E1eL87+mxubr0RfYLUSeKoMwI5U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-502-mG0EkZpuPlCR4i706fgDDw-1; Wed, 22 Jul 2020 10:56:43 -0400
X-MC-Unique: mG0EkZpuPlCR4i706fgDDw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0F40419253C2;
        Wed, 22 Jul 2020 14:56:42 +0000 (UTC)
Received: from [10.10.114.255] (ovpn-114-255.rdu2.redhat.com [10.10.114.255])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B50615FC3B;
        Wed, 22 Jul 2020 14:56:40 +0000 (UTC)
Subject: Re: [PATCH v4 00/10] Function Granular KASLR
From:   Joe Lawrence <joe.lawrence@redhat.com>
To:     Kees Cook <keescook@chromium.org>, Miroslav Benes <mbenes@suse.cz>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        arjan@linux.intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
        rick.p.edgecombe@intel.com, live-patching@vger.kernel.org
References: <20200717170008.5949-1-kristen@linux.intel.com>
 <alpine.LSU.2.21.2007221122110.10163@pobox.suse.cz>
 <202007220738.72F26D2480@keescook>
 <aa51eb26-e2a9-c448-a3b8-e9e68deeb468@redhat.com>
Message-ID: <b5bc7a92-a11e-d75d-eefb-fc640c87490d@redhat.com>
Date:   Wed, 22 Jul 2020 10:56:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <aa51eb26-e2a9-c448-a3b8-e9e68deeb468@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/22/20 10:51 AM, Joe Lawrence wrote:
> On 7/22/20 10:39 AM, Kees Cook wrote:
>> On Wed, Jul 22, 2020 at 11:27:30AM +0200, Miroslav Benes wrote:
>>> Let me CC live-patching ML, because from a quick glance this is something
>>> which could impact live patching code. At least it invalidates assumptions
>>> which "sympos" is based on.
>>
>> In a quick skim, it looks like the symbol resolution is using
>> kallsyms_on_each_symbol(), so I think this is safe? What's a good
>> selftest for live-patching?
>>
> 
> Hi Kees,
> 
> I don't think any of the in-tree tests currently exercise the
> kallsyms/sympos end of livepatching.
> 

On second thought, I mispoke.. The general livepatch code does use it:

klp_init_object
   klp_init_object_loaded
     klp_find_object_symbol

in which case any of the current kselftests should exercise that.

   % make -C tools/testing/selftests/livepatch run_tests

-- Joe

