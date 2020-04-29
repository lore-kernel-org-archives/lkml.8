Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 428C7C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 11:33:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A88A2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 11:33:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="sFv2zLZ0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgD2LdH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 07:33:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726516AbgD2LdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 07:33:07 -0400
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3EFFC03C1AD;
        Wed, 29 Apr 2020 04:33:06 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 49BxG91qHmz9sRY;
        Wed, 29 Apr 2020 21:33:05 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1588159985;
        bh=Adj+fG8YDKfPDUE9InMCb5DttAUKu40s9AS5+byR6mY=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=sFv2zLZ0qaNXw6rVKpWVaCYMtoW69+gkf7dQD3mcQaYunRfoql/kCN/1uIFVVLKOR
         cfNlSqelh0VvtGgBtBr6K0kCbVpsuf/wFJ5Luc/1yRhF2dmVvYoUx2Vv+hf7KJMmnj
         xeFTEaHzRzVGsvxVWFJTFI7SOJU4MDXbR/CLjvQ53gq8hA14952XM2QUg7USjoey40
         Ez6JoRcK7p8dTSjID6dXpfbM1hgcF2KTXiaPvF1OAYfjzPPEaOGC0NvmPLfVWhGJep
         IMcmLX4OCQo3PfR23uyCeUYELFDWudw+WPcqjFkC5q0PyFQ6KnzzWlbTBA/ZUNuu/0
         KOA2UjNxrbTfA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Kajol Jain <kjain@linux.ibm.com>, acme@kernel.org,
        linuxppc-dev@lists.ozlabs.org, sukadev@linux.vnet.ibm.com
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
        ravi.bangoria@linux.ibm.com, peterz@infradead.org,
        yao.jin@linux.intel.com, ak@linux.intel.com, jolsa@kernel.org,
        kan.liang@linux.intel.com, jmario@redhat.com,
        alexander.shishkin@linux.intel.com, mingo@kernel.org,
        paulus@ozlabs.org, namhyung@kernel.org, mpetlan@redhat.com,
        gregkh@linuxfoundation.org, benh@kernel.crashing.org,
        mamatha4@linux.vnet.ibm.com, mark.rutland@arm.com,
        tglx@linutronix.de, kjain@linux.ibm.com
Subject: Re: [PATCH v7 3/5] powerpc/hv-24x7: Add sysfs files inside hv-24x7 device to show processor details
In-Reply-To: <87d07qfrxb.fsf@mpe.ellerman.id.au>
References: <20200327063642.26175-1-kjain@linux.ibm.com> <20200327063642.26175-4-kjain@linux.ibm.com> <87d07qfrxb.fsf@mpe.ellerman.id.au>
Date:   Wed, 29 Apr 2020 21:33:21 +1000
Message-ID: <87a72ufrwe.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman <mpe@ellerman.id.au> writes:
> Kajol Jain <kjain@linux.ibm.com> writes:
>> To expose the system dependent parameter like total number of
>> sockets and numbers of chips per socket, patch adds two sysfs files.
>> "sockets" and "chips" are added to /sys/devices/hv_24x7/interface/
>> of the "hv_24x7" pmu.
>>
>> Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
>> ---
>>  arch/powerpc/perf/hv-24x7.c | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>
> This should also add documentation under Documentation/ABI.

Ugh, sorry, you do that in the next patch :}

cheers
