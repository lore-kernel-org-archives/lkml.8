Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCF3C4BA24
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 10:32:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD5BE24691
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 10:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ICXJq5nD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbgB0Kcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 05:32:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23748 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728680AbgB0Kcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 05:32:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582799574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2pWyPH2/Ft3GL3DYnjQSn7n1AXiKP/1omIif/rcF0CY=;
        b=ICXJq5nDiQjwNi9AsFwfxKUkaWhQWMzTW5bnn8iofruHg6ouRFuIc8P6FLaPtwuSDyUWQ2
        Mof96Z780WLgW8LXt/WPSSIG6N1Cz7e2QJH4L6Hjqu7E+OGowpfYzWzjgmT8xKX0mSdszD
        d/yp/6/iYdeta2M8slNXzdje0sfakxQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-316-0QdnR5wAOZGslNKgMzxKwg-1; Thu, 27 Feb 2020 05:32:52 -0500
X-MC-Unique: 0QdnR5wAOZGslNKgMzxKwg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1D03DBA8;
        Thu, 27 Feb 2020 10:32:50 +0000 (UTC)
Received: from oldenburg2.str.redhat.com (unknown [10.36.118.156])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8D5CE60BE2;
        Thu, 27 Feb 2020 10:32:47 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Szabolcs Nagy <szabolcs.nagy@arm.com>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Chris Kennelly <ckennelly@google.com>, nd@arm.com,
        "Joel Fernandes\, Google" <joel@joelfernandes.org>,
        Paul Turner <pjt@google.com>,
        Carlos O'Donell <codonell@redhat.com>,
        libc-alpha <libc-alpha@sourceware.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        paulmck <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
        Brian Geffon <bgeffon@google.com>
Subject: Re: Rseq registration: Google tcmalloc vs glibc
References: <1503467992.2999.1582234410317.JavaMail.zimbra@efficios.com>
        <20200221154923.GC194360@google.com>
        <1683022606.3452.1582301632640.JavaMail.zimbra@efficios.com>
        <CAEXW_YRT7AjaJs7mPyNd=J6fhBicYwGbQMK2Senwm3cBhFvWPw@mail.gmail.com>
        <CAEE+ybmQb02u-=c1sHozkJ+RXOi2Hno6qYJ0Vx9rOpKjSQ4fPQ@mail.gmail.com>
        <1089333712.8657.1582736509318.JavaMail.zimbra@efficios.com>
        <CAEE+ybkTs4U7h-Js818k1QEqpVfHwAHSTXaEwHs3g37LwOsjLQ@mail.gmail.com>
        <982202794.8791.1582743392060.JavaMail.zimbra@efficios.com>
        <c79e3622-30df-001f-8f60-5a3edc10f7e5@arm.com>
Date:   Thu, 27 Feb 2020 11:32:45 +0100
In-Reply-To: <c79e3622-30df-001f-8f60-5a3edc10f7e5@arm.com> (Szabolcs Nagy's
        message of "Thu, 27 Feb 2020 10:18:32 +0000")
Message-ID: <87v9nsz5f6.fsf@oldenburg2.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Szabolcs Nagy:

> On 26/02/2020 18:56, Mathieu Desnoyers wrote:
>> ----- On Feb 26, 2020, at 12:27 PM, Chris Kennelly ckennelly@google.com wrote:
>>> I agree that this could potentially violate inviarants, but
>>> InitFastPerCpu is not intended to be called by the application.
>> 
>> OK, explicitly documenting this would be a good thing. In my own projects,
>> I prefix those symbols with double-underscores (__) to indicate that those
>> are not meant to be called by other means than the static inlines in the API.
>
> use a different convention for that, __ prefix is always
> reserved for the implementation for arbitrary use.

tcmalloc is *not* the implementation in that sense.  It must not use the
__ prefix for its identifiers.

Thanks,
Florian

