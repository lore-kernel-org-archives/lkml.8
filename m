Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A1E2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 12:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42E3A20791
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 12:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GHwpL9zF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oNP2h9Dq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726578AbgHMMNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 08:13:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58318 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgHMMNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 08:13:54 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597320831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tQYvkqXE5EdBVdiO0ISKqxb3rBUgEsMwquDtXOKueGI=;
        b=GHwpL9zFdxYNR/AGJIiDNIbyE8avRxZkeurRafXu2kWcZkSqLM90dTdOxJJxJsZ8GR0CSh
        QoKjOqhN6WHbJaSDaH5yyjtJ9ZfvPyw6tmQ3RX5JhqhCAFnqPn7SEchjI6hQW953o9jYAA
        masmnprKB/aNpB0oS6rBOBL3CfjWLMeJC3pGHvVULsfuRYm0SPa8kj5oWZQ8D9vYvOUaco
        0qnERYUF7ST3RB9mO2M73iGWMW4cD4j3VDWcCHbrHgsgN9Dhzyltf/Iisawi1PX7HJUjNA
        98yuKdJ0qNCIEtkD9pyhXp66DvdL7NGOpQNajKWsKtCbhsTU1/g+I3XPnDZBug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597320831;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tQYvkqXE5EdBVdiO0ISKqxb3rBUgEsMwquDtXOKueGI=;
        b=oNP2h9DqtdR+YQ2kEQK018T5aZHXQYYJHc4PVSs8iIXRffNBf4hwBEkf5zMpCzVqlkqAtK
        61E86EtGA/GAg/DA==
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Jonathan Adams <jwadams@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     netdev@vger.kernel.org, kvm@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Jim Mattson <jmattson@google.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [RFC PATCH 6/7] core/metricfs: expose x86-specific irq information through metricfs
In-Reply-To: <2500b04e-a890-2621-2f19-be08dfe2e862@redhat.com>
References: <20200807212916.2883031-1-jwadams@google.com> <20200807212916.2883031-7-jwadams@google.com> <87mu2yluso.fsf@nanos.tec.linutronix.de> <2500b04e-a890-2621-2f19-be08dfe2e862@redhat.com>
Date:   Thu, 13 Aug 2020 14:13:50 +0200
Message-ID: <87a6yylp4x.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 13/08/20 12:11, Thomas Gleixner wrote:
>>> Add metricfs support for displaying percpu irq counters for x86.
>>> The top directory is /sys/kernel/debug/metricfs/irq_x86.
>>> Then there is a subdirectory for each x86-specific irq counter.
>>> For example:
>>>
>>>    cat /sys/kernel/debug/metricfs/irq_x86/TLB/values
>> What is 'TLB'? I'm not aware of any vector which is named TLB.
>
> There's a "TLB" entry in /proc/interrupts.

It's TLB shootdowns and not TLB.

Thanks,

        tglx

