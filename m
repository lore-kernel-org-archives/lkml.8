Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C6BDC433E2
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECB0920791
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 10:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LWuI98ju";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uzvNLAjC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730151AbgIDK0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 06:26:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60380 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729950AbgIDK0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 06:26:10 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599215168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IIb9DxOVf2o7mz0utSYXLof9MskW68PFyAZoe+fk2Dc=;
        b=LWuI98juUnFZ+JFLdt+0iKBUigefi/KYCS+j6l2a5xLL9E0FL24XqIKriMo5D/ukklNXSd
        tpTACXWre12qyiDSXiJ6BuAKRHGfYtU4PLVNKspVcDx82G58/8rDDWjBinLPqi+TYVuQM0
        6MNOetV609tkmMRdomNBJW1fWyIsB+TfBoPnJoxfpQMjHzzJEXdWvR8YM3PzoQWWeiceT7
        y1oxW3Xg4xgCPZEg4ovz+zM5hRU4tclboo/Y3XVls5wepQxR3O4cI83bFrSMnc/sHA5uFb
        HeDd2quLlPlf7N9JWFR8Iw785/8gaQwqQL60S67ovWup6Ww9/LnNqqCuHzYQHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599215168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IIb9DxOVf2o7mz0utSYXLof9MskW68PFyAZoe+fk2Dc=;
        b=uzvNLAjCd5bnR28TEdEGvfM9tM7O+dwNUAz98ohBpBG1BITpbM40TZDR20cs9fY8XvXMMD
        zS+HQ2911yr3hRCg==
To:     Ingo Molnar <mingo@kernel.org>,
        "Zhang\, Qiang" <Qiang.Zhang@windriver.com>
Cc:     "longman\@redhat.com" <longman@redhat.com>,
        "elver\@google.com" <elver@google.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSNOg==?= [PATCH v2] debugobjects: install cpu
 hotplug callback
In-Reply-To: <20200904055040.GA2765622@gmail.com>
References: <20200827050614.15100-1-qiang.zhang@windriver.com> <BYAPR11MB2632C578C5863019114EE572FF2D0@BYAPR11MB2632.namprd11.prod.outlook.com> <20200904055040.GA2765622@gmail.com>
Date:   Fri, 04 Sep 2020 12:26:07 +0200
Message-ID: <87k0x94z40.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 04 2020 at 07:50, Ingo Molnar wrote:
>> +#if defined(CONFIG_HOTPLUG_CPU)
>> +static int object_cpu_offline(unsigned int cpu)
>> +{
>> +       struct debug_percpu_free *percpu_pool;
>> +       struct hlist_node *tmp;
>> +       struct debug_obj *obj;
>> +
>> +       percpu_pool = per_cpu_ptr(&percpu_obj_pool, cpu);
>> +       hlist_for_each_entry_safe(obj, tmp, &percpu_pool->free_objs, node) {
>> +               hlist_del(&obj->node);
>> +               kmem_cache_free(obj_cache, obj);
>> +       }
>> +
>> +       return 0;
>> +}
>> +#endif
>
> What happens to ->obj_free, if the CPU is brought back online? Won't it be 
> out of sync at that point?

Yes and it's going to do the completely wrong thing.

Thanks,

        tglx
