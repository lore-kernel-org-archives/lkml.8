Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E86C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 11:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AEE7208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 11:29:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="OSEdhG5N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732721AbgGaL3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 07:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732437AbgGaL3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 07:29:19 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B9D7C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 04:29:19 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4BJ4mp6L85z9sT6;
        Fri, 31 Jul 2020 21:29:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1596194955;
        bh=34jb67RQIXV7zdZcIuU4OXuBbmIQf5h3pTfTRC5qdDg=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=OSEdhG5Nyegx+5lOPERe6hw4U7kZu3HZEbYJtnRsl8VvmMN3DcleE37IaNnVP2uEK
         vnTxt01f9TprUvYcrsPsp15OupO4YryCp7m4fVdSfNL9IMJlKbb7yDitd4j+gt2nfk
         2rHfXv9rxfC9ZrYOHo/yqaBQ2e5+agBi5TtmzvwiOCFWNyGdmEhN7zzl3xdYi+FcQx
         Q/FtrMUqFn4hjPy4YvFIPCZFz2pOTt4hJ3sUONjzranMjpADV7aY60FOLBiXGu+S3i
         Str4YbjIQ7Bjg9ZVLoOUxxQnotEjW8aNslQt29gVTU77jf7A+ohGujwZwWCdIYwMQr
         U3IMDb0052Vyg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Anton Blanchard <anton@ozlabs.org>,
        Oliver O'Halloran <oohall@gmail.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Michael Neuling <mikey@neuling.org>,
        Gautham R Shenoy <ego@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Jordan Niethe <jniethe5@gmail.com>
Subject: Re: [PATCH v4 10/10] powerpc/smp: Implement cpu_to_coregroup_id
In-Reply-To: <20200731095808.GB18776@linux.vnet.ibm.com>
References: <20200727053230.19753-1-srikar@linux.vnet.ibm.com> <20200727053230.19753-11-srikar@linux.vnet.ibm.com> <87wo2k3yeq.fsf@mpe.ellerman.id.au> <20200731095808.GB18776@linux.vnet.ibm.com>
Date:   Fri, 31 Jul 2020 21:29:13 +1000
Message-ID: <87tuxn53ee.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
> * Michael Ellerman <mpe@ellerman.id.au> [2020-07-31 18:02:21]:
>
>> Srikar Dronamraju <srikar@linux.vnet.ibm.com> writes:
>> > Lookup the coregroup id from the associativity array.
>
> Thanks Michael for all your comments and inputs.
>
>> It's slightly strange that this is called in patch 9, but only properly
>> implemented here in patch 10.
>> 
>> I'm not saying you have to squash them together, but it would be good if
>> the change log for patch 9 mentioned that a subsequent commit will
>> complete the implementation and how that affects the behaviour.
>
> I probably got influenced by few LKML community members who always add a
> stub and implement the gory details in a subsequent patch. I will surely add
> the change log in patch 9 about the subsequent patches.

That's OK, it's a valid way to do things, and can be good for keeping
the size of individual patches down to make them easier to review.

But yeah a mention in the change log of the preceeding patch is helpful
for anyone looking at that commit on its own in the future.

cheers
