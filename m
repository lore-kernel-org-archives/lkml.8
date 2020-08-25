Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80CBC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 23:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83DA1206E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 23:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BmPGkWsX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K9FyjbVp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbgHYXxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 19:53:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53484 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbgHYXxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 19:53:08 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1598399585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7sjuDNKoNuivCO4m9qTc9EZF7ep9JNUbpUXkfmM2aDw=;
        b=BmPGkWsXSKuh5VPNK7AWgRiGjag/CK7IsyxCGihen0mv9vcZDteoHb6lLcWJvg+QdUq4Jz
        GWZLrSFsh2aNtMZCzRWGq81KJBlIiA6GyDFvrW1qZwySjylyELvAaGBNgZq9qGTaPgxnqr
        yzS5mh+e5dw0EBxmWfRPFWvwzAPdvQBjNHpUwjjMNL6LdQBHtoBJniVPp2nLkFliIIj99B
        Iy3Mf8vM0jSdgYcmcZemfsrovl9aeTGn50WOVeHgWsgYrUsrS2YxPoKA52F5SGu+cN7sHJ
        QsbRd/kaesAZ3Z5600k6TX/KHp6FfMDpqif9hW1TcA2uRv09n+LP3/Qrd8os9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1598399585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7sjuDNKoNuivCO4m9qTc9EZF7ep9JNUbpUXkfmM2aDw=;
        b=K9FyjbVpbd79OT5j9MBsQvctnOvFrtlSWGudMTaH3o6wHWDyzci4iQodpIOgIRBey2eIt+
        7xPoKllDsjo0uYCw==
To:     Waiman Long <longman@redhat.com>,
        "Zhang\, Qiang" <Qiang.Zhang@windriver.com>,
        "elver\@google.com" <elver@google.com>
Cc:     "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm\@linux-foundation.org" <akpm@linux-foundation.org>
Subject: Re: =?utf-8?B?5Zue5aSNOg==?= [PATCH] debugobjects: install cpu
 hotplug callback
In-Reply-To: <e75c1601-b466-8476-f75b-514b1c21646e@redhat.com>
References: <20200820032453.5222-1-qiang.zhang@windriver.com> <BYAPR11MB263237C2A74C32CC14DD0F2EFF570@BYAPR11MB2632.namprd11.prod.outlook.com> <e75c1601-b466-8476-f75b-514b1c21646e@redhat.com>
Date:   Wed, 26 Aug 2020 01:53:05 +0200
Message-ID: <87pn7ewae6.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 25 2020 at 18:26, Waiman Long wrote:
> On 8/25/20 12:53 AM, Zhang, Qiang wrote:
>>
>> When a cpu going offline, we should free objects in "percpu_obj_pool"
>> free_objs list which corresponding to this cpu.
>
> The percpu free object pool is supposed to be accessed only by that 
> particular cpu without any lock. Trying to access it from another cpu 
> can cause a race condition unless one can make sure that the offline cpu 
> won't become online in the mean time. 

It is actually safe because CPU hotplug is globally serialized and there
is no way that an offline CPU will come back from death valley
magically. If such a zombie ever surfaces then we have surely more
serious problems than accessing that pool :)

> There shouldn't be too many free objects in the percpu pool. Is it
> worth the effort to free them?

That's a really good question nevertheless. The only case where this
ever matters is physical hotplug. All other CPU hotplug stuff is
temporarily or in case of a late (post boottime) SMT disable it's going
to be a handful of free objects on that pool. As debugobjects is as the
name says a debug facility the benefit is questionable unless there is a
good reason to do so.

Thanks,

        tglx


