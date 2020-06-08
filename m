Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEE39C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 16:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C75652076A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 16:58:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730693AbgFHQ67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 12:58:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:52812 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730236AbgFHQ66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 12:58:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 91F6DAAE8;
        Mon,  8 Jun 2020 16:59:00 +0000 (UTC)
Subject: Re: [RFC PATCH 1/5] mm, slub: extend slub_debug syntax for multiple
 blocks
To:     Kees Cook <keescook@chromium.org>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        vinmenon@codeaurora.org, Matthew Garrett <mjg59@google.com>,
        Jann Horn <jannh@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>
References: <20200602141519.7099-1-vbabka@suse.cz>
 <20200602141519.7099-2-vbabka@suse.cz> <202006051401.9AB3D2CAD@keescook>
From:   Vlastimil Babka <vbabka@suse.cz>
Message-ID: <a9310f8b-ef99-089a-4932-e15cbf09def4@suse.cz>
Date:   Mon, 8 Jun 2020 18:58:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <202006051401.9AB3D2CAD@keescook>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/5/20 11:06 PM, Kees Cook wrote:
>> @@ -83,6 +88,18 @@ in low memory situations or if there's high fragmentation of memory.  To
>>  
>>  	slub_debug=O
>>  
>> +You can apply different options to different list of slab names, using blocks
>> +of options. This will enable red zoning for dentry and user tracking for
>> +kmalloc. All other slabs will not get any debugging enabled::
>> +
>> +	slub_debug=Z,dentry;U,kmalloc-*
>> +
>> +You can also enable options (e.g. sanity checks and poisoning) for all caches
>> +except some that are deemed too performance critical and don't need to be
>> +debugged::
> 
> Just for more clarity, how about:
> 
>  ... debugged by starting the list with "-" (to mean "all except the
> following")::

Hmm, "-" is not exactly "all except the following", but "no debugging", as
explained in the list of debug options earlier in the file.

So I'm updating it to this:

You can also enable options (e.g. sanity checks and poisoning) for all caches
except some that are deemed too performance critical and don't need to be
debugged by specifying global debug options followed by a list of slab names
with "-" as options::

        slub_debug=FZ;-,zs_handle,zspage


>> +
>> +	slub_debug=FZ;-,zs_handle,zspage
>> +
>>  In case you forgot to enable debugging on the kernel command line: It is
>>  possible to enable debugging manually when the kernel is up. Look at the
>>  contents of::
> 
> Everything else looks great; very nice! :)
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
 
Thanks!
